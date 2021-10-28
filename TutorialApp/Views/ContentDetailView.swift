//
//  ContentDetailView.swift
//  TutorialApp
//
//  Created by mac on 10/8/21.
//

import SwiftUI
import AVKit
struct ContentDetailView: View {
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson // this represent a single row inside the lesson array, that is the currentLesson the user is viewing
        //wrap the "(lesson?.video ?? "") in a bracket to ensure it gets evaluated first before concantenating it, the lesson video "(lesson?.video ?? "") )" will get updated here immediately the currentLessonIndex changes when the model.nextLesson() is called
        let url = URL(string: Constants.videoHostUrl +  (lesson?.video ?? "") )
        
        VStack{
        //only show video if there is a valid URL
        if let urlString = url {
            VideoPlayer(player: AVPlayer(url: urlString))
                .cornerRadius(10)
        }
        
        // Description
        
        CodeTextView()
            
        // show  Next lesson button only if there is a next lesson
            
            if model.hasNextLesson(){
                Button {
                    // Advance to the next lesson and update the view
                    model.nextLesson()
                    
                } label: {
                    ZStack{
                        
                        Rectangle()
                            .frame(height:48)
                            .foregroundColor(Color.green)
                            .cornerRadius(10)
                            .shadow(radius: 5)
                        
                        Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                    
                   
                }
            }
      
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
