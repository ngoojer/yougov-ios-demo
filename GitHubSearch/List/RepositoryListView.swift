import SwiftUI

struct RepositoryListView : View {
    @ObservedObject var viewModel: RepositoryListViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                
                List(viewModel.repositories) { repository in
                    NavigationLink(destination: DetailView(viewModel: DetailViewModel(repo: repository))) {
                        RepositoryCell(displayData: repository)
                    }
                }
            }
            .navigationBarTitle(Text("Repositories"))
            .onAppear(perform: {
                self.viewModel.onAppear()
            })
        }
    }
}

#if DEBUG
struct RepositoryListView_Previews : PreviewProvider {
    static var previews: some View {
        RepositoryListView(viewModel: .init())
    }
}
#endif
