import Foundation
import UIKit

// MARK: - DogDataBase

// Structure representing dog data
struct DogDataBase: Codable {
    var dogName: String          // Dog's name
    var description: String      // Dog's description
    var age: Int                 // Dog's age
    var imageURL: String         // URL of the dog's image
    var imageData: Data = Data()  // Binary image data of the dog
    
    // URL to store the plist file in the documents directory
    static var archiveURL: URL {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archiveURL = documentsURL.appendingPathComponent("dogs").appendingPathExtension("plist")
        
        return archiveURL
    }

    // Sample dog to handle error cases
    static var sampleDog: DogDataBase {
        return DogDataBase(dogName: "Error", description: "There was a problem getting the image", age: 0, imageURL: "Not Valid", uiImage: UIImage(systemName: "photo.on.rectangle") ?? UIImage())
    }

    // Initializer that accepts a UIImage parameter and converts it to Data
    init(dogName: String, description: String, age: Int, imageURL: String, uiImage: UIImage) {
        self.dogName = dogName
        self.description = description
        self.age = age
        self.imageURL = imageURL
        self.imageData = convertImageToData(uiImage) ?? Data()
    }

    // Static method to save data to a plist file
    static func saveToFile(dogs: [DogDataBase]) {
        let encoder = PropertyListEncoder()
        do {
            let encodedDogs = try encoder.encode(dogs)
            try encodedDogs.write(to: DogDataBase.archiveURL)
        } catch {
            print("Error encoding DogsDataBase: \(error)")
        }
    }

    // Static method to load data from a plist file
    static func loadFromFile() -> [DogDataBase]? {
        guard let dogsData = try? Data(contentsOf: DogDataBase.archiveURL) else {
            return nil
        }
        
        do {
            let decoder = PropertyListDecoder()
            let decodedDogs = try decoder.decode([DogDataBase].self, from: dogsData)
            
            return decodedDogs
        } catch {
            print("Error decoding DogsDataBase: \(error)")
            return nil
        }
    }

    // Method to convert imageData to UIImage
    func getImage() -> UIImage? {
        return UIImage(data: self.imageData)
    }

    // Private method to convert UIImage to Data
    private func convertImageToData(_ image: UIImage) -> Data? {
        return image.jpegData(compressionQuality: 1.0)
    }
}
