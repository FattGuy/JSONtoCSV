//
//  Location.swift
//  Exporter-csv
//
//  Created by Feng Chang on 10/15/21.
//

import Foundation

struct Location: Codable {
    var id: Int64
    var penLocation: String
    var lat: Double
    var lng: Double
    var altitude: Double
    var accuracy: Int
    var timestamp: String
}
