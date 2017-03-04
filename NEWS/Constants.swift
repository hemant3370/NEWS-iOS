//
//  Constants.swift
//  NEWS
//
//  Created by Hemant Singh on 04/03/17.
//  Copyright © 2017 Hatchitup Inc. All rights reserved.
//

import UIKit
import SwiftyJSON

class Constants: NSObject {
    struct UDKeys {
       static let sourcesKey = "NewsSources"
    }
    static let apiKey = "7ad5d64e5f5143a4b95754fa64f15b15"
    static func isPad() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func isPhone() -> Bool {
        
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}
class languageQuery: NSObject, NSCoding{
    
    var language : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(lang: String){
        if lang.isEmpty{
            return
        }
        language = lang
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if language != nil{
            dictionary["language"] = language
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        language = aDecoder.decodeObject(forKey: "language") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if language != nil{
            aCoder.encode(language, forKey: "language")
        }
        
    }
    
}

class articlesQuery : NSObject, NSCoding{
    
    var apiKey : String!
    var source : String!
    
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(src: String){
        if src.isEmpty{
            return
        }
        apiKey = Constants.apiKey
        source = src
    }
    
    /**
     * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> NSDictionary
    {
        let dictionary = NSMutableDictionary()
        if apiKey != nil{
            dictionary["apiKey"] = apiKey
        }
        if source != nil{
            dictionary["source"] = source
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        apiKey = aDecoder.decodeObject(forKey: "apiKey") as? String
        source = aDecoder.decodeObject(forKey: "source") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if apiKey != nil{
            aCoder.encode(apiKey, forKey: "apiKey")
        }
        if source != nil{
            aCoder.encode(source, forKey: "source")
        }
        
    }
    
}
