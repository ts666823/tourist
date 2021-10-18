//
//  ForecastCardView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/10.
//

import SwiftUI

struct ForecastCardView: View {
    var weather: WeatherDataModel = WeatherDataModel(id: 0, day: "日星期四", minTemp: "低温 11℃", maxTemp: "高温 19℃", dayType: "阴", nightType: "阴")

    var body: some View {
        VStack(spacing: 20) {
            Text(self.weather.day!)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
            

            HStack {
                Image(systemName: weather2Symbos(weatherName: weather.dayType!))
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 80, height: 60)
                Image(systemName: weather2Symbos(weatherName: weather.nightType!))
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: 80, height: 60)

            }
            
            Text(weather.maxTemp!+"\n"+weather.minTemp!)
                .font(.title)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
        }
        .frame(width: 200, height: 300)
//        .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity, minHeight: 150, idealHeight: 300, maxHeight: .infinity)
        .background(Color.pink.opacity(0.5))
        .cornerRadius(20)
        .shadow(color: Color.pink.opacity(0.5), radius: 10, x: 0, y: 8)
    }
}

struct ForecastCardView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastCardView()
    }
}
