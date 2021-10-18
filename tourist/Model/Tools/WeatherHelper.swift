//
//  WeatherSymbols.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/13.
//

import Foundation
import SwiftUI

/// 晴, 阴, 多云, 雷阵雨, 小雨, 中雨, 阵雨, 大雨, 扬沙, 小到中雨, 大到暴雨, 沙尘暴, 浮尘, 雨夹雪, 中雪, 暴雨, 中到大雨
///
func weather2Symbos(weatherName:String)->String{
    switch(weatherName)
    {
    case "晴" : return "sun.max"
    case "阴" : return "cloud.sun"
    case "多云" : return "cloud"
    case "雷阵雨" : return "cloud.bolt.rain"
    case "小雨" : return "cloud.sun.rain"
    case "中雨" : return "cloud.drizzle"
    case "阵雨" : return "cloud.drizzle.fill"
    case "大雨" : return "cloud.heavyrain.fill"
    case "扬沙" : return "aqi.low"
    case "小到中雨" : return "cloud.sun.rain.fill"
    case "大到暴雨" : return "cloud.rain.fill"
    case "沙尘暴" : return "aqi.high"
    case "浮尘" : return "aqi.medium"
    case "雨夹雪" : return "cloud.sleet"
    case "中雪" : return "cloud.snow"
    case "暴雨" : return "cloud.bolt.rain.fill"
    case "中到大雨" : return "cloud.heavyrain"
    default:
        return "questionmark.app"
    }
}

func guide2Symbos(guideName:String)->String{
    switch(guideName)
    {
    case "穿衣指数" : return "tshirt"
    case "紫外线强度" : return "sun.min"
    case "护肤指数" : return "face.smiling"
    case "洗车指数" : return "car"
    case "感冒指数" : return "cross.case"
    case "晾晒指数" : return "sun.max.circle"
    case "户外指数" : return "leaf"
    case "污染指数" : return "globe.asia.australia"
    case "钓鱼指数" : return "drop"
    case "中暑指数" : return "sun.max.fill"
    case "舒适度" : return "heart.text.square"
    case "赏月指数" : return "moon"
    default:
        return "questionmark.app"
    }
}

func guideFormatName(guideName:String)->String{
    switch(guideName)
    {
    case "穿衣指数" : return "穿衣指南"
    case "护肤指数" : return "护肤指南"
    case "洗车指数" : return "洗车指南"
    case "晾晒指数" : return "晾晒指南"
    case "户外指数" : return "户外指南"
    case "钓鱼指数" : return "钓鱼指南"
    case "赏月指数" : return "赏月指南"
    default:
        return guideName
    }
}

enum WeatherSymbols:String{
    case 晴 = "sum.max"
    case 阴 = "cloud.sun"
    case 多云 = "cloud"
    case 雷阵雨 = "cloud.bolt.rain"
    case 小雨 = "cloud.sun.rain"
    case 中雨 = "cloud.drizzle"
    case 阵雨 = "cloud.drizzle.fill"
    case 大雨 = "cloud.heavyrain.fill"
    case 扬沙 = "aqi.low"
    case 小到中雨 = "cloud.sun.rain.fill"
    case 大到暴雨 = "cloud.rain.fill"
    case 沙尘暴 = "aqi.high"
    case 浮尘 = "aqi.medium"
    case 雨夹雪 = "cloud.sleet"
    case 中雪 = "cloud.snow"
    case 暴雨 = "cloud.bolt.rain.fill"
    case 中到大雨 = "cloud.heavyrain"
}




