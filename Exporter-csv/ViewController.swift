//
//  ViewController.swift
//  Exporter-csv
//
//  Created by Feng Chang on 10/15/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.creatCSV()
    }

    func getData() -> [Location] {
        let url = Bundle.main.url(forResource: "RealmFile", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data) as! [String: [Any]]
            let jsonData = try JSONSerialization.data(withJSONObject: json["PRLocationRealm"], options: [])
            let decoder = JSONDecoder()
            let locations = try decoder.decode([Location].self, from: jsonData)
            
            return locations
        } catch {
            print(error)
            return []
        }
    }

    func creatCSV() {
        let fileName = "locations-ios.csv"
        let path = NSURL(fileURLWithPath: "/Users/fengchang/Documents/").appendingPathComponent(fileName)
        var csvText = "id,penLocation,lat,lng,altitude,accuracy,timestamp\n"
        
        for location in getData() {
            let newLine = "\(location.id),\(location.penLocation),\(location.lat),\(location.lng),\(location.altitude),\(location.accuracy),\(location.timestamp)\n"
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        print(path ?? "not found")
    }
}



