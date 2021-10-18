
//
//  CookBookDataModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/16.
//

import Foundation

class CookBookDataModel:Codable,Identifiable{
    var id = UUID()
    var cpName:String?
    var largeImg:String?
    var smallImg:String?
    var tip:String?
    var type_v3:String?
    var yl:[Yl]?
    var steps:[Step]?
    var des:String?
    
    enum CodingKeys: String, CodingKey {
        case cpName
        case largeImg
        case smallImg
        case tip
        case type_v3
        case des
        case steps
        case yl
    }
    
    func processYL(yls:[Yl])->String{
        var origin:[String] = []
        var str = ""
        for yl in yls {
            str = (yl.ylName ?? "暂无名称") + "（" + (yl.ylUnit ?? "暂无用量") + "）"
            origin.append(str)
        }
        let result = origin.lazy.joined(separator: ",")
        print(result)
        return result
    }
    
}

class Yl:Codable,Identifiable
{

    var id = UUID()
    var ylName:String?
    var ylUnit:String?
    
    enum CodingKeys: String, CodingKey {
        case ylName
        case ylUnit
    }
}

class Step:Codable,Identifiable
{
    var id = UUID()
    var orderNum:Int?
    var content:String?
    
    enum CodingKeys: String, CodingKey {
        case orderNum
        case content
    }
}
