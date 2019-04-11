from PIL import Image
import sys
import pyocr
import pyocr.builders

tools = pyocr.get_available_tools()

if len(tools) == 0:
    print("No OCR tool found")
    sys.exit(1)
tool = tools[0]

print("Will use tool {}".format(tool.get_name()))

langs = tool.get_available_languages()
print("Available languages: %s", ", ".join(langs))

txt = tool.image_to_string(
        Image.open('test.png'), 
        lang='jpn',
        builder=pyocr.builders.TextBuilder()
)
print(txt)
