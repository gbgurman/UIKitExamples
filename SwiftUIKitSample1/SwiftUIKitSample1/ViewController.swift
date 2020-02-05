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
    var count : Int!
    
    //var news = [News]()
    var items = [News]()


    @IBOutlet weak var myTableView: UITableView!
      @IBOutlet weak var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //https://jsonplaceholder.typicode.com/todos
        let url = URL(string: "https://newsapi.egcorp.net/all")
        URLSession.shared.dataTask(with: url!){(data, response, error) in
            if error==nil{
                do{
                self.items = try JSONDecoder().decode([News].self, from: data!)
                }catch{
                    print("Parse error")
                }
                DispatchQueue.main.async {
                    //reload items in the table cells which are empty at this moment
                    self.myTableView.reloadData()
                    
                    
                    //write to console
                    print(self.items.count)
                    
                    //create alert dialog
                    //preferredStyle can be alert or action sheet
                    //alert is the typical alert dialog
                    //action sheet is the vertically stacked options in the bottom
                    //if you have more than 3 buttons it is better to user an action sheet
                    let alert = UIAlertController(
                        title: "Download complete",
                        message: "Downloaded: " + String(self.items.count) + " items.",
                        preferredStyle: .alert /* .actionSheet */)
                    
                    //OK button
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                        //this is a closure, like a callback
                        //this code will execute when this action is fired
                        NSLog("OK clicked.")
                    }))
                    
                    //Cancel button
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Cancel action"), style: .cancel, handler: {
                        //this block is executed when cancel action is fired
                        _ in NSLog("Cancel clicked")
                    }))
                    
                    //show another alert conditionally
                    if(self.items.count == 0){
                        let al = UIAlertController(title:"No items !",
                        message: "No items downloaded",
                        preferredStyle: .alert)
                        al.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(al, animated: false, completion: nil)
                    }else{
                        //show alert by calling present
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                    
                    
                }
                
            }
        }.resume()
        
        myTableView.dataSource=self
        myTableView.delegate=self
        
        label.text = "Items: "
        count=0
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //The identifier is the id of the cell component
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")
            as? MyTableViewCell else {
                return UITableViewCell()
        }
        //cell?.textLabel?.text = items[indexPath.row].title
        let item = items[indexPath.row]
        cell.lblTitle.text = item.title
        cell.lblDescription.text = item.description
        //cell?.imageView?.image.lo
        return cell
    }
    
    //This will be executed whenever a cell is clicked
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        print(item.title + " clicked")
        let alert = UIAlertController(title: item.title, message: item.description,
                                     preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            // change cell color to indicate user has read this item
            var cell = tableView.cellForRow(at: indexPath)
            //
        }))
        self.present(alert, animated: true)
    }

  
    @IBAction func btnPressed(_ sender: Any) {
        print("Button pressed!")
        count = count+1
        label.text = "Button pressed " + String(count) + " times"
            
    }
    
}

//https://app.quicktype.io
struct Todo: Decodable {
    var userID, id: Int
    var title: String
    var completed: Bool
}

struct News: Decodable{
    var _id:String
    var title: String
    var description: String
}

