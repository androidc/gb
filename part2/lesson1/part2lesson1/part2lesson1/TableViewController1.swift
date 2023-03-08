//
//  TableViewController1.swift
//  part2lesson1
//
//  Created by Артем Солохин on 30.11.2022.


import UIKit
import Alamofire



class TableViewController1: UITableViewController {

    let baseUrl = "https://api.vk.com"


    
    let friendsTestData:[FriendModel]  = [
        FriendModel(image: UIImage.init(systemName: "figure.walk"), name: "Уася"),
        FriendModel(image: UIImage.init(systemName: "person.2"), name: "Петя"),
        FriendModel(image: UIImage.init(systemName: "person.wave.2"), name: "Костя"),
        FriendModel(image: UIImage.init(systemName: "person.fill"), name: "Натаха"),
        FriendModel(image: UIImage.init(systemName: "person.fill.turn.left"), name: "Вика"),
        FriendModel(image: UIImage.init(systemName: "figure.stand"), name: "Рита")
        
    ]
    
    func getUsers() {
       
        let method = "/method/users.get"
        
        let param: Parameters = [
            "user_ids":"8553946",
            "access_token":Session.sharedInstance.token,
            "v":"5.131"
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get
                   , parameters: param)
            .responseJSON { res in
               
                print(res)
                if let data = res.data {
                    let users = try! JSONDecoder().decode(Response.self, from: data)
                    print(users.response[0].firstName)
                }
            }
        
    }
   /**
    Возвращает список идентификаторов друзей пользователя или расширенную информацию о друзьях пользователя (при использовании параметра fields).
    
     - Parameter order: Порядок, в котором нужно вернуть список друзей. Допустимые значения: hints, random, name
     - Parameter count: Количество друзей, которое нужно вернуть.
    - Parameter userId: id пользователя друзей которого надо вернуть, если не указан то возвращаются друзья текущего
    
    */
    
    func getFriends(order:String, count: Int, offset: Int? = 0, userId:Int?) {
        let method = "/method/friends.get"
        var param: Parameters = ["access_token":Session.sharedInstance.token]
        if let userId = userId {
            param = [
                "access_token":Session.sharedInstance.token,
                "user_id":userId,
                "order":order,
                "count":count,
                "offset":offset,
                "fields":"first_name,last_name",
                "v":"5.131"
       ]
        } else {
        param = [
           "access_token":Session.sharedInstance.token,
           "order":order,
           "count":count,
           "offset":offset,
           "fields":"first_name,last_name",
           "v":"5.131"
       ]
        }
        
        
        
        let url = baseUrl + method
        
        AF.request(url, method: .get
                   , parameters: param)
            .responseJSON { res in
                
                print(res)
                if let data = res.data {
                    let friends = try! JSONDecoder().decode(ResponseFriendsRoot.self, from: data)
                    print(friends.response.items[0].firstName)
                }
            }
        
        
        
    }
    /**
     Возвращает список сообществ указанного пользователя.
      - Parameter filter: Список фильтров сообществ, которые необходимо вернуть, перечисленные через запятую. (admin, editor, moder,publics etc)
      - Parameter count: Количество сообществ, информацию о которых нужно вернуть.
      - Parameter offset: Смещение, необходимое для выборки определённого подмножества сообществ.
     */
    
    func getGroups (filter :String,count:Int,offset: Int? = 0, userId: Int?) {
        
        let method = "/method/groups.get"
        var param: Parameters = ["access_token":Session.sharedInstance.token]
        if let userId = userId {
        param = [
            "user_id":userId,
            "access_token":Session.sharedInstance.token,
            "filter":filter,
            "count": count,
            "extended":true,
            "offset": offset,
            "v":"5.131"
        ]
        } else {
        param = [

            "access_token":Session.sharedInstance.token,
            "filter":filter,
            "count": count,
            "offset": offset,
            "extended":true,
            "v":"5.131"
        ]
        
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get
                   , parameters: param)
            .responseJSON { res in
                
                if let data = res.data {
                    let groups = try! JSONDecoder().decode(ResponseGroupsRoot.self, from: data)
                    print(groups.response.items[0].name)
                }
                
                print(res)
            }
        
        
    }
    
    /**
     Осуществляет поиск сообществ по заданной подстроке.
       - Parameter q: Текст поискового запроса
       - Parameter count: Количество результатов поиска, которое необходимо вернуть.
       - Parameter offset: Смещение, необходимое для выборки определённого подмножества результатов поиска. По умолчанию 0

     */
    func searchGroups(q:String, count:Int, offset:Int? = 0) {
        let method = "/method/groups.search"
        let param:Parameters = [
            "access_token":Session.sharedInstance.token,
            "q":q,
            "count": count,
            "offset": offset,
            "v":"5.131"
        ]
        
        let url = baseUrl + method
        
        AF.request(url, method: .get
                   , parameters: param)
            .responseJSON { res in
                print(res)
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
       // getUsers()
      //  getFriends(order: "random", count: 100,userId: nil)
       // getGroups(filter: "", count: 10, userId: nil)
      //  searchGroups(q: "программирование", count: 10)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return friendsTestData.count
    }

//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCellId", for: indexPath) as? FriendCell else {
            preconditionFailure("Friend cell not defined")
        }
        
        cell.imageFriend?.image =  friendsTestData[indexPath.row].image
        cell.friendName.text = friendsTestData[indexPath.row].name
        
        
       

        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
