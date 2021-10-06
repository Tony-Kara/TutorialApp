//
//  TutorialAppApp.swift
//  TutorialApp
//
//  Created by mac on 10/6/21.
//

import SwiftUI

@main
struct TutorialApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(ContentModel())
        }
    }
}
