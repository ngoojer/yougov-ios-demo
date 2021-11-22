import Foundation
import SwiftUI

struct CellView: View {
    @ObservedObject private var viewModel: CellViewModel
    private let screenWidth = UIScreen.main.bounds.width

    public init(displayData: CellViewModel) {
        self.viewModel = displayData
    }
    
    var body: some View {
        ImageViewLike(imageName: viewModel.likeImageName)
        
        ImageView(avatarImage: viewModel.avatar)
        
        VStack (alignment: .leading, spacing: 5) {
            
            Text(viewModel.fullName)
                .font(.headline)
            
            HStack(alignment: .top){
                TextView(text: "Language:")
                TextView(text: viewModel.language)
            }
            
            HStack(alignment: .top) {
                TextView(text: "Star:")
                TextView(text: viewModel.star)
            }
        }
        .frame(height: 75)
    }
    
    struct ImageView: View {
        let avatarImage: UIImage
        let screenWidth = UIScreen.main.bounds.width
        
        var body: some View {
            HStack {
                Image(uiImage: avatarImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.2,
                           height: screenWidth * 0.2,
                           alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 1))
            }
        }
    }
    
    struct ImageViewLike: View {
        let imageName: String
        private let placeholderImge = UIImage(named: "place")!

        var body: some View {
            HStack {
                Image(uiImage: UIImage(named:imageName) ?? placeholderImge)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,
                           height: 20,
                           alignment: .top)
                    .clipShape(Circle())
            } .padding(.bottom, 50)

        }
    }
    
    struct TextView: View {
        let text: String
        
        var body: some View {
            Text(text)
                .font(.subheadline)
                .fontWeight(.medium)
        }
    }
    
}
