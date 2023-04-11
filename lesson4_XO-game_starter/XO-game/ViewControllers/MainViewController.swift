//Created by chizztectep on 11.04.2023 

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Functions
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "computerSegue":
            guard let destinationVC = segue.destination as? GameViewController else {return}
            destinationVC.gameType = .computer
        case "humanSegue":
            guard let destinationVC = segue.destination as? GameViewController else {return}
            destinationVC.gameType = .human
        default:
            break
        }
        
    }
    

}

