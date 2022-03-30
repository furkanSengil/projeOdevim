//
//  AnasayfaInteractor.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import Foundation
import Alamofire
class AnasayfaInteractor : PresenterToInteractorAnasayfaProtocol{

    func yemekAra(aramaKelimesi: String) {
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response{ response in
            if let data = response.data {
                do{
                    var aramaListesi = [Yemekler]()
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let gelenListe = cevap.yemekler {
                                        
                        aramaListesi = gelenListe.filter { yemek in
                            if yemek.yemek_adi!.lowercased().contains(aramaKelimesi.lowercased()) || aramaKelimesi == ""
                            { return true
                            }else {
                                return false
                            }
                        }
                        self.anasayfaPresenter?.preseneteraVeriGonder(yemeklerListesi: aramaListesi)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?
    
    func tumYemekleriAl() {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response{ response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let gelenListe = cevap.yemekler {
                        self.anasayfaPresenter?.preseneteraVeriGonder(yemeklerListesi: gelenListe)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
