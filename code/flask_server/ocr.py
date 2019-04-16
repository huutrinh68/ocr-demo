import pytesseract
import requests
from PIL import Image
from PIL import ImageFilter
from StringIO import StringIO
import pyocr
import pyocr.builders

def process_image(url):
#    tools = pyocr.get_available_tools()
#    if len(tools) == 0:
#        print("No OCR tool found")
#        sys.exit(1)
#    tool = tools[0]
#
#    print("Will use tool {}".format(tool.get_name()))
#
#    langs = tool.get_available_languages()
#    print("Available language: %s" % ", ".join(langs))
#    txt = tool.image_to_string(
#        _get_image(url),
#        lang='jpn',
#        builder=pyocr.builders.TextBuilder()
#    )
    image = _get_image(url)
    image.filter(ImageFilter.SHARPEN)

    return pytesseract.image_to_string(image, lang='eng')
    #return txt

def _get_image(url):
    return Image.open(StringIO(requests.get(url).content))
