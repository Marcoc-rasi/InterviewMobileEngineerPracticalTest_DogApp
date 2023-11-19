//
//  DogTableViewCell.swift
//  PracticalTest_Marcocrasi
//
//  Created by Alumno on 16/11/23.
//

import UIKit

// MARK: - DogTableViewCell

class DogTableViewCell: UITableViewCell {

    // Outlets for the cell components
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // No parece necesario tener una instancia de APIRequestController aquí, ya que no se utiliza en este código específico.
    // Si se necesita para otras operaciones, considera pasarla como parámetro o instanciarla donde se necesite directamente.
    // let dogViewController = APIRequestController()

    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code: This method is called when the cell is loaded. You can perform additional setup here if needed.
    }

    // MARK: - Selection
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state: You can perform additional setup when the cell is selected.
    }

    // MARK: - Cell Update
    
    // Update the function to receive DogDataBase directly. It is more efficient and avoids the need to fetch the image in this class.
    func update(with dogDataBase: DogDataBase) {
        let dogImage = dogDataBase.getImage() ?? UIImage(systemName: "photo.on.rectangle")
        
        // Update the user interface with data from DogDataBase
        dogImageView.image = dogImage
        
        // Set the desired corner radius
        let cornerRadius: CGFloat = 30
        // Configure rounded corners
        dogImageView.layer.cornerRadius = cornerRadius
        dogImageView.layer.masksToBounds = true
        
        nameLabel.text = dogDataBase.dogName
        nameLabel.textColor = UIColor(hex: "#333333")
        descriptionLabel.text = dogDataBase.description
        descriptionLabel.textColor = UIColor(hex: "#666666")
        ageLabel.text = "Almost \(String(dogDataBase.age)) years"
    }
}

// MARK: - UIColor Extension

// Extension for UIColor that allows initializing a color using a hexadecimal code.
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
