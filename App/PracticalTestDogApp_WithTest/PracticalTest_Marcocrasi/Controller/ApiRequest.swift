import Foundation
import UIKit

// MARK: - APIRequestController

class APIRequestController {

    // MARK: - Properties

    // Array to store DogDataBase instances
    var dogsDataBaseArray = [DogDataBase]()

    // MARK: - Enums

    // Custom errors for API request and image fetching
    enum DogInfoError: Error, LocalizedError {
        case itemNotFound
        case imageDataMissing
    }

    // MARK: - API Methods

    // Fetch information about dogs from the specified URL
    func fetchInfoDogs() async throws -> [DogJSON] {
        // URL for fetching dog information
        let url = URL(string: "https://jsonblob.com/api/1151549092634943488")!
        
        // Perform asynchronous network request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check HTTP status code for success
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DogInfoError.itemNotFound
        }
        
        // Decode JSON data into an array of DogJSON objects
        let jsonDecoder = JSONDecoder()
        let dogs = try jsonDecoder.decode([DogJSON].self, from: data)
        return dogs
    }
    
    // Fetch a UIImage from a given URL
    func fetchImage(from url: URL) async throws -> UIImage {
        // Perform asynchronous network request
        let (data, response) = try await URLSession.shared.data(from: url)
        
        // Check HTTP status code for success
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DogInfoError.imageDataMissing
        }
        
        // Create UIImage from fetched data
        guard let image = UIImage(data: data) else {
            throw DogInfoError.imageDataMissing
        }
        
        return image
    }

    // Fetch information about dogs and their images
    func fetchInfoAndImages() async throws -> [DogDataBase] {
        // Fetch dog information from the API
        let dogJsonArray = try await fetchInfoDogs()
        var dogsDataBaseArray = [DogDataBase]()
        
        // Iterate through the array of DogJSON objects
        for dogJson in dogJsonArray {
            // Fetch the image for each dog
            let image = try await fetchImage(from: dogJson.imageURL)
            
            // Create a DogDataBase object and append to the array
            let dogDataBase = DogDataBase(dogName: dogJson.dogName,
                                          description: dogJson.description,
                                          age: dogJson.age,
                                          imageURL: dogJson.imageURL.absoluteString,
                                          uiImage: image)
            dogsDataBaseArray.append(dogDataBase)
        }
        
        return dogsDataBaseArray
    }
}
