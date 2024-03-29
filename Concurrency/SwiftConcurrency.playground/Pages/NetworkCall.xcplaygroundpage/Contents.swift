//: [Previous](@previous)
import Foundation
import UIKit

// https://picsum.photos/300
let randomImageURL = URL(string: "https://random.imagecdn.app/300/300")!

func downloadImage() async throws - > UIImage {
    async let image = URLSession.shared.data(from: randomImageURL)
    await image
//    let (data, response) = try await URLSession.shared.data(from: randomImageURL)
//    guard
//        let response = response as? HTTPURLResponse,
//        (200...299).contains(response.statusCode)
//    else {
//        fatalError()
//    }
    return UIImage(data: image.0)!
}

Task {
    try await downloadImage()
}
//: [Next](@next)
