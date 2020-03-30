//
//  previsionViewController.swift
//  Weather
//
//  Created by Thabet on 3/28/20.
//  Copyright © 2020 TO. All rights reserved.
//

import UIKit

class previsionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    var ville :String = ""
    var data = [Meteo]()
    @IBOutlet weak var TB: UITableView!
    @IBOutlet weak var bare: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bare.topItem?.title = "prévision de \(ville) "
        do {
        let url =               NSURL(string:"http://api.openweathermap.org/data/2.5/forecast?appid=79ab92ee7aba089ef7c6dbb6c96c9a54&units=metric&q=\(ville)");
        let texte:NSString = try NSString(contentsOf: url! as URL, usedEncoding:nil)
                
        let jsonData = texte.data(using: 4)
        let jsonResult: NSDictionary? = try JSONSerialization.jsonObject(with: jsonData!) as? NSDictionary
        
                if let jsonRuslt = jsonResult
                
            {
                let list = jsonRuslt["list"] as! NSArray
                for meteo_ in list {
                    let meteo:NSDictionary = meteo_ as!NSDictionary
                    
                    let weather_array = meteo["weather"] as! NSArray
                    let weather = weather_array[0] as! NSDictionary
                    let main = meteo["main"] as! NSDictionary
                    let dt = meteo["dt"] as! Int
                    
                    let id_condition:Int = weather["id"] as! Int
                    let temp = main["temp"] as! Double
                    
                    self.data.append(Meteo(unix: dt, temp: temp, id_condition: id_condition))
                }}
                
                
            } catch{
                
                print("Error de conversation")
        }

      
        
    }
    
    @IBAction func quitter(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // table viwe
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
        
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.TB.dequeueReusableCell(withIdentifier: "celli") as! CustomTableViewCell
        
        let meteo:Meteo=self.data[indexPath.row]
        
        
        cell.img1.image=UIImage(named: meteo.nom_image)
        cell.dati.text = meteo.date_string
        cell.dgr.text = "\(meteo.temperature) °C"
        cell.ds.text=meteo.desc
        
        
        
        
        return cell 
        
       }

}
