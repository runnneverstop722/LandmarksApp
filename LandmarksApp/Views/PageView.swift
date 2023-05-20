//
//  PageView.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/20.
//

import SwiftUI

struct PageView<Page: View>: View {
    var pages: [Page]
    @State private var currentPage = 0 // Declare the @State variable in PageView, and pass a binding to the property when creating the child PageViewController. <Important> Remember to use the $ syntax to create a binding to a value that is stored as state.
    
    var body: some View {
        VStack {
            PageViewController(pages: pages, currentPage: $currentPage)
            Text("Current Page: \(currentPage)")
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(pages: ModelData().features.map { FeatureCard(landmark: $0) })
            .aspectRatio( 3/2, contentMode: .fit)
    }
}
