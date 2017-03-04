//
//  DetailViewController.swift
//  NEWS
//
//  Created by Hemant Singh on 01/03/17.
//  Copyright © 2017 Hatchitup Inc. All rights reserved.
//

import UIKit
import SafariServices

class DetailViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    var articles : Articles!
    var newsSource : Source!
    func configureView() {
        // Update the user interface for the detail item.
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        articles = Articles.init(src: "bbc-news")
        var id = "bbc-news"
        self.title = "BBC News"
        if newsSource != nil {
            id = newsSource.id
            self.title = newsSource.name
        }
        Articles.getArticles(sourceID: id) { (news) in
            self.articles = news
            self.activityIndicator.stopAnimating()
            self.collectionView.reloadData()
        }
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //1
     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
     func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return articles.articles.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell",
                                                      for: indexPath) as! newsCell
        //2
        let article = articles.articles[indexPath.row]
        cell.backgroundColor = UIColor.white
        //3
        cell.newsIV.kf.setImage(with: URL.init(string: article.urlToImage))
        cell.newsDetailLabel.text = article.descriptionField
        cell.titleLabel.text = article.title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = articles.articles[indexPath.row]
        let svc = SFSafariViewController(url: URL(string: article.url)! , entersReaderIfAvailable: true)
        self.present(svc, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if Constants.isPad() {
        let width:CGFloat = self.view.bounds.size.width*0.3;
        let height:CGFloat = 350.0;
        return CGSize(width: width, height: height)
        }
        else{
            let width:CGFloat = self.view.bounds.size.width*0.9;
            let height:CGFloat = 350.0;
            return CGSize(width: width, height: height)
        }
    }
}
class newsCell : UICollectionViewCell {
    @IBOutlet weak var newsDetailLabel: UILabel!
    @IBOutlet weak var newsIV: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
}
