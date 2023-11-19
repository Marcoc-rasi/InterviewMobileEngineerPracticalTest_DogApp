#Video App

https://github.com/Marcoc-rasi/InterviewMobileEngineerPracticalTest_DogApp/assets/51039101/87574b6f-111b-4275-b2e8-66bd07fce573

# Technical Report: Mobile Engineer Practical Test

In this report, the solution for the technical challenge is presented, addressing aspects related to the creation of an application to display a list of 'Dog' objects.

## Application:
The "PracticalTest_Marcocrasi" application for iOS allows users to explore a list of dogs with details such as name, description, age, and images. The `DogDataBase` structure manages the representation of dog data, storing and loading information from a plist file to ensure persistence. The `APIRequestController` handles requests to an external API to fetch dog data and their images. The main interface, managed by `DogsTableViewController`, provides editing functionalities in the list, including deletion and reordering of items. Additionally, unit tests have been implemented to ensure the integrity of key functions in the application.

## Architecture:
The application architecture follows an MVC (Model-View-Controller) approach, common in iOS app development. Below is a summary of the main architecture:

**Model:**
The `DogDataBase` structure acts as the main model, representing detailed information about a dog, including name, description, age, and image data.
`DogJSON` is used for data representation in JSON format, facilitating encoding and decoding to and from the external API.

**View:**
`DogsTableViewController` is responsible for managing the user interface and presenting the list of dogs in a table.
`DogTableViewCell` defines the table cell and how each item in the list is presented.

**Controller:**
`APIRequestController` serves as the primary controller that manages requests to the external API to retrieve information about dogs and their images. 
`DogsTableViewController` also acts as a controller, coordinating the interaction between the model and the view, and handling events such as table editing.

**Data Persistence:**
The `DogDataBase` structure is used for data persistence, storing and loading dog information from a plist file in the documents directory.

## Unit Testing:
The application features a robust suite of unit tests covering key aspects of the code, ensuring the functionality and robustness of the software. Test cases encompass the initialization and functionality of data structures, as well as the behavior of controllers and interaction with the network.

## User Interface Design:
The user interface has been developed following the guidelines established in the challenge. Although an exact representation according to the specifications was not achieved, ensuring a similar appearance and effective content adaptation was prioritized, providing optimal visualization on any device. The choice of font colors is based on the predefined palettes in the challenge for various components, ensuring visual consistency.
User interface tests have focused on validating the proper initialization and functionality of the `DogsTableViewController` view controller. This approach ensures an error-free user experience, supporting the integrity and effectiveness of the implemented design, which dynamically adapts to different screen sizes and devices.

