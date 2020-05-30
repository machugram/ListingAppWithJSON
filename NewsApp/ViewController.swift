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
    return  news.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.configure(with: news[indexPath.row])
        return cell
    }
    
    @IBOutlet weak var tableView :UITableView!
    var news =  [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsResult()
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
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
            do {
                let fetchedData = try JSONDecoder().decode(News.self, from: data)
                self.news = fetchedData.articles
                let newsArray = fetchedData.articles
            }
            catch {
               print("error: \(error)")
            }

            //Update user interface
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            }).resume()
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
        let article = news[indexPath.row]   //Show news details
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        destination?.article = news[tableView.indexPathForSelectedRow!.row]
    }

    
    }
    


struct News : Codable{
    let count: Int
    let urls: url
    let articles: [Article]
    
    init(count: Int, urls: url, articles:[Article]) {
        self.count =  count
        self.urls = urls
        self.articles = articles
    }
}
struct url : Codable{
    let next: String
    let prev: String
    let _self: String
    
    private enum CodingKeys: String, CodingKey {
        case next, prev,_self = "self"
  }
    
    init(next: String, prev: String, _self:String) {
        self.next =  next
        self.prev = prev
        self._self = _self
    }
}

struct Article : Codable{
let id : String
let url : String
let title: String
let text: String
let publisher: String
let author: String
let image : String
let date: String
    
    init( id : String, url : String, title: String,text: String, publisher: String, author: String,image : String,
date: String) {
        self.author = author
        self.id = id
        self.url = url
        self.title = title
        self.text = text
        self.publisher = publisher
        self.image = image
        self.date = date
    }
}






