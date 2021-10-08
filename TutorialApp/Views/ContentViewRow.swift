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
                    
                    Text(model.currentModule!.content.lessons[index].title)
                        .bold()
                    Text("Video - \(model.currentModule!.content.lessons[index].duration)")
                }
            }
            .padding()
            
        }
        .padding(.bottom, 5) // add padding to the bottom of each row
        
    }
}

