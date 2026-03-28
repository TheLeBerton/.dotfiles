from mymath import MyMath
from utils import log

def main() -> None:
    a: int = 10
    b: int = 5
    log( f"{ a } + { b } = { MyMath.add( a, b ) }" )
    log( f"{ a } - { b } = { MyMath.sub( a, b ) }" )
    log( f"{ a } * { b } = { MyMath.division( a, b ) }" )
    log( f"{ a } / { b } = { MyMath.sub( a, b ) }" )



if __name__ == "__main__":
    main()
