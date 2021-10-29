//
//  ContentView.swift
//  TutorialApp
//
//  Created by mac on 10/6/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model: ContentModel
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading){
                Text("What do you want to do today")
                    .padding(.leading, 20.0)
                
                ScrollView {
                    
                    LazyVStack{
                        
                        ForEach(model.modules){ module in //index number is not being tracked here unlike ContentView where their is an index number and it is being tracked
                            
                            VStack(spacing: 20.0){ //you could use a spacer() instead of a vstack to seperate each row and add spacing between them
                            
                                NavigationLink(tag: module.id, selection: $model.currentContentSelected) {
                                    ContentView()
                                        .onAppear {
                                            model.beginModule(module.id)
                                            print(model.currentContentSelected)
                                        }
                                } label: {
                                    //Learning stack
                                    
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }

                            
//                                NavigationLink {
//                                    ContentView()
//                                        .onAppear {
//                                            model.beginModule(module.id)
//                                        }
//                                }
//                            tag: module.id,
//                            selection: model.$currentContentSelected,
//                            label: {
//                                    //Learning stack
//
//                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
//                                }

                            // Test Card
                            
                            HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                
                            }
                        }
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
            }
            .navigationTitle("Get started")
        }
        .navigationViewStyle(.stack)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ContentModel())
    }
}
