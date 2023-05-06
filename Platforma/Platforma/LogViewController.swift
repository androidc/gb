//Created by chizztectep on 06.05.2023 

import UIKit

class LogViewController: UIViewController {
    var victim:Victim?
    
    @IBOutlet weak var LName: UILabel!
    
    @IBOutlet weak var TLog: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LName.text = victim?.name
        guard let logs = victim?.logs else {return}
        
        for log in logs {
            TLog.text.append("\n")
            let header = "день \(log.day), этаж: \(log.floor), статус: \(log.status.showStatus()), голод: \(log.hungry ?? 0) \n"
            TLog.text.append(header)
            TLog.text.append("\n")
            TLog.text.append("\(log.message) \n")
            
            
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
