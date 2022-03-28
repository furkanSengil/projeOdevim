//
//  AnasayfaPresenter.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import Foundation
class AnasayfaPresenter : ViewToPresenterAnasayfaProtocol{
   
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func ara(aramaKelimesi: String) {
        anasayfaInteractor?.yemekAra(aramaKelimesi: aramaKelimesi)
    }
    
    func sil(yemek_id: String) {
        anasayfaInteractor?.yemekSil(yemek_id: yemek_id)
    }
    
  
    
    func yemekleriYukle() {
        anasayfaInteractor?.tumYemekleriAl()
        
    }

}

extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func preseneteraVeriGonder(yemeklerListesi: Array<Yemekler>) {
        anasayfaView?.vieweVeriGonder(yemeklerListesi: yemeklerListesi)
    }
}
