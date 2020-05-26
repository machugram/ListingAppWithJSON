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
class ViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource,UITableViewDelegate {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 //news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
//        cell.configure(with: news[indexPath.row])
        return cell
    }
    
    
    @IBOutlet weak var tableView :UITableView!
    @IBOutlet weak var field : UITextField!
    let news =  [News]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        field.delegate = self

    }
    
// Field
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchNews()
        return true
    }
    
    func searchNews(){
        field.resignFirstResponder()
        guard let text = field.text, !text.isEmpty else {
            return
        }
        
URLSession.shared.dataTask(with: URL(string: "https://learnappmaking.com/ex/news/articles/Apple?secret=CHWGk3OTwgObtQxGqdLvVhwji6FsYm95oe87o3ju")!,
    completionHandler: {data, response, error in
        guard let data = data, error == nil
            else{
                return
        }
                    //COnvert
        
        do{
            result = try JSONDecoder().decode(news.self, from: data)
        }
        catch{
            print("error")
        }
        
        guard let finalResult = result else{return}
        let news = finalResult.Search
            }).resume()
        }
    }
    
    
    //Table
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //Show news details
    }
    
struct Search : Codable{
    let articles:[News]
}


struct News : Codable{
    let id : String
    let url : String
    var title: String
    var text: String
    var publisher: String
    var author: String
    var image : String
    var date: String
}
