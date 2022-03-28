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
    
    var yemeklerListesi = [Yemekler]()
    
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        yemeklerCollectionView.delegate = self
        yemeklerCollectionView.dataSource = self
        
        AnasayfaRouter.createModule(ref: self)
        
        let tasarim = UICollectionViewFlowLayout()
        tasarim.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        tasarim.minimumInteritemSpacing = 10
        tasarim.minimumLineSpacing = 10
        
        let genislik =  self.yemeklerCollectionView.frame.size.width
        tasarim.itemSize = CGSize(width: (genislik-40)/2, height: (genislik-30)/2)
        yemeklerCollectionView.collectionViewLayout = tasarim
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Anasayfa ilk açıldığında ve anasayfaya geri döndüğümüzde çalışır.
        anasayfaPresenterNesnesi?.yemekleriYukle()
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
extension AnasayfaVC : UICollectionViewDelegate,UICollectionViewDataSource {
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
        
        
        return cell
    }
    

}
