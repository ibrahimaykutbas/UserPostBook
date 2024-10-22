import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Posts", systemImage: "doc.text") {
                PostLists()
            }
            
            Tab("Users", systemImage: "person.2") {
                UserList()
            }
        }
    }
}

#Preview {
    ContentView()
}
