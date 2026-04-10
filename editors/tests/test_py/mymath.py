
class MyMath:
    """My simple math class"""


    @staticmethod
    def add( a: int, b: int ) -> int:
        return a + b


    @staticmethod
    def sub( a: int, b: int ) -> int:
        return a - b


    @staticmethod
    def mul( a: int, b: int ) -> int:
        return a * b


    @staticmethod
    def division( a: int, b: int ) -> int:
        if b == 0:
            return 0
        return a // b

