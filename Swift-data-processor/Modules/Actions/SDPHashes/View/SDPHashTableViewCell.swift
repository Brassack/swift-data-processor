//
//  SDPHashTableViewCell.swift
//  Swift-data-processor
//
//  Created by Dmytro Platov on 7/31/18.
//  Copyright © 2018 Dmytro Platov. All rights reserved.
//

import UIKit


class SDPHashTableViewCell: UITableViewCell, SDPTableViewCellConfigurable, SDPHashTableViewCellInput {
    
    var externalConfigurator: SDPTableViewCellExternalConfigurator?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.textColor = UIColor.darkGray
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: SDPHashTableViewCellInput
    func animateCopy() {
        
        let savedText = titleLabel.text
        let text = "Copied"
        
        titleLabel.text = text
        
        weak var wlabel = titleLabel
        
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            
            if wlabel?.text == text {
                wlabel?.text = savedText
            }
        }
    }
    
    // MARK: SDPTableViewCellConfigurable
    func configure(object: Any) {
        guard let data = object as? SDPTableViewDataSourceRow else{
            return
        }
        
        titleLabel.text = data.title
        
        if let subtitle = data.subtitle {
            
            subtitleLabel.textColor = UILabel.appearance(whenContainedInInstancesOf: [UITableViewCell.self]).textColor
            subtitleLabel.text = subtitle
        }else if data.isFailed {
            
            subtitleLabel.text = "Failed!"
            subtitleLabel.textColor = UIColor.red
        }else{
            
            subtitleLabel.text = "Calculating..."
            subtitleLabel.textColor = UIColor.darkGray
        }
    }

}
