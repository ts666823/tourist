//
//  CookBookRequestHelper.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/16.
//

import Foundation
import Combine
import SwiftUI

struct CookBookDataResourceResponse: Codable {
    let code: String
    let datas: [CookBookDataModel]
    let msg:String

    enum CodingKeys: String, CodingKey {
        case code
        case datas
        case msg
    }
}



enum CookBook {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "http://cb.ylapi.cn")!
}

var uid = "11904"
var appkey:String = "eab6db6a9a25a24473241280330fe53d"


extension CookBook {

    static func request4Data(_ path: APIPath, _ queryItems: [URLQueryItem]) -> AnyPublisher<CookBookDataResourceResponse, Error> {
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

