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
        //cell.newsTitleLabel?.text = news[indexPath.row].title//idArray[indexPath.row]
        //cell.newsPublisherLabel?.text = news[indexPath.row].publisher//idArray[indexPath.row]

        return cell
    }
    
    
    
    
    @IBOutlet weak var tableView :UITableView!
    var news =  [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        getNewsResult()
        tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        //parse()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
// Field
    
     //This funstion was used for the local json file
//    func parse (){
//
//        let url = Bundle.main.url(forResource: "data", withExtension: "json")
//        if let url = url {
//
//            let data = try? Data(contentsOf: url)
//            do {
//                guard let data = data
//                    else{return}
//                let news = try JSONDecoder().decode(News.self, from: data)
//                self.news = news.articles
//                //print("news:",news)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//                let newsArray = news.articles
//                //print("newsArray:",newsArray)
//            } catch let error {
//                print(error)
//            }
//        }
//
//
//    }
    
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
            //var json: News?
            do {
                let fetchedData = try JSONDecoder().decode(News.self, from: data)
                self.news = fetchedData.articles
                //if let count = fetchedData["count"] as? Int{print(count)}
               // print("decoded:",fetchedData)
                let newsArray = fetchedData.articles
                //print(newsArray)
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
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showDetails", sender: self)
        //Show news details
        let article = news[indexPath.row]
        //print(article)
     //let vc = storyboard?.instantiateViewController(withIdentifier: "DetailView") as? DetailViewController
       // self.navigationController?.pushViewController(vc!, animated: true)

//        vc?.detailViewController()
//        present(vc!, animated: true)
        //print("Cell row selected")
        
//
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        destination?.article = news[tableView.indexPathForSelectedRow!.row]
    }

    
    
    
    }
    
    
    //Table
    
    
    
    

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






