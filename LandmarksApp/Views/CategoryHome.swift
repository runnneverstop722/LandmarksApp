//
//  CategoryHome.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/19.
//

import SwiftUI

struct CategoryHome: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var showingProfile = false
    
    var body: some View {
        NavigationView {
            List {
                PageView(pages: modelData.features.map{ FeatureCard(landmark: $0) })
                    .aspectRatio(3/2, contentMode: .fit)
                    .listRowInsets(EdgeInsets()) //Set the edge insets to zero on both kinds of landmark previews so the content can extend to the edges of the display.
                
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets()) //Set the edge insets to zero on both kinds of landmark previews so the content can extend to the edges of the display.
            }
            .navigationTitle("Featured")
            .listStyle(.inset) // Add the listStyle modifier to pick a list style that better suits the content.
            
            // Add a user profile button to the navigation bar using the toolbar modifier, and present the ProfileHost view when the user taps it.
            .toolbar {
                Button {
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environmentObject(modelData)
            }
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
            .environmentObject(ModelData())
    }
}
