//
//  ContentModel.swift
//  TutorialApp
//
//  Created by mac on 10/6/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    var styleData: Data?
    
    init(){
        
        getlocalData()
    }
    
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
    
}
