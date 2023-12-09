//
//  AddNoteViewController.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/9/23.
//

import UIKit

class AddNoteViewController: UIViewController {

    let addNoteScreenView = AddNoteScreenView()
    
    let notificationCenter = NotificationCenter.default
    
    var authToken: String!
    
    var selectDate: String!
    
    override func loadView() {
        view = addNoteScreenView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        title = "Add a Note"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Save",
            style: .done,
            target: self,
            action: #selector(onSaveButtonTapped)
        )
        
        addNoteScreenView.block = { [weak self] vlaue in
            self?.datePickerTapped()
        }
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: now)
        self.addNoteScreenView.setDateLabel(date: dateString)
        self.selectDate = dateString
    }
    
    func datePickerTapped() {
        
        DatePickerDialog().show("DatePicker", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .dateAndTime) { date in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateStr = formatter.string(from: dt)
                self.addNoteScreenView.setDateLabel(date: dateStr)
                self.selectDate = dateStr
            }
        }
    }
    
    @objc func onSaveButtonTapped(){
        if let text = addNoteScreenView.noteText.text{
            if text.isEmpty{
                ValidationAlerts.showErrorAlert(self, "The text must not be empty!")
            }else{
                self.addANewNote(token: authToken, text: text)
            }
        }else{
            ValidationAlerts.showErrorAlert(self, "The text must not be empty!")
        }
        
    }

}
