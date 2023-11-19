import Foundation

// MARK: - DogJSON

// Definition of the DogJSON structure implementing Codable for JSON serialization/deserialization
struct DogJSON: Codable {
    var dogName: String                // Dog's name
    var description: String            // Dog's description
    var age: Int                       // Dog's age
    var imageURL: URL                  // URL of the dog's image
    
    // Enum to specify custom encoding and decoding keys
    enum CodingKeys: String, CodingKey {
        case dogName                    // Key for the dog's name
        case description                // Key for the dog's description
        case age                        // Key for the dog's age
        case imageURL = "image"         // The key "image" in JSON maps to imageURL
    }
}
