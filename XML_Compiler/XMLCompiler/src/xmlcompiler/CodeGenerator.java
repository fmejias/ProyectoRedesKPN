package xmlcompiler;

//Import Packages need it to read and write files and directories
import java.io.File;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;
import org.apache.commons.io.FileUtils;

/**
 *
 * Class need it to generate KPN Hardware Code
 */
public class CodeGenerator {
    
    /**
     * List of attributes
     */
    String directoryPath; //Directory path of the KPNModules and Verilog Modules directory
    String firstQueueStringToChange; //Contains the string: module queue_module
    String secondQueueStringToChange; //Containts the string: $readmemh 
    int queueModuleFiles; //Use to update the queue file name
    XMLParser xmlParser; //Need it to parse the XML File
    BufferedWriter top_module; //File that represents the top module
    FixedPointParser fixedPointTranslator; //Use to parse the fixed point for the queue file
    boolean isLCDFIFO; //Use to indicate which FIFO is the LCD FIFO
    
    //Constructor of the class with no parameters
    public CodeGenerator() throws ParserConfigurationException, SAXException, IOException 
    {
        //Set the directory path where the verilog modules are located
        directoryPath = "C:/Users/Felipe/Desktop"
                + "/Tec/ProyectoDiseno/ProyectoGithub"
                + "/ProyectoRedesKPN/XML_Compiler";  
        
        //Parse the XML File
        xmlParser = new XMLParser(directoryPath + "/EjemploCompletoKPN1.xml");  
        
        //Set the first string value to change in the queue module
        firstQueueStringToChange = "module queue_module\\(";
        
        //Set the second string value to change in the queue module
        secondQueueStringToChange = "\\$readmemh\\(\"C:/Users/Felipe/Desktop/Tec/"
                + "ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/"
                + "KPN_From_XML/QueueFiles/"
                + "queue_precharge_data.txt\", array_reg\\);";
        
        //Set the queueModuleFiles to 1
        queueModuleFiles = 1;
        
        //Create the FixedPointTranslator
        fixedPointTranslator = new FixedPointParser();
        
        //Set the FIFO value
        isLCDFIFO = false;
    }
    
    
    /*
     * This method creates all the KPN in hardware code
     */
    public void createKPN() throws IOException{
        //First, clean all of the files that are the directory name KPNModules
        cleanKPNDirectory();
        
        //This method is call to create the top module
        codeGeneration();
        
        //This loop is necessary to get the modules files of the KPN
        int numberOfModules = xmlParser.getNumberOfModules();
        String moduleType;
        for(int i = 0; i < numberOfModules; i++){
            moduleType = xmlParser.getModuleType(i);
            addFileToKpnDirectory(moduleType);
        }
        
        //Add the bcd file, the lcd_fifo file, the display and lcd files
        Path kpnPath = Paths.get(directoryPath + "/KPNModules/lcd_fifo.v");
        Path sourcePath = Paths.get(directoryPath + "/VerilogModules/lcd_fifo.v");
        File module = new File(directoryPath + "/KPNModules/lcd_fifo.v");
        if(!module.exists()) { 
            //Then, copy the file from the source path to the file in the kpn path
            Files.copy(sourcePath, kpnPath);
        }
        
        kpnPath = Paths.get(directoryPath + "/KPNModules/bcd_converter.v");
        sourcePath = Paths.get(directoryPath + "/VerilogModules/bcd_converter.v");
        module = new File(directoryPath + "/KPNModules/bcd_converter.v");
        if(!module.exists()) { 
            //Then, copy the file from the source path to the file in the kpn path
            Files.copy(sourcePath, kpnPath);
        }
        
        kpnPath = Paths.get(directoryPath + "/KPNModules/lcd_module.v");
        sourcePath = Paths.get(directoryPath + "/VerilogModules/lcd_module.v");
        module = new File(directoryPath + "/KPNModules/lcd_module.v");
        if(!module.exists()) { 
            //Then, copy the file from the source path to the file in the kpn path
            Files.copy(sourcePath, kpnPath);
        }
        
        kpnPath = Paths.get(directoryPath + "/KPNModules/write_to_display.v");
        sourcePath = Paths.get(directoryPath + "/VerilogModules/write_to_display.v");
        module = new File(directoryPath + "/KPNModules/write_to_display.v");
        if(!module.exists()) { 
            //Then, copy the file from the source path to the file in the kpn path
            Files.copy(sourcePath, kpnPath);
        }
        
        kpnPath = Paths.get(directoryPath + "/KPNModules/clock_divider_module.v");
        sourcePath = Paths.get(directoryPath + "/VerilogModules/clock_divider_module.v");
        module = new File(directoryPath + "/KPNModules/clock_divider_module.v");
        if(!module.exists()) { 
            //Then, copy the file from the source path to the file in the kpn path
            Files.copy(sourcePath, kpnPath);
        }
        
        //Update the queue_modules files
        updateQueueModules();
    }
    
