//
//  Sources.swift
//  NEWS
//
//  Created by Hemant Singh on 04/03/17.
//  Copyright © 2017 Hatchitup Inc. All rights reserved.
//

import UIKit
import  SwiftyJSON
import Alamofire

class Sources: NSObject, NSCoding{
    
    var sources : [Source]!
    var status : String!
    
    class func getSources(lang: String, completion: @escaping (Sources) -> Swift.Void){
        Alamofire.request(Router.Sources(languageQuery.init(lang: lang).toDictionary() as! [String : AnyObject])).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                completion(Sources.init(fromJson: json))
            case .failure(let error):
                print(error)
                completion(Sources())
            }
        }
    }
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    override init() {
        super.init()
        sources = []
        status = "empty"
    }
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        sources = [Source]()
        let sourcesArray = json["sources"].arrayValue
        for sourcesJson in sourcesArray{
            let value = Source(fromJson: sourcesJson)
            sources.append(value)
        }
        status = json["status"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if sources != nil{
            var dictionaryElements = [NSDictionary]()
            for sourcesElement in sources {
                dictionaryElements.append(sourcesElement.toDictionary())
            }
            dictionary["sources"] = dictionaryElements
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
        sources = aDecoder.decodeObject(forKey: "sources") as? [Source]
        status = aDecoder.decodeObject(forKey: "status") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if sources != nil{
            aCoder.encode(sources, forKey: "sources")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        
    }
    
}
class Source : NSObject, NSCoding{
    
    var category : String!
    var country : String!
    var descriptionField : String!
    var id : String!
    var language : String!
    var name : String!
    var sortBysAvailable : [String]!
    var url : String!
    var urlsToLogos : UrlsToLogo!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        category = json["category"].stringValue
        country = json["country"].stringValue
        descriptionField = json["description"].stringValue
        id = json["id"].stringValue
        language = json["language"].stringValue
        name = json["name"].stringValue
        sortBysAvailable = [String]()
        let sortBysAvailableArray = json["sortBysAvailable"].arrayValue
        for sortBysAvailableJson in sortBysAvailableArray{
            sortBysAvailable.append(sortBysAvailableJson.stringValue)
        }
        url = json["url"].stringValue
        let urlsToLogosJson = json["urlsToLogos"]
        if !urlsToLogosJson.isEmpty{
            urlsToLogos = UrlsToLogo(fromJson: urlsToLogosJson)
        }
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if category != nil{
            dictionary["category"] = category
        }
        if country != nil{
            dictionary["country"] = country
        }
        if descriptionField != nil{
            dictionary["description"] = descriptionField
        }
        if id != nil{
            dictionary["id"] = id
        }
        if language != nil{
            dictionary["language"] = language
        }
        if name != nil{
            dictionary["name"] = name
        }
        if sortBysAvailable != nil{
            dictionary["sortBysAvailable"] = sortBysAvailable
        }
        if url != nil{
            dictionary["url"] = url
        }
        if urlsToLogos != nil{
            dictionary["urlsToLogos"] = urlsToLogos.toDictionary()
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        category = aDecoder.decodeObject(forKey: "category") as? String
        country = aDecoder.decodeObject(forKey: "country") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        language = aDecoder.decodeObject(forKey: "language") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        sortBysAvailable = aDecoder.decodeObject(forKey: "sortBysAvailable") as? [String]
        url = aDecoder.decodeObject(forKey: "url") as? String
        urlsToLogos = aDecoder.decodeObject(forKey: "urlsToLogos") as? UrlsToLogo
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if language != nil{
            aCoder.encode(language, forKey: "language")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if sortBysAvailable != nil{
            aCoder.encode(sortBysAvailable, forKey: "sortBysAvailable")
        }
        if url != nil{
            aCoder.encode(url, forKey: "url")
        }
        if urlsToLogos != nil{
            aCoder.encode(urlsToLogos, forKey: "urlsToLogos")
        }
        
    }
    
}
class UrlsToLogo : NSObject, NSCoding{
    
    var large : String!
    var medium : String!
    var small : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        large = json["large"].stringValue
        medium = json["medium"].stringValue
        small = json["small"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if large != nil{
            dictionary["large"] = large
        }
        if medium != nil{
            dictionary["medium"] = medium
        }
        if small != nil{
            dictionary["small"] = small
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        large = aDecoder.decodeObject(forKey: "large") as? String
        medium = aDecoder.decodeObject(forKey: "medium") as? String
        small = aDecoder.decodeObject(forKey: "small") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if large != nil{
            aCoder.encode(large, forKey: "large")
        }
        if medium != nil{
            aCoder.encode(medium, forKey: "medium")
        }
        if small != nil{
            aCoder.encode(small, forKey: "small")
}

}
}
