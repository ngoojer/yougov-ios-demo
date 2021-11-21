import Foundation
import SwiftUI
import Combine

struct DetailView: View {
    @ObservedObject var viewModel: DetailViewModel
    
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        ScrollView{
            VStack {
                Image(uiImage: viewModel.avatar)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.5,
                           height: screenWidth * 0.5,
                           alignment: .center)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
                    .padding()
                
                VStack (alignment: .leading, spacing: 20){
                    HStack {
                        Text("Repo Name: ").bold()
                        Text(viewModel.name).italic()
                    }
                    
                    HStack {
                        Text("Craeted At: ").bold()
                        Text(viewModel.creationTime).italic()
                    }
                    HStack {
                        Text("Star Count: ").bold()
                        Text(viewModel.star).italic()
                    }
                    HStack {
                        Text("Language: ").bold()
                        Text(viewModel.langage).italic()
                    }
                }
                .padding(.top, 20)
                Spacer()
            }
        }
        .navigationBarTitle(viewModel.ownerName)
        .onAppear(perform: {
            self.viewModel.onAppear()
        })
    }
}

