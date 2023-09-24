//
//  ProfileView.swift
//  Assignment3_iOS-Development
//
//  Created by Minh Trinh Quangon 21.09.2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            VStack {
                switch viewModel.currentState {
                case .start:
                    EmptyView()
                case .loading:
                    header()
                        .padding(.bottom, 60)
                    ProgressView()
                        .scaleEffect(1, anchor: .center)
                        .progressViewStyle(.circular)
                case .success(let profileInfo):
                    header(imageLink: profileInfo.imageLink)
                    profile(
                        name: profileInfo.name,
                        subtitle: profileInfo.position,
                        description: profileInfo.description
                    )
                case .failure(let error):
                    header()
                    Text(error)
                        .multilineTextAlignment(.center)
                        .padding()
                }

                Spacer()
            }
        }
        .onAppear {
            viewModel.getProfile()
        }
    }
    
    @ViewBuilder
    private func header(imageLink: String? = nil) -> some View {
        let circleWidth: CGFloat = 215
        let circleHeight: CGFloat = 215
        
        ZStack(alignment: .top) {
            Rectangle()
                .foregroundColor(.mint)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 100)
            AsyncImage(
                url: URL(string: imageLink ?? ""),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: circleWidth, height: circleHeight)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .clipShape(Circle())
                },
                placeholder: {
                    ProgressView()
                        .frame(width: circleWidth, height: circleHeight)
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .background(Color.white)
                        .clipShape(Circle())
                }
            )
        }
    }
    
    @ViewBuilder
    private func profile(name: String?, subtitle: String?, description: String?) -> some View {
        VStack(spacing: 15) {
            VStack(spacing: 5) {
                Text(name ?? "")
                    .bold()
                    .font(.title)
                Text(subtitle ?? "")
                    .font(.body)
                    .foregroundColor(.secondary)
            }.padding()
            Text(description ?? "")
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel())
    }
}
