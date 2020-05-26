//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Rexford Machu on 5/25/20.
//  Copyright © 2020 MachuDigital. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var newsTitleLabel: UILabel!
    @IBOutlet var newsPublisherLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        let identifier = "TableViewCell"
         func nib()->UINib{
            return UINib(nibName: "TableViewCell", bundle: nil)
        }
        // Configure the view for the selected state
        func configure(with model: News){
            self.newsTitleLabel.text = model.title
            self.newsPublisherLabel.text = model.publisher
        }
    }
    
}
