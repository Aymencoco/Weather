//
//  ViewController.swift
//  Weather
//
//  Created by Thabet on 3/27/20.
//  Copyright © 2020 TO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image_fnd: UIImageView!
    @IBOutlet weak var degree: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var ville: UITextField!
    @IBOutlet weak var date: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        rechercher(ville : "paris")
    }
    
    func rechercher(ville:String)  {
        do {
        let url =               NSURL(string:"http://api.openweathermap.org/data/2.5/weather?appid=79ab92ee7aba089ef7c6dbb6c96c9a54&units=metric&q=\(ville)");
        let texte:NSString = try NSString(contentsOf: url! as URL, usedEncoding:nil)
                
        let jsonData = texte.data(using: 4)
        let jsonResult: NSDictionary? = try JSONSerialization.jsonObject(with: jsonData!) as? NSDictionary
        
                if let jsonRuslt = jsonResult {
                    
                    let weather_array = jsonResult?["weather"] as! NSArray
                    let weather = weather_array[0] as! NSDictionary
                    let main = jsonResult? ["main"] as! NSDictionary
                    let dt = jsonResult? ["dt"] as! Int
                    
                    let id_condition:Int = weather["id"] as! Int
                    let temp = main["temp"] as! Double
                    
            let meteo:Meteo = Meteo(unix: dt, temp: temp, id_condition: id_condition)
                    afficher(m:meteo)
                }
                
                
            } catch{
                
                print("Error de conversation")
            }
            
    }
    
    func afficher(m:Meteo) {
           icon.image = UIImage(named: m.nom_image)
             image_fnd.image = UIImage(named: "f_"+m.nom_image)
             degree.text = "\(m.temperature)°C"
             desc.text = m.desc
             date.text="Dernière mise a jour le \(m.date_string)"
    }
    @IBAction func rechercher(_ sender: UIButton) {
        
        rechercher(ville : ville.text!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            (segue.identifier == "aller_vers_prevision"){
            
            let VsPrevision:previsionViewController = segue.destination as! previsionViewController
            
            VsPrevision.ville = ville.text!
            
            
            
        }
    }
    
    
}

