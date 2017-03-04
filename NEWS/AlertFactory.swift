//
//  AlertFactory.swift


import UIKit
class AlertFactory {

    static func defaultAlert(caller: UIViewController) {
        let alert = UIAlertController(title: "Something went wrong", message: "please try again later", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        caller.present(alert, animated:true, completion: nil)
    }
    static func successAlert(caller: UIViewController, msg: String) {
        let alert = UIAlertController(title: "Success!", message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(action)
        caller.present(alert, animated:true, completion: nil)
    }
}
