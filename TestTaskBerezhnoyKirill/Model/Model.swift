//
//  Model.swift
//  TestTaskBerezhnoyKirill
//
//  Created by Кирилл Бережной on 13.09.2023.
//

import Foundation
import MapKit

class Person: NSObject, MKAnnotation {
    let title: String?
    let connection: String?
    let date: String?
    let time: String?
    let coordinate: CLLocationCoordinate2D
    var image: UIImage?
    
    var subtitle: String? {
        return "\(connection ?? ""), \(time ?? "")"
    }
    
    var newImage: UIImage {
        guard let imageName = title else {
            return UIImage(named: "mark") ?? UIImage()
        }
        switch imageName {
        case "Илья":
            return UIImage(named: "ilya") ?? UIImage()
        case "Александр":
            return UIImage(named: "aleksandr") ?? UIImage()
        case "Анастасия":
            return UIImage(named: "anastasia") ?? UIImage()
        default:
            return UIImage(named: "mark") ?? UIImage()
        }
    }
    
    init(title: String?, connection: String?, date: String?, time: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.connection = connection
        self.date = date
        self.time = time
        self.coordinate = coordinate
        
        super.init()
    }
}

class NowLocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var image: UIImage = UIImage(named: "nowLocation") ?? UIImage()
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
