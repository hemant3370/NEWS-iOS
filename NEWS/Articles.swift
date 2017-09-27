//
//  Articles.swift
//  NEWS
//
//  Created by Hemant Singh on 04/03/17.
//  Copyright © 2017 Hatchitup Inc. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
class Articles: NSObject, NSCoding{
    
    var articles : [Article]!
    var sortBy : String!
    var source : String!
    var status : String!
    
    
   class func getArticles(sourceID: String, completion: @escaping (Articles) -> Swift.Void){
        Alamofire.request(Router.GetNews(articlesQuery.init(src: sourceID).toDictionary() as! [String : AnyObject])).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                completion(Articles.init(fromJson: json))
            case .failure(let error):
                print(error)
                completion(Articles.init(src: sourceID))
                
            }
        }
    }
     init(src: String) {
        super.init()
        articles = []
        status = "empty"
        source = src
    }
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        articles = [Article]()
        let articlesArray = json["articles"].arrayValue
        for articlesJson in articlesArray{
            let value = Article(fromJson: articlesJson)
            articles.append(value)
        }
        sortBy = json["sortBy"].stringValue
        source = json["source"].stringValue
        status = json["status"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if articles != nil{
            var dictionaryElements = [NSDictionary]()
            for articlesElement in articles {
                dictionaryElements.append(articlesElement.toDictionary())
            }
            dictionary["articles"] = dictionaryElements
        }
        if sortBy != nil{
            dictionary["sortBy"] = sortBy
        }
        if source != nil{
            dictionary["source"] = source
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        articles = aDecoder.decodeObject(forKey: "articles") as? [Article]
        sortBy = aDecoder.decodeObject(forKey: "sortBy") as? String
        source = aDecoder.decodeObject(forKey: "source") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if articles != nil{
            aCoder.encode(articles, forKey: "articles")
        }
        if sortBy != nil{
            aCoder.encode(sortBy, forKey: "sortBy")
        }
        if source != nil{
            aCoder.encode(source, forKey: "source")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        
    }
    
}
class Article : NSObject, NSCoding{
    
    var author : String!
    var descriptionField : String!
    var publishedAt : String!
    var title : String!
    var url : String!
    var urlToImage : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        author = json["author"].stringValue
        descriptionField = json["description"].stringValue
        publishedAt = json["publishedAt"].stringValue
        title = json["title"].stringValue
        url = json["url"].stringValue
        urlToImage = json["urlToImage"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if author != nil{
            dictionary["author"] = author
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if publishedAt != nil{
            dictionary["publishedAt"] = publishedAt
        }
        if title != nil{
            dictionary["title"] = title
        }
        if url != nil{
            dictionary["url"] = url
        }
        if urlToImage != nil{
            dictionary["urlToImage"] = urlToImage
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        author = aDecoder.decodeObject(forKey: "author") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        publishedAt = aDecoder.decodeObject(forKey: "publishedAt") as? String
        title = aDecoder.decodeObject(forKey: "title") as? String
        url = aDecoder.decodeObject(forKey: "url") as? String
        urlToImage = aDecoder.decodeObject(forKey: "urlToImage") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if author != nil{
            aCoder.encode(author, forKey: "author")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if publishedAt != nil{
            aCoder.encode(publishedAt, forKey: "publishedAt")
        }
        if title != nil{
            aCoder.encode(title, forKey: "title")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        if urlToImage != nil{
            aCoder.encode(urlToImage, forKey: "urlToImage")
        }
        
    }
    
}
