//
//  TeaTableViewCell.swift
//  TeaTimer
//
//  Copyright © 2018 Ngan Tran. All rights reserved.
//

import UIKit

class TeaTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var secsLabel: UILabel!
<<<<<<< HEAD

    override func awakeFromNib() {
        super.awakeFromNib()

=======
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //self.addShadow()
        // Initialization code
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
<<<<<<< HEAD

=======
        
        // Configure the view for the selected state
>>>>>>> 5668bf26eed387a1cf351eaf1568ce74a5a61b98
    }
}


