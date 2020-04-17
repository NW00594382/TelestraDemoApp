//
//  CustomCell.swift
//  AssignmentApp
//
//  Created by Nikhil Wagh on 4/15/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //MARK: - Outlets
    
    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.titleColor
        lbl.font = UIFont(name: "Helvetica-bold", size: 18)
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: "Helvetica", size: 15)
        lbl.textAlignment = .left
        lbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let nameImageView : UIImageView = {
        let imgView = UIImageView(image: #imageLiteral(resourceName: "placeholder"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = false
        return imgView
    }()
    
    //MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.themeColor
        addSubview(nameLabel)
        addSubview(descriptionLabel)
        addSubview(nameImageView)

        nameImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        nameLabel.anchor(top: topAnchor, left: nameImageView.rightAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: frame.size.width, height: 0, enableInsets: false)
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: nameImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: frame.size.width, height: 0, enableInsets: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private methods

    func setUpCellData(row: Row) {
        nameImageView.imageFromServerURL(row.imageHref ?? "", placeHolder: #imageLiteral(resourceName: "placeholder"))
        nameLabel.text = row.title
        descriptionLabel.text = row.description
    }
}

