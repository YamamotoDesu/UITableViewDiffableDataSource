//
//  NewRestaurantController.swift
//  FoodPin
//
//  Created by 山本響 on 2021/08/03.
//

import UIKit
import CoreData

class NewRestaurantController: UITableViewController {
    
    var restaurant: Restaurant!
    
    @IBOutlet var nameTextField: RoundedTextField! {
        didSet {
            nameTextField.tag = 1
            nameTextField.becomeFirstResponder()
            nameTextField.delegate = self
        }
    }
    
    @IBOutlet var typeTextField: RoundedTextField! {
        didSet {
            typeTextField.tag = 2
            typeTextField.delegate = self
        }
    }
    
    @IBOutlet var addressTextField: RoundedTextField! {
        didSet {
            addressTextField.tag = 3
            addressTextField.delegate = self
        }
    }
    
    @IBOutlet var phoneTextField: RoundedTextField! {
        didSet {
            phoneTextField.tag = 4
            phoneTextField.delegate = self
        }
    }
    
    @IBOutlet var descriptionTextField: RoundedTextField! {
        didSet {
            descriptionTextField.tag = 5
            descriptionTextField.layer.cornerRadius = 10.0
            descriptionTextField.layer.masksToBounds = true
            descriptionTextField.delegate = self
        }
    }
    
    @IBOutlet var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 10.0
            photoImageView.layer.masksToBounds = true
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if nameTextField.text != "", typeTextField.text != "", addressTextField.text != "", phoneTextField.text != "", descriptionTextField.text != "" {
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                restaurant = Restaurant(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text!
                restaurant.type = typeTextField.text!
                restaurant.location = addressTextField.text!
                restaurant.phone = phoneTextField.text!
                restaurant.summary = descriptionTextField.text!
                restaurant.isFavorite = false
                
                if let imageData = photoImageView.image?.pngData() {
                    restaurant.image = imageData
                }
                
                print("Saving data to contex...")
                appDelegate.saveContext()
                dismiss(animated: true)
            }
            return
        }
            
        let alertMessage = UIAlertController(title: "Oops", message: "We can't proceeed because one of rhe fields is blank. Please note that all fields are required", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the superview's layout
        let margins = photoImageView.superview!.layoutMarginsGuide
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        photoImageView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        photoImageView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        // custom naviagation bar
        if let appearance = navigationController?.navigationBar.standardAppearance {
            
            if let customFont = UIFont(name: "Nuito-Bold", size: 40.0) {
                
                appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
                appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(named: "NavigationBarTitle")!, .font: customFont]
                
                navigationController?.navigationBar.compactAppearance = appearance
                navigationController?.navigationBar.compactAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let photoSourceRequestController = UIAlertController(title: "", message: "Choose your photo source", preferredStyle: .actionSheet)
            
            let cameraAction = UIAlertAction(
                title: "Camera",
                style: .default,
                handler: { (action) in
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        let imagePicker = UIImagePickerController()
                        imagePicker.delegate = self
                        imagePicker.allowsEditing = false
                        imagePicker.sourceType = .camera
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                })
            
            let photoLibraryAction = UIAlertAction(
                title: "Photo libaray",
                style: .default) { action in
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.allowsEditing = false
                    imagePicker.sourceType = .photoLibrary
                    
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
            
            photoSourceRequestController.addAction(cameraAction)
            photoSourceRequestController.addAction(photoLibraryAction)
            
            // For iPad
            if let popoverController = photoSourceRequestController.popoverPresentationController {
                if let cell = tableView.cellForRow(at: indexPath) {
                    popoverController.sourceView = cell
                    popoverController.sourceRect = cell.bounds
                }
            }
            
            present(photoSourceRequestController, animated: true, completion: nil)
        }
    }

}

extension NewRestaurantController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let newTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            newTextField.becomeFirstResponder()
        }
        return true
    }
}

extension NewRestaurantController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFit
            photoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}
