import SwiftUI

struct ListView : View {
    @ObservedObject var viewModel: ListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List(viewModel.displayData) { displayData in
                    NavigationLink(destination: DetailView(viewModel: displayData)) {
                        CellView(displayData: displayData)
                    }
                }
            }
            .navigationBarTitle(Text("Repositories"))
            .onLoad {
                self.viewModel.load()
            }
        }
    }
}

#if DEBUG
struct RepositoryListView_Previews : PreviewProvider {
    static var previews: some View {
        ListView(viewModel: .init())
    }
}
#endif
