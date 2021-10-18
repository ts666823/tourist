//
//  HistoryTodayDataModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/17.
//

import Foundation

struct HistoryTodayDataModel: Codable, Hashable, Identifiable {
    var id = UUID()
    let title: String?
    let year: String?
    let month: String?
    let day: String?
    let img:String?
    
    var isChoice: Bool = false
    
    /// 自定义字段属性 需要遵守Codingkey
    enum CodingKeys: String, CodingKey {
        case title
        case year
        case month
        case day
        case img
    }
    
    func processDate(year:String,month:String,day:String)->String{
        return year+"年"+month+"月"+day+"日"
    }
}

struct HistoryTodayResponse: Codable {
    let code: Int
    let data: [HistoryTodayDataModel]
    let msg: String

    enum CodingKeys: String, CodingKey {
        case code
        case data
        case msg
    }
}
