//
//  Alert.swift
//  BasisTestTask
//
//  Created by Himanshu Chaurasiya on 19/05/20.
//  Copyright © 2020 Himanshu Chaurasiya. All rights reserved.
//

import UIKit


struct Alert {
    
    public static func showAlert(on vc:UIViewController, with title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
