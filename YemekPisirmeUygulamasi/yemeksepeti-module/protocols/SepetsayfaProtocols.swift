import Foundation

protocol PresenterToInteractorSepettProtocol {
    var sepetPresenter:InteractorToPresenterSepetProtocol? {get set}
    
    func tumsepetiGetir(kullanici_adi:String)
    func deleteFood(sepet_yemek_id:Int,kullanici_adi:String)
}

protocol ViewToPresenterSepetProtocol {
    var sepetInteractor:PresenterToInteractorSepettProtocol? {get set}
    var sepetView:PresenterToViewSepetProtocol? {get set}
    
    func sepettekileriGetir(kullanici_adi:String)
    func delete(sepet_yemek_id:Int,kullanici_adi:String)
}

protocol InteractorToPresenterSepetProtocol {
    func preseneteraVeriGonder(yemeklistesi:Array<SepetYemekleri>)
}

protocol PresenterToViewSepetProtocol {
    func sendDataToView(yemeklistesi:Array<SepetYemekleri>)
}

protocol PresenterToRouterSepetProtocol {
    static func createModule(ref: YemekSepetVC)
}
