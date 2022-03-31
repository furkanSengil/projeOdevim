//
//  YemekDetayProtocols.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 26.03.2022.
//

import Foundation
protocol ViewToPresenterYemekDetayProtocol {//Presenter Katmanı
    var yemekDetayInteractor:PresenterToInteractorYemekDetayProtocol? {get set}
   
    func ekle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String,yemek_siparis_adet:String,kullanici_adi:String)
    
}
protocol PresenterToInteractorYemekDetayProtocol {//Interactor Katmanı

    func yemekEkle(yemek_adi:String,yemek_resim_adi:String,yemek_fiyat:String,yemek_siparis_adet:String,kullanici_adi:String)

}
protocol PresenterToRouterYemekDetayProtocol {
    static func createModule(ref:YemekDetayVC)
}
