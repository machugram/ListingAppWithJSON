//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Rexford Machu on 5/27/20.
//  Copyright © 2020 MachuDigital. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailText: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var publisherLabel: UILabel!
    var article: Article?
    override func viewDidLoad() {
        super.viewDidLoad()
    let urlKey = article?.image
    detailText.text = article?.text
    navItem.title = setNavTitle(title: article!.title)
    navItem.titleView?.sizeToFit()
    TitleLabel.text = article?.title
    publisherLabel.text = article?.publisher
    if let url = URL(string: urlKey!){
            do {
               let data =  try Data(contentsOf: url)
                self.ImageView.image = UIImage(data: data)
            } catch let error {
                print("error",error)
            }
        }
            }
        
    
    func setNavTitle(title: String) -> String
    {
        //get the first 25 characters of your title, change the number to your need
        let first25 = title.substring(to: title.index(title.startIndex, offsetBy: 25))
        //concatenate the strings
        let title = first25 + " ... "
        return title
    }
        
        // Do any additional setup after loading the view.
    }
