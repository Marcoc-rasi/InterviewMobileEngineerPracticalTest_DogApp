//
//  DogsTableViewController.swift
//  PracticalTest_Marcocrasi
//
//  Created by Alumno on 16/11/23.
//

import UIKit

// MARK: - DogsTableViewController

class DogsTableViewController: UITableViewController {

    // MARK: - Table view properties
    
    // Instance of APIRequestController to handle API requests.
    let dogApiRequestController = APIRequestController()
    
    // Array containing objects of the DogDataBase class.
    var dogsDataBaseArray: [DogDataBase] = [] {
        didSet {
            // This didSet block is automatically executed when the value of dogsDataBaseArray changes.
            print("The variable dogsDataBaseArray has been modified.")
            
            // Call the saveToFile static method of the DogDataBase structure
            // to save the data to a file every time the property is updated.
            DogDataBase.saveToFile(dogs: dogsDataBaseArray)
        }
    }

    // MARK: - Table view view life cycle
    
    // Called when the view is first loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use concurrent model to asynchronously load data from the API and update the UI.
        Task {
            do {
                try await getDogsData()
                updateUI()
            } catch {
                displayError(error)
            }
        }
    }
    
    // Called each time the view is about to appear.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Reload the table to ensure it reflects the most recent data.
        tableView.reloadData()
    }

    // MARK: - Table view data source

    // Returns the number of sections in the table.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Returns the number of rows in the specified section.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsDataBaseArray.count
    }

    // Configures and returns a specific cell for the given row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogTableViewCell

        // Step 2: Fetch model object to display
        let dog = dogsDataBaseArray[indexPath.row]

        // Step 3: Configure cell
        cell.update(with: dog)
        cell.backgroundColor = UIColor(hex: "#F8F8F8")
        cell.showsReorderControl = true

        // Step 4: Return cell
        return cell
    }
    
    // Sets the height of the row at the specified position.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    // Called when a row is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // Called when a row is moved in the table.
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveDog = dogsDataBaseArray.remove(at: sourceIndexPath.row)
        dogsDataBaseArray.insert(moveDog, at: destinationIndexPath.row)
    }
    
    // Returns the editing style for the row at the specified position.
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Called when the editing action is confirmed (e.g., deleting a row).
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dogsDataBaseArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        // If there are no more rows after deletion, reload data from the API.
        if dogsDataBaseArray.count == 0 {
            Task {
                do {
                    try await getDogsData()
                    updateUI()
                } catch {
                    displayError(error)
                }
            }
        }
    }
    
    // MARK: - Table View UI DISPLAY
    
    // Update the user interface on the main thread.
    func updateUI() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // Display an error message in the console.
    func displayError(_ error: Error) {
        print("Error fetching data: \(error)")
    }
    
    // MARK: - Table View Gets data
    
    // Get dog data from the API asynchronously.
    func getDogsData() async throws {
        // Check if the file is already stored at the URL
        if let storedDogs = DogDataBase.loadFromFile(), !storedDogs.isEmpty {
            // If stored, assign to dogsDataBaseArray
            dogsDataBaseArray = storedDogs
        } else {
            // If not stored, make the request to the API and store the data
            dogsDataBaseArray = try await dogApiRequestController.fetchInfoAndImages()
            print("API was queried")
            // Save to the plist file at the specified URL
            DogDataBase.saveToFile(dogs: dogsDataBaseArray)
        }
    }
    
    // MARK: - Table View Actions
    
    // Action of the Edit button in the navigation bar.
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        // Toggle between table editing and non-editing modes.
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
}
