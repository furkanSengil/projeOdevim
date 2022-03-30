//
//  tableViewCell.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 26.03.2022.
//

import UIKit

class tableViewCell: UITableViewCell {

    @IBOutlet weak var yemekResim: UIImageView!
    @IBOutlet weak var yemekAdi: UILabel!
    @IBOutlet weak var yemekFiyati: UILabel!
    @IBOutlet weak var yemekAdeti: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
