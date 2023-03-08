//
//  NewsViewController.swift
//  part2lesson1
//
//  Created by Артем on 23.02.2023.
//

import UIKit
import Alamofire

class NewsViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let baseUrl = "https://api.vk.com"
    var newsresp:NewsResponse?
   
    var dict: [Int: String] = [:]
    
    func createDict(from news:NewsResponse) {
     
        if news.response.profiles.count > 0 {
        for profile in news.response.profiles {
            self.dict[profile!.id] = "\(profile!.first_name) \(profile!.last_name)"
        }}
        if  news.response.groups.count > 0 {
        for group in news.response.groups {
            self.dict[group.id] = group.name
        }
        }
                      
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      getNews(count: 3, userId: nil)
       
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: "CustomHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomHeaderView")
        tableView.register(UINib(nibName: "CustomerFooterView", bundle: nil), forHeaderFooterViewReuseIdentifier: "CustomerFooterView")

        // Do any additional setup after loading the view.
        
     //   print("in NewsViewController")
        
    }
    
    func getFioByIDFromProfiles(id ID: Int,from news: NewsResponse) -> String {
        var result: String = ""
        var counter: Int = 0
        if news.response.profiles.count > 0 {
            repeat {
                if news.response.profiles[counter]?.id == ID {
                    result = "\(news.response.profiles[counter]?.first_name) \(news.response.profiles[counter]?.last_name)"
                }
               counter += 1
            } while (result == "" && counter<news.response.profiles.count)
        }
       
          return result
    }
    
    func getFioByIDFromGroups(id ID: Int,from news: NewsResponse) -> String {
        var result: String = ""
        var counter: Int = 0
        if news.response.groups.count > 0 {
            repeat {
                if news.response.groups[counter].id == -ID {
                    result = "\(news.response.groups[counter].name)"
                }
               counter += 1
            } while (result == "" && counter<news.response.groups.count)
        }
       
          return result
    }
    
    func getFio(id: Int,news: NewsResponse) -> String {
        var result:String = ""
        result = getFioByIDFromProfiles(id: id, from: news)
        if result == ""
                {result = getFioByIDFromGroups(id: id, from: news) }
        return result
    }
    

    
    /**
     Возвращает список новостей указанного пользователя.
     Если пользователь не указан, то список новостей текущего пользователя

   
      - Parameter count: Количество сообществ, информацию о которых нужно вернуть.
     
     */
    
    func getNews (count:Int, userId: Int?)  {
        
        let method = "/method/newsfeed.get"
        var param: Parameters = ["access_token":Session.sharedInstance.token]
        if let userId = userId {
        param = [
            "access_token":Session.sharedInstance.token,
            "filters":"post",
            "user_id":userId,
            "count": count,
            "v":"5.131"
        ]
        } else {
        param = [

            "access_token":Session.sharedInstance.token,
            "filters":"post",
            "count": count,
            "v":"5.131"
        ]
        
        }
        
        let url = baseUrl + method
        
        AF.request(url, method: .get
                   , parameters: param)
            .responseJSON { res in
                print(res)
                if let data = res.data {
                    let news = try! JSONDecoder().decode(NewsResponse.self, from: data)
                    self.newsresp = news
                    self.createDict(from: news)
                    self.tableView.reloadData()
                    for new in news.response.items {
                        print(new.text)

                    }
                    
                    if  news.response.profiles.count > 0  {
                        print(news.response.profiles[0]?.first_name)
                        print(news.response.profiles[0]?.last_name)
                    }
                    
                   
                   

                    
                }
                
             
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

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        // количество постов = количество items в  ResponseNews
      
        return self.newsresp?.response.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        // количество строк в секции зависит от входящих данных
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
       
    cell.textLabel?.text = "IndexPath \(indexPath.row)"
    return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomHeaderView") as! CustomerHeaderView
        headerView.backgroundColor = .blue
        if let news = newsresp {
            
            headerView.fioText.text = dict[-news.response.items[section].source_id]
            headerView.dateText.text = news.response.items[section].dateString
           
          //  headerView.fioText.text = getFio(id: news.response.items[section].source_id, news: news)
            
            //getFioByIDFromProfiles(id: news.response.items[section].source_id, from: news)
        }
      
    return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "CustomerFooterView") as! CustomerFooterView
        
        if let news = newsresp {
            footerView.likesCount.text = String(news.response.items[section].likes_count)
        }
        
    return footerView
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 10
    }
    
}
