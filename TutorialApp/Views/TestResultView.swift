//
//  TestResultView.swift
//  TutorialApp
//
//  Created by mac on 11/7/21.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    var numCorrect: Int
    
    // Depending on the score of the user using percentage, change the motivational text in this screen
    var resultHeading: String {
        
        guard model.currentModule != nil else{return ""}
        let pct = Double(numCorrect) / Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5 {
            return "Awesome"
        }
        
        else if pct > 0.5 {
            return "Doing great"
        }
        
        else{
            return "Keep learning"
        }
    }
    
    var body: some View {
        
        VStack{
            Spacer()
            
            Text(resultHeading)
                .font(.title)
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            Spacer()
            
            Button {
                // send the user back to the home view
                model.currentTestSelected  = nil
            } label: {
                ZStack{
                    
                    RectangleCard(color: .green)
                        .frame(height: 48)
                    
                    Text("Complete")
                        .bold()
                        .foregroundColor(.white)
                }
            }
            .padding()
            
            Spacer()

        }
       
    }
}

//struct TestResultView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestResultView()
//    }
//}
