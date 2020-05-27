//
//  ViewController.swift
//  NewsApp
//
//  Created by Rexford Machu on 5/24/20.
//  Copyright © 2020 MachuDigital. All rights reserved.
//

import UIKit

//UI
//Network Request
//Tap a cell to view info/ details of cell
//Custom cell.
class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return  3
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
     //cell.configure(with: news[indexPath.row])
        return cell
    }
    
    
    
    @IBOutlet weak var tableView :UITableView!
    @IBOutlet weak var label : UILabel!
    var news =  [Article]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsResult()
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
// Field
    
    func getNewsResult(){
    
    let url = URL(string: "https://learnappmaking.com/ex/news/articles/Apple?secret=CHWGk3OTwgObtQxGqdLvVhwji6FsYm95oe87o3ju")!
    let session = URLSession.shared
        session.dataTask(with: url, completionHandler:{data, response, error in
            //validation
            guard let data = data , error == nil
                else {
                    print("Something went wrong")
                    return
            }
            var json: News?
            do {
                let fetchedData = try JSONSerialization.jsonObject(with: data, options:.mutableContainers)
                //if let count = fetchedData["count"] as? Int{print(count)}
                print("decoded:",fetchedData)
    
                
            }
            catch {
                print("error: \(error)")
            }
            guard let result = json else{
                return
            }
            
            //Update user interface
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }).resume()
//
    }
    
    
    
    
    }
    
    
    //Table
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show news details
    }
    

struct News : Codable{
    let count: Int
    let urls: url
    let articles: Article
}
struct url : Codable{
    let next: String
    let prev: String
    let `self`: String
}

struct Article : Codable{
let id : String
let url : String
var title: String
var text: String
var publisher: String
var author: String
var image : String
var date: String
}



