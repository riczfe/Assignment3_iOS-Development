//
//  ProfileViewService.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quang  on 23.09.2023.
//

import Foundation


final class ProfileViewService {
    
    func getProfile() async throws -> ProfileInfo {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        return ProfileInfo(
            name: "Johny Appleseed",
            position: "Developer",
            description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Non arcu risus quis varius quam. Faucibus ornare suspendisse sed nisi lacus sed viverra tellus. Ornare suspendisse sed nisi lacus sed viverra tellus. Arcu odio ut sem nulla pharetra. Vitae congue mauris rhoncus aenean vel elit. Scelerisque eu ultrices vitae auctor eu.",
            imageLink: "https://source.unsplash.com/user/c_v_r/100x100"
        )
    }
}
