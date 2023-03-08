//
//  LoginViewController.swift
//  part2lesson1
//
//  Created by Артем Солохин on 15.01.2023.
//

import UIKit
import WebKit
import Alamofire



class LoginViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let thread = ThreadPrintPalm()
//        thread.start()
//        sleep(1)
//        thread.cancel()
        
        getWeather()
        
        webView.navigationDelegate = self
        
        var urlComponent = URLComponents()
        
        urlComponent.scheme = "https"
        urlComponent.host = "oauth.vk.com"
        urlComponent.path = "/authorize"
        
        urlComponent.queryItems = [
        URLQueryItem(name: "client_id", value: "51526580"),
        URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "scope", value: "wall,friends")
        ]

        let request = URLRequest(url: urlComponent.url!)
        
        webView.load(request)
        
        // Do any additional setup after loading the view.
    }
    


}



func getWeather() {    let url = "http://lr-system.pro/rss/sbapi.php?q=valid"
//    AF.request(url,method: .get).responseJSON { resp in
//       // print(resp)
//        if let data = resp.data {
//            let json = try! JSONDecoder().decode(WeatherRoot.self, from: data)
//            print(json)
//        }
  
    AF.request(url,method: .get).responseDecodable(of: WeatherRoot.self) { resp in
        print(resp)
       }
    
    }




extension LoginViewController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse) async -> WKNavigationResponsePolicy {
    
        guard let url = navigationResponse.response.url, url.path == "/blank.html",
              let fragment = url.fragment
        else {return .allow}
        
        let params = fragment.components(separatedBy: "&")
            .map{$0.components(separatedBy: "=")}
            .reduce([String: String]()) { res, params in
                var dict = res
                let key = params[0]
                let value = params[1]
                
                dict[key] = value
                return dict
            }
        
        let token = params["access_token"]
        Session.sharedInstance.token = token!
        Session.sharedInstance.userId = "51526580"
        
        performSegue(withIdentifier: "openMainTabBarFromLogin", sender: nil)
        
        return .allow
    }
    
}
