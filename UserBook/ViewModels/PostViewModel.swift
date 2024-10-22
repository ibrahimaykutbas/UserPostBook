import Foundation

@MainActor
class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedPost: Post?
    
    private let postRepository: PostRepositoryProtocol
    
    init(postRepository: PostRepositoryProtocol = PostRepository()) {
        self.postRepository = postRepository
    }
    
    func fetchPosts() async {
        isLoading = true
        
        do {
            let fetchedPosts = try await postRepository.fetchPosts()
            posts = fetchedPosts
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
