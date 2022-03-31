//
//  ViewController.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//


import UIKit
import Kingfisher

class AnasayfaVC: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var yemeklerCollectionView: UICollectionView!
    @IBOutlet weak var hesapKapamaButton: UIButton!
    @IBOutlet weak var grisVeKayitAlani: UIStackView!
    
    var yemeklerListesi = [Yemekler]()
    var bilgiler:[String] = []
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    static var kullaniciadi = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        AnasayfaRouter.createModule(ref: self)
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        tasarim.minimumInteritemSpacing = 20
        tasarim.minimumLineSpacing = 20
        
        let genislik =  self.yemeklerCollectionView.frame.size.width
        tasarim.itemSize = CGSize(width: (genislik-50)/2, height: (genislik-50)/2)
        yemeklerCollectionView.collectionViewLayout = tasarim
        
       
    }
    @IBAction func hesapKapamaButton(_ sender: Any) {
        bilgiler = []
        hesapKapamaButton.isHidden = true
        grisVeKayitAlani.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Anasayfa ilk açıldığında ve anasayfaya geri döndüğümüzde çalışır.
        anasayfaPresenterNesnesi?.yemekleriYukle()
        print(bilgiler)
       
        if bilgiler == []{
            hesapKapamaButton.isHidden = true
            grisVeKayitAlani.isHidden = false
        }else{
            hesapKapamaButton.isHidden = false
            grisVeKayitAlani.isHidden = true
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetay" {
            let yemek = sender as? Yemekler
            let gidilecekVC = segue.destination as! YemekDetayVC
            gidilecekVC.yemek = yemek
        }
    }
   
    
}

extension AnasayfaVC : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi: Array<Yemekler>) {
        self.yemeklerListesi = yemeklerListesi
        DispatchQueue.main.async {
            self.yemeklerCollectionView.reloadData()
        }
    }
}
extension AnasayfaVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        anasayfaPresenterNesnesi?.ara(aramaKelimesi: searchText)
    }
}
extension AnasayfaVC : UICollectionViewDelegate,UICollectionViewDataSource,HucreProtocol {
    func buttonTiklandi(indexPath: IndexPath) {
        
        if bilgiler == [] {
            // create the alert
                   let alert = UIAlertController(title: "Hesap bulunamadı", message: "Detay sayfasını görüntülemek için giriş yapmanız gerekmektedir.", preferredStyle: UIAlertController.Style.alert)

                   // add an action (button)
                   alert.addAction(UIAlertAction(title: "tamam", style: UIAlertAction.Style.default, handler: nil))

                   // show the alert
                   self.present(alert, animated: true, completion: nil)
        }else{
            
            let yemek = yemeklerListesi[indexPath.row]
         
            yemek.kullanici_adi = bilgiler[1]
            AnasayfaVC.kullaniciadi = bilgiler[1]
            performSegue(withIdentifier: "toDetay", sender: yemek)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yemeklerListesi.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let yemek = yemeklerListesi[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "yemekHucre", for: indexPath) as! CollectionVC
        
        cell.yemekAdiLabel.text = "\(yemek.yemek_adi ?? "" )"
        cell.yemekFiyatiLabel.text = "\(yemek.yemek_fiyat ?? "" ) ₺" 
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(yemek.yemek_resim_adi ?? "")") {
            DispatchQueue.main.async {
                cell.resim.kf.setImage(with:url)
            }
        }
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        
        return cell
    }
   

}
