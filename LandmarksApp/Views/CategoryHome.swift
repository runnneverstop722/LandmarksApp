//
//  CategoryHome.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/19.
//

import SwiftUI

struct CategoryHome: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            List {
                //You’ll turn this view into an interactive carousel in a later tutorial. For now, it displays one of the featured landmarks with a scaled and cropped preview image.
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets()) //Set the edge insets to zero on both kinds of landmark previews so the content can extend to the edges of the display.
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets()) //Set the edge insets to zero on both kinds of landmark previews so the content can extend to the edges of the display.
            }
            .navigationTitle("Featured")
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
