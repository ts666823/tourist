//
//  HistoryTodayDataViewModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/17.
//

import Foundation
import Combine
import SwiftUI

class HistoryTodayViewModel: ObservableObject {

    @Published var historyTodayList: [HistoryTodayDataModel] = []
    
    @Published var historyTodayRequestMsg:String = ""
    
    @Published var historyTodayRequestError:Bool = false
    
    @Published var date:Date = Date()
    
    
    
    var cancellationToken: AnyCancellable?

    init() {
        getResourceList(date: Date())
    }
    
    func search(_ input: Date) {
        getResourceList(date: input)
    }
    
    
    
    func getResourceList(date:Date = Date()) {
        let dateFormatter = DateFormatter()
         
        dateFormatter.dateFormat = "MMdd"
         
        let dateStr = dateFormatter.string(from: date)
        
        let queryItems = [URLQueryItem(name: "uid", value: "11904"),URLQueryItem(name: "appkey", value: "2781c20309b1b8eaab95e30cd68ed273"),URLQueryItem(name: "date", value: dateStr)]
        cancellationToken = HistoryToday.request4Data(.historyToday, queryItems)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [self] in
                if $0.code == "1000"{
                    historyTodayList = $0.datas
                    historyTodayRequestMsg = $0.msg
                    historyTodayRequestError = false
                }
                else
                {
                    historyTodayRequestMsg = $0.msg
                    historyTodayRequestError = true
                }
            })
    }

    
}
