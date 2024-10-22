import SwiftUI

struct PostDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    let post: Post
    
    var body: some View {
        VStack {
            ScrollView {
                Text(post.title)
                    .font(.title2)
                
                Divider()
                
                if let imageUrl = URL(string: post.image) {
                    AsyncImage(url: imageUrl) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius: 8))
                    } placeholder: {
                        ProgressView()
                    }
                }
                
                Text(post.content)
                    .font(.headline)
                    .fontWeight(.light)
                
                Text(post.category)
                    .padding(6)
                    .background(Color.primary)
                    .foregroundStyle(.white)
                    .cornerRadius(8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                Divider()
                
                HStack {
                    DateInfo(title: "Published", value: post.publishedAt.removeSeconds)
                    Text("|")
                    DateInfo(title: "Updated", value: post.publishedAt.removeSeconds)
                }
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
        }
        .padding(.horizontal)
        .navigationTitle("Post Detail")
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
        .scrollIndicators(.hidden)
    }
}

struct DateInfo: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text("\(title):")
                .fontWeight(.medium)
            
            Text(value)
        }
    }
}

extension String {
    var removeSeconds: String {
        return self.prefix(16).description
    }
}

#Preview {
    NavigationStack {
        PostDetail(post: DummyData.examplePost)
            .navigationTitle("Post Detail")
            .navigationBarTitleDisplayMode(.inline)
    }
}
