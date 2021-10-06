//
//  ContentModel.swift
//  TutorialApp
//
//  Created by mac on 10/6/21.
//

import Foundation

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    
    // Current module, this will keep the state of things happening like "what lesson the user is looking at or what question the user is currently answering. create an instance of the model which will be specific to the Module dataType and not an array of Module() struct, in essence, i have created an array of [Module]() to loop and get what i generally require at the top hierachy which is the HomeView() and an instance of the Module() to get what i require on a deeper level after the user haas clicked on the module they are interested in.
    @Published var currentModule: Module?
    
    // current module index
    var currentModuleIndex = 0
    
    var styleData: Data?
    
    init(){
        
        getlocalData()
    }
    
    
    
    //MARK: - Data method
    
    func getlocalData() {
        
       
        
        // Get a url path to the json file, we use the "withextension as we will be parsing the additional style data
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json") // You can put a breakpoint here to test if you are parsing the data correctly, remerber, if you run into errors, you probably did not map your model properly
        
        do {
        // Read the file into a data object
            let jsonData = try Data(contentsOf: jsonUrl!)
       // Try to decode the json into an array of modules
        let jsonDecoder = JSONDecoder()
        let modules =  try  jsonDecoder.decode([Module].self, from: jsonData)
        
            self.modules =  modules // once you can po modules in the console after you run the simulator, you successfully parsed the data.
            
        }
        catch{
            print("could'nt parse local data")
        }
        
         
        //parse the style data
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
       
        do{
            //Read the file into a data object, leave it as data object and do not decode it as it is not actually a JSON object
            let styleData = try Data(contentsOf: styleUrl!)
            self.styleData = styleData
        }
        catch{
            print("could'nt parse style data")
        }
            
    }
    
    //MARK: - Module navigation methods
    
    
    func beginModule(_ moduleId:Int){
    // find the index for this module id
        for index in 0..<modules.count { //loop through the module array
            if modules[index].id == moduleId {
                // matching module has been found
                currentModuleIndex = index
                break
            }
            
        }
        
    // set the current module, this will allow me to enter the current module the user is looking at from the navigation link in the home screen
        currentModule = modules[currentModuleIndex]
    }
    
}
