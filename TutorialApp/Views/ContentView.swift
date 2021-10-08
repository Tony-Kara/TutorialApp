//
//  ContentView.swift
//  TutorialApp
//
//  Created by mac on 10/7/21.
//

import SwiftUI

struct ContentView: View {
   // var module: Module // we will count on the Homeview passing the selected content from over there to here, this will allow us to drill down to the right content, BUT instead of passing through the model as in the recipe App i built earlier, another way to do this is by keeping track of the selected current model by the user using the viewmodel. note that i am drilling down into more layers in this app unlike the recipe App where i drill from the List of recipe --> the detail view of selected recipe.
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack{
                
                // Confirm that the currentModule is set
                if model.currentModule != nil {
                     // "lesson" is not an index number
                    ForEach(0..<model.currentModule!.content.lessons.count){ index in
                    
                        NavigationLink {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(index) // we will use this to get access to the current lesson
                                }
                        } label: {
                            ContentViewRow(index: index)
                        }

                        
                        
                }
                }
               
            }
            // change the font color of text inside the navigation link to black
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       
        ContentView()
    }
}
