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
    func readWholeStory(sender: UIBarButtonItem) {
                let article = articles.articles[sender.tag]
                let svc = SFSafariViewController(url: URL(string: article.url)! , entersReaderIfAvailable: true)
                self.present(svc, animated: true, completion: nil)
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
        collectionView.deselectItem(at: indexPath, animated: false)

        let vc = UIViewController()
        let contentView = (collectionView.cellForItem(at: indexPath)?.contentView.copyView())!
        contentView.frame = CGRect(x: 30, y: 50, width: self.view.frame.width - 60, height: self.view.frame.height - 100)
        vc.view.addSubview(contentView)
        let wholeStory = UIBarButtonItem.init(title: "Full Story", style: .plain, target: self, action: #selector(DetailViewController.readWholeStory(sender:)))
        wholeStory.tag = indexPath.row
            vc.navigationItem.rightBarButtonItem = wholeStory
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if Constants.isPad() {
        let width:CGFloat = self.view.bounds.size.width*0.45;
            let height:CGFloat = self.view.bounds.size.height*0.45;
        return CGSize(width: width, height: height)
        }
        else{
            let width:CGFloat = self.view.bounds.size.width*0.9;
            let height:CGFloat = self.view.bounds.size.height*0.5;
            return CGSize(width: width, height: height)
        }
        
    }
}
class newsCell : UICollectionViewCell {
    @IBOutlet weak var newsDetailLabel: UILabel!
    @IBOutlet weak var newsIV: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
}
