//
//  ViewController.swift
//  SwiftUIKitSample1
//
//  Created by trin on 2.02.2020.
//  Copyright © 2020 Pink Hat Apps. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let titles = ["Lorem ipsum dolore sit 1",
                  "Lorem ipsum dolore sit 2",
                  "Lorem ipsum dolore sit 3",
                  "Lorem ipsum dolore sit 4",
                  "Lorem ipsum dolore sit 5",
                  "Lorem ipsum dolore sit 6",
                  "Lorem ipsum dolore sit 7",
                  "Lorem ipsum dolore sit 8",
                  "Lorem ipsum dolore sit 9",
                  "Lorem ipsum dolore sit 10"
    ]
    var news = [News]()


    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = URL(string: "https://newsapi.egcorp.net/all")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error==nil{
                do{
                self.news = try JSONDecoder().decode([News].self, from: data!)
                }catch{
                    print("Parse error")
                }
                DispatchQueue.main.async {
                    print(self.news.count)
                }
            }
        }.resume()
        
        myTableView.dataSource=self
        myTableView.delegate=self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = news[indexPath.row].title
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(titles[indexPath.row] + " clicked")
    }


}

struct News:  Decodable{
    var _id:String
    var title: String
    var description: String
}

