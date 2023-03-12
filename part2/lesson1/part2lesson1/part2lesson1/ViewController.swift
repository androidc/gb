//
//  ViewController.swift
//  part2lesson1
//
//  Created by Артем  on 28.11.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var loginInput: UITextField!
    
    @IBOutlet weak var passInput: UITextField!
    
    @IBAction func openTabBar(_ sender: Any) {
        
        guard let login = loginInput.text, let password = passInput.text, login == "aaa", password == "111" else {
            show(message: "неверный логин или пароль")
            return}
        
        performSegue(withIdentifier: "openMainTabBar", sender: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension UIViewController {
    
    func show(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertVC.addAction(okAction)
        
        present(alertVC,animated: true,completion: nil)
        
    }
}

