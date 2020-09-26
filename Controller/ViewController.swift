//
//  ViewController.swift
//  Newsaty
//
//  Created by Andrew Maher on 9/12/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import UIKit
class ViewController: UITableViewController, RequestHandler {
    let articleService: ArticleService
    var articles = [Article]()
    @IBOutlet var myIndicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        articleService = ArticleService()
        super.init(coder: aDecoder)
    }
    
    func requestSuccessed(data: Any) {
        if let data = data as? [Article]{
            articles = data
            DispatchQueue.main.async {
                //self.myIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 600
        articleService.getAllArticles(rh: self)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Newsaty"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details"{
            let controller = segue.destination as! DetailsViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.article = articles[indexPath.row]
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Article", for: indexPath)
        if let urlImage = articles[indexPath.row].urlToImage{
            let image = cell.viewWithTag(1000) as? UIImageView
            image?.load(url: URL(string: urlImage)!)
        }
        let titleText = cell.viewWithTag(1001) as? UILabel
        titleText?.text  = articles[indexPath.row].title!
        titleText?.sizeToFit()
        let descText = cell.viewWithTag(1002) as? UILabel
        descText?.text = articles[indexPath.row].description ?? "more..."
        return cell
    }
}


