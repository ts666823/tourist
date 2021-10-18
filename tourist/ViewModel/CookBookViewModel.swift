//
//  CookBookDataModel.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/16.
//

import Foundation
import Combine
import SwiftUI

class CookBookViewModel: ObservableObject {

    @Published var CookBookList: [CookBookDataModel] = []
    
    @Published var cookRequestMsg:String = ""
    
    @Published var cookRequestError:Bool = false
    var cancellationToken: AnyCancellable?

    init() {
        getResourceList(name: "炒饭")
    }
    
    func search(_ input: String) {
        getResourceList(name: input)
    }
    
    
    func getResourceList(name:String = "麻辣烫") {
        let queryItems = [URLQueryItem(name: "uid", value: "11904"),URLQueryItem(name: "appkey", value: "eab6db6a9a25a24473241280330fe53d"),URLQueryItem(name: "cName", value: name),URLQueryItem(name: "type", value: "热门专题")]
        cancellationToken = CookBook.request4Data(.cookBook, queryItems)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [self] in
                if $0.code == "1000"{
                    CookBookList = $0.datas
                    cookRequestMsg = $0.msg
                    cookRequestError = false
                }
                else
                {
                    cookRequestMsg = $0.msg
                    cookRequestError = true
                }
            })
    }

    
}
