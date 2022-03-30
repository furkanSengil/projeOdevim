//
//  YemekDetayVC.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import UIKit
import Kingfisher
class YemekDetayVC: UIViewController {
    var yemekDetayPresenterNesnesi:ViewToPresenterYemekDetayProtocol?
    var yemek:Yemekler?
    static var sepet:[Yemekler] = []
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
        YemekDetayRouter.createModule(ref: self)
        
        
    }
    
    @IBAction func adetAyari(_ sender: UIStepper) {
        yemekAdeti.text = String(Int(sender.value))
    }
    
    @IBAction func detayKapamaButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sepeteEklemeButtonu(_ sender: Any) {
        yemek?.yemek_siparis_adet = yemekAdeti.text
        YemekDetayVC.sepet.append(yemek!)
      
        yemekDetayPresenterNesnesi?.ekle(yemek_adi: (yemek?.yemek_adi)!, yemek_resim_adi: (yemek?.yemek_resim_adi)!, yemek_fiyat: (yemek?.yemek_fiyat)!, yemek_siparis_adet: (yemek?.yemek_siparis_adet)!, kullanici_adi: AnasayfaVC.kullaniciadi)
        self.dismiss(animated: true, completion: nil)
        print(YemekDetayVC.sepet[0].kullanici_adi!)
    
    }
    

}
