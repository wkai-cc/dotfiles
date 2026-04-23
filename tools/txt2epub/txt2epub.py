import os
import re
from ebooklib import epub


def create_epub(txt_path, output_epub):
    book = epub.EpubBook()

    # 获取文件名作为标题
    title = os.path.splitext(os.path.basename(txt_path))[0]
    book.set_title(title)
    book.set_language("zh")
    book.add_author("Unknown")

    # 读取文本内容 (默认尝试 utf-8，失败则尝试 gbk)
    try:
        with open(txt_path, "r", encoding="utf-8") as f:
            content = f.read()
    except UnicodeDecodeError:
        with open(txt_path, "r", encoding="gbk") as f:
            content = f.read()

    # 章节匹配正则：匹配“第x章”、“第x节”、“第x回”等
    # 你可以根据实际的小说格式修改这个正则
    chapter_pattern = re.compile(
        r"(^第[0-9一二三四五六七八九十百千]+[章节回部].*)", re.MULTILINE
    )

    # 分割文本
    parts = chapter_pattern.split(content)

    # 过滤掉开头的空字符串
    if parts[0].strip() == "":
        parts = parts[1:]

    chapters = []
    toc = []
    spine = ["nav"]

    # 循环处理：正则分割后，偶数索引通常是章节名，奇数索引是正文
    # 如果第一段不是章节名，先把它当成前言
    if not chapter_pattern.match(parts[0]):
        parts.insert(0, "前言")

    for i in range(0, len(parts), 2):
        chapter_title = parts[i].strip()
        chapter_content = parts[i + 1] if i + 1 < len(parts) else ""

        file_name = f"chap_{i // 2}.xhtml"
        chapter = epub.EpubHtml(title=chapter_title, file_name=file_name, lang="zh")

        # 将换行符转为 HTML 换行
        html_content = f"<h1>{chapter_title}</h1>"
        html_content += "".join(
            [
                f"<p>{line.strip()}</p>"
                for line in chapter_content.split("\n")
                if line.strip()
            ]
        )
        chapter.content = html_content

        book.add_item(chapter)
        chapters.append(chapter)
        toc.append(epub.Link(file_name, chapter_title, file_name))

    # 设置目录和阅读顺序
    book.toc = tuple(toc)
    book.add_item(epub.EpubNav())
    book.spine = spine + chapters

    # 保存文件
    epub.write_epub(output_epub, book, {})
    print(f"转换成功: {output_epub}")


if __name__ == "__main__":
    # 示例：转换当前目录下的 test.txt
    # 你可以修改为命令行参数 sys.argv[1]
    import sys

    if len(sys.argv) > 1:
        input_txt = sys.argv[1]
        output_name = input_txt.replace(".txt", ".epub")
        create_epub(input_txt, output_name)
    else:
        print("用法: uv run txt2epub.py <你的小说.txt>")
