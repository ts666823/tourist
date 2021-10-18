//
//  ListSuggestion.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/10.
//

import SwiftUI

struct ListSuggestionCardView: View {
    var guideData:GuideDataModel = GuideDataModel(name: "穿衣指数", value: "保暖春秋装", detail: "天气舒适，温度适宜。建议着休闲装，风衣，夹克衫，薄毛衣等，既舒适，又时尚。")
    var body: some View {
        VStack(spacing: 20) {
            VStack{
                Text(guideFormatName(guideName:guideData.name!))
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
            }
            
            Image(systemName: guide2Symbos(guideName: guideData.name!))
                .resizable()
                .foregroundColor(Color.white)
                .frame(width: 100, height: 100)
            VStack{
                Text(guideData.value!)
                .font(.title2)
                .foregroundColor(Color.white)
                .fontWeight(.bold)
                Text(guideData.detail!)
                .font(.headline)
                .foregroundColor(Color.white)
            }
        }
        .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity, minHeight: 150, idealHeight: 300, maxHeight: .infinity)
        .background(Color.green.opacity(0.5))
        .cornerRadius(20)
        .shadow(color: Color.green.opacity(0.5), radius: 10, x: 0, y: 8)
    }
}

struct ListSuggestion_Previews: PreviewProvider {
    static var previews: some View {
        ListSuggestionCardView()
    }
}
