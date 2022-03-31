//
//  CollectionVC.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import UIKit
protocol HucreProtocol {
    func buttonTiklandi(indexPath:IndexPath)
}
class CollectionVC: UICollectionViewCell {
    
    var hucreProtocol:HucreProtocol?
    var indexPath:IndexPath?
    
    @IBOutlet weak var resim: UIImageView!
    @IBOutlet weak var yemekAdiLabel: UILabel!
    @IBOutlet weak var yemekFiyatiLabel: UILabel!
    
    
    @IBAction func detaySayfaButton(_ sender: Any) {
        hucreProtocol?.buttonTiklandi(indexPath: indexPath!)
    }
}
