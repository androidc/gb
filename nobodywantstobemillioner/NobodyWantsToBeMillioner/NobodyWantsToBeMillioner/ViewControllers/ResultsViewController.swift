//Created by chizztectep on 25.03.2023

// v.1.0.0
// v.1.0.1 - hw pattern l2 strategy, facade, observer, builder

import UIKit

class ResultsViewController: UIViewController {
    
    

    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }
    
    // MARK: - private properties
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    

  

}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        let record = Game.shared.records[indexPath.row]
        cell.textLabel?.text = dateFormatter.string(from: record.date)
        cell.detailTextLabel?.text = "\(record.score)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Game.shared.records.count
    }
  
    
    
}
