//
//  NewsModel.swift
//  VinidNews
//
//  Created by Apple on 11/27/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class NewsModel{
    
    
    public let thumnail:String!
    public let subtitle:String!
    public let pubdate:String
    
    public let title:String
    public let url:String
    
    
    init(thumnail:String,subtitle:String,pubdate:String,title:String,url:String) {
        
        self.thumnail = thumnail
        self.subtitle = subtitle
        self.pubdate = pubdate
        self.title = title
        self.url = url
    }
    
   
    
    
   
    
}
