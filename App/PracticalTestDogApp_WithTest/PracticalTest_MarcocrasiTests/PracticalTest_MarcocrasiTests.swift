//
//  PracticalTest_MarcocrasiTests.swift
//  PracticalTest_MarcocrasiTests
//
//  Created by Student on 17/11/23.
//

import XCTest
@testable import PracticalTest_Marcocrasi

class PracticalTest_MarcocrasiTests: XCTestCase {

    override func setUpWithError() throws {
        // Set up any resources needed for each test.
    }

    override func tearDownWithError() throws {
        // Clean up any resources after each test.
    }

    func testExample() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        // Use measure() to measure the time of a code block.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - DogDataBase Tests

    func testDogDataBaseInitialization() {
        // Create a test image
        let originalImage = UIImage(systemName: "photo.on.rectangle") ?? UIImage()

        // Convert the image to JPEG data
        guard let imageData = originalImage.jpegData(compressionQuality: 1.0) else {
            XCTFail("Failed to convert image to data.")
            return
        }

        // Create an instance of DogDataBase
        let dog = DogDataBase(dogName: "Buddy", description: "Friendly dog", age: 3, imageURL: "https://example.com", uiImage: originalImage)

        // Ensure that stored image data matches the original image
        XCTAssertEqual(dog.dogName, "Buddy")
        XCTAssertEqual(dog.description, "Friendly dog")
        XCTAssertEqual(dog.age, 3)
        XCTAssertEqual(dog.imageURL, "https://example.com")

        // Get the image from the instance and ensure data is similar
        guard let storedImageData = dog.getImage()?.jpegData(compressionQuality: 1.0) else {
            XCTFail("Failed to obtain image data from stored image.")
            return
        }

        // Allow a difference of up to 100 bytes
        let allowableDifference = 100
        XCTAssertLessThanOrEqual(abs(imageData.count - storedImageData.count), allowableDifference, "Unacceptable difference in image data size.")
    }

    func testDogDataBaseEncodingAndDecoding() {
        let originalDog = DogDataBase(dogName: "Charlie", description: "Playful dog", age: 2, imageURL: "https://example.com/charlie", uiImage: UIImage(named: "charlieImage") ?? UIImage())
        
        // Encode DogDataBase to Data
        let encodedData = try? JSONEncoder().encode([originalDog])
        XCTAssertNotNil(encodedData)
        
        // Decode Data back to DogDataBase
        let decodedDogs = try? JSONDecoder().decode([DogDataBase].self, from: encodedData!)
        XCTAssertNotNil(decodedDogs)
        
        // Check if the decoded dog is equal to the original dog
        XCTAssertEqual(decodedDogs?.first, originalDog)
    }
    
    // MARK: - DogJSON Tests
    
    func testDogJSONEncodingAndDecoding() {
        let originalDog = DogJSON(dogName: "Rex", description: "Energetic dog", age: 4, imageURL: URL(string: "https://example.com/rex")!)
        
        // Encode DogJSON to Data
        let encodedData = try? JSONEncoder().encode([originalDog])
        XCTAssertNotNil(encodedData)
        
        // Decode Data back to DogJSON
        let decodedDogs = try? JSONDecoder().decode([DogJSON].self, from: encodedData!)
        XCTAssertNotNil(decodedDogs)
        
        // Check if the decoded dog is equal to the original dog
        XCTAssertEqual(decodedDogs?.first, originalDog)
    }
    
    

    // MARK: - DogsTableViewController Tests

    // Test case for verifying the initialization of DogsTableViewController
    func testDogsTableViewControllerInitialization() {
        let viewController = DogsTableViewController()
    
        XCTAssertNotNil(viewController)
        XCTAssertNotNil(viewController.dogApiRequestController)
        XCTAssertEqual(viewController.dogsDataBaseArray.count, 0)
    }

    // Test case for ensuring that the initial state of dogsDataBaseArray is empty after viewDidLoad()
    func testDogsTableViewControllerViewDidLoad() {
        let viewController = DogsTableViewController()
    
        // Ensure that viewDidLoad() does not crash, and dogsDataBaseArray is empty initially
        viewController.viewDidLoad()
        XCTAssertEqual(viewController.dogsDataBaseArray.count, 0)
    }

    // Test case for handling the selection of a row in the table view
    func testDogsTableViewControllerSelection() {
        let viewController = DogsTableViewController()
        let tableView = UITableView()
        viewController.tableView = tableView

        // Ensure that didSelectRowAt does not crash
        let indexPath = IndexPath(row: 0, section: 0)
        viewController.tableView(tableView, didSelectRowAt: indexPath)
    }

    // Test case for handling editing functionalities in the table view
    func testDogsTableViewControllerEditing() {
        let viewController = DogsTableViewController()
        let tableView = UITableView()
        viewController.tableView = tableView

        // Ensure that editingStyleForRowAt returns delete
        let indexPath = IndexPath(row: 0, section: 0)
        XCTAssertEqual(viewController.tableView(tableView, editingStyleForRowAt: indexPath), .delete)

        // Ensure that commit editingStyle removes a row
        let initialCount = viewController.dogsDataBaseArray.count
        viewController.tableView(tableView, commit: .delete, forRowAt: indexPath)
        XCTAssertEqual(viewController.dogsDataBaseArray.count, initialCount - 1)
    }

    // MARK: - APIRequestController Tests

    // Test case for fetching information about dogs from an API
    func testFetchInfoDogs() {
        let apiController = APIRequestController()
        Task{
            do {
                let dogsInfo = try await apiController.fetchInfoDogs()
                XCTAssertGreaterThan(dogsInfo.count, 0)
            } catch {
                XCTFail("Failed to fetch dogs info with error: \(error)")
            }
        }
    }

    // Test case for fetching an image from a specified URL
    func testFetchImage() {
        let apiController = APIRequestController()

        let imageURL = URL(string: "https://example.com/dog_image.jpg")!
        Task {
            do {
                let dogImage = try await apiController.fetchImage(from: imageURL)
                XCTAssertNotNil(dogImage)
            } catch {
                XCTFail("Failed to fetch dog image with error: \(error)")
            }
        }
    }

    // Test case for fetching both information and images of dogs from an API
    func testFetchInfoAndImages() {
        let apiController = APIRequestController()
        Task{
            do {
                let dogsData = try await apiController.fetchInfoAndImages()
                XCTAssertGreaterThan(dogsData.count, 0)
            } catch {
                XCTFail("Failed to fetch dogs info and images with error: \(error)")
            }
        }
    }
}