//
//  NotesTableViewCell.swift
//  WA7_Solution_draft
//
//  Created by Sakib Miazi on 11/8/23.
//

import UIKit

typealias cellBlock = (NSInteger) -> ()

class NotesTableViewCell: UITableViewCell {
    
    var block:cellBlock?
    
    var wrapperCellView: UIView!
    var labelName: UILabel!
    var doneButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupWrapperCellView()
        setupLabelName()
        setupDoneButton()
        initConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupWrapperCellView(){
        wrapperCellView = UITableViewCell()
        
        //working with the shadows and colors...
        wrapperCellView.backgroundColor = .white
        wrapperCellView.layer.cornerRadius = 6.0
        wrapperCellView.layer.shadowColor = UIColor.gray.cgColor
        wrapperCellView.layer.shadowOffset = .zero
        wrapperCellView.layer.shadowRadius = 4.0
        wrapperCellView.layer.shadowOpacity = 0.4
        wrapperCellView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(wrapperCellView)
    }
    
    func setupDoneButton() {
        doneButton = UIButton()
        doneButton.setImage(UIImage(named: "unselect_icon"), for: .normal)
        doneButton.setImage(UIImage(named: "selected_icon"), for: .selected)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonAction), for: .touchUpInside)
        contentView.addSubview(doneButton)
    }
    
    func setupLabelName(){
        labelName = UILabel()
        labelName.font = UIFont.boldSystemFont(ofSize: 14)
        labelName.textAlignment = .left
        labelName.translatesAutoresizingMaskIntoConstraints = false
        wrapperCellView.addSubview(labelName)
    }
    
    @objc func doneButtonAction(sender:UIButton){
        if let block = self.block {
            block(0)
        }
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            wrapperCellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 6),
            wrapperCellView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            wrapperCellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4),
            wrapperCellView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4),
            
            labelName.topAnchor.constraint(equalTo: wrapperCellView.topAnchor, constant: 8),
            labelName.leadingAnchor.constraint(equalTo: wrapperCellView.leadingAnchor, constant: 10),
            labelName.heightAnchor.constraint(equalToConstant: 20),
            labelName.widthAnchor.constraint(lessThanOrEqualTo: wrapperCellView.widthAnchor, constant: -60),
            
            doneButton.centerYAnchor.constraint(equalTo: labelName.centerYAnchor, constant: 0),
            doneButton.trailingAnchor.constraint(equalTo: wrapperCellView.trailingAnchor, constant: -15),
            doneButton.heightAnchor.constraint(equalToConstant: 30),
            doneButton.widthAnchor.constraint(equalToConstant: 30),
            
            wrapperCellView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
