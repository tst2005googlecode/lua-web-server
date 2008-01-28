xmlp = require("xml.parser")
doc = xmlp.load("mime.xml")
print("\n" .. xmlp.tag(doc, "mime") .. "\n" .. xmlp.attrib(doc, "file", "ext"))
