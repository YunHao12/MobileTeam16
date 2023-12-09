//
//  EditViewController.swift
//  ToDoList
//
//  Created by azure on 2023/12/6.
//

import UIKit
import Alamofire
import Photos
import FirebaseAuth
import FirebaseStorage

class EditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    let editScreenView = EditScreenView()
    
    lazy var storage = Storage.storage()
    
    override func loadView() {
        view = editScreenView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        editScreenView.imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onButtonLoginTapped)))
        editScreenView.editLogin.addTarget(self, action: #selector(onButtonToRegisterScreenTapped), for: .touchUpInside)

        // hide keyboard when tapped outside
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func onButtonLoginTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
          picker.sourceType = .camera
        } else {
          picker.sourceType = .photoLibrary
        }

        present(picker, animated: true, completion: nil)
    }
    
    func showLoginErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "User not exist or wrong password", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    @objc func onButtonToRegisterScreenTapped() {
    
        navigationController?.popViewController(animated: true)
    }
    
    // hide keyboard when tapped outside
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [
                                 UIImagePickerController.InfoKey: Any
                               ]) {
      // Local variable inserted by Swift 4.2 migrator.
      let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

      picker.dismiss(animated: true, completion: nil)

      // if it's a photo from the library, not an image from the camera
      if let referenceUrl =
        info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey
            .referenceURL)] as? URL {
        let assets = PHAsset.fetchAssets(withALAssetURLs: [referenceUrl], options: nil)
        let asset = assets.firstObject
        asset?.requestContentEditingInput(with: nil, completionHandler: { contentEditingInput, info in
          let imageFile = contentEditingInput?.fullSizeImageURL
          let filePath = Auth.auth().currentUser!.uid +
            "/\(Int(Date.timeIntervalSinceReferenceDate * 1000))/\(imageFile!.lastPathComponent)"
          // [START uploadimage]
          let storageRef = self.storage.reference(withPath: filePath)
          storageRef.putFile(from: imageFile!) { result in
            switch result {
            case .success:
              self.uploadSuccess(storageRef, storagePath: filePath)
            case let .failure(error):
              print("Error uploading: \(error)")
            }
          }
          // [END uploadimage]
        })
      } else {
        guard let image =
          info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey
              .originalImage)] as? UIImage else { return }
        guard let imageData = image.jpegData(compressionQuality: 0.8) else { return }
        let imagePath = Auth.auth().currentUser!.uid +
          "/\(Int(Date.timeIntervalSinceReferenceDate * 1000)).jpg"
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        let storageRef = storage.reference(withPath: imagePath)
        storageRef.putData(imageData, metadata: metadata) { result in
          switch result {
          case .success:
            self.uploadSuccess(storageRef, storagePath: imagePath)
          case let .failure(error):
            print("Error uploading: \(error)")
          }
        }
      }
    }

    func uploadSuccess(_ storageRef: StorageReference, storagePath: String) {
      print("Upload Succeeded!")
        
      storageRef.downloadURL { result in
        switch result {
        case let .success(url):
          UserDefaults.standard.set(storagePath, forKey: "storagePath")
          UserDefaults.standard.synchronize()
          self.editScreenView.setHeaderUrl(url: storagePath)
        case let .failure(error):
          print("Error getting download URL: \(error)")
        }
      }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController
    .InfoKey: Any]) -> [String: Any] {
  return Dictionary(uniqueKeysWithValues: input.map { key, value in (key.rawValue, value) })
}

// Helper function inserted by Swift 4.2 migrator.
private func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController
  .InfoKey) -> String {
  return input.rawValue
}

