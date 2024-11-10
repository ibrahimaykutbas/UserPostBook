import SwiftUI

struct UserDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    let user: User
    
    var body: some View {
        Form {
            Section(header: Text("User Information")) {
                UserInfo(title: "User", value: "\(user.firstname) \(user.lastname)")
                UserInfo(title: "E-Mail", value: user.email)
                UserInfo(title: "Address", value: "\(user.address.street) \(user.address.suite) \(user.address.city)")
                UserInfo(title: "Phone", value: user.phone)
                UserInfo(title: "Website", value: user.website)
                UserInfo(title: "Company", value: user.company.name)
            }
        }
        .navigationTitle("User Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "arrow.left")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}

struct UserInfo: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    UserDetail(user: DummyData.exampleUser)
}
