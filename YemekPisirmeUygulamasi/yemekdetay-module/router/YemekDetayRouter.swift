//
//  YemekDetayRouter.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 27.03.2022.
//

import Foundation
class YemekDetayRouter: PresenterToRouterYemekDetayProtocol  {
    static func createModule(ref: YemekDetayVC) {
        ref.yemekDetayPresenterNesnesi = YemekDetayPresenter()
        ref.yemekDetayPresenterNesnesi?.yemekDetayInteractor = YemekDetayInteractor()
    }
}
