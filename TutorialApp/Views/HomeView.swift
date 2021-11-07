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
                                // save the module.id in the model.currentContentSelected property, once this is set to nil inside a button at the ContentDetailView class, it will bring the user back to this home view.
                                NavigationLink(tag: module.id, selection: $model.currentContentSelected) {
                                    ContentView()
                                        .onAppear {
                                            model.beginModule(module.id) // passing the module id here wil allow me to keep track of the current module selected by the user.
                                           
                                        }
                                } label: {
                                    //Learning stack
                                    
                                    HomeViewRow(image: module.content.image, title: "Learn \(module.category)", description: module.content.description, count: "\(module.content.lessons.count) Lessons", time: module.content.time)
                                }

                            
                            // Test Card
                                NavigationLink(tag: module.id, selection: $model.currentTestSelected) {
                                    TestView()
                                        .onAppear {
                                            model.beginTest(module.id)
                                        }
                                } label: {
                                  
                                HomeViewRow(image: module.test.image, title: "\(module.category) Test", description: module.test.description, count: "\(module.test.questions.count) Lessons", time: module.test.time)
                                    
                                }

                            }
                            .padding(.bottom,10)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                    
                }
            }
            .navigationTitle("Get started")
            // once the user drills back to the homeview from the ContentView after viewing the last video, we need to set the model.currentModule back to nil as the user might need to enter a diofferent module which requires a new index count of the elements in the module, the model.currentContentSelected property is set to nil to take the user back to the HomeView
            .onChange(of: model.currentContentSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }
            }
            .onChange(of: model.currentTestSelected) { changedValue in
                if changedValue == nil {
                    model.currentModule = nil
                }

            }
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
