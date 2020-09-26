// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let articles = try? newJSONDecoder().decode(Articles.self, from: jsonData)

import Foundation

// MARK: - Article
struct Article: Codable {
    let author, title, description: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?
}
