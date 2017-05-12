/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package xmlcompiler;

import java.io.File;
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
     //   FixedPointParser parser = new FixedPointParser();
     //   String path = "C:/Users/Felipe/Desktop"
     //           + "/Tec/ProyectoDiseno/ProyectoGithub"
     //           + "/ProyectoRedesKPN/XML_Compiler/QueueFiles/queue_precharge_data.txt";
     //   parser.parserFixedPointNumbers(path, "4.7,6.5,200.4");
      //  UpdateQueueFiles update = new UpdateQueueFiles();
      //  update.updateFile();
      //  File directory = new File("KPNModules/UpdateQueueTest.v");
      //  System.out.println(directory.getAbsolutePath());
      

    }
    
}
