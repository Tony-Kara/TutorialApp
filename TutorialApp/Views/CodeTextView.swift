//
//  CodeTextView.swift
//  TutorialApp
//
//  Created by mac on 10/29/21.
//

import SwiftUI

// we need to use a UITextView which is available in UIKIT, but we can use a protocol called UIViewRepresentable, implement it's methods and use this UlKit Class in our SwiftUI
struct CodeTextView: UIViewRepresentable {
    
    @EnvironmentObject var model: ContentModel
   
    func makeUIView(context: Context) -> UITextView {
        
        let textView = UITextView()
        textView.isEditable = false
        
        return textView
    }
    
   
    func updateUIView(_ textView: UITextView, context: Context) {
        
        //set the attributed text for the lesson, styling has been added to the lessonDescription in the ViewModel
        textView.attributedText = model.lessonDescription
        //scroll back to the top
        // this will allow the Text to scroll all the way up after the "Next lesson" button is clicked.
        textView.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: false)
    }
    
    
}

struct CodeTextView_Previews: PreviewProvider {
    static var previews: some View {
        CodeTextView()
    }
}
