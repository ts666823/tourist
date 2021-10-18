//
//  AddressModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/13.
//

import Foundation
import Combine


///解析City
struct CityDataModel: Codable, Hashable, Identifiable {
    var id = UUID()
    let cityId: String?
    let name: String?
    let parentId: String?
    let parentName: String?
    
    var isChoice: Bool = false
    
    /// 自定义字段属性 需要遵守Codingkey  2.每个字段都要枚举
    enum CodingKeys: String, CodingKey {
        case cityId = "id"
        case name
        case parentId
        case parentName
    }
}

struct CityResponse: Codable {
    let code: Int
    let data: [CityDataModel]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case code
        case data
        case msg
    }
}
