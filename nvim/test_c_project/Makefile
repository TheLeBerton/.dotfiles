CC = gcc
CFLAGS = -Wall -Wextra -std=c99 -g
SRCDIR = src
INCDIR = include
OBJDIR = obj
BINDIR = bin

SOURCES = $(wildcard $(SRCDIR)/*.c)
OBJECTS = $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
TARGET = $(BINDIR)/test_program

.PHONY: all clean run

all: $(TARGET)

$(TARGET): $(OBJECTS) | $(BINDIR)
	$(CC) $(OBJECTS) -o $@

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) $(CFLAGS) -I$(INCDIR) -c $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)

clean:
	rm -rf $(OBJDIR) $(BINDIR)

run: $(TARGET)
	./$(TARGET)

debug: CFLAGS += -DDEBUG
debug: $(TARGET)

install: $(TARGET)
	cp $(TARGET) /usr/local/bin/

.PHONY: help
help:
	@echo "Available targets:"
	@echo "  all     - Build the program"
	@echo "  clean   - Remove build files"
	@echo "  run     - Build and run the program"
	@echo "  debug   - Build with debug flags"
	@echo "  help    - Show this help message"