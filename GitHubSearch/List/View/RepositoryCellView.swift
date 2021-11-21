import Foundation
import SwiftUI

struct RepositoryCellView: View {
    @ObservedObject private var viewModel: CellViewModel

    private let placeholderImge = UIImage(named: "place")!
    private let screenWidth = UIScreen.main.bounds.width

    public init(displayData: CellViewModel) {
        self.viewModel = displayData
    }
    
    var body: some View {
        HStack {
            Image(uiImage: viewModel.avatar)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screenWidth * 0.2,
                       height: screenWidth * 0.2,
                       alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.blue, lineWidth: 1))
        }
        
        VStack (alignment: .leading, spacing: 5) {
            
            Text(viewModel.fullName)
                .font(.headline)
            
            HStack(alignment: .top){
                Text("Language:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(viewModel.language)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            HStack(alignment: .top){
                Text("Star:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(viewModel.star)
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .frame(height: 75)
    }
}
