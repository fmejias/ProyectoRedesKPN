/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package xmlcompiler;

import java.io.File;
import java.io.IOException;
import org.apache.commons.io.FileUtils;

/**
 *
 * @author Felipe
 */
public class UpdateQueueFiles {
    
    /*
     * Constructor of the class
     */
    public UpdateQueueFiles(){
        
    }
    
    /*
     * Method to search and change the string
     */
    
    public void updateFile() throws IOException{
       // String[] files = { "file1.txt", "file2.txt", "file3.txt" };
        String[] files = {"KPNModules/UpdateQueueTest.v"};
        for (String file : files) {
            File f = new File(file);
            String content = FileUtils.readFileToString(new File("KPNModules/UpdateQueueTest.v"));
            FileUtils.writeStringToFile(f, content.replaceAll("world", "hola")); //(StringToSearch, NewString)
        }
    }
    
    
}
