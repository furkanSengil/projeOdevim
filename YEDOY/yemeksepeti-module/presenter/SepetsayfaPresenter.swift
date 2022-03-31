//
//  tableViewCell.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 26.03.2022.
//

import Foundation

class SepetsayfaPresenter : ViewToPresenterSepetProtocol {
    var sepetInteractor: PresenterToInteractorSepettProtocol?
    
    var sepetView: PresenterToViewSepetProtocol?
    
    func sepettekileriGetir(kullanici_adi: String) {
        sepetInteractor?.tumsepetiGetir(kullanici_adi: kullanici_adi)
    }
    
    func delete(sepet_yemek_id: Int, kullanici_adi: String) {
        sepetInteractor?.deleteFood(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
    }
    
    
}

extension SepetsayfaPresenter : InteractorToPresenterSepetProtocol {
    func preseneteraVeriGonder(yemeklistesi: Array<SepetYemekleri>) {
        sepetView?.sendDataToView(yemeklistesi: yemeklistesi)
    }
}
