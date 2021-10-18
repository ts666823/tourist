//
//  TodayWeatherView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/10.
//

import SwiftUI

struct TodayWeatherCardView: View {
    var weather: TodayWeatherDataModel

    var body: some View {
        VStack(spacing: 10) {
            VStack(){
                Text("\(weather.currentTemp ?? "暂无数据")°")
                    .foregroundColor(Color.white)
                    .fontWeight(Font.Weight.heavy)
                    .font(Font.system(size: 50))
                
                Text("\(weather.maxTemp ?? "暂无")/\(weather.minTemp  ?? "暂无")")
                    .foregroundColor(Color.white)
                    .font(.title)
            }
            HStack(spacing: 20){
                VStack{
                    Text("白天")
                        .foregroundColor(Color.white)
                        .font(.title)
                    Image(systemName: weather2Symbos(weatherName: weather.dayType ?? "暂无"))
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 90, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
                VStack{
                    Text("夜间")
                        .foregroundColor(Color.white)
                        .font(.title)
                    Image(systemName: weather2Symbos(weatherName: weather.nightType ?? "暂无"))
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 90, height: 60)
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            HStack() {
                HStack {
                    Image(systemName: "sunrise")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 50, height: 40)
                        .aspectRatio(contentMode: .fit)
                    Text(weather.sunriseTime ?? "暂无")
                        .foregroundColor(Color.white)
                        .font(.headline)
                }
                Text("/")
                    .foregroundColor(Color.white)
                    .font(.headline)
                HStack{
                    Text(weather.sunsetTime ?? "暂无")
                        .foregroundColor(Color.white)
                        .font(.headline)
                    Image(systemName: "sunset")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: 50, height: 40)
                        .aspectRatio(contentMode: .fit)
                }
            }
            
            HStack {
                Spacer()
                Text("上次更新时间:\(weather.updateTime ?? "暂无")")
                    .foregroundColor(Color.white)
                    .font(.footnote)
                    .padding(.trailing)
            }
            
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.blue)
        
    }
}


