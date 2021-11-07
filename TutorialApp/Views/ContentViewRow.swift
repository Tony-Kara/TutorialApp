//
//  ContentViewRow.swift
//  TutorialApp
//
//  Created by mac on 10/8/21.
//

import SwiftUI

struct ContentViewRow: View {
    
    @EnvironmentObject var model: ContentModel
    var index: Int
    
    var lesson: Lesson {
        // here, i am performing checks to ensure that model.currentModule != nil and the currentModule has the right number of elements to avoid index out of range error
        if model.currentModule != nil && index < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[index]
        }
        
        else {
            return Lesson(id: 0, title: "", video: "", duration: "", explanation: "")
        }
    }
    
  
    
    var body: some View {
       
        // Lesson card
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame( height: 66)
            
            HStack(spacing: 30){
                
                Text(String(index + 1))
                    .bold()
                
                VStack(alignment: .leading) {
                    
                    Text(lesson.title)
                        .bold()
                    Text("Video - \(lesson.duration)")
                }
            }
            .padding()
            
        }
        .padding(.bottom, 5) // add padding to the bottom of each row
        
    }
}

