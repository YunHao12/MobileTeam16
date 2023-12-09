//
//  ValidationAlerts.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import Foundation
import UIKit

class ValidationAlerts{
    static func showInvalidEmailAlert(_ viewController: UIViewController){
        let alert = UIAlertController(title: "Error!", message: "Email address must be valid!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        viewController.present(alert, animated: true)
    }
    
    static func showEmptyNoteAlert(_ viewController: UIViewController){
        let alert = UIAlertController(title: "Error!", message: "Note must not be empty!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        viewController.present(alert, animated: true)
    }
    
    static func showEmptyEmailAlert(_ viewController: UIViewController){
        let alert = UIAlertController(title: "Error!", message: "Email address must be entered!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        viewController.present(alert, animated: true)
    }
    
    static func showEmptyPassAlert(_ viewController: UIViewController){
        let alert = UIAlertController(title: "Error!", message: "Password must not be empty!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        viewController.present(alert, animated: true)
    }
    
    // Given to for assignment. From Stack Overflow
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    
        print(emailPred.evaluate(with: email))
        return emailPred.evaluate(with: email)
    }
    
    //MARK: error alerts...
    static func showErrorAlert(_ viewController: UIViewController, _ text: String){
        let alert = UIAlertController(title: "Error!", message: text, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        viewController.present(alert, animated: true)
    }
}
