//
//  tableViewCell.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 26.03.2022.
//

import Foundation
import Alamofire

class SepetsayfaInteractor : PresenterToInteractorSepettProtocol {
    var sepetPresenter: InteractorToPresenterSepetProtocol?
    
    func tumsepetiGetir(kullanici_adi: String) {
        let params : Parameters = ["kullanici_adi":kullanici_adi]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
            if let data = response.data {
                do{
                    let res = try JSONDecoder().decode(SepetYemekleriCevap.self, from: data)
                    var list = [SepetYemekleri]()
                    if let sepetListesi = res.sepet_yemekler {
                        list = sepetListesi
                    }
                    self.sepetPresenter?.preseneteraVeriGonder(yemeklistesi: list)
                }catch{
                    self.sepetPresenter?.preseneteraVeriGonder(yemeklistesi: [])
                    print(error.localizedDescription)
                }
            }
        }
    }
    

    func deleteFood(sepet_yemek_id: Int, kullanici_adi: String) {
            let params:Parameters = ["sepet_yemek_id":sepet_yemek_id,"kullanici_adi":kullanici_adi]

            AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post, parameters: params).response { response in
                if let data = response.data{

                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            print(json)

                            self.tumsepetiGetir(kullanici_adi: kullanici_adi)
                        }
                    } catch {
                        print(String(describing: error))
                    }
                }
            }
        }

    
}
