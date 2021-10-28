//
//  CodeTextView.swift
//  TutorialApp
//
//  Created by mac on 10/29/21.
//

import SwiftUI

struct CodeTextView: UIViewRepresentable {
   
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
   
    func updateUIView(_ textView: UITextView, context: Context) {
        
        //set the attributed text for the lesson
        textView.text = "testing"
        //scroll back to the top
    }
    
    
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
