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
        detailText.text = article?.text
        navItem.title = article?.title
        navItem.titleView?.sizeToFit()
        TitleLabel.text = article?.title
        publisherLabel.text = article?.publisher
        let urlKey = article?.image
        if let url = URL(string: urlKey!){
            do {
               let data =  try Data(contentsOf: url)
                self.ImageView.image = UIImage(data: data)
                //print(data)
            } catch let error {
                print("error",error)
            }
        }
        
                //Image View is  done
        //Wanting to make UILabelclickable for link url
            }
        
        
        
        // Do any additional setup after loading the view.
    }
