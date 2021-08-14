//
//  AlertController+Image.swift
//  TestProjectHedgehogTech
//
//  Created by Михаил on 13.08.2021.
//

import UIKit

extension UIAlertController {
    func addImage(image: UIImage) {
        let imgAction = UIAlertAction(title: "", style: .default, handler: nil)
        imgAction.isEnabled = false
        imgAction.setValue(image, forKey: "image")
        self.addAction(imgAction)
    }
}
