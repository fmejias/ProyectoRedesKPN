/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package xmlcompiler;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

/**
 *
 * @author Felipe
 */
public class FixedPointParser {
    
    /**
     * List of attributes
     */
    int intDigits; //Total of digits for the int part of the number
    int decimalDigits; //Total of digits for the decimal part of the number
    BufferedWriter queueFile; //File that represents the queue file
    
    //Constructor of the class with no parameters
    public FixedPointParser() 
    {
        intDigits = 3;
        decimalDigits = 1;
    }
    
    /*
     * This method translates the fixed point number to hex format
     */
    public void parserFixedPointNumbers(String path, String elements) throws IOException{
        
        //Creates the queue file
        FileWriter writer = new FileWriter(path, true);
        PrintWriter pw1 = new PrintWriter(new BufferedWriter(writer));
        pw1.close(); // Make sure the first PrintWriter object name is different from the second one.

        queueFile = new BufferedWriter(writer);
        
        //Extract all the elements of the queue from the string of elements
        String[] queueElements = elements.split(",");
        
        
        //Loop to go over all of the elements
        for(int i = 0; i < queueElements.length; i++){
            
            //Extract the integer part and the decimal part
            String[] element = queueElements[i].split("\\.");
            
            //Get the integer part
            int integerPart = Integer.parseInt(element[0]);
          
            //This instruction convert the integer to hex string
            String integerPartToHex = "0000" + Integer.toHexString(integerPart);
            
            integerPartToHex = integerPartToHex.substring(integerPartToHex.length()-3,integerPartToHex.length());
            
            //Get the decimal part
            int decimalPart = Integer.parseInt(element[1]);
            
            //This instruction convert the decimal to hex string
            String decimalPartToHex = Integer.toHexString(decimalPart);
            
            //Concatenate the strings
            String hexToWrite = integerPartToHex + decimalPartToHex;
            
            //Write the element to the file
            queueFile.write(hexToWrite);
            queueFile.newLine();
        }
        
        //Close the queue file
        queueFile.close();
        
        
    }
    
    
    
}
