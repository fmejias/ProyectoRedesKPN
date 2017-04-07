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

/**
 *
 * Class need it to generate KPN Hardware Code
 */
public class CodeGenerator {
    
    /**
     * List of attributes
     */
    String directoryPath; //Directory path of the KPNModules and Verilog Modules directory
    XMLParser xmlParser; //Need it to parse the XML File
    BufferedWriter top_module; //File that represents the top module
    
    //Constructor of the class with no parameters
    public CodeGenerator() throws ParserConfigurationException, SAXException, IOException 
    {
        directoryPath = "C:/Users/Felipe/Desktop"
                + "/Tec/ProyectoDiseno/ProyectoGithub"
                + "/ProyectoRedesKPN/XML_Compiler";  
        
        xmlParser = new XMLParser(directoryPath + "/SecondTest.xml"); 
        
    }
    
    
    /*
     * This method creates all the KPN in hardware code
     */
    public void createKPN() throws IOException{
        //This method is call to create the top mpdule
        codeGeneration();
        
        //This loop is necessary to get the files of the KPN
        int numberOfModules = xmlParser.getNumberOfModules();
        String moduleType;
        for(int i = 0; i < numberOfModules; i++){
            moduleType = xmlParser.getModuleType(i);
            addFileToKpnDirectory(moduleType);
            
        }
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
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("subtractor")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/subtractor_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/subtractor_module.v");
            File subtractorModule = new File(directoryPath + "/KPNModules/subtractor_module.v");
            if(!subtractorModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("delay")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/delay_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/delay_module.v");
            Files.copy(sourcePath, kpnPath);
            File delayModule = new File(directoryPath + "/KPNModules/delay_module.v");
            if(!delayModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("clock_divider")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/clock_divider.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/clock_divider.v");
            Files.copy(sourcePath, kpnPath);
            File clockModule = new File(directoryPath + "/KPNModules/clock_divider.v");
            if(!clockModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("fifo")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/fifo_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/fifo_module.v");
            Files.copy(sourcePath, kpnPath);
            File fifoModule = new File(directoryPath + "/KPNModules/fifo_module.v");
            if(!fifoModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("multiplier")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/multiplier_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/multiplier_module.v");
            Files.copy(sourcePath, kpnPath);
            File multiplierModule = new File(directoryPath + "/KPNModules/multiplier_module.v");
            if(!multiplierModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else if(moduleType.equals("split")){
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/split_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/split_module.v");
            Files.copy(sourcePath, kpnPath);
            File splitModule = new File(directoryPath + "/KPNModules/split_module.v");
            if(!splitModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
        }
        else{ //In this case, the type is queue
            Path kpnPath = Paths.get(directoryPath + "/KPNModules/queue_module.v");
            Path sourcePath = Paths.get(directoryPath + "/VerilogModules/queue_module.v");
            Files.copy(sourcePath, kpnPath);
            File queueModule = new File(directoryPath + "/KPNModules/queue_module.v");
            if(!queueModule.exists()) { 
                Files.copy(sourcePath, kpnPath);
            }
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
     * Third method: Generate the code for the top module
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
        
        //We rite the intermediate signals of the top module
        writeIntermediateSignalsTopModule();
        
        //We have to write some comments for the instantiated modules
        writeCommentsTopModule("Here, we instantiate the modules");
        
        //We have to write the instantiated modules
        writeInstantiatedModulesTopModule();
        
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
        top_module.write("output_1");
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
        top_module.write("output [15:0] output_1;");
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
        String finalSignal;
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
                instantiatedString = buildInstantiatedString(moduleType, moduleId, entry1, entry1);
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
            instantiatedString = "adder_module adder_module_inst_" + id + " ("
                    + ".clk(clk), " + ".entry_1(output_" + entry_1_information[0] 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")," + ".entry_2(output_" + entry_2_information[0]
                    + "_module_"  + entry_2_information[1] + "_" + 
                    entry_2_information[2] + "), " + ".output_1(output_" + type 
                    + "_module_" + id + "_1)" + ";"; 
            writeCommentsTopModule("This is an instance of the adder module");
        }
        else if(type.equals("subtractor")){
            instantiatedString = "subtractor_module subtractor_module_inst_" + id + " ("
                    + ".clk(clk), " + ".entry_1(output_" + entry_1_information[0] 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")," + ".entry_2(output_" + entry_2_information[0]
                    + "_module_"  + entry_2_information[1] + "_" + 
                    entry_2_information[2] + "), " + ".output_1(output_" + type 
                    + "_module_" + id + "_1" + ");";
            writeCommentsTopModule("This is an instance of the subtractor module");
        }
        else if(type.equals("delay")){
            instantiatedString = "delay_module delay_module_inst" + id + "("
                    + ".clk(clk), " + ".entry_1(output_" + entry_1_information[0] 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")," + ".output_1(output_" + type 
                    + "_module_" + id + "_1)" + ";";
            writeCommentsTopModule("This is an instance of the delay module");
        }
        else if(type.equals("fifo")){
            instantiatedString = "fifo_module fifo_module_inst" + id + "("
                    + ".clk(clk), " + ".entry_1(output_" + entry_1_information[0] 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")," + ".output_1(output_" + type 
                    + "_module_" + id + "_1)" + ";";
            writeCommentsTopModule("This is an instance of the fifo module");
        }
        else if(type.equals("multiplier")){
            instantiatedString = "multiplier_module multiplier_module_inst" + id + "("
                    + ".clk(clk), " + ".entry_1(output_" + entry_1_information[0] 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")," + ".entry_2(output_" + entry_2_information[0]
                    + "_module_"  + entry_2_information[1] + "_" + 
                    entry_2_information[2] + "), " + ".output_1(output_" + type 
                    + "_module_" + id + "_1)" + ";";
            writeCommentsTopModule("This is an instance of the multiplier module");
        }
        else if(type.equals("split")){
            instantiatedString = "split_module split_module_inst" + id + "("
                    + ".clk(clk), " + ".entry_1(output_" + entry_1_information[0] 
                    + "_module_"  + entry_1_information[1] + "_" + 
                    entry_1_information[2] + ")," + ".output_1(output_" + type 
                    + "_module_" + id + "_1)" + ".output_2(output_" + type 
                    + "_module_" + id + "_2)" + ";";
            writeCommentsTopModule("This is an instance of the split module");
        }
        else{ //This means the type is "queue"
            instantiatedString = "queue_module queue_module_inst" + id + "("
                    + ".clk(clk), " + ".output_1(output_" + type 
                    + "_module_" + id + "_1)" + ";";
            writeCommentsTopModule("This is an instance of the queue module");
        }
        return instantiatedString;
    }
}
