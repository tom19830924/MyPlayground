import SwiftUI

struct Photo: Codable, Identifiable {
    var id: String
    var author: String
    var width: CGFloat
    var height: CGFloat
    var url: URL
    var download_url: URL
}

struct ContentView: View {
    @StateObject var items = Remote(
        url: URL(string: "https://picsum.photos/v2/list")!
    ) {
        try? JSONDecoder().decode([Photo].self, from: $0)
    }
    
    var body: some View {
        NavigationView {
            if let photos = items.value {
                List(photos) { photo in
                    NavigationLink(photo.author, destination: PhotoView(photo.download_url, aspectRatio: photo.width / photo.height))
                }
            }
            else {
                ProgressView()
                    .onAppear {
                        items.load()
                    }
            }
        }
    }
}

struct PhotoView: View {
    @ObservedObject var image: Remote<UIImage>
    var aspectRatio: CGFloat
    
    init(_ url: URL, aspectRatio: CGFloat) {
        self.image = Remote(url: url, transform: { UIImage(data: $0) })
        self.aspectRatio = aspectRatio
    }
    
    var imageOrPlaceholder: Image {
        image.value.map(Image.init) ?? Image(systemName: "photo")
    }
    
    var body: some View {
        imageOrPlaceholder
            .resizable()
            .foregroundColor(.secondary)
            .aspectRatio(aspectRatio, contentMode: .fit)
            .padding()
            .onAppear {
                image.load()
            }
    }
}

#Preview {
    ContentView()
}
