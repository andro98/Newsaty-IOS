//
//  ArticleService.swift
//  Newsaty
//
//  Created by Andrew Maher on 9/12/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import Foundation

protocol RequestHandler{
    func requestSuccessed(data: Any)
}


class ArticleService{
    func getAllArticles(rh: RequestHandler){
        let session = URLSession.shared
        let url = createUrl()
        let task = session.dataTask(with: url) {
            (data, response, error) in
            
            if error != nil || data == nil {
                print("Client error! \(error.debugDescription)")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            do {
                if let data = data{
                    var articles = [Article]()
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject]
                    //print(json)
                    let articlesFromJson = json["articles"] as! [[String: AnyObject]]
                    for articleFromJson in articlesFromJson{
                        let author:String? = articleFromJson["author"] as? String
                        let title:String? = articleFromJson["title"] as? String
                        let description:String? = articleFromJson["description"] as? String
                        let urlToImage:String? = articleFromJson["urlToImage"]as? String
                        let publishedAt:Date? = articleFromJson["publishedAt"]as? Date
                        let content:String? = articleFromJson["content"]as? String
                        let article = Article(author: author, title: title, articleDescription: description, urlToImage: urlToImage, publishedAt: publishedAt, content: content)
                        articles.append(article)
                        
                    }
                    rh.requestSuccessed(data: articles)
                }
            }catch{
                
            }

        }
        task.resume()
    }
    
    private func createUrl()-> URL {
        let queryItems = [URLQueryItem(name: "country", value: "us"), URLQueryItem(name: "apiKey", value: "2e4e38c75219400488421f12215f43b6")]
        var urlComps = URLComponents(string: "https://newsapi.org/v2/top-headlines")!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
}
