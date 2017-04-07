/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package xmlcompiler;

import java.io.IOException;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;

/**
 *
 * @author Felipe
 */
public class XMLCompiler {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws ParserConfigurationException, 
            IOException, SAXException {
        
        // TODO code application logic here
        CodeGenerator xmlCompiler = new CodeGenerator();
        xmlCompiler.createKPN();

    }
    
}
