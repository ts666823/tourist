//
//  CookDetailedView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/16.
//

import SwiftUI

struct CookDetailedView: View {
    
    @Binding var cookDetail:CookBookDataModel
    
    var body: some View {
        
        ScrollView{
            VStack (alignment:.leading){
                if #available(iOS 15.0, *) {
                    AsyncImage(url: URL(string: cookDetail.largeImg ?? "https://img.tukuppt.com/png_preview/00/58/22/PBqPfRfSQl.jpg!/fw/780")) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 382, height: 300)
                } else {
                    Image("food_detailed")
                        .resizable()
                        .frame(height:300)
                    // Fallback on earlier versions
                }
                Text(cookDetail.cpName ?? "暂无菜品名称")
                    .font(.title)
                Text(cookDetail.des ?? "暂无描述")
                    .font(.footnote)
                    .foregroundColor(.gray)
                Divider()
                
                VStack(alignment:.leading) {
                    Text("材料:")
                        .font(.title2)
                    HStack{
                        Text("     "+cookDetail.processYL(yls: cookDetail.yl!))
                    }
                    
                    Text("小提示:")
                        .font(.title2)
                        .padding(.top)
                    Text("     "+(cookDetail.tip ?? "暂无小提示"))
                    Text("步骤：")
                        .font(.title2)
                        .padding(.top)
                    if(cookDetail.steps == nil||cookDetail.steps?.count == 0)
                    {
                        Text("暂无步骤")
                    }
                    else{
                        ForEach(cookDetail.steps! , id: \.id){ data in
                            Text((data.orderNum ?? 1).description + "、" + (data.content ?? "该步骤暂无"))
                        }
                    }
                }
        }
            
            
        }
        .padding(.horizontal)
    }
    
}

struct CookDetailedView_Previews: PreviewProvider {
    static var previews: some View {
        CookDetailedView(cookDetail: .constant(CookBookViewModel().CookBookList[0]))
    }
}
