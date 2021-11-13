import base64
import json


def token_uri_to_svg(token_uri):
    x = base64.b64decode(token_uri[29:])
    jsonobj = json.loads(x)
    img = jsonobj["image"][26:]
    return str(base64.b64decode(img))
