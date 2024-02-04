// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let walmartResponse = try? JSONDecoder().decode(WalmartResponse.self, from: jsonData)

import Foundation

// MARK: - WalmartResponse
struct WalmartResponse: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}

// MARK: - CommentResponse
struct CommentResponse: Codable {
    let comments: [Comment]
    let total, skip, limit: Int
}

// MARK: - Comment
struct Comment: Codable, Identifiable {
    let id: Int
    let body: String
    let postID: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case id, body
        case postID = "postId"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username: String
}
