//
//  TestView.swift
//  TutorialApp
//
//  Created by mac on 10/30/21.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack {
                // Question number
               Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                // Question
               CodeTextView()
                // Answers
                
                // Buttons
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else{
            ProgressView()
        }
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
