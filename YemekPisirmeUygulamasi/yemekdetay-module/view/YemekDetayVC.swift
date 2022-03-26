//
//  YemekDetayVC.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import UIKit
import Kingfisher
class YemekDetayVC: UIViewController {
    var yemek:Yemekler?
    
    @IBOutlet weak var detaydakiYemekResim: UIImageView!
    @IBOutlet weak var yemekAdi: UILabel!
    @IBOutlet weak var yemekFiyati: UILabel!
    @IBOutlet weak var yemekAdeti: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  print((yemek!.kullanici_adi)!)
    
        yemekAdi.text = yemek!.yemek_adi
        yemekFiyati.text = "\((yemek!.yemek_fiyat)!) ₺"
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\((yemek!.yemek_resim_adi)!)") {
            DispatchQueue.main.async {
                self.detaydakiYemekResim.kf.setImage(with:url)
            }
        }
        
    }
    
    @IBAction func adetAyari(_ sender: UIStepper) {
        yemekAdeti.text = String(Int(sender.value))
    }
    
    @IBAction func sepeteEklemeButtonu(_ sender: Any) {
        
    }
    

}