![Dogs_1](https://github.com/Marcoc-rasi/InterviewMobileEngineerPracticalTest_DogApp/assets/51039101/647e5a25-4e94-48a9-9fe6-fc542852a610)
![Dogs_3](https://github.com/Marcoc-rasi/InterviewMobileEngineerPracticalTest_DogApp/assets/51039101/018fd1f0-8871-4285-b9e8-6b372a8e562d)
![Dogs_2](https://github.com/Marcoc-rasi/InterviewMobileEngineerPracticalTest_DogApp/assets/51039101/969bd124-1342-4894-bfa4-5d8a41c814c6)
![Dogs_4](https://github.com/Marcoc-rasi/InterviewMobileEngineerPracticalTest_DogApp/assets/51039101/6d9dd5ae-f6c1-4ce1-8ee6-a47b823ff63c)

## Network Request:
Fetching information from an external network is crucial and is handled through the `APIRequestController`. The asynchronous functions `fetchInfoDogs`, `fetchImage`, and `fetchInfoAndImages` ensure efficient retrieval of data from the API without blocking the user interface.

## Database:
Data persistence is achieved through the `DogDataBase` structure and the handling of plist files. The `saveToFile` and `loadFromFile` methods facilitate the efficient storage and loading of dog information, providing a seamless experience for the user.

## Table of Key Components

To provide a quick and clear overview of the essential components in the project files, the following table has been included:

| File                      | Description                                                                                     |
|----------------------------|-------------------------------------------------------------------------------------------------|
| `DogJSON` | The `DogJSON` structure in Swift defines a data model to represent information about dogs, designed to facilitate the serialization and deserialization of JSON objects. This structure includes key properties such as "dogName" for the dog's name, "description" for its description, "age" for the age, and "imageURL" for the dog's image URL. It highlights the use of an enum called `CodingKeys` that specifies custom encoding and decoding keys, where the "image" key in JSON is mapped to the `imageURL` property. Additionally, the structure implements the `Codable` protocol to achieve easy conversion between Swift objects and JSON representations.  |
| `DogDataBase`              | The `DogDataBase` structure is a central component for managing dog-related data in a Swift application. The structure includes key properties such as '`dogName`', representing the dog's name, '`description`' for the dog's description, '`age`' for the dog's age, '`imageURL`' for the dog's image URL, and '`imageData`' for storing binary image data. A distinctive aspect is the static '`archiveURL`' property, defining the URL to store a plist file in the documents directory, facilitating data persistence. Additionally, there is a sample dog named '`sampleDog`', serving as error handling by providing a default dog in case of issues. The structure includes a convenient initializer that takes a '`UIImage`' object and converts it to binary data, useful for instantiation from image data. It also features crucial static methods such as '`saveToFile`' and '`loadFromFile`' for writing and reading data to and from a plist file, respectively. For image manipulation, there is a '`getImage`' method that converts binary data stored in '`imageData`' back to a '`UIImage`' object. Internally, there is a private method '`convertImageToData`' performing the reverse conversion, transforming a '`UIImage`' object into binary data with full compression quality. In summary, the `DogDataBase` structure comprehensively encapsulates the management, persistence, and manipulation of essential dog data in a Swift application. |
| `APIRequestController`     | The `APIRequestController` class in this Swift code manages requests to an API to retrieve information about dogs, storing the results in an array named `dogsDataBaseArray`. This array contains instances of the `DogDataBase` class, encapsulating retrieved information such as dog names, descriptions, ages, and images. The class defines an enum called `DogInfoError`, which, conforming to the `Error` and `LocalizedError` protocols, specifies custom errors associated with item retrieval and image data fetching. This enum is used to handle potential failures during API requests. Regarding methods, the class presents three relevant functions. The first, `fetchInfoDogs`, performs an asynchronous request to a specific URL to obtain dog information in JSON format, using Swift 5.5's new `async/await` syntax. The second function, `fetchImage(from:)`, asynchronously retrieves images from a given URL and creates `UIImage` objects from the obtained data, handling potential errors in detail. The third function, `fetchInfoAndImages`, combines the functionalities of the previous two to obtain both dog information and associated images. It iterates through the array of `DogJSON` objects, calls `fetchImage` for each image, and creates instances of the `DogDataBase` class with complete information for each dog, including its image. Finally, it returns the complete array with detailed information about each dog. In summary, the `APIRequestController` class efficiently encapsulates asynchronous logic to interact with a dog API, managing errors through a custom enum, and organizing retrieved information into `DogDataBase` instances. |
| `DogsTableViewController`  | The `DogsTableViewController` class in the `DogsTableViewController.swift` file displays a table view controller to present dog-related information in an iOS application. This class inherits from `UITableViewController` and is responsible for managing requests to an API through the `dogApiRequestController` instance of the `APIRequestController` class. The `dogsDataBaseArray` array stores objects of the `DogDataBase` class containing information about the dogs. This array has a `didSet` observer that, upon detecting changes, prints a message and saves the data to a file using the static `saveToFile` method of the `DogDataBase` structure. The view lifecycle begins with the `viewDidLoad` method, which uses a concurrent model to asynchronously load data from the API and update the user interface. The `viewWillAppear` method ensures reloading the table to reflect the most recent data each time the view is about to appear. The implementation of methods related to the `UITableViewDataSource` protocol includes `numberOfSections`, always returning 1, `numberOfRowsInSection`, based on the number of elements in `dogsDataBaseArray`, and `cellForRowAt`, configuring and returning a custom `DogTableViewCell` with the corresponding dog information. For table manipulation, methods like `moveRowAt` for reordering rows, `editingStyleForRowAt` to set the editing style (deletion), and `commit editingStyle` for performing editing actions, such as deleting a row and updating the table, have been implemented. If no rows remain after deletion, data is reloaded from the API. Additional methods include `updateUI`, updating the user interface on the main thread, and `displayError`, printing error messages in case of issues fetching data from the API. The `getDogsData` method is responsible for asynchronously fetching dog data from the API. It checks if the data is already locally stored and loads it if so. If not, it makes an API request, stores the new data, and saves it to a local file. Finally, `editButtonTapped` is an action method linked to the edit button in the navigation bar, toggling between table editing and non-editing modes. In summary, the `DogsTableViewController` class provides centralized control for the efficient presentation and manipulation of dog data in the application's user interface. |
| `DogTableViewCell`         | The `DogTableViewCell` class is a custom implementation of `UITableViewCell` designed to display detailed information about dogs in an iOS application's user interface. The cell contains various components, including a dog image, the dog's name, a description, and the dog's age. Its notable properties include `dogImageView` (a `UIImageView` displaying the dog's image), `nameLabel` (a `UILabel` showing the dog's name), `descriptionLabel` (a `UILabel` for displaying the dog's description), `ageLabel` (a `UILabel` for displaying the dog's age), and `cornerRadius` (a radius used to set the rounded corners of the dog's image). As for its methods, there is `awakeFromNib()`, an initialization method called when the cell is first loaded. Additionally, `setSelected(_:animated:)` is a method triggered when the cell is selected, useful for performing additional configurations if needed. Finally, `update(with:)` is a method that takes a `DogDataBase` object and updates the user interface with the corresponding dog information. The class also includes an extension, `UIColor Extension`, facilitating color initialization using a hexadecimal code. |


## Final Comments:
This challenge was an enriching experience that I thoroughly enjoyed. I believe I addressed the problem with elegance and added additional features to highlight data persistence. I am very satisfied with the outcome achieved. It is relevant to note that, while the user interface does not precisely conform to the requested specifications, it effectively fulfills its function and is fully adaptable to any screen size.

## Conclusion:
I appreciate the opportunity to tackle this technical challenge and am available for any further questions or clarifications. I trust that the proposed solution meets the required standards of performance and quality.

