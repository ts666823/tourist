//
//  CookBookView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/16.
//

import SwiftUI

struct CookBookView: View {
    //@Binding var showAlert : Bool cookBookViewModel.cookRequestError
    @ObservedObject var cookBookViewModel = CookBookViewModel()
    @State var input:String = ""
    @State var alertShow = false
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    TextField("搜索菜谱", text: self.$input,onCommit:  {
                            self.cookBookViewModel.search(self.input)
                        })
                        .keyboardType(.default)
                        .font(.title2)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    
                    Image(systemName: "magnifyingglass")
                        .frame(width: 41, height: 37)
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        .onTapGesture {
                            self.cookBookViewModel.search(self.input)
                        }
                }
                Spacer()
                
                List(cookBookViewModel.CookBookList){ data in
                    NavigationLink(destination: CookDetailedView(cookDetail: .constant(data))){
                        FoodIntroductionView(cookData: data)
                    }
                }
            }
            .onReceive(cookBookViewModel.$cookRequestError){data in
                alertShow = data
            }
            .alert(isPresented: $alertShow) {
                        Alert(title: Text("系统提示"),
                              message: Text(cookBookViewModel.cookRequestMsg),
                         dismissButton: .default(Text("OK")))
            }
            .padding(.horizontal)
            .navigationTitle("吃你想吃的！")
        }
        
    }
}

struct CookBookView_Previews: PreviewProvider {
    static var previews: some View {
        CookBookView()
    }
}

struct FoodIntroductionView: View {
    
    var cookData:CookBookDataModel
    
    var body: some View {
        HStack{
            if #available(iOS 15.0, *) {
                AsyncImage(url: URL(string: cookData.smallImg ?? "https://img.tukuppt.com/png_preview/00/58/22/PBqPfRfSQl.jpg!/fw/780" )) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 130, height: 100)
            } else {
                Image("food")
                    .resizable()
                    .frame(width: 130, height: 100)
                // Fallback on earlier versions
            }
            VStack(alignment:.leading){
                Text(cookData.cpName ?? "暂无名字")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.title2)
                Text(cookData.type_v3 ?? "暂无分类")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Text(cookData.des ?? "暂无描述")
                    .font(.caption)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
