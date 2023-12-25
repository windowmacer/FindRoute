//
//  Alerts.swift
//  FindRoute
//
//  Created by Кирилл Арефьев on 24.12.2023.
//

import UIKit

extension UIViewController {
	
	func alertAddAdress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
		let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
		alertController.addTextField { textField in
			textField.placeholder = placeholder
		}
		
		let alertOk = UIAlertAction(title: "OK", style: .default) { action in
			let textField = alertController.textFields?.first
			guard let text = textField?.text else { return }
			completionHandler(text)
		}
		let alertCancel = UIAlertAction(title: "Cancel", style: .default)
		
		alertController.addAction(alertOk)
		alertController.addAction(alertCancel)
		
		present(alertController, animated: true)
	}
	
	func alertError(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
		
		let alertOk = UIAlertAction(title: "OK", style: .default)
		
		alertController.addAction(alertOk)
		
		present(alertController, animated: true)
	}
	
}
