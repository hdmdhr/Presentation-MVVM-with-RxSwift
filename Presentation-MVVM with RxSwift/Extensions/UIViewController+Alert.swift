//
//  UIViewController+Alert.swift
//  Presentation-MVVM with RxSwift
//
//  Created by 胡洞明 on 2021-03-24.
//

import UIKit
import Alamofire



extension UIViewController {
    
    func presentErrorAlert(error: Error) {
        let message: String?
        
        switch error {
        case is Alamofire.AFError:
            switch (error as! Alamofire.AFError) {
            case .responseValidationFailed(reason: .unacceptableStatusCode(let code)):
                message = "invalid status code: \(code)"
                
            default: message = error.localizedDescription
            }
            
        default: message = "Unknown error"
        }
        
        
        let alert = UIAlertController(title: "Error Occurred", message: message, preferredStyle: .alert)
        alert.addAction(.Action("OK", style: .cancel))
        
        present(alert, animated: true, completion: nil)
    }
    
}
