//
//  WeatherViewModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/11.
//

import Foundation
import Combine

class WeatherViewModel:ObservableObject{
    @Published var weatherResource:WeatherResource = WeatherResource(guides: [], weatherData: [], today: TodayWeatherDataModel(day: "", minTemp: "", maxTemp: "", currentTemp: "", dayType: "", nightType: "", updateTime: "", sunriseTime: "", sunsetTime: ""))
    
    @Published var weatherRequestMsg:String = ""
    
    @Published var weatherRequestError:Bool = false
    
    let xmlHelper = XMLhelper()
    
    init(){
        httpRequest(requestUrl: "http://wthrcdn.etouch.cn/WeatherApi?citykey=101010100")
    }
    
}

extension WeatherViewModel{
    
    
    
    
    
    func httpRequest(requestUrl:String)
    {
        guard let url = URL(string: requestUrl) else {
            print("URL error")
            return
        }
        print("url\(url)")
        URLSession.shared.dataTask(with: url) { [self] (data, rsp, error) in
            //解决错误情况
            print("Request Start\(requestUrl)")
            guard let data = data,error == nil else {
                print("Request failed\(requestUrl)")
                print(error ?? "Unknown error")
                weatherRequestMsg = error.debugDescription
                weatherRequestError = true
                return
            }
            DispatchQueue.main.async {
                let data = xmlHelper.XMLTranslate(xmlData: data)
                if(xmlHelper.errorMsg != "")
                {
                    weatherRequestMsg = xmlHelper.errorMsg
                    weatherRequestError = true
                }
                else
                {
                    weatherResource = data
                }
                xmlHelper.clearData()
            }
        }.resume()
    }
}
