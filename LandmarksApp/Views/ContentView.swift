//
//  ContentView.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/17.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .featured // Add a state variable for the tab selection, and give it a default value.
    
    enum Tab {
        case featured
        case list
    }
    
    var body: some View {
        //The tag(_:) modifier on each of the views matches one of the possible values that the selection property can take so the TabView can coordinate which view to display when the user makes a selection in the user interface.
        TabView(selection: $selection) {
            CategoryHome()
                .tabItem({
                    Label("Featured", systemImage: "star")
                })
                .tag(Tab.featured)
            LandmarkList()
                .tabItem({
                    Label("List", systemImage: "list.bullet")
                })
                .tag(Tab.list)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
