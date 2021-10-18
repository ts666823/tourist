//
//  HistoryTodayView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/17.
//

import SwiftUI

struct HistoryTodayView: View {
    @ObservedObject var historyTodayViewModel = HistoryTodayViewModel()
    @State var alertShow = false
    
    var body: some View {
        
        NavigationView {
            VStack(spacing:20) {
                
                DatePicker(selection: $historyTodayViewModel.date, displayedComponents: [.date], label: { Text("日期").font(.title) })
                        .padding(.horizontal, 25.0)
                
                List(historyTodayViewModel.historyTodayList){ data in
                    HStack{
                        if #available(iOS 15.0, *) {
                            AsyncImage(url: URL(string: data.img ?? "https://img.tukuppt.com/png_preview/00/58/22/PBqPfRfSQl.jpg!/fw/780" )) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 200, height: 150)
                        } else {
                            Image("history")
                                .resizable()
                                .frame(width: 200, height: 150)
                        }
                       
                        VStack {
                            Text(data.title ?? "暂无标题")
                                .fontWeight(.black)

                            Text(data.processDate(year: data.year!,month: data.month!,day: data.day!))
                                .font(.footnote)
                        }
                        
                        
                    }
                }
                
            }
            .navigationTitle("历史上的今天")
            .onReceive(historyTodayViewModel.$date){data in
                historyTodayViewModel.search(data)
            }
            .onReceive(historyTodayViewModel.$historyTodayRequestError){data in
                alertShow = data
            }
            .alert(isPresented: $alertShow) {
                        Alert(title: Text("系统提示"),
                              message: Text(historyTodayViewModel.historyTodayRequestMsg),
                         dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct HistoryTodayView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryTodayView()
    }
}
