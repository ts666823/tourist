package com.WebServeSOA;

import org.xml.sax.ErrorHandler;
import org.xml.sax.SAXException;
import org.xml.sax.SAXParseException;

import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;
import java.io.File;

/**
 * @author tangshuo
 * @version 1.0.0
 * @ClassName Validate.java
 * @Description TODO
 * @createTime 2021年10月18日 20:26:00
 */
public class Validate {
    public static void main(String[] args) throws Exception {
//        if (args.length < 2) {
//            System.out.print("usage：cmd xsdfile xmlfile");
//            System.exit(0);
//        }
        SchemaFactory schemaFactory = SchemaFactory
                .newInstance("http://www.w3.org/2001/XMLSchema");

        Schema schema = schemaFactory.newSchema(new File("/Users/tangshuo/Downloads/SchemaXML/src/resource/note.xsd"));
        Validator validator = schema.newValidator();
        validator.setErrorHandler(new ErrorHandler() {

            public void warning(SAXParseException exception)
                    throws SAXException {
                System.out.println("警告：" + exception);
            }

            public void fatalError(SAXParseException exception)
                    throws SAXException {
                System.out.println("致命：" + exception);
            }

            public void error(SAXParseException exception) throws SAXException {
                System.out.println("错误：" + exception);

            }
        });
        validator.validate(new StreamSource(new File("/Users/tangshuo/Downloads/SchemaXML/src/resource/note.xml")));
    }

}
