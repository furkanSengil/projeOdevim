//
//  KayitSayfasiVC.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 25.03.2022.
//

import UIKit

class KayitSayfasiVC: UIViewController {

    @IBOutlet weak var girilenKullaniciGirisi: UITextField!
    @IBOutlet weak var girilenEmail: UITextField!
    @IBOutlet weak var girilenSifre: UITextField!
    @IBOutlet weak var girilenTelefon: UITextField!
    @IBOutlet weak var girilenAdres: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    let dataBase = DataBase()
    

    @IBAction func kayitButton(_ sender: Any) {
        let yeniKisi = Kisiler(kullaniciIsmi: girilenKullaniciGirisi.text!, sifre: girilenSifre.text!, email: girilenEmail.text!, telefon: girilenTelefon.text!, adres: girilenAdres.text!)
        if dataBase.kisiler.contains(where: {$0.email == girilenEmail.text!}) {
            print("baska mail gir")
        } else {
            print("yeni kişi girildi")
            dataBase.kisiler.append(yeniKisi)
            DataBase.sharedInstance.ekleme(KullaniciIsmi: girilenKullaniciGirisi.text!, Sifre: girilenSifre.text!, Email: girilenEmail.text!, Telefon: girilenTelefon.text!, Adres: girilenAdres.text!)
        }
    }
    

}
