// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let articles = try? newJSONDecoder().decode(Articles.self, from: jsonData)

import Foundation

// MARK: - Article
class Article: Codable {
    let author, title, articleDescription: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
    
    init(author: String?, title: String?, articleDescription: String?, urlToImage: String?, publishedAt: Date?, content: String?) {
        self.author = author
        self.title = title
        self.articleDescription = articleDescription
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
