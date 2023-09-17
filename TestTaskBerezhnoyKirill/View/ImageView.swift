//
//  ImageView.swift
//  TestTaskBerezhnoyKirill
//
//  Created by Кирилл Бережной on 15.09.2023.
//

import UIKit
import Foundation

extension UIImage {
    func createImage(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
        image.draw(in: CGRect(x: 8, y: 5, width: image.size.width, height: image.size.height))
        guard let combinedImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return combinedImage
    }
}

