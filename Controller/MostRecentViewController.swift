//
//  MostRecentViewController.swift
//  Newsaty
//
//  Created by Andrew Maher on 9/22/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import UIKit

class MostRecentViewController: UIViewController, RequestHandler {
    let articleService: ArticleService
    var articles = [Article]()
    
    @IBOutlet var newsCollectionView: UICollectionView!
    
    required init?(coder aDecoder: NSCoder) {
        articleService = ArticleService()
        super.init(coder: aDecoder)
    }
    
    func requestSuccessed(data: Any) {
        if let data = data as? [Article]{
            articles = data
            
            DispatchQueue.main.async {
                self.newsCollectionView.reloadData()
            }
//            newsCollectionView.performSelector(onMainThread: #selector(UICollectionView.reloadData), with: nil, waitUntilDone: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustCellSize()
        performSelector(inBackground: #selector(getAllArticles), with: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Newsaty"
    }
    
    @objc private func getAllArticles(){
        articleService.getAllArticles(rh: self)
    }
    
    private func adjustCellSize(){
        let width = (view.frame.size.width - 10) / 2
        let layout = newsCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Details"{
            let controller = segue.destination as! DetailsViewController
            if let indexPath = newsCollectionView.indexPath(for: sender as! UICollectionViewCell){
                controller.article = articles[indexPath.item]
            }
        }
    }
}

extension MostRecentViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCollectionViewCell
        cell.imageUrl = articles[indexPath.item].urlToImage
        cell.titleN = articles[indexPath.item].title
        return cell
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

