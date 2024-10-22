import SwiftUI

struct PostLists: View {
    @StateObject private var viewModel: PostViewModel
    
    init(postRepository: PostRepositoryProtocol = PostRepository()) {
        _viewModel = StateObject(wrappedValue: PostViewModel(postRepository: postRepository))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.posts) { post in
                            VStack {
                                Button(action: {
                                    viewModel.selectedPost = post
                                }) {
                                    Text(post.title)
                                }
                            }
                    }
                    .fullScreenCover(item: $viewModel.selectedPost) { post in
                        NavigationView {
                            PostDetail(post: post)
                        }
                    }
                }
            }
            .navigationTitle("Posts")
            .task {
                await viewModel.fetchPosts()
            }
        }
    }
}

#Preview {
    PostLists()
}
