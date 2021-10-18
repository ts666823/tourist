//
//  WeatherData.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/10.
//

import Foundation


/// 出游建议
struct GuideDataModel:Identifiable{
    var id = UUID()
    /// 建议名称
    var name:String?
    /// 建议内容
    var value:String?
    /// 建议详细内容
    var detail:String?
    
    static var SymbolData = [GuideDataModel(name: "暂无", value: "暂无", detail: "暂无")
    ]
}

/// 当日天气数据
struct TodayWeatherDataModel{
    /// 日期，格式为10日星期天
    var day: String?
    /// 最低气温
    var minTemp: String?
    /// 最高气温
    var maxTemp: String?
    /// 现在温度
    var currentTemp: String?
    /// 白天天气情况，
    /// 晴, 阴, 多云, 雷阵雨, 小雨, 中雨, 阵雨, 大雨, 扬沙, 小到中雨, 大到暴雨, 沙尘暴, 浮尘, 雨夹雪, 中雪, 暴雨, 中到大雨
    var dayType:String?
    /// 晚上天气情况，
    /// 晴, 阴, 多云, 雷阵雨, 小雨, 中雨, 阵雨, 大雨, 扬沙, 小到中雨, 大到暴雨, 沙尘暴, 浮尘, 雨夹雪, 中雪, 暴雨, 中到大雨
    var nightType:String?
    /// 数据更新时间
    var updateTime:String?
    /// 日出时间
    var sunriseTime:String?
    /// 日落时间
    var sunsetTime:String?
    
}


/// 天气数据
struct WeatherDataModel: Hashable, Identifiable {
    var id: Int
    /// 日期，格式为10日星期天
    var day: String?
    /// 最低气温
    var minTemp: String?
    /// 最高气温
    var maxTemp: String?
    /// 白天天气情况，
    /// 晴, 阴, 多云, 雷阵雨, 小雨, 中雨, 阵雨, 大雨, 扬沙, 小到中雨, 大到暴雨, 沙尘暴, 浮尘, 雨夹雪, 中雪, 暴雨, 中到大雨
    var dayType:String?
    /// 晚上天气情况，
    /// 晴, 阴, 多云, 雷阵雨, 小雨, 中雨, 阵雨, 大雨, 扬沙, 小到中雨, 大到暴雨, 沙尘暴, 浮尘, 雨夹雪, 中雪, 暴雨, 中到大雨
    var nightType:String?
    
    static var SymbolData = [WeatherDataModel(id: 0, day: "暂无", minTemp: "暂无", maxTemp: "暂无", dayType: "暂无", nightType: "暂无")
    ]
}

struct WeatherResource{
    var guides:[GuideDataModel]?
    var weatherData:[WeatherDataModel]?
    var today:TodayWeatherDataModel?
}

