//
//  FactsCell.swift
//  TelstraDemoApp
//
//  Created by Nikhil Wagh on 20/04/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import UIKit

class FactsCell: UITableViewCell {
    
    //MARK: - Outlets
    
    private let nameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.titleColor
        lbl.font = UIFont(name: Constant.customFontBold, size: CGFloat(Constant.titleFontSize))
        lbl.textAlignment = .left
        return lbl
    }()
    
    private let descriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont(name: Constant.customFont, size: CGFloat(Constant.descFontSize))
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
        
        nameImageView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, enableInsets: false)
        nameImageView.anchorSize(width: CGFloat(Constant.imageViewWidth), height: CGFloat(Constant.imageViewHeight))
        
        nameLabel.anchor(top: topAnchor, left: nameImageView.rightAnchor, bottom: nil, right: rightAnchor, enableInsets: false)
        nameImageView.anchorSize(width: frame.size.width, height: CGFloat(Constant.zero))
        
        descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(Constant.heightConstant)).isActive = true
        descriptionLabel.anchor(top: nameLabel.bottomAnchor, left: nameImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, enableInsets: false)
        descriptionLabel.anchorSize(width: frame.size.width, height: CGFloat(Constant.zero))
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
