//Created by chizztectep on 15.04.2023

// v.1.0 - lesson5hw

import UIKit

class ViewController: UIViewController {
    let testModel:TestModel = TestModel()
    var selectedIndexPath: Int = 0

    
    
    
    // MARK: - Actions

    @IBAction func AddTaskAction(_ sender: Any) {
        
        print("addTask button pressed")
    }
    
    
    @IBAction func backButtonAction(_ sender: Any) {
        
        // возвращаемся на предыдущий уровень и обновляем таблицу
        // вопрос как это сделать :)
        // это было бы не проблемой если бы мы использовали разные экраны :)
        
        // для отладки
        CurrentLevel.shared.description()
        
        let popVal =   CurrentLevel.shared.pop()
        
        guard let peek = CurrentLevel.shared.peek() else {
            // значит выбросили корень
            self.backButton.isEnabled = false
            // вернуть в стек вытащенный массив
            CurrentLevel.shared.push(popVal)
            CurrentLevel.shared.level = 0
            tableView.reloadData()
            self.navBar.topItem?.title = "Root"
            return
        }
        CurrentLevel.shared.currentTasks = peek
        // нужно обновить в currentTasks таски у добавленной задачи
        CurrentLevel.shared.currentTasks[selectedIndexPath].tasks = popVal
        
        // уменьшаем уровень перехода
        CurrentLevel.shared.level -= 1
        tableView.reloadData()
        if let parent = CurrentLevel.shared.currentTasks[0].parent {
            self.navBar.topItem?.title = parent
        } else { self.navBar.topItem?.title = "Root" }
        
      // print(CurrentLevel.shared.currentTasks[0].parent)
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    
    

    @IBOutlet weak var navBar: UINavigationBar!
    
    // MARK: - main
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        navBar.topItem?.title = "Root"
        
        testModel.createTestTasks()
        CurrentLevel.shared.level = 0
        CurrentLevel.shared.currentTasks = testModel.tasks
        CurrentLevel.shared.push(testModel.tasks)
        
        NotificationCenter.default.addObserver(self,selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"),object: nil)
            
    }
                                               
    @objc func loadList(notification: NSNotification) {
      
           self.tableView.reloadData()
        
        }

    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentLevel.shared.currentTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse or create a cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        
        // For a standard cell, use the UITableViewCell properties.
        cell.textLabel!.text = CurrentLevel.shared.currentTasks[indexPath.row].name
        cell.detailTextLabel?.text = "Подзадач: \(CurrentLevel.shared.currentTasks[indexPath.row].tasks.count)"
        
         return cell
    }
    
    // нажатие на ячейку в таблице
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("pressed on \(CurrentLevel.shared.currentTasks[indexPath.row].name)")
        // сохраним имя таски для передачи в NavBar в случае если дошли до листа
        let name = CurrentLevel.shared.currentTasks[indexPath.row].name
        //
        CurrentLevel.shared.currentTasks = CurrentLevel.shared.currentTasks[indexPath.row].tasks
        CurrentLevel.shared.push(CurrentLevel.shared.currentTasks)
        // это нужно, чтобы при нажатии на кнопку Back обновить таски у задачи, в которую мы добавляли subtask
        selectedIndexPath = indexPath.row
        // переходим на уровень ниже в дереве
        CurrentLevel.shared.level += 1
        backButton.isEnabled = true
        
        if CurrentLevel.shared.currentTasks.count > 0 , let parent = CurrentLevel.shared.currentTasks[0].parent {
            self.navBar.topItem?.title = parent
        } else {
            self.navBar.topItem?.title = name
        }
        
        CurrentLevel.shared.selectedIndexPath = indexPath.row
        
        
        tableView.reloadData()
        
    }
    
    
    
}


