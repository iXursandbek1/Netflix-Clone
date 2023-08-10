//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 10/08/23.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifire = "CollectionViewTableViewCell"
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
