//
//  ScenicDataModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/14.
//

import Foundation
import SwiftUI

struct ScenicDataModel: Codable, Identifiable {
    
    var id = UUID()
    var name:String?
    var address:String?
    var adname:String?
    var business:Bussiness?
    var photos:[Photo]?
    
    
    /// 自定义字段属性 需要遵守Codingkey  2.每个字段都要枚举
    enum CodingKeys: String, CodingKey {
        case name
        case address
        case adname
        case business
        case photos
    }
    
    
}

struct Bussiness: Codable{
    var tel:String?
    var keytag:String?
    var rating:String?

    
    enum CodingKeys: String, CodingKey {
        case tel
        case keytag
        case rating
    }
}

struct Photo: Codable{
    var title:String?
    var url:String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case url
    }
}

struct ButtonViewData:Identifiable{
    var id = UUID()
    var imageName:String = "bolt.car"
    var textString:String = "加油站"
    
    static var SymbolData = [ButtonViewData(imageName:"bolt.car",textString: "加油站"),
                             ButtonViewData(imageName:"house",textString: "酒店"),
                             ButtonViewData(imageName:"cart",textString: "购物"),
                             ButtonViewData(imageName:"leaf.fill",textString: "景区"),
                             ButtonViewData(imageName:"cross.fill",textString: "医院"),
                             ButtonViewData(imageName:"yensign.circle.fill",textString: "银行"),
                             
    ]
}

