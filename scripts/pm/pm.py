import json
import os
import argparse
import subprocess

DATA_FILE = "projects.json"
PM_BASE_DIR = os.path.expanduser("~/lab")
PM_CURRENT_FILE = os.path.expanduser("~/.pm_current_project")

class ProjectManager:
    def __init__(self) -> None:
        if not os.path.exists(PM_CURRENT_FILE):
            print("❌ Aucun projet courant défini. Utilise --init ou --continue.")
            exit(1)

        with open(PM_CURRENT_FILE, "r") as f:
            self.project_path = f.read().strip()

        self.data_path = os.path.join(self.project_path, "projects.json")
        self.data = self._load_data()

    def _load_data(self):
        if os.path.exists(self.data_path):
            with open(self.data_path, 'r') as f:
                return json.load(f)
        return {"tasks": []}

    def _save_data(self):
        with open(self.data_path, 'w') as f:
            json.dump(self.data, f, indent=4)

    def add_task(self, title, due=None, message=None):
        task = {
            "title": title,
            "status": "todo",
            "due": due or "",
            "message": message or ""
        }
        self.data.setdefault("tasks", []).append(task)
        self._save_data()
        print(f"✅ Tâche ajoutée au projet courant ({os.path.basename(self.project_path)})")

    def list_tasks(self):
        tasks = self.data.get("tasks", [])
        if not tasks:
            print("Aucune tâche trouvée.")
            return
        print(f"📋 Tâches pour le projet : {os.path.basename(self.project_path)}")
        for i, task in enumerate(tasks):
            print(f"{i}. [{task.get('status', 'todo')}] {task.get('title', '')} (due: {task.get('due', '')})")
            if task.get("message"):
                print(f"   ↳ {task['message']}")

    def remove_task(self, index):
        tasks = self.data.get("tasks", [])
        if 0 <= index < len(tasks):
            removed = tasks.pop(index)
            self._save_data()
            print(f"🗑️ Tâche supprimée : {removed.get('title', '')}")
        else:
            print("❌ Index de tâche invalide.")

    def mark_done(self, index):
        tasks = self.data.get("tasks", [])
        if 0 <= index < len(tasks):
            tasks[index]["status"] = "done"
            self._save_data()
            print(f"✅ Tâche marquée comme terminée : {tasks[index]['title']}")
        else:
            print("❌ Index de tâche invalide.")


def init_project(name):
    project_path = os.path.join(PM_BASE_DIR, name)
    if os.path.exists(project_path):
        print(f"❌ Le dossier '{project_path}' existe déjà.")
        return
    os.makedirs(project_path)
    print(f"📁 Projet créé dans : {project_path}")
    subprocess.run(["git", "init"], cwd=project_path)
    print("✅ Dépôt git initialisé.")
    with open(os.path.join(project_path, "projects.json"), "w") as f:
        f.write("{}")
    with open(PM_CURRENT_FILE, "w") as f:
        f.write(project_path)
    print(f"💾 Projet courant défini : {project_path}")
    subprocess.run(["tmux", "new-session", "-s", name, "-c", project_path])

def continue_project(path):
    if not os.path.exists(os.path.join(path, ".git")):
        print("❌ Ce dossier n’est pas un dépôt Git.")
        return
    json_path = os.path.join(path, "projects.json")
    if not os.path.exists(json_path):
        with open(json_path, "w") as f:
            f.write("{}")
        print("📄 projects.json créé.")
    with open(PM_CURRENT_FILE, "w") as f:
        f.write(path)
    print(f"✅ Projet actif : {path}")
    session_name = os.path.basename(path).replace(".", "_")
    tmux_running = subprocess.run(["pgrep", "tmux"], stdout=subprocess.DEVNULL).returncode == 0
    if not os.environ.get("TMUX") and not tmux_running:
        subprocess.run(["tmux", "new-session", "-s", session_name, "-c", path])
        return
    result = subprocess.run(["tmux", "has-session", "-t", session_name], stderr=subprocess.DEVNULL)
    if result.returncode != 0:
        subprocess.run(["tmux", "new-session", "-ds", session_name, "-c", path])
    if not os.environ.get("TMUX"):
        subprocess.run(["tmux", "attach", "-t", session_name])
    else:
        subprocess.run(["tmux", "switch-client", "-t", session_name])

def choose_project_with_fzf(base_dir):
    git_dirs = []
    for root, dirs, files in os.walk(base_dir):
        if ".git" in dirs:
            git_dirs.append(root)
    if not git_dirs:
        print("Aucun dépôt git trouvé.")
        return
    proc = subprocess.run(
        ["fzf"],
        input="\n".join(git_dirs),
        stdout=subprocess.PIPE,
        text=True
    )
    chosen = proc.stdout.strip()
    if chosen:
        continue_project(chosen)


def main():
    parser = argparse.ArgumentParser(description="Project Manager CLI")

    parser.add_argument("-a", metavar="TITLE", help="Ajouter une tâche (projet courant)")
    parser.add_argument("--due", help="Date limite", required=False)
    parser.add_argument("--message", help="Message", required=False)
    parser.add_argument("-ls", action="store_true", help="Lister les tâches du projet courant")
    parser.add_argument("--init", metavar="PROJECT", help="Init a new project")
    parser.add_argument("--continue", dest="resume", action="store_true", help="Continuer un projet existant (avec fzf)")
    parser.add_argument("-rm", metavar="INDEX", type=int, help="Supprimer une tâche par son index")
    parser.add_argument("-done", metavar="INDEX", type=int, help="Marquer une tâche comme terminée")


    args = parser.parse_args()
    pm = None
    if args.a or args.ls:
        pm = ProjectManager()
        if args.a:
            pm.add_task(args.a, args.due, args.message)
        elif args.ls:
            pm.list_tasks()
    elif args.init:
        init_project(args.init)
    elif args.resume:
        choose_project_with_fzf(PM_BASE_DIR)
    elif args.rm is not None or args.done is not None:
        pm = ProjectManager()
        if args.rm is not None:
            pm.remove_task(args.rm)
        elif args.done is not None:
            pm.mark_done(args.done)
    else:
        parser.print_help()

if __name__ == "__main__":
    main()
