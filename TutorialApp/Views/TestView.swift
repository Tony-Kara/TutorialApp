//
//  TestView.swift
//  TutorialApp
//
//  Created by mac on 10/30/21.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex: Int?
    @State var numCorrect = 0
    @State var submitted = false
    
    var body: some View {
        
        
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                    .padding(.leading, 20)
                // Question
               CodeTextView()
                    .padding(.horizontal,20)
                // Answers
                
                ScrollView {
                    
                    VStack{
                        
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self){ index in
                            
                            Button {
                                selectedAnswerIndex = index
                                
                            } label: {
                                ZStack{
                                    
                                    // use a conditional statement to set the colour, if index == selectedAnswerIndex, then colour should be set to gray, if not, white will be used, also if the submit button has not been clicked, use the rectangle inside the if statement
                                    if submitted == false {
                                        RectangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                        .frame(height: 48)
                                        
                                    }
                                    
                                    else if index == selectedAnswerIndex && index != model.currentQuestion!.correctIndex {
                                        // show a red background,user has submitted the wrong answer
                                        RectangleCard(color: .red)
                                        .frame(height: 48)
                                        
                                    }
                                    
                                    else if index == model.currentQuestion!.correctIndex {
                                        // user has submitted the right answer, show a green background
                                        RectangleCard(color: .green)
                                        .frame(height: 48)
                                    }
                                    
                                    else if index == selectedAnswerIndex && index == model.currentQuestion!.correctIndex {
                                        // Answer has been submitted
                                        // user has submitted the right answer, show a green background
                                            RectangleCard(color: .green)
                                            .frame(height: 48)
                                    }
                                    
                                    else {
                                        RectangleCard(color:Color.white)
                                        .frame(height: 48)
                                    }
                                
                                   
                                
                                
                                    Text("\(model.currentQuestion!.answers[index])")
                                 
                                }
                                
                            }
                            .disabled(submitted) // disable this button when the state property "submitted" changes to True, on initial load, the state property is set to false, if this changes to True, the button wil be disabled.
                            
                        
                   
                        }
                    }
                    .padding()
                    .accentColor(.black)                }
                
                // Buttons
                
                Button {
                    
                    // change submitted state to true
                    if submitted == true {
                        // Answer has been submitted, move to next question
                        model.nextQuestion()
                        
                        // Reset properties
                        submitted = false
                        selectedAnswerIndex = nil
                    }
                    
                    else {
                        //submit the answer
                        
                        //change submitted state to true
                        submitted = true
                        
                        //check the answer and increment the counter if correct
                        if selectedAnswerIndex == model.currentQuestion?.correctIndex {
                            numCorrect += 1
                        }
                    }
                    
                   
                    
                } label: {
                    ZStack{
                        // use a conditional statement to set the colour, if index == selectedAnswerIndex, then colour should be set to gray, if not, white will be used.
                        RectangleCard(color: .green)
                            .frame(height: 48)
                       
                        Text(buttonText)
                            .bold()
                            .foregroundColor(Color.white)
                     
                    }
                    .padding()
                    
                }
                .disabled(selectedAnswerIndex == nil) // if selectedAnswerIndex is nil and has no Int value, the condition here will be set to true and the button will be disable but once selectedAnswerIndex has a value, the condition will be false and you can click on the submit button.
                
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
        }
        else{
           // ProgressView()
            // if current question is nil and we have reach the last question in the quiz and the finish button is displayed, we show the result view WHICH IS the TestResultView, clicking finish in this new view will take us to the HomeView()
            TestResultView(numCorrect: numCorrect)
        }
    }
    
    var buttonText: String {
        // check if answer has been submitted
        if submitted == true {
            // This is the last question
            if model.currentQuestionIndex + 1  == model.currentModule?.test.questions.count {
                return "Finish"
            }
            else {
                return "Next"
            }
        }
        else {
            return "Submit"
        }
    }
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
