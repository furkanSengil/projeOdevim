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
        let params:Parameters = ["yemek_adi":aramaKelimesi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .post,parameters: params).response{ response in
            if let data = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemeklerCevap.self, from: data)
                    if let gelenListe = cevap.yemekler {
                        //yemek listesindeki adları string biçiminde diziye atadım
                        var adDizisi = [String]()
                        for adlar in gelenListe{
                            adDizisi.append((adlar.yemek_adi)!)
                           // print(adDizisi)
                        }
                        var filteredData = [String]()
                        filteredData = adDizisi.filter { item in
                                    item.localizedCaseInsensitiveContains(aramaKelimesi)
                                }
                           
                               

                           
                        print(filteredData)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func yemekSil(yemek_id: String) {
        let params:Parameters = ["yemek_id":yemek_id]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .post,parameters: params).response{ response in
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        print(json)
                        self.tumYemekleriAl()
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
