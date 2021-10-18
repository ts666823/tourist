//
//  XMLhelper.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/13.
//

import Foundation

class XMLhelper: NSObject,XMLParserDelegate{
    
    var weatherData:[WeatherDataModel] = []
    var currentElement = ""
    var curID = 0
    var curWeatherData:WeatherDataModel!
    var curIsDay = true
    
    var guides:[GuideDataModel] = []
    var curGuide:GuideDataModel!
    
    var todayWeatherData:TodayWeatherDataModel = TodayWeatherDataModel()
    
    var errorMsg = ""
    
    func transferTodayWeatherData(data:WeatherDataModel){
        todayWeatherData.day = data.day
        todayWeatherData.minTemp = data.minTemp
        todayWeatherData.maxTemp = data.maxTemp
        todayWeatherData.dayType = data.dayType
        todayWeatherData.nightType = data.nightType
    }
    
    func clearData(){
        weatherData.removeAll()
        guides.removeAll()
    }
    
    /// XML解析
    /// - Parameter xmlData: 需要解析的XML文件
    func XMLTranslate(xmlData:Data) ->WeatherResource
    {
        let parser = XMLParser(data: xmlData)
        //设置delegate
        parser.delegate = self
        //开始解析
        print("Parse Start")
        parser.parse()
        transferTodayWeatherData(data: weatherData[0])
        weatherData.remove(at: 0)
        var weatherResource = WeatherResource(guides: guides, weatherData: weatherData, today: todayWeatherData)

        return weatherResource
    }
    
    // 遇到一个开始标签时调用
    func parser(_ parser: XMLParser, didStartElement elementName: String,
                    namespaceURI: String?, qualifiedName qName: String?,
                    attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        switch elementName{
        case "resp":
            todayWeatherData = TodayWeatherDataModel()
        case "weather":
            curWeatherData = WeatherDataModel(id: curID)
            curID += 1
        case "day":
            curIsDay = true
        case "night":
            curIsDay = false
        case "zhishu":
            curGuide = GuideDataModel()
        default:
            break
        }
        
    }
     
    // 遇到字符串时调用
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        //接下来每遇到一个字符，将该字符追加到相应的 property 中
        switch currentElement{
        case "updatetime":
            todayWeatherData.updateTime = todayWeatherData.updateTime ?? "" + data
        case "wendu":
            todayWeatherData.currentTemp = todayWeatherData.currentTemp ?? "" + data
        case "sunrise_1":
            todayWeatherData.sunriseTime = todayWeatherData.sunriseTime ?? "" + data
        case "sunset_1":
            todayWeatherData.sunsetTime = todayWeatherData.sunsetTime ?? "" + data
        case "date":
            //运算符优先级！
            curWeatherData.day = (curWeatherData.day ?? "") + data
        case "high":
            curWeatherData.maxTemp = curWeatherData.maxTemp ?? "" + data
        case "low":
            curWeatherData.minTemp = curWeatherData.minTemp ?? "" + data
        case "type":
            if(curIsDay){
                curWeatherData.dayType = curWeatherData.dayType ?? "" + data
            }
            else{
                curWeatherData.nightType = curWeatherData.nightType ?? "" + data
            }
        case "name":
            curGuide.name = curGuide.name ?? "" + data
        case "value":
            curGuide.value = curGuide.value ?? "" + data
        case "detail":
            curGuide.detail = curGuide.detail ?? "" + data
        case "error":
            errorMsg = errorMsg + data
        default:
            break
        }
    }
     
    // 遇到结束标签时调用
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?) {
       
        if(elementName == "weather")
        {
            weatherData.append(curWeatherData)
        }
        else if(elementName == "zhishu"){
            guides.append(curGuide)
        }
        
    }
}
