import sys
import os
from txt2epub import create_epub

def main():
    print("Hello from txt2epub!")
    if len(sys.argv) > 1:
        input_txt = sys.argv[1]
        output_name = input_txt.replace(".txt", ".epub")
        create_epub(input_txt, output_name)
    else:
        print("用法: python main.py <你的小说.txt>")


if __name__ == "__main__":
    main()
