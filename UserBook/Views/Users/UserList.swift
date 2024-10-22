import SwiftUI

struct UserList: View {
    @StateObject private var viewModel: UserViewModel
    
    init(userRepository: UserRepositoryProtocol = UserRepository()) {
        _viewModel = StateObject(wrappedValue: UserViewModel(userRepository: userRepository))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                } else {
                    List(viewModel.users) { user in
                        Button(action: {
                            viewModel.selectedUser = user
                        }) {
                            Text("\(user.firstname) \(user.lastname)")
                        }
                    }
                    .fullScreenCover(item: $viewModel.selectedUser) { user in
                        NavigationView {
                            UserDetail(user: user)
                        }
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UserList()
}
