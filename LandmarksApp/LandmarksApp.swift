//
//  LandmarksAppApp.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/17.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject private var modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
