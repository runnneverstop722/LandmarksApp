//
//  ProfileHost.swift
//  LandmarksApp
//
//  Created by Teff on 2023/05/20.
//

import SwiftUI

// The ProfileHost view will host both a static, summary view of profile information and an edit mode.
struct ProfileHost: View {
    //Add an Environment view property that keys off of the environment’s \.editMode.
    //SwiftUI provides storage in the environment for values you can access using the @Environment property wrapper. Access the editMode value to read or write the edit scope.
    @Environment(\.editMode) var editMode
    @EnvironmentObject var modelData: ModelData // Read the user’s profile data from the environment to pass control of the data to the profile host. To avoid updating the global app state before confirming any edits — such as while the user enters their name — the editing view operates on a copy of itself.
    @State private var draftProfile = Profile.default
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                // Unlike the Done button that EditButton provides, the Cancel button doesn’t apply the edits to the real profile data in its closure.
                if editMode?.wrappedValue == .active {
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                EditButton() // Create an Edit button that toggles the environment’s editMode value on and off. The EditButton controls the same editMode environment value that you accessed in the previous step.
            }
            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                //Apply the onAppear(perform:) and onDisappear(perform:) modifiers to populate the editor with the correct profile data and update the persistent profile when the user taps the Done button. Otherwise, the old values appear the next time edit mode activates.
                ProfileEditor(profile: $draftProfile)
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

struct ProfileHost_Previews: PreviewProvider {
    static var previews: some View {
        //Even though this view doesn’t use a property with the @EnvironmentObject attribute, ProfileSummary, a child of this view, does. So without the modifier, the preview fails.
        ProfileHost()
            .environmentObject(ModelData())
    }
}
