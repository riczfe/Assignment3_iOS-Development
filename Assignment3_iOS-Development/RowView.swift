//
//  RowView.swift
//  Assignment3_iOS-Development
//
//  Created by Nguyễn Tuân on 20/09/2023.
//

import SwiftUI

struct RowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.blue)
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(imageName: "imageTitle", title: "Version", tintColor: Color(.systemGray))
    }
}
