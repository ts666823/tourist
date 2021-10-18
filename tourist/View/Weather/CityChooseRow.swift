//
//  CityChooseView.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/13.
//

import SwiftUI

struct CityChooseRow: View {
    var isChoose:Bool
    var cityName:String
    
    var body: some View {
        HStack {
            Text(cityName)
            Spacer()
            Image(systemName: isChoose ? "checkmark" : "")
        }
    }
}



struct CityChooseView_Previews: PreviewProvider {
    static var previews: some View {
        CityChooseRow(isChoose: false,cityName: "上海")
    }
}
