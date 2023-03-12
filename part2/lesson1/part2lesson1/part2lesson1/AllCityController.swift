//
//  AllCityController.swift
//  part2lesson1
//
//  Created by Артем  on 30.11.2022.
//

import UIKit

class AllCityController: UIViewController {
    
    let cities = [
        CityModelData(image: UIImage.init(systemName: "globe.americas") ,name: "Moscow"),
        CityModelData(name: "SPB"),
        CityModelData(name: "Kazan"),
        CityModelData(name: "Perm")
    ]

    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

extension AllCityController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllCityCellId", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = cities[indexPath.row].name
        content.image = cities[indexPath.row].image
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
