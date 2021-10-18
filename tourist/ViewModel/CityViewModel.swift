//
//  CityViewModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/13.
//

import Foundation
import Combine

class CityViewModel :ObservableObject{
    var cityData:[CityDataModel] = []
    @Published var chooseCityName:String = "北京"
    
    init()
    {
        loadData()
    }
    
    func loadData() {
        let filePath = Bundle.main.path(forResource: "address", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: filePath))
        print(data)
        let model = try? JSONDecoder().decode([CityDataModel].self, from: data)
        cityData = model!
//        guard let url = URL(string: requestUrl) else {
//            print("URL error")
//            return
//        }
//        print("url\(url)")
//        URLSession.shared.dataTask(with: url) { [self] (data, rsp, error) in
//            //解决错误情况
//            print("Request Start\(requestUrl)")
//            guard let data = data,error == nil else {
//                print("Request failed\(requestUrl)")
//                print(error ?? "Unknown error")
//                return
//            }
//            DispatchQueue.main.async {
//                self.weatherResource = xmlHelper.XMLTranslate(xmlData: data)
//            }
//        }.resume()
    }
    
    func setAddress(city: CityDataModel?, block: ((String?)->Void)?) {
        guard let city = city else { return }
        for i in 0..<(self.cityData.count ) {
            let addressId = self.cityData[i].cityId
            self.cityData[i].isChoice = addressId == city.cityId
        }
        DispatchQueue.main.async { [self] in
            block?(city.cityId)
            chooseCityName = city.name!
        }
    }
}

