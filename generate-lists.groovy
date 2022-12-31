#!/usr/bin/env groovy

import javax.xml.transform.*
import javax.xml.transform.stream.*
import groovy.xml.*


def transform = { out, xs, xml -> 
    def buffer = new StringWriter()
    TransformerFactory.newInstance().newTemplates(new StreamSource(xs as File)).newTransformer().transform(new StreamSource(xml as File), new StreamResult(buffer));

    def parser = new XmlParser(false, false, true)
    parser.trimWhitespace = true
    parser.keepIgnorableWhitespace = false
    def dom = parser.parseText(buffer as String)

    def result = XmlUtil.serialize(dom)
    result = result.replace('<?xml version="1.0" encoding="UTF-8"?>', '<?xml version="1.0" encoding="utf-8"?>\n') // JAVA XML PRETTY PRINTING IS PRETTY BUGGY :(
    result = result.replaceAll(/\s+\R+/, '\n')

    new File(out).setText(result, 'UTF-8')
}


transform('anime-list.xml', 'transforms/create-anime-list.xsl', 'anime-list-master.xml')
transform('anime-list-full.xml', 'transforms/create-anime-list-full.xsl', 'anime-list-master.xml')
transform('anime-list-unknown.xml', 'transforms/create-anime-list-unknown.xsl', 'anime-list-master.xml')
transform('anime-list-todo.xml', 'transforms/create-anime-list-todo.xsl', 'anime-list-master.xml')
transform('anime-movieset-list.xml', 'transforms/update-anime-movieset-list.xsl', 'anime-movieset-list.xml')