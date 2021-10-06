//
//  ContentView.swift
//  TutorialApp
//
//  Created by mac on 10/7/21.
//

import SwiftUI

struct ContentView: View {
   // var module: Module // we will count on the Homeview passing the selected content from over there to here, this will allow us to drill down to the right content, BUT instead of passing through the model as in the recipe App i built earlier, another way to do this is by keeping track of the selected current model by the user using the viewmodel
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack{
                
                // Confirm that the currentModule is set
                if model.currentModule != nil {
                     // "lesson" is not an index number
                    ForEach(0..<model.currentModule!.content.lessons.count){ index in
                    
                    // Lesson card
                    
                    ZStack {
                        
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                            .frame( height: 66)
                        
                        HStack(spacing: 30){
                            
                            Text(String(index + 1))
                            
                            VStack(alignment: .leading) {
                                
                                Text(model.currentModule!.content.lessons[index].title)
                                    .bold()
                                Text("Video - \(model.currentModule!.content.lessons[index].duration)")
                            }
                        }
                        
                    }
                }
                }
               
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       
        ContentView()
    }
}
