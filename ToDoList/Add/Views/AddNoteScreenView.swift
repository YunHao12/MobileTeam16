//
//  AddNoteScreenView.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/9/23.
//

import UIKit

typealias dateBlock = (String) -> ()

class AddNoteScreenView: UIView {
    
    var block:dateBlock?
    
    var noteText: UITextView!
    var noteButton: UIButton!
    var dateLabel: UILabel!
    var placeholderLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupNoteText()
        setupNoteButton()
        setupDateLabel()
        setupPlaceholderLabel()
        initConstraints()
    }
    
    // MARK: Setting up UI elements...
    func setupNoteText() {
        noteText = UITextView()
        noteText.translatesAutoresizingMaskIntoConstraints = false
        noteText.delegate = self
        addSubview(noteText)
    }
    
    func setupNoteButton() {
        noteButton = UIButton()
        noteButton.setTitle("Select Date", for: .normal)
        noteButton.setTitleColor(.blue, for: .normal)
        noteButton.translatesAutoresizingMaskIntoConstraints = false
        noteButton.addTarget(self, action: #selector(noteButtonAction), for: .touchUpInside)
        addSubview(noteButton)
    }
    
    func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.textColor = UIColor.lightGray
        dateLabel.font = noteText.font
        addSubview(dateLabel)
    }
    
    func setupPlaceholderLabel() {
        placeholderLabel = UILabel()
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.text = "Enter your note here..."
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.font = noteText.font
        addSubview(placeholderLabel)
    }
    
    func initConstraints() {
        NSLayoutConstraint.activate([
            // MARK: noteText constraints...
            noteText.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            noteText.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            noteText.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            noteText.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            
            noteButton.topAnchor.constraint(equalTo: noteText.bottomAnchor, constant: 20),
            noteButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            dateLabel.topAnchor.constraint(equalTo: noteButton.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            // MARK: placeholderLabel constraints...
            placeholderLabel.topAnchor.constraint(equalTo: noteText.topAnchor, constant: 8),
            placeholderLabel.leadingAnchor.constraint(equalTo: noteText.leadingAnchor, constant: 5),
            placeholderLabel.trailingAnchor.constraint(equalTo: noteText.trailingAnchor),
            placeholderLabel.bottomAnchor.constraint(lessThanOrEqualTo: noteText.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDateLabel(date:String){
        
        self.dateLabel.text = date;
    }
    
    @objc func noteButtonAction(sender:UIButton) {
        
        if let block = self.block {
            block("tap")
        }
    }
}

extension AddNoteScreenView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
}
