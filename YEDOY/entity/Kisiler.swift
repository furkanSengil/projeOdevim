//
//  Kisiler.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 25.03.2022.
//

import Foundation

class Kisiler: NSObject {
    var kullaniciIsmi:String?
    var sifre:String?
    var email:String?
    var telefon:String?
    var adres:String?
    
    init(kullaniciIsmi:String,sifre:String,email:String,telefon:String,adres:String){
        self.email = email
        self.kullaniciIsmi = kullaniciIsmi
        self.sifre = sifre
        self.telefon = telefon
        self.adres = adres
    }
}
