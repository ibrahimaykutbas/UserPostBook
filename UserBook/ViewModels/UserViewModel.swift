import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedUser: User?
    
    private let userRepository: UserRepositoryProtocol
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        self.userRepository = userRepository
    }
    
    func fetchUsers() async {
        isLoading = true
        
        do {
            let fetchedUsers = try await userRepository.fetchUsers()
            users = fetchedUsers
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}
