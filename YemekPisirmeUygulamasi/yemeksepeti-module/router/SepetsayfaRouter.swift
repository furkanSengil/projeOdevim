//
//  SepetsayfaRouter.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 27.03.2022.
//

import Foundation

class SepetsayfaRouter : PresenterToRouterSepetProtocol {
    static func createModule(ref: YemekSepetVC) {
        let presenter = SepetsayfaPresenter()
        
        //View
        ref.sepetsayfaPresenterNesnesi = presenter
        //Presenter
        ref.sepetsayfaPresenterNesnesi?.sepetInteractor = SepetsayfaInteractor()
        ref.sepetsayfaPresenterNesnesi?.sepetView = ref
        //Interactor
        ref.sepetsayfaPresenterNesnesi?.sepetInteractor?.sepetPresenter = presenter
    }
    
    
}
