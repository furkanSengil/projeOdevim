//
//  YemekDetayProtocols.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 26.03.2022.
//

import Foundation
protocol ViewToPresenterYemekDetayProtocol {//Presenter Katmanı
    var yemekDetayInteractor:PresenterToInteractorYemekDetayProtocol? {get set}
    var yemekDetayView:PresenterToViewYemekDetayProtocol? {get set}
    
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
    func sil(yemek_id:String)
}

protocol PresenterToInteractorYemekDetayProtocol {//Interactor Katmanı
    var yemekDetayPresenter:InteractorToPresenterYemekDetayProtocol? {get set}
    
 
    func tumYemekleriAl()
    func yemekAra(aramaKelimesi:String)
    func yemekSil(yemek_id:String)
}

protocol InteractorToPresenterYemekDetayProtocol {
    func preseneteraVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToViewYemekDetayProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToRouterYemekDetayProtocol {
    static func createModule(ref:YemekDetayVC)
}
