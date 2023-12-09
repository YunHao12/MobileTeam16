//
//  NoteDetailViewController.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/9/23.
//

import UIKit

class NoteDetailViewController: UIViewController {

    let noteDetailScreenView = NoteDetailScreenView()
    
    var note: Note!
    
    override func loadView() {
        view = noteDetailScreenView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteDetailScreenView.paragraphTextView.text = note.text
    }
    
}
