//
//  Meteo.swift
//  Weather
//
//  Created by Thabet on 3/27/20.
//  Copyright © 2020 TO. All rights reserved.
//

import Foundation

class Meteo {
    var date_string:String = ""
    var temperature:Double = 0.0
    var desc:String = ""
    var nom_image: String = ""
    
    init (unix:Int, temp:Double, id_condition:Int ){
        traiter_date(unix: unix)
        self.temperature = temp
        traiter_condition(Id: id_condition)
    
    }
    
    func traiter_date(unix:Int)   // fonction converter chiffre --> date
    {
        let ns_date = NSDate(timeIntervalSince1970: TimeInterval(unix))
        let date:Date = ns_date as Date
         let date_formater:DateFormatter = DateFormatter()
        date_formater.dateFormat = "dd MMM YYYY à HH:mm"
        self.date_string = date_formater.string(from: date)
    }
    
    func traiter_condition(Id:Int)
    {
        switch Id {
        case 200...232:
            self.nom_image="11.jpg"
            self.desc="Orage"
        case 300...321,520...531:
            self.nom_image="12.jpg"
            self.desc="Pluie nuageuse "
        case 500...504:
            self.nom_image="13.jpg"
            self.desc="Pluie ensoleillé"
        case 511:
            self.nom_image="14.jpg"
            self.desc="pluie verglacente"
        case 800:
            self.nom_image="15.jpg"
            self.desc="ciel claire"
        
        case 801...804:
            self.nom_image="16.jpg"
            self.desc="Nuageux"
        default:
            self.nom_image="15.jpg"
            self.desc="ciel claire"
        }
    }
}
