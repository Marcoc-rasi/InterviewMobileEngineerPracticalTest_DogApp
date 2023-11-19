import UIKit

class DogsWeLoveTableViewController: UITableViewController {

    let dogViewController = APIRequestController()
    var dogsArray: [Dog] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            do {
                let dogsArray = try await dogViewController.fetchInfoDogs()
                updateUI(dogs: dogsArray)
            }catch {
                displayError(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dogsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Step 1: Dequeue cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell", for: indexPath) as! DogTableViewCell

        //Step 2: Fetch model object to display
        let dog = dogsArray[indexPath.row]

        //Step 3: Configure cell
        cell.update(with: dog)

        //Step 4: Return cell
        return cell
    }
    
    func updateUI(dogs: [Dog]){
        
    }

    func displayError(_ error: Error){
        
    }
n
