//
//  HistoryTodayRequestHelper.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/17.
//

import Foundation
import Combine
import SwiftUI

struct HistoryTodayResourceResponse: Codable {
    let code: String
    let datas: [HistoryTodayDataModel]
    let msg:String

    enum CodingKeys: String, CodingKey {
        case code
        case datas
        case msg
    }
}



enum HistoryToday {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "http://dh.ylapi.cn")!
}



extension HistoryToday {

    static func request4Data(_ path: APIPath, _ queryItems: [URLQueryItem]) -> AnyPublisher<HistoryTodayResourceResponse, Error> {
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
