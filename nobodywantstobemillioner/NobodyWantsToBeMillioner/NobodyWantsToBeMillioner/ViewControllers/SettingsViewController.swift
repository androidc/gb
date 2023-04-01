//Created by chizztectep on 30.03.2023 

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var settingsControl: UISegmentedControl!
    
    // MARK: - calculated properties
    
    private var selectedStrategy: ChoosenStrategy {
        switch settingsControl.selectedSegmentIndex {
        case 0: return .staticStrategy
        case 1: return .randomStrategy
        default:   return .staticStrategy
        }
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Game.shared.choosenStrategy = selectedStrategy
       
    }

    

}
