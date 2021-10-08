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
        
        let lesson = model.currentLesson
        //wrap the "(lesson?.video ?? "") in a bracket to ensure it gets evaluated first before concantenating it
        let url = URL(string: Constants.videoHostUrl +  (lesson?.video ?? "") )
        //only show video if there is a valid URL
        if let urlString = url {
            VideoPlayer(player: AVPlayer(url: urlString))
        }
        
        
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
