//
//  ContentView.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(ModelData())
    }
}
