//
//  ContentModel.swift
//  TutorialApp
//
//  Created by mac on 10/6/21.
//

import Foundation
import SwiftUI

class ContentModel: ObservableObject {
    // List of modules
    @Published var modules = [Module]()
    
    // Current module, this will keep the state of things happening like "what lesson the user is looking at or what question the user is currently answering. create an instance of the model which will be specific to the Module dataType and not an array of Module() struct, in essence, i have created an array of [Module]() to loop and get what i generally require at the top hierachy which is the HomeView() and an instance of the Module() to get what i require on a deeper level after the user has clicked on the module they are interested in.
    @Published var currentModule: Module?
    
    // current module index
    var currentModuleIndex = 0
    
    //Current Lesson( this is an array of various lessons,  @Published keyword will ensure that when the property "currentLesson" changes, any view relying on it is notified and will be updated, this is how we track the current lesson the user is viewing and update the view with the detail content.
    @Published var currentLesson: Lesson?
    //Keep track of the current lesson the user is viewing
    var currentLessonIndex = 0
    
    // current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0 
    
    @Published var codeText = NSAttributedString() // use this to add formatting(html and css) to the explanation text, we will be storing values from "currentQuestion!.content" and "currentLesson!.explanation" inside this property.
    
    // Current selected content and test, this will allow me to navigate from the selected lesson back to the Home view, i will save the Tag number inside this property, i will be using this property inside a navigationLink
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected:Int?
    
    var styleData: Data?
    
    init(){
        // Parse local included json data
        getlocalData()
        
        //  Download remote json file and parse data
        getRemoteData()
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
    
    
    func getRemoteData() {
        
        // string path
        let urlString = "https://tony-kara.github.io/TutorialAppData/data2.json"
        
        // create a url object
        let url = URL(string: urlString)
        
        // could not create a url
        guard url != nil else { return }
        
        // create a URLRequest object
        let request = URLRequest(url: url!)
        
        // Get the session and kick off the task
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            // check if there is an error
            guard error == nil else {
                // there was an error
                return
            }
            do{
              
                // Try to decode the json
                 let jsonDecoder = JSONDecoder()
                 let modules =  try jsonDecoder.decode([Module].self, from: data!)
                
                DispatchQueue.main.async {
                    // Append parsed modules into modules property
                    self.modules += modules
                }
                
            }
            catch{
                // could not parse json
            }
            
        }
        // kick off data task
        dataTask.resume()
        
        
        
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
        
    // set the current module, this will allow me to enter the current module the user is looking at from the navigation link in the home screen, this answers the question of what module the user clicked on, on which row number which is dertermined by the index number of the Module array
        currentModule = modules[currentModuleIndex]
    }
    
    
    //MARK: - Lesson Navigation methods
    // use this to drill from the ContentView() to the ContentDetailView(() 
    func beginLesson(_ lessonIndex: Int){
        
        // check that the lesson index is within range of module lessons
        
        if lessonIndex < (currentModule!.content.lessons.count) {
            
            currentLessonIndex = lessonIndex
        }
        else{
            currentLessonIndex = 0
        }
        //set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex] // This answers the question of what lesson the user clicks on, on which row number which is dertermined by the index number of the lesson array.
        
        // create an attributedText with styling from the explanation text, more like converting the html contents to an attributed string that can be used in displaying Texts that contains styling
        codeText = addStyling(currentLesson!.explanation)
    }
    
    
    func hasNextLesson() -> Bool {
        
        guard currentModule != nil else {
            return false // return view to the Homescreen if currentModule == nil
        }
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        }
        else{
            return false
        }
    }
    
    // This is for the test part of the module
    func beginTest(_ moduleId: Int) {
        
        // Set the current module
        beginModule(moduleId)
        
        // Set the current question index
        currentQuestionIndex = 0
        
        //if there are questions, set the current question to the first one
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule?.test.questions[currentQuestionIndex]
            
            // Set the question content as an attributed text
            codeText = addStyling(currentQuestion!.content)
        }
        
        
        
    }
    
    
    func nextLesson() {
        
        // Advance to the next lesson index
        currentLessonIndex += 1
        
        //check that it is within range
        if currentLessonIndex  <  currentModule!.content.lessons.count {
            //set the current lesson property, currentLesson has the published keywork, any changes to it is listened to and view using it will get updated
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            
            // create an attributedText with styling from the explanation text
            codeText = addStyling(currentLesson!.explanation)
        }
        else {
            //Reset the lesson state
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func nextQuestion() {
        // Advance the questioon index
        currentQuestionIndex += 1
        
        // check if it's within the range of questions
        if currentQuestionIndex < currentModule!.test.questions.count {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            codeText = addStyling(currentQuestion!.content)
        }
        
        else {
            // if it's out of range, then reset the properties
            currentQuestionIndex = 0
            currentQuestion = nil
        }
            
    }
    
    //MARK: - Code Styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        var resultString = NSAttributedString()
        var data = Data()
    
        // Add the styling data
        if let styleDataUpdate = styleData {
            data.append(styleDataUpdate)
        }
        // Add the html data
        data.append(Data(htmlString.utf8)) // the htmlString is the explanation text
        
        // Convert to attributed string
        
        do {
             let attributedString = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                resultString = attributedString
            
            
        }
        catch {
            print("Could not turn html to attributed string")
        }
        
       
        return resultString
    }
    
    
    
}
