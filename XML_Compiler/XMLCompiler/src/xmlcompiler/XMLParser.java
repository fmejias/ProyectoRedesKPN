package xmlcompiler;

//Import XML-related packages
import java.io.IOException;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.ParserConfigurationException;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

/**
 *
 * Class need it to parse the XML Document
 */
public class XMLParser {
    
    /**
     * List of attributes
     */
    
    DocumentBuilderFactory factory;
    DocumentBuilder builder;
    Document xmlDoc;
    int actual_node;
    
    
    //Constructor of the class with no parameters
    public XMLParser(String filePath) throws ParserConfigurationException, SAXException, IOException
    {
        factory = DocumentBuilderFactory.newInstance();
        builder = factory.newDocumentBuilder();
        xmlDoc = builder.parse(filePath); 
        actual_node = 0;
    }
   
    /*
     * This method is used to get the root element
     */
    public void getRootElement()
    {
        xmlDoc.getDocumentElement().normalize();
        System.out.println("Root element :"  + xmlDoc.getDocumentElement().getNodeName());
    }
    
    /*
     * This method is used to get the number of modules need it for the KPN
     */
    public int getNumberOfModules()
    {
        //Get the number of nodes
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        int numberOfModules = nodesList.getLength();
        return numberOfModules;
    }
    
    /*
     * This method is used to get the rd signal for the FIFO 
     */
    public String[] getRdModule(String fifo)
    {
        //Get the number of nodes
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        int numberOfModules = getNumberOfModules();
        String[] rd = {"",""};
        for(int i = 0; i < numberOfModules; i++){
            int numberOfEntries = getNumberOfEntries(i);
            if(numberOfEntries == 1){
                String entry_1 = getModuleEntry1(i);
                String[] entry1_information = entry_1.split("_");
                entry_1 = entry1_information[0].replaceAll("\\s+","") + entry1_information[1];
                if(entry_1.equals(fifo)){
                    rd[0] = getModuleType(i);
                    rd[1] = getModuleId(i);
                }
            }
            else if (numberOfEntries == 2){
                String entry_1 = getModuleEntry1(i);
                String entry_2 = getModuleEntry2(i);
                String[] entry1_information = entry_1.split("_");
                String[] entry2_information = entry_2.split("_");
                entry_1 = entry1_information[0].replaceAll("\\s+","") + entry1_information[1];
                entry_2 = entry2_information[0].replaceAll("\\s+","") + entry2_information[1];

                if(entry_1.equals(fifo)){
                    rd[0] = getModuleType(i);
                    rd[1] = getModuleId(i);
                }
                else if(entry_2.equals(fifo)){
                    rd[0] = getModuleType(i);
                    rd[1] = getModuleId(i);
                }
            }
            
            
        }
        return rd;
    }
    
    /*
     * This method is used to get the type of the module need it for the KPN
     */
    public String getModuleType(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        String moduleType = eElement.getAttribute("type");
        return moduleType;
    }
    
    /*
     * This method is used to get all the elements of the queue
     */
    public String[] getModuleElements(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        String elements = eElement.getAttribute("elements");
        String[] elementsArray = elements.split(",");
        return elementsArray;
    }
    
    /*
     * This method is used to get the number of entries of the module 
     */
    public int getNumberOfEntries(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        int numberOfEntries = Integer.parseInt(eElement.getAttribute("entries"));
        return numberOfEntries;
    }
    
    /*
     * This method is used to get the id of the module need it for the KPN
     */
    public String getModuleId(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        String moduleId = eElement.getAttribute("id");
        return moduleId;
    }
    
    /*
     * This method is used to get all of the elements of the queues
     */
    public String getQueueElements(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        String queueElements = eElement.getAttribute("elements");
        return queueElements;
    }
    
    
    
    /*
     * This method is used to get the entry_1 of the module need it for the KPN
     */
    public String getModuleEntry1(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        String moduleEntry1 = eElement.getElementsByTagName("entry_1").item(0).getTextContent();
        return moduleEntry1;
    }
    
    /*
     * This method is used to get the entry_2 of the module need it for the KPN
     */
    public String getModuleEntry2(int numberOfModule)
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
        Node node = nodesList.item(numberOfModule);
        Element eElement = (Element) node;
        String moduleEntry2 = eElement.getElementsByTagName("entry_2").item(0).getTextContent();
        return moduleEntry2;
    }
    
    /*
     * This method is used to print all the nodes information
     */
    public void printNodesInformation()
    {
        NodeList nodesList = xmlDoc.getElementsByTagName("module");
         System.out.println("----------------------------");
         for (int i = 0; i < nodesList.getLength(); i++) {
            Node node = nodesList.item(i);
            System.out.println("\nCurrent Element :"  + node.getNodeName());
            if (node.getNodeType() == Node.ELEMENT_NODE) {
               
               // First, we obtain all the attributes of the node
               Element eElement = (Element) node;
               System.out.println("Module Id: " 
                  + eElement.getAttribute("id"));
               
               System.out.println("Module Type: " 
                  + eElement.getAttribute("type"));
               
               System.out.println("Module Entries: " 
                  + eElement.getAttribute("entries"));
               
               System.out.println("Module Outputs: " 
                  + eElement.getAttribute("outputs"));
               
               //Second, we obtain all the information of the node
               System.out.println("Entry_1: " 
                  + eElement.getElementsByTagName("entry_1").item(0).getTextContent());
               
               System.out.println("Entry_2: " 
                  + eElement.getElementsByTagName("entry_2").item(0).getTextContent());
               
               System.out.println("Output_1: " 
                  + eElement.getElementsByTagName("output_1").item(0).getTextContent());
               
            }
         }
    }
    
}
