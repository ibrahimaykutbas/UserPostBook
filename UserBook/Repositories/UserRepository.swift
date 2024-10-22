import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers() async throws -> [User]
}

class UserRepository: UserRepositoryProtocol {
    private let url = "https://jsonplaceholder.org/users"
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            //        if let jsonString = String(data: data, encoding: .utf8) {
            //            print("JSON Response: \(jsonString)")
            //        }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200,
                  response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
            
            let decodedUsers = try JSONDecoder().decode([User].self, from: data)
            
            return decodedUsers
        } catch {
            print("Decoding Error: \(error)")
            throw error
        }
    }
}
