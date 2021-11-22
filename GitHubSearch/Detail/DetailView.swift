import Foundation
import SwiftUI
import Combine

struct DetailView: View {
    @ObservedObject var viewModel: CellViewModel
    
    var body: some View {
        NavigationView {
            ScrollContent(viewModel: viewModel)
        }
        .navigationBarTitle(viewModel.ownerName)
        .navigationBarItems(trailing:
            Button(action: {
                viewModel.like.toggle()
            }) {
                Image(viewModel.likeImageName).imageScale(.large)
            }
        )
    }
    
    struct ScrollContent: View {
        let viewModel: CellViewModel
        var body: some View {
            ScrollView(.vertical, showsIndicators: true){
                VStack(spacing: 10) {
                    ImageView(avatarImage: viewModel.avatar)
                    VStack (alignment: .leading, spacing: 20){
                        TextView(label: "Repo Name: ", text: viewModel.repoName)
                        TextView(label: "Craeted At : ", text: viewModel.creationTime)
                        TextView(label: "Star Count: ", text: viewModel.star)
                        TextView(label: "Language: ", text: viewModel.language)
                    }
                    .padding(.top, 20)
                    Spacer()
                }
            }
        }
    }

    struct ImageView: View {
        let avatarImage: UIImage
        private let screenWidth = UIScreen.main.bounds.width
        
        var body: some View {
            HStack {
                Image(uiImage: avatarImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.5,
                           height: screenWidth * 0.5,
                           alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
            }
        }
    }

    struct TextView: View {
        let label: String
        let text: String
        
        var body: some View {
            HStack {
                Text(label).bold()
                Text(text).italic()
            }
        }
    }
}



