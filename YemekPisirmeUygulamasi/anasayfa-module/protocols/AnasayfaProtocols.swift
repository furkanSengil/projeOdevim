//
//  AnasayfaProtocols.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 23.03.2022.
//

import Foundation

protocol ViewToPresenterAnasayfaProtocol {//Presenter Katmanı
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func yemekleriYukle()
    func ara(aramaKelimesi:String)
  
}

protocol PresenterToInteractorAnasayfaProtocol {//Interactor Katmanı
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
 
    func tumYemekleriAl()
    func yemekAra(aramaKelimesi:String)

}

protocol InteractorToPresenterAnasayfaProtocol {
    func preseneteraVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(yemeklerListesi:Array<Yemekler>)
}

protocol PresenterToRouterAnasayfaProtocol {
    static func createModule(ref:AnasayfaVC)
}