    /*
     * This method delete all the files on the KPN Directory
     */
    public void cleanKPNDirectory() throws IOException{
        FileUtils.cleanDirectory(new File(directoryPath + "/KPNModules/")); 
    }
    
    /*
     * This method add the files need it to create the KPN to the KPN Directory
     */
    public void addFileToKpnDirectory(String moduleType) throws IOException
    {
        if(moduleType.equals("adder")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/adder_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/adder_module.v");
            File adderModule = new File(directoryPath + "/KPNModules/adder_module.v");
            if(!adderModule.exists()) { 
                //Then, copy the file from the source path to the file in the kpn path
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("subtractor")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/subtractor_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/subtractor_module.v");
            File subtractorModule = new File(directoryPath + "/KPNModules/subtractor_module.v");
            if(!subtractorModule.exists()) { 
                //Then, copy the file from the source path to the file in the kpn path
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("delay")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/delay_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/delay_module.v");
            File delayModule = new File(directoryPath + "/KPNModules/delay_module.v");
            if(!delayModule.exists()) { 
                //Then, copy the file from the source path to the file in the kpn path
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("clock_divider")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/clock_divider.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/clock_divider.v");
            File clockModule = new File(directoryPath + "/KPNModules/clock_divider.v");
            if(!clockModule.exists()) { 
                //Then, copy the file from the source path to the file in the kpn path
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("fifo")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/fifo_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/fifo_module.v");
            File fifoModule = new File(directoryPath + "/KPNModules/fifo_module.v");
            if(!fifoModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("multiplier")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/multiplier_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/multiplier_module.v");
            File multiplierModule = new File(directoryPath + "/KPNModules/multiplier_module.v");
            if(!multiplierModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("split")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/split_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/split_module.v");
            File splitModule = new File(directoryPath + "/KPNModules/split_module.v");
            if(!splitModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else{ //In this case, the type is queue
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/queue_module" + Integer.toString(queueModuleFiles) + ".v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/queue_module.v");
            File queueModule = new File(directoryPath + "/KPNModules/queue_module" + Integer.toString(queueModuleFiles) + ".v");
            if(!queueModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
            queueModuleFiles = queueModuleFiles + 1;
        }
    }
    
    
    /*
     * Second method: Create the top module file
     */
    public BufferedWriter createTopModuleFile() throws IOException{
        
        //First, we have to create the file
        FileWriter writer = new FileWriter(directoryPath + "/KPNModules/top_module.v", true);
        BufferedWriter bufferedWriter = new BufferedWriter(writer);
        
        return bufferedWriter;
    }
    
    /*
     * Third method: Generate the code for the top module file
     */
    public void codeGeneration() throws IOException{
        //First, we have to create the top_module file
        top_module = createTopModuleFile();
        
        //Second, we have to write the name of the entries and the outputs of the top module
        writeNameEntriesOutputsTopModule();
        
        //We have to write some comments for the entries and outputs
        writeCommentsTopModule("We define the type of entries and outputs");
        
        //We have to write the type of the entries and the outputs of the top module
        writeTypeEntriesOutputsTopModule();
        
        //We have to write some comments for the entries and outputs
        writeCommentsTopModule("Here, we declare some signals need it to pass "
                + "information between modules");
        
        //We write the intermediate signals of the top module
        writeIntermediateSignalsTopModule();
        
        //We have to write some comments for the instantiated modules
        writeCommentsTopModule("Here, we instantiate the modules");
        top_module.newLine();
        
        //We have to write the instantiated modules
        writeInstantiatedModulesTopModule();
        
        //We have to create the queue_precharge_data_files
        createQueuePrechargeDataFiles();
        
        //Write the last line endmodule
        top_module.write("endmodule");
        top_module.newLine();
        
        //Set the variable queueModuleFiles to 1 again
        queueModuleFiles = 1;
        
        //We close the top_module file
        top_module.close();
    }
    
    /*
     * Fourth method: Write the entries and the outputs of the top module
     */
    public void writeNameEntriesOutputsTopModule() throws IOException{
        //First, we have to write the entries
        top_module.write("module top_module (");
        top_module.newLine();
        top_module.write("clk,");
        top_module.newLine();
        top_module.write("rs,");
        top_module.newLine();
        top_module.write("rw,");
        top_module.newLine();
        top_module.write("on,");
        top_module.newLine();
        top_module.write("en,");
        top_module.newLine();
        top_module.write("lcd_data,");
        top_module.newLine();
        top_module.write("hex_4,");
        top_module.newLine();
        top_module.write("hex_3,");
        top_module.newLine();
        top_module.write("hex_2,");
        top_module.newLine();
        top_module.write("hex_1,");
        top_module.newLine();
        top_module.write("hex_0");
        top_module.newLine();
        top_module.write(");");
        top_module.newLine();
        top_module.newLine();
        top_module.newLine();
    }
    
    
    /*
     * Fifth method: Write comments for the code
     */
    public void writeCommentsTopModule(String comment) throws IOException{
        //First, we have to write the entries
        top_module.write("/*");
        top_module.newLine();
        top_module.write(" * " + comment);
        top_module.newLine();
        top_module.write(" */");
        top_module.newLine();
    }
    
    /*
     * Write the type of entries and the outputs of the top module
     */
    public void writeTypeEntriesOutputsTopModule() throws IOException{
        //First, we have to write the entries
        top_module.write("input clk;");
        top_module.newLine();
        top_module.write("output rs;");
        top_module.newLine();
        top_module.write("output rw;");
        top_module.newLine();
        top_module.write("output on;");
        top_module.newLine();
        top_module.write("output en;");
        top_module.newLine();
        top_module.write("output [7:0] lcd_data;");
        top_module.newLine();
        top_module.write("output [6:0] hex_4;");
        top_module.newLine();
        top_module.write("output [6:0] hex_3;");
        top_module.newLine();
        top_module.write("output [6:0] hex_2;");
        top_module.newLine();
        top_module.write("output [6:0] hex_1;");
        top_module.newLine();
        top_module.write("output [6:0] hex_0;");
        top_module.newLine();
        top_module.newLine();
        top_module.newLine();

    }
    
    /*
     * Write the intermediate signals of the top module
     */
    public void writeIntermediateSignalsTopModule() throws IOException{
        //We have to write the intermediate signals
        int numberOfModules = xmlParser.getNumberOfModules();
        String moduleId;
        String moduleType;
        String generalSignal = "wire [15:0] output_";
        String rdSignal = "wire [15:0] rd_";
        String wrSignal = "wire [15:0] wr_";
        String finalRdSignal;
        String finalWrSignal;
        String finalSignal;
    
        /* Write some signals need it to activate the LCD and Display */
        
        //Write the kpn_clk signal first
        top_module.write("wire kpn_clk;");
        top_module.newLine();
        
        //Write the bcd output wire 
        top_module.write("wire [15:0] bcd_output;");
        top_module.newLine();
        
        //Write some lcd signals
        top_module.write("wire lcd_rd;");
        top_module.newLine();
        
        //This loop writes the wr and rd signals of each module
        for(int j = 0; j < numberOfModules; j++){
            moduleId = xmlParser.getModuleId(j);
            moduleType = xmlParser.getModuleType(j);
            
            if(moduleType.equals("fifo")){
                
            }
            else if(moduleType.equals("queue")){
                finalWrSignal = wrSignal + moduleType + "_module_" + moduleId + ";";
                top_module.write(finalWrSignal);
                top_module.newLine();
            }
            else{
                finalRdSignal = rdSignal + moduleType + "_module_" + moduleId + ";";
                finalWrSignal = wrSignal + moduleType + "_module_" + moduleId + ";";
                top_module.write(finalRdSignal);
                top_module.newLine();
                top_module.write(finalWrSignal);
                top_module.newLine();
            }
        }
        
        //This loop writes the outputs of each module
        for(int i = 0; i < numberOfModules; i++){
            moduleId = xmlParser.getModuleId(i);
            moduleType = xmlParser.getModuleType(i);
            finalSignal = generalSignal + moduleType + "_module_" + moduleId + "_1;";
            top_module.write(finalSignal);
            top_module.newLine();
            
            if(moduleType.equals("split")){
                finalSignal = generalSignal + moduleType + "_module_" + moduleId + "_2;";
                top_module.write(finalSignal);
                top_module.newLine();
            }
        }
        top_module.newLine();
    }
    
    /*
     * Write the instantiated modules of the top module
     */
    public void writeInstantiatedModulesTopModule() throws IOException{
        //We have to write the intermediate signals
        int numberOfModules = xmlParser.getNumberOfModules();
        String entry1;
        String entry2;
        String moduleType;
        String moduleId;
        int numberOfEntries = 0;
        String instantiatedString;
        
        
        //First, write the clock_divider, lcd and display modules instantiated
        
        //Write a comment for the instantiated module
        writeCommentsTopModule("This is an instance of the clock_divider module");
        top_module.write("clock_divider_module clk_inst(.clk_in(clk), .clk_out(kpn_clk));");
        top_module.newLine();
        top_module.newLine();
        
        //Write a comment for the instantiated module
        writeCommentsTopModule("This is an instance of the display module");
        top_module.write("write_to_display display_inst(.clk(kpn_clk), "
                + ".entry_1(bcd_output), .hex_4(hex_4), .hex_3(hex_3), "
                + ".hex_2(hex_2), .hex_1(hex_1), .hex_0(hex_0));");
        top_module.newLine();
        top_module.newLine();
        
        //Write a comment for the instantiated module
        writeCommentsTopModule("This is an instance of the LCD module");
        top_module.write("lcd_module write_to_lcd_inst(.clock(kpn_clk), "
                + ".entry_1(bcd_output), .rs(rs), .rw(rw), .on(on), "
                + ".enable(en), .lcd_data(lcd_data) , .rd(lcd_rd));");
        top_module.newLine();
        top_module.newLine();
        
        
        //Go over all the modules need it to instantiate
        for(int i = 0; i < numberOfModules; i++){
            moduleId = xmlParser.getModuleId(i);
            moduleType = xmlParser.getModuleType(i);
            numberOfEntries = xmlParser.getNumberOfEntries(i);
            if(numberOfEntries == 2){
                entry1 = xmlParser.getModuleEntry1(i);
                entry2 = xmlParser.getModuleEntry2(i);
                instantiatedString = buildInstantiatedString(moduleType, moduleId, entry1, entry2);
                top_module.write(instantiatedString);
                top_module.newLine();
                top_module.newLine();
            }
            else if (numberOfEntries == 1){
                entry1 = xmlParser.getModuleEntry1(i);
                isLCDFIFO = xmlParser.getLCDFIFO(i);
                instantiatedString = buildInstantiatedString(moduleType, moduleId, entry1, entry1);
                top_module.write(instantiatedString);
                top_module.newLine();
                top_module.newLine();
            }
            else{
                instantiatedString = buildInstantiatedString(moduleType, moduleId, "_", "_");
                top_module.write(instantiatedString);
                top_module.newLine();
                top_module.newLine();
            }
            
        }
    }
    
    /*
     * Build the string to instantiate a module
     */
    public String buildInstantiatedString(String type, String id, 
            String entry_1, String entry_2) throws IOException{
        
        String instantiatedString = "";
        String[] entry_1_information = entry_1.split("_");
        String[] entry_2_information = entry_2.split("_");
        if(type.equals("adder")){
            String header = "adder_module adder_module_inst_" + id;
            String openParenthesis = "(";
            String closeParenthesis = ")";
            String comma = ", ";
            String semicolon = ";";
            String clk = ".clk(kpn_clk)";
            String rd = ".rd(rd_" + type + "_module_" + id + ")";
            String wr = ".wr(wr_" + type + "_module_" + id + ")";
            String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")";
            String secondEntry = ".entry_2(output_" + entry_2_information[0].replaceAll("\\s+","")
                    + "_module_"  + entry_2_information[1] + "_" + 
                    entry_2_information[2] + ")";
            String output = ".output_1(output_" + type + "_module_" + id + "_1)";
            
            instantiatedString = header + openParenthesis + clk + comma + rd + comma + wr + comma +
                    firstEntry + comma + secondEntry + comma + output + closeParenthesis + semicolon;
            
            
            //Write a comment for the instantiated module
            writeCommentsTopModule("This is an instance of the adder module");
        }
        else if(type.equals("subtractor")){
            String header = "subtractor_module subtractor_module_inst_" + id;
            String openParenthesis = "(";
            String closeParenthesis = ")";
            String comma = ", ";
            String semicolon = ";";
            String clk = ".clk(kpn_clk)";
            String rd = ".rd(rd_" + type + "_module_" + id + ")";
            String wr = ".wr(wr_" + type + "_module_" + id + ")";
            String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")";
            String secondEntry = ".entry_2(output_" + entry_2_information[0].replaceAll("\\s+","")
                    + "_module_"  + entry_2_information[1] + "_" + 
                    entry_2_information[2] + ")";
            String output = ".output_1(output_" + type + "_module_" + id + "_1)";
            
            instantiatedString = header + openParenthesis + clk + comma + rd + comma + wr + comma +
                    firstEntry + comma + secondEntry + comma + output + closeParenthesis + semicolon;
            
            //Write a comment for the instantiated module
            writeCommentsTopModule("This is an instance of the subtractor module");
        }
        else if(type.equals("delay")){
            String header = "delay_module delay_module_inst" + id;
            String openParenthesis = "(";
            String closeParenthesis = ")";
            String comma = ", ";
            String semicolon = ";";
            String clk = ".clk(kpn_clk)";
            String rd = ".rd(rd_" + type + "_module_" + id + ")";
            String wr = ".wr(wr_" + type + "_module_" + id + ")";
            String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")";
            String output = ".output_1(output_" + type + "_module_" + id + "_1)";
            
            instantiatedString = header + openParenthesis + clk + comma + rd + comma + wr + comma +
                    firstEntry +  comma + output + closeParenthesis + semicolon;
            
            //Write a comment for the instantiated module
            writeCommentsTopModule("This is an instance of the delay module");
        }
        else if(type.equals("fifo")){
            if(isLCDFIFO == false){
                String header = "fifo_module fifo_module_inst" + id;
                String openParenthesis = "(";
                String closeParenthesis = ")";
                String comma = ", ";
                String semicolon = ";";
                String clk = ".clk(kpn_clk)";
                String wr = ".wr(wr_" + entry_1_information[0].replaceAll("\\s+","") + "_"
                        + "module_" + entry_1_information[1] + ")";
                String fifo = type + id;
                String[] rd = searchRdModule(fifo);
                String rdInstruction = ".rd(rd_" + rd[0] + "_module_" + rd[1] + ")";
                String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                        + "_module_"  + entry_1_information[1] + "_" + 
                        entry_1_information[2] + ")";
                String output = ".output_1(output_" + type + "_module_" + id + "_1)";

                instantiatedString = header + openParenthesis + clk + comma + rdInstruction + comma + wr + comma +
                        firstEntry +  comma + output + closeParenthesis + semicolon;

                //Write a comment for the instantiated module
                writeCommentsTopModule("This is an instance of the fifo module");
            }
            else{
                String header = "lcd_fifo fifo_module_inst" + id;
                String openParenthesis = "(";
                String closeParenthesis = ")";
                String comma = ", ";
                String semicolon = ";";
                String clk = ".clk(kpn_clk)";
                String wr = ".wr(wr_" + entry_1_information[0].replaceAll("\\s+","") + "_"
                        + "module_" + entry_1_information[1] + ")";
                String fifo = type + id;
                String rdInstruction = ".rd(" + "lcd_rd" + ")";
                String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                        + "_module_"  + entry_1_information[1] + "_" + 
                        entry_1_information[2] + ")";
                String output = ".output_1(output_" + type + "_module_" + id + "_1)";

                instantiatedString = header + openParenthesis + clk + comma + rdInstruction + comma + wr + comma +
                        firstEntry +  comma + output + closeParenthesis + semicolon;
                
                //Write the bcd converter instance
                //Write a comment for the instantiated module
                writeCommentsTopModule("This is an instance of the bcd_converter module");
                top_module.write("bcd_converter bcd_converter_inst(.clk(kpn_clk), "
                        + ".binary_number(" + "output_" + type + "_module_" + id + "_1" + "), .bcd_number(bcd_output));");
                
                top_module.newLine();
                top_module.newLine();
                
                //Write a comment for the instantiated module
                writeCommentsTopModule("This is an instance of the fifo module");
            }
            
        }
        else if(type.equals("multiplier")){
            String header = "multiplier_module multiplier_module_inst" + id;
            String openParenthesis = "(";
            String closeParenthesis = ")";
            String comma = ", ";
            String semicolon = ";";
            String clk = ".clk(kpn_clk)";
            String rd = ".rd(rd_" + type + "_module_" + id + ")";
            String wr = ".wr(wr_" + type + "_module_" + id + ")";
            String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")";
            String secondEntry = ".entry_2(output_" + entry_2_information[0].replaceAll("\\s+","")
                    + "_module_"  + entry_2_information[1] + "_" + 
                    entry_2_information[2] + ")";
            String output = ".output_1(output_" + type + "_module_" + id + "_1)";
            
            instantiatedString = header + openParenthesis + clk + comma + rd + comma + wr + comma +
                    firstEntry + comma + secondEntry + comma + output + closeParenthesis + semicolon;
            
            //Write a comment for the instantiated module
            writeCommentsTopModule("This is an instance of the multiplier module");
        }
        else if(type.equals("split")){
            String header = "split_module split_module_inst" + id;
            String openParenthesis = "(";
            String closeParenthesis = ")";
            String comma = ", ";
            String semicolon = ";";
            String clk = ".clk(kpn_clk)";
            String rd = ".rd(rd_" + type + "_module_" + id + ")";
            String wr = ".wr(wr_" + type + "_module_" + id + ")";
            String firstEntry = ".entry_1(output_" + entry_1_information[0].replaceAll("\\s+","") 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")";
            String firstOutput = ".output_1(output_" + type + "_module_" + id + "_1)";
            String secondOutput = ".output_2(output_" + type + "_module_" + id + "_2)";
            
            instantiatedString = header + openParenthesis + clk + comma + rd + comma + wr + comma +
                    firstEntry +  comma + firstOutput + comma + secondOutput + closeParenthesis + semicolon;
            
            //Write a comment for the instantiated module
            writeCommentsTopModule("This is an instance of the split module");
        }
        else{ //This means the type is "queue"
            String header = "queue_module" + Integer.toString(queueModuleFiles) + " queue_module_inst" + id;
            String openParenthesis = "(";
            String closeParenthesis = ")";
            String comma = ", ";
            String semicolon = ";";
            String clk = ".clk(kpn_clk)";
            String wr = ".wr(wr_" + type + "_module_" + id + ")";
            String output = ".output_1(output_" + type + "_module_" + id + "_1)";
            
            instantiatedString = header + openParenthesis + clk + comma + wr + comma + output 
                    + closeParenthesis + semicolon;
            
            //Write a comment for the instantiated module
            writeCommentsTopModule("This is an instance of the queue module");
            
            //Update the variable queueModuleFiles
            queueModuleFiles = queueModuleFiles + 1;
        }
        return instantiatedString;
    }
    
    /*
     * Search for the rd to complete the module
     */
    public String[] searchRdModule(String fifo) throws IOException{
        //First, we have to write the entries
        return xmlParser.getRdModule(fifo);
    }
    
    /*
     * Create the queue_precharge_data files
     */
    public void createQueuePrechargeDataFiles() throws IOException{
        
        //Directory for the queue output files
        String queueFilesPath = directoryPath + "/QueueFiles/";
        String fileName = "queue_precharge_data";
        String newQueueFilePath = "";
        String queueElements = "";
        int outputFileNumber = 1;
        
        //This loop is necessary to get the modules files of the KPN
        int numberOfModules = xmlParser.getNumberOfModules();
        String moduleType;
        
        for(int i = 0; i < numberOfModules; i++){
            moduleType = xmlParser.getModuleType(i);
            
            if(moduleType.equals("queue")){
                //Get all the elements of the queue
                queueElements = xmlParser.getQueueElements(i);
                
                //Set the new path
                newQueueFilePath = queueFilesPath + fileName + Integer.toString(outputFileNumber) + ".txt";
                
                //Go and create the file
                fixedPointTranslator.parserFixedPointNumbers(newQueueFilePath, queueElements);
                
                //Update the output file number
                outputFileNumber = outputFileNumber + 1;
            }
        }
     
    }
    
    
    /*
    This method is use to change some lines in the queue files
    */
    public void updateQueueModules() throws IOException{
        //Directory for the queue output files
        String queueFilesPath = directoryPath + "/KPNModules/";
        String fileName = "queue_module";
        String newQueueFilePath = "";
        String firstString = "module queue_module";
        String secondString = "\\$readmemh\\(\"C:/Users/Felipe/Desktop/Tec/"
                + "ProyectoDiseno/ProyectoGithub/ProyectoRedesKPN/KPN_Modules/"
                + "KPN_From_XML/QueueFiles/"
                + "queue_precharge_data";
        
        for(int i = 1; i < queueModuleFiles; i++){
            newQueueFilePath = queueFilesPath + fileName + Integer.toString(i) + ".v";
            File f = new File(newQueueFilePath);
            String content = FileUtils.readFileToString(new File(newQueueFilePath));
            FileUtils.writeStringToFile(f, content.replaceAll(firstQueueStringToChange, 
                    firstString + Integer.toString(i) + "("));      
        } 
        
        for(int i = 1; i < queueModuleFiles; i++){
            newQueueFilePath = queueFilesPath + fileName + Integer.toString(i) + ".v";
            File f = new File(newQueueFilePath);
            String content = FileUtils.readFileToString(new File(newQueueFilePath));
            FileUtils.writeStringToFile(f, content.replaceAll(secondQueueStringToChange, 
                    secondString + Integer.toString(i) + ".txt\", array_reg\\);"));
            
        }
    }
}
