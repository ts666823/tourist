//
//  RequestHelper.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/15.
//

import Foundation
import Combine
import SwiftUI

struct ScenicDataResourceResponse: Codable {
    let status: String
    let pois: [ScenicDataModel]
    let info:String
    let count:String

    enum CodingKeys: String, CodingKey {
        case status
        case pois
        case info
        case count
    }
}



enum Scenic {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://restapi.amap.com/v5/place/")!
}

var key:String = "87110f19e1125d097e82f8bc0de0f9cc"



extension Scenic {

    static func request(_ path: APIPath, _ queryItems: [URLQueryItem]) -> AnyPublisher<ScenicDataResourceResponse, Error> {
        //let str = "https://restapi.amap.com/v5/place/text?keywords=酒店&city=嘉定&page=1&key=413cb0480a3d9f2bbb824115c4f22aa0&extensions=all&show_fields=business,photos&page=1"
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: false)
                   else { fatalError("Couldn't create URLComponents") }
        components.queryItems = queryItems
        
        print(components.url)
        //let url = URL(string: str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        
        let request = URLRequest(url: components.url!)

        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
}

