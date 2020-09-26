//
//  NewsCollectionViewCell.swift
//  Newsaty
//
//  Created by Andrew Maher on 9/22/20.
//  Copyright © 2020 Andrew Maher. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleNews: UILabel!
    
    var imageUrl: String?{
        didSet{
            if let imageUrl = imageUrl{
                if let url = URL(string: imageUrl)
                {imageView.load(url: url)}
            }
        }
    }
    var titleN:String?{
        didSet{
            if let titleN = titleN{
                titleNews.text = titleN
            }
        }
    }
}

