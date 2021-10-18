//
//  SceneicDataViewModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/15.
//

import Foundation
import Combine

class ScenicDataResourceViewModel: ObservableObject {

    @Published var ScenicDataResourceList: [ScenicDataModel] = []
    
    @Published var scenicDataRequestMsg:String = ""
    
    @Published var scenicDataRequestError:Bool = false
    
    var cancellationToken: AnyCancellable?

    init() {
        getResourceList(keywords: "酒店")
    }
    
    func search(_ input: String = "酒店",city:String = "嘉定") {
        getResourceList(keywords: input,city: city)
    }
    
    
    
    
    
    func getResourceList(keywords:String = "酒店",city:String = "嘉定") {
        let queryItems = [URLQueryItem(name: "keywords", value: keywords),URLQueryItem(name: "city", value: city),URLQueryItem(name: "key", value: "413cb0480a3d9f2bbb824115c4f22aa0"),URLQueryItem(name: "extensions", value: "all"),URLQueryItem(name: "show_fields", value: "business,photos"),URLQueryItem(name: "page", value: "1")]
        cancellationToken = Scenic.request(.resourceList, queryItems)
            .mapError({ (error) -> Error in 
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [self] in
                if($0.status == "0")
                {
                    scenicDataRequestError = true
                    scenicDataRequestMsg = $0.info
                }
                else if($0.pois.count <= 0)
                {
                    scenicDataRequestError = true
                    scenicDataRequestMsg = "无法查询到对应数据"
                }
                else{
                    scenicDataRequestError = false
                    ScenicDataResourceList = $0.pois
                }
            })
    }

}
