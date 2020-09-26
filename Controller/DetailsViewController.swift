//
//  DetailsViewController.swift
//  Newsaty
//
//  Created by Andrew Maher on 9/13/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var publishedAt: UILabel!
    @IBOutlet var desc: UITextView!
    @IBOutlet var articleContent: UITextView!
    
    var article: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never

        if let article = article{
            title = article.title
            image.load(url: URL(string: article.urlToImage!)!)
            date.text = "Date: " + (article.publishedAt?.description ?? "Soon...")
            publishedAt.text = "Author: " + (article.author ?? "Unkown")
            desc.text = article.description ?? "More..."
            desc.sizeToFit()
            articleContent.text = article.content ?? "No information available now"
            articleContent.sizeToFit()
        }
    }
}
