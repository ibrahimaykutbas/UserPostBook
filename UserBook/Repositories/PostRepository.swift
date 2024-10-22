import Foundation

protocol PostRepositoryProtocol {
    func fetchPosts() async throws -> [Post]
}

class PostRepository: PostRepositoryProtocol {
    private let url = "https://jsonplaceholder.org/posts"
    
    func fetchPosts() async throws -> [Post] {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200,
                  response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            
            let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
            
            return decodedPosts
        } catch {
            print("Post Decoding Error: \(error)")
            throw error
        }
    }
}
