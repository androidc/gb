//Created by chizztectep on 06.05.2023 

import UIKit

class ViewController: UIViewController {
    private var dayCounter: Int = 0
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var LDay: UILabel!
    
    @IBOutlet weak var LTable: UILabel!
    
    
    var platforma: Platforma = Platforma(victims: People.generateTwentyVictims(), floorCount: 10)
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        platforma.settleVictims()
        platforma.tableLifeCycle()
        
        platforma.table.currentFloor.addObserver(self, options: [.new]) { floor, _ in
            DispatchQueue.main.async {
                self.LDay.text = "День \(self.platforma.dayCounter)"
                self.LTable.text = "Стол \(self.platforma.table.currentFoodValue), Этаж \(self.platforma.table.currentFloor.value)"
                self.tableView.reloadData()
            }
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
    }


}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return platforma.floorCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // section - floor
        return platforma.floors[section].victims_on_floor.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // section - floor
        let section = platforma.floors[indexPath.section]
        // в indexPath хранится текущий индекс жителя на этаже (в секции)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
       
        // let record = Game.shared.records[indexPath.row]
        cell.textLabel?.text = "\(section.victims_on_floor[indexPath.row].name) - \(section.victims_on_floor[indexPath.row].dayZ)"
        cell.detailTextLabel?.text = "\(section.victims_on_floor[indexPath.row].status.showStatus()) , голод: \(section.victims_on_floor[indexPath.row].hungry) "
         return cell
        
        
    }
    
    func tableView(_ tableView: UITableView,
                       titleForHeaderInSection section: Int) -> String? {
            "Этаж \(section + 1)"
        }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        //print(indexPath.row)
        //print(indexPath.section)
        //print(platforma.floors[indexPath.section].victims_on_floor[indexPath.row].name)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)

        let vc = storyBoard.instantiateViewController(withIdentifier: "logView") as! LogViewController
        vc.victim = platforma.floors[indexPath.section].victims_on_floor[indexPath.row]
        self.present(vc, animated:true, completion:nil)
    }

    
}

