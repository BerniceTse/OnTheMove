//
//  CustomTableViewCell.swift
//  CSIA
//
//  Created by Bernice Tse on 1/1/2021.
//  Copyright © 2021 Bernice Tse. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    //https://www.youtube.com/watch?v=WK5vrOD1zCQ
    @IBOutlet var roomName: UILabel!
    @IBOutlet var boxName: UILabel!
    @IBOutlet var itemCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
