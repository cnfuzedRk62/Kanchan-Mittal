//
//  BannerImages.swift
//  Kanchan Mittal Ministries
//
//  Created by Ravinder on 12/11/19.
//  Copyright © 2019 Ravinder. All rights reserved.
//

import Foundation
import ObjectMapper
class BannerImageBanners: Mappable {
    var image_path: String?
    var image : String?
    
    required init?(map: Map) {
             mapping(map: map)
      }
      
      open func mapping(map: Map) {
          image_path  <- map["image_path"]
          image  <- map["image"]
      }
}

