//
//  GirisSayfasiVC.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 25.03.2022.
//

import UIKit

class GirisSayfasiVC: UIViewController {

    @IBOutlet weak var emailgiris: UITextField!
    @IBOutlet weak var sifregiris: UITextField!
    
    
    var mail = DataBase.sharedInstance.a
    var kullanıcıismi = DataBase.sharedInstance.c
    var adres = DataBase.sharedInstance.b
    var telefon = DataBase.sharedInstance.d
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        //Anasayfa ilk açıldığında ve anasayfaya geri döndüğümüzde çalışır.
        DataBase.sharedInstance.a = ""
        DataBase.sharedInstance.c = ""
        DataBase.sharedInstance.b = ""
        DataBase.sharedInstance.d = ""
    }
    
   
        @IBAction func girisButton(_ sender: Any) {
            if let email = emailgiris.text, let sifre = sifregiris.text {
                
                DataBase.sharedInstance.filtre(verilenMail: email,verilenSifre: sifre)
                
                mail = DataBase.sharedInstance.a
                kullanıcıismi = DataBase.sharedInstance.c
                adres = DataBase.sharedInstance.b
                telefon = DataBase.sharedInstance.d
                
                
                print(mail)
                print(kullanıcıismi)
                
                if mail != "" {
                    performSegue(withIdentifier: "anasayfaKullaniciBilgileri", sender: [mail,kullanıcıismi,adres,telefon])
                }
               
            
        }
           
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "anasayfaKullaniciBilgileri"{
            let bilgiler = sender as? [String]
            let gidilecekVC = segue.destination as! AnasayfaVC
            gidilecekVC.bilgiler = [mail,kullanıcıismi,adres,telefon]
        }
    }

}
