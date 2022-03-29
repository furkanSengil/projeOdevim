//
//  DataBase.swift
//  YemekPisirmeUygulamasi
//
//  Created by Furkan Sengil on 25.03.2022.
//

import Foundation
import SQLite

class DataBase {
    static var sharedInstance = DataBase()
    var db: Connection?
    var kisiler = [Kisiler]()
    
    var users = Table("users")
    let id = Expression<Int64>("id")
    let kullaniciIsmi = Expression<String>("kullaniciIsmi")
    let sifre = Expression<String>("sifre")
    let email = Expression<String>("email")
    let telefon = Expression<String>("telefon")
    let adres = Expression<String>("adres")

    
    init () {

        var path = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true).first!
print(path)
    
        do {

            db = try Connection("\(path)/db.sqlite3")
           
            try db!.run(users.create(temporary: false, ifNotExists: true, block: { t in
                t.column(id, primaryKey: true)
                t.column(kullaniciIsmi)
                t.column(sifre)
                t.column(email, unique: true)
                t.column(telefon)
                t.column(adres)
        }))
        }catch{
            print(error)
        }
        
    }
    
    func ekleme(KullaniciIsmi:String,Sifre:String,Email:String,Telefon:String,Adres:String){
        do {
        try db!.run(users.insert(kullaniciIsmi <- KullaniciIsmi, sifre <- Sifre, email <- Email, telefon <- Telefon, adres <- Adres))

        }catch{
            
            print(error)
            
        }
    }
    func listeleme(){
        do{
            for user in try db!.prepare(users) {
                   print("id: \(user[id]), name: \(user[kullaniciIsmi]), email: \(user[email]), şifre: \(user[sifre]), telefon: \(user[telefon]), adres: \(user[adres])")
               }
        }catch{
            print(error)
        }
    }
    var a = ""
    var b = ""
    var c = ""
    var d = ""
    func filtre(verilenMail:String,verilenSifre:String) {
        
        do{
            
            let arananKisi = users.filter(email == verilenMail && sifre == verilenSifre)
           // print(arananKisi)
                for user in try db!.prepare(arananKisi) {
                       print("id: \(user[id]), name: \(user[kullaniciIsmi]), email: \(user[email]), şifre: \(user[sifre])")
                    a = user[email]
                     b = user[adres]
                     c = user[kullaniciIsmi]
                    d = user[telefon]
                 
                }
         
        
        }catch{
            
            print(error)
            
        }
        
    
    }
    /*
    func guncelle(){
        do{
            let  arananKisi = users.filter(kullaniciIsmi == "Furkan")
            try db!.run(arananKisi.update(email <- email.replace("furkan@gmail.com@gmail.com@gmail.com", with: "furkan@gmail.com")))
            
        }catch{
            
            print(error)
            
        }
    }
     */
    /*
    func silme(){
        
        do{
            let  arananKisi = users.filter(kullaniciIsmi == "Furkan")
            try db!.run(arananKisi.delete())
            
        }catch{
            
            print(error)
            
        }
        
    }
    */
}
