import Foundation
import SwiftUI

struct RepositoryCell: View {
    private let displayData: Repository
    
    init(displayData: Repository) {
        self.displayData = displayData
    }
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(displayData.name ?? "")
                .font(.headline)
            
            HStack(alignment: .top){
                Text("Language:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(displayData.language ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
            
            HStack(alignment: .top){
                Text("Star:")
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(displayData.starCount ?? "")
                    .font(.subheadline)
                    .fontWeight(.medium)
            }
        }
        .frame(height: 65)
    }
}
