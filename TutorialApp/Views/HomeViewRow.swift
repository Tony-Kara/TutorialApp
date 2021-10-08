//
//  HomeViewRow.swift
//  TutorialApp
//
//  Created by mac on 10/7/21.
//

import SwiftUI

struct HomeViewRow: View {
    var image: String
    var title: String
    var description: String
    var count: String
    var time: String
    
    var body: some View {
       
        ZStack {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
            // this is a more dynamic way of adding width and height to rectangle
                .aspectRatio(CGSize(width: 335, height: 175), contentMode: .fit)
            
            HStack {
                
                //Image
                Image(image)
                    .resizable()
                    .frame(width: 116, height: 116)
                    .clipShape(Circle())
                
                //Text
                Spacer()
                VStack(alignment: .leading, spacing: 10.0) {
                    
                    //Headline
                    Text(title)
                        .bold()
                    
                    //Description
                    Text(description)
                        .multilineTextAlignment(.leading)
                        .padding(.bottom, 20)
                        .font(.caption)
                    
                    //Icons
                    
                    HStack{
                        
                        //Number of lessons/Questions
                        Image(systemName: "text.book.closed")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(count)
                            .font(Font.system(size: 10))
                        
                        Spacer()
                        //Time
                        Image(systemName: "clock")
                            .resizable()
                            .frame(width: 15, height: 15)
                        Text(time)
                            .font(.caption)
                    }
                }
                .padding(.horizontal, 5)
                
            }
            .padding(.horizontal, 20)
        }
        
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewRow(image: "swift", title: "Learn swift", description: "some description", count: "10 Lessons", time: "2 hours")
    }
}
