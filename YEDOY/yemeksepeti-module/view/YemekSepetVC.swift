//
//  YemekSepetVC.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import UIKit

class YemekSepetVC: UIViewController {
    var sepetsayfaPresenterNesnesi:ViewToPresenterSepetProtocol?
    @IBOutlet weak var sepetTableView: UITableView!
    
    @IBOutlet weak var toplamTutar: UILabel!
    
    @IBOutlet weak var arkaPlanView: UIView!
    
    var yemeklistesi = [SepetYemekleri]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        sepetTableView.delegate = self
        sepetTableView.dataSource = self
        
   
        
        SepetsayfaRouter.createModule(ref: self)
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        sepetsayfaPresenterNesnesi?.sepettekileriGetir(kullanici_adi: AnasayfaVC.kullaniciadi)
        
    }
    
    func toplamTutarHesapla(){
        var toplamTutar = 0
        var yemekAdedi = 0
        
        for f in yemeklistesi {
            yemekAdedi = Int(f.yemek_fiyat!)! * Int(f.yemek_siparis_adet!)!
            toplamTutar += yemekAdedi
        }
        self.toplamTutar.text = "\(toplamTutar) ₺"
    }
    
    @IBAction func siparisiOnaylamaButton(_ sender: Any) {
        let alert = UIAlertController(title: "SİPARİŞİNİZ VERİLDİ", message: "Yemekleri siparişiniz verildi.Afiyet olsun", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Tamam", style: .cancel) { action in
            self.buttunSepetiSil()
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
        
    }
    
    func buttunSepetiSil(){
            for yemek in yemeklistesi {
                sepetsayfaPresenterNesnesi?.delete(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: yemek.kullanici_adi!)
            }

        }
}

extension YemekSepetVC : PresenterToViewSepetProtocol {
    func sendDataToView(yemeklistesi: Array<SepetYemekleri>) {
        self.yemeklistesi = yemeklistesi
        toplamTutarHesapla()
        
        if yemeklistesi.isEmpty {
            arkaPlanView.isHidden = true
        }else {
            arkaPlanView.isHidden = false
        }
        DispatchQueue.main.async {
            self.sepetTableView.reloadData()
        }
    }
}

extension YemekSepetVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklistesi.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let basketFood = yemeklistesi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewHucre", for: indexPath) as! tableViewCell
        cell.yemekAdi.text = basketFood.yemek_adi
        cell.yemekAdeti.text = "\(basketFood.yemek_siparis_adet!)"
        cell.yemekFiyati.text = "\(Int(basketFood.yemek_fiyat!)! * Int(basketFood.yemek_siparis_adet!)!) ₺"
        
        DispatchQueue.main.async {
            cell.yemekResim.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(basketFood.yemek_resim_adi!)"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Create Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, bool) in
            let yemek = self.yemeklistesi[indexPath.row]
           
            //Create Alert
            let alert = UIAlertController(title: "Silme işlemi", message: "\(yemek.yemek_adi!) silinsinmi?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel){ action in }
            alert.addAction(cancelAction)
            
            let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.sepetsayfaPresenterNesnesi?.delete(sepet_yemek_id: Int(yemek.sepet_yemek_id!)!, kullanici_adi: yemek.kullanici_adi!)
               
        
            }
            
            alert.addAction(confirmAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
}


