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
    
    func calculateTotalCost(){
        var totalCost = 0
        var foodPrice = 0
        
        for f in yemeklistesi {
            foodPrice = Int(f.yemek_fiyat!)! * Int(f.yemek_siparis_adet!)!
            totalCost += foodPrice
        }
       // self.totalPriceLabel.text = "\(totalCost) ₺"
    }
    
    @IBAction func confirmBasketTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Congrats", message: "Your order has been received.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Done", style: .cancel) { action in
            self.deleteAllBasketItems()
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
        
    }
    
    func deleteAllBasketItems(){
            for food in yemeklistesi {
                sepetsayfaPresenterNesnesi?.delete(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: food.kullanici_adi!)
            }
        //Set Basket Badge Value
        let ud = UserDefaults.standard
        var basketItemCount = ud.integer(forKey: "basketItemCount")
        basketItemCount = 0
        ud.set(basketItemCount, forKey: "basketItemCount")
      //   self.basketTabItem.badgeValue = nil
        }
}

extension YemekSepetVC : PresenterToViewSepetProtocol {
    func sendDataToView(yemeklistesi: Array<SepetYemekleri>) {
        self.yemeklistesi = yemeklistesi
        calculateTotalCost()
 
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
        cell.yemekFiyati.text = "Fiyat: \(Int(basketFood.yemek_fiyat!)! * Int(basketFood.yemek_siparis_adet!)!) ₺"
        
        DispatchQueue.main.async {
            cell.yemekResim.kf.setImage(with: URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(basketFood.yemek_resim_adi!)"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //Create Action
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete"){ (contextualAction, view, bool) in
            let food = self.yemeklistesi[indexPath.row]
           
            //Create Alert
            let alert = UIAlertController(title: "Silme işlemi", message: "\(food.yemek_adi!) silinsinmi?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "İptal", style: .cancel){ action in }
            alert.addAction(cancelAction)
            
            let confirmAction = UIAlertAction(title: "Evet", style: .destructive) { action in
                self.sepetsayfaPresenterNesnesi?.delete(sepet_yemek_id: Int(food.sepet_yemek_id!)!, kullanici_adi: food.kullanici_adi!)
               
                //Set Basket Badge Value
                let ud = UserDefaults.standard
                var basketItemCount = ud.integer(forKey: "basketItemCount")
                basketItemCount -= 1
                ud.set(basketItemCount, forKey: "basketItemCount")
                if basketItemCount > 0 {
                    let tabBar = self.tabBarController!.tabBar
                    let tabItem = tabBar.items![1]
                    tabItem.badgeValue = String(basketItemCount)
                    print("basketItemCount: \(basketItemCount)")
                }else {
                   // self.basketTabItem.badgeValue = nil
                }
            }
            
            alert.addAction(confirmAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
}


