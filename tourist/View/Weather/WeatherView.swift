//
//  ContentView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/6.
//

import SwiftUI
import Combine

let screen = UIScreen.main.bounds

struct WeatherView: View {
    @State var showDetails:Bool = false
    @State var alertShow:Bool = false
    @ObservedObject var weatherViewModel = WeatherViewModel()
    @ObservedObject var cityViewModel = CityViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "ellipsis.circle.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Spacer()
                        Text(cityViewModel.chooseCityName+"天气")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .onTapGesture {
                                showDetails.toggle()
                            }
                    }.padding()
                    
                    DatePicker(selection: .constant(Date()), displayedComponents: [.date], label: { Text("日期")
                            .font(.title)
                    })
                    
                    Text("今日天气")
                        .font(.system(size: 22))
                        .fontWeight(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.bottom,-5)
                        .padding(.horizontal, 10.0)
                    
                    TodayWeatherCardView(weather: weatherViewModel.weatherResource.today ?? TodayWeatherDataModel(day: "暂无", minTemp: "暂无", maxTemp: "暂无", currentTemp: "暂无", dayType: "暂无", nightType: "暂无", updateTime: "暂无", sunriseTime: "暂无", sunsetTime: "暂无"))
                        .cornerRadius(20)
                        .padding(.horizontal)
                        .shadow(color: Color.blue.opacity(0.4), radius: 20,x: 0,y: 20)
                    
                    Text("未来七天")
                        .font(.system(size: 22))
                        .fontWeight(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:20){
                            ForEach(weatherViewModel.weatherResource.weatherData ?? WeatherDataModel.SymbolData, id: \.id) { weather in
                                Button(action: {
                                }) {
                                    GeometryReader { geometry in
                                        ForecastCardView(weather: weather).rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 60) / -30), axis: (x: 0, y: 10, z: 0))
                                    }
                                }.frame(width: 200, height: 300)
                            }
                        }
                        .frame(height: 350)
                        .padding(.horizontal)
                    }
                    
                    Text("出行建议")
                        .font(.system(size: 22))
                        .fontWeight(.black)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:20){
                            ForEach(weatherViewModel.weatherResource.guides ?? GuideDataModel.SymbolData, id: \.id) { guide in
                                Button(action: {
                                }) {
                                    GeometryReader { geometry in
                                        ListSuggestionCardView(guideData: guide).rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 60) / -30), axis: (x: 0, y: 10, z: 0))
                                    }
                                }.frame(width: 200, height: 300)
                            }
                        }
                        .frame(height: 350)
                        .padding(.horizontal)
                    }
                }.blur(radius: showDetails ? 20 : 0)
                
                List{
                    ForEach(cityViewModel.cityData){city in
                        Button(action: {
                            if city.isChoice {
                                self.showDetails.toggle()
                            } else {
                                self.cityViewModel.setAddress(city: city) { (_) in
                                    self.weatherViewModel.httpRequest(requestUrl: "http://wthrcdn.etouch.cn/WeatherApi?citykey="+(city.cityId!.description))
                                    self.showDetails.toggle()
                                }
                            }
                        }) {
                            CityChooseRow(isChoose: city.isChoice,cityName: city.name!)
                        }
                    }
                    
                }
                .rotation3DEffect(Angle(degrees: showDetails ? 0 : 60), axis: (x: 0, y: 10.0, z: 0))
                .offset(x: showDetails ? screen.width/4 : screen.width)
                .animation(.default)
                .frame(width: screen.width/3 * 2)
            }
            .onReceive(weatherViewModel.$weatherRequestError){data in
                alertShow = data
            }
            .alert(isPresented: $alertShow) {
                Alert(title: Text("系统提示"),
                        message: Text(weatherViewModel.weatherRequestMsg),
                    dismissButton: .default(Text("OK")))
            }
        }
    }
}


struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

