//
//  CategoryItem.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/19.
//

import SwiftUI

struct CategoryItem: View {
    var landmark: Landmark
    
    var body: some View {
        VStack(alignment: .leading) {
            landmark.image
                .renderingMode(.original) // Text that you pass as the label for a navigation link renders using the environment’s accent color, and images may render as template images. You can modify either behavior to best suit your design.
                .resizable()
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(landmark.name)
                .foregroundColor(.primary) // Text that you pass as the label for a navigation link renders using the environment’s accent color, and images may render as template images. You can modify either behavior to best suit your design.
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}

struct CategoryItem_Previews: PreviewProvider {
    static var previews: some View {
        CategoryItem(landmark: ModelData().landmarks[0])
    }
}
