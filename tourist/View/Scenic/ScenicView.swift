//
//  SwiftUIView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/14.
//

import SwiftUI
import Combine

struct ScenicView: View {
    
    @ObservedObject var scenicDataResourceViewModel = ScenicDataResourceViewModel()
    @ObservedObject var cityViewModel = CityViewModel()
    @State var remoteImage = Image("hotel")
    @State var chooseCity = "嘉定"
    @State var chooseStr = "酒店"
    @State var alertShow = false
    @State var showDetails = false
    @State var province = "上海"
    
    var body: some View {
        ZStack {
            VStack{
                HStack {
                    Image(systemName: "location.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.leading)
                        .onTapGesture {
                            showDetails.toggle()
                        }
                    Text(province)
                        .font(.title)
                    Text(chooseCity)
                        .font(.title)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                        .onTapGesture {
                            showDetails.toggle()
                        }
                }
                .padding(.top)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing:20) {
                        ForEach(ButtonViewData.SymbolData){data in
                            Button(action: {
                                scenicDataResourceViewModel.search(data.textString,city: chooseCity)
                                chooseStr = data.textString
                            }){
                                ButtonView(buttonViewData: data)
                            }
                        }
                    }
                    .padding([.top, .leading, .trailing])
                }
                Text("酒店")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.leading)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack(spacing:20) {
                        ForEach(scenicDataResourceViewModel.ScenicDataResourceList){data in
                            InformationView(data: data)
                            
                        }
                    }
                    .padding([.top, .leading, .trailing])
                }
                Spacer()
                
                
            }
            .onReceive(scenicDataResourceViewModel.$scenicDataRequestError){data in
                alertShow = data
            }
            .alert(isPresented: $alertShow) {
                Alert(title: Text("系统提示"),
                        message: Text(scenicDataResourceViewModel.scenicDataRequestMsg),
                    dismissButton: .default(Text("OK")))
        }
        List{
            ForEach(cityViewModel.cityData){city in
                Button(action: {
                    if city.isChoice {
                        self.showDetails.toggle()
                        self.chooseCity = city.name ?? "未知城市"
                        self.province = city.parentName ?? "未知省份"
                        scenicDataResourceViewModel.search(chooseStr, city: chooseCity)
                    } else {
                        self.cityViewModel.setAddress(city: city) { (_) in
                            self.chooseCity = city.name ?? "未知城市"
                            self.province = city.parentName ?? "未知省份"
                            scenicDataResourceViewModel.search(chooseStr, city: chooseCity)
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
        
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ScenicView()
        }
    }
}



struct ButtonView: View {
    var buttonViewData:ButtonViewData = ButtonViewData(imageName:"bolt.car",textString: "加油站")
    
    var body: some View {
        VStack{
            Image(systemName: buttonViewData.imageName)
                .resizable()
                .foregroundColor(.blue)
                .frame(width: 72, height: 52.5)
            Text(buttonViewData.textString)
                .font(.title2)
        }
        .frame(width: 100, height: 200)
        .background(Color.green.opacity(0.5))
        .cornerRadius(20)
        .shadow(color: Color.green.opacity(0.5), radius: 10, x: 0, y: 8)
    }
}

struct InformationView: View {

    var data:ScenicDataModel

    var body: some View {
        VStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: (data.photos?.count == 0 ? "https://img.tukuppt.com/png_preview/00/58/22/PBqPfRfSQl.jpg!/fw/780" :data.photos?[0].url) ?? "https://img.tukuppt.com/png_preview/00/58/22/PBqPfRfSQl.jpg!/fw/780")) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 380, height: 360)
            } else {
                Image("hotel")
            }
            VStack{
                HStack{
                    Text(data.name ?? "查询不到名字")
                        .font(.title2)
                        .fontWeight(.heavy)
                }
                HStack{
                    Text("类型："+(data.business?.keytag ??  "查询不到类型"))
                        .multilineTextAlignment(.leading)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth:100,maxHeight: .infinity)
                    Spacer()
                    Text("地址："+(data.address ?? "查询不到地址"))
//                        .fixedSize(horizontal: false, vertical: true)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth:200,maxHeight: .infinity)
                }
                HStack{
                    Text("评分："+(data.business?.rating ?? "查询不到评分"))
                        .font(.headline)
                    Spacer()
                    Text("电话：" + (data.business?.tel ?? "查询不到电话"))
                }
            }
        }
        
    }
}
