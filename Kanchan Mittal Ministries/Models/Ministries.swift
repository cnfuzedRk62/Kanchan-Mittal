//
//  Ministries.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 20/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import Foundation
import ObjectMapper
class MinistriesModel: Mappable {
    var content: String?
    var image : String?
    var image_path : String?
    var name : String?
    var slug : String?
    var status : String?
    var id : Int?
    
    required init?(map: Map) {
             mapping(map: map)
      }
      
      open func mapping(map: Map) {
          content  <- map["content"]
          image  <- map["image"]
          image_path <- map["image_path"]
          name <- map["name"]
          slug <- map["slug"]
          status  <- map["status"]
          id    <- map["id"]
      }
}
class GalleryModel: Mappable {
    var content: String?
    var image_name : String?
    var image_path : String?
    var name : String?
    var slug : String?
    var status : String?
    var id : Int?
    
    required init?(map: Map) {
             mapping(map: map)
      }
      
      open func mapping(map: Map) {
          content  <- map["content"]
          image_name  <- map["image_name"]
          image_path <- map["image_path"]
          name <- map["name"]
          slug <- map["slug"]
          status  <- map["status"]
          id    <- map["id"]
      }
}
