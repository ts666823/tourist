//
//  Regular expression.swift
//  tourist
//
//  Created by 唐烁 on 2021/10/14.
//

import Foundation

class HTMLHelper{
    //MARK: - --- 根据正则表达式提取字符串(获取单条)
   func extractStr(_ str:String, _ pattern:String) -> String{
       
       do{
           let regex = try NSRegularExpression(pattern: pattern , options: .caseInsensitive)
           
           let firstMatch = regex.firstMatch(in: str, options: .reportProgress, range: NSMakeRange(0, str.count))
           if firstMatch != nil {
               let resultRange = firstMatch?.range(at: 0)
               let result = (str as NSString).substring(with: resultRange!)
               //print(result)
               return result
           }
       }catch{
           print(error)
           return ""
       }
       return ""
   }
   
   //MARK: - --- 根据正则表达式提取字符串(获取多条)
   func regexGetSub(_ pattern:String, _ str:String) -> [String] {
       var subStr = [String]()
       
       do {
           let regex = try NSRegularExpression(pattern: pattern, options:[NSRegularExpression.Options.caseInsensitive])
           let results = regex.matches(in: str, options: NSRegularExpression.MatchingOptions.init(rawValue: 0), range: NSMakeRange(0, str.count))
           //解析出子串
           for  rst in results {
               let nsStr = str as  NSString  //可以方便通过range获取子串
               subStr.append(nsStr.substring(with: rst.range))
           }
       }catch{
           print(error)
           return [""]
       }
       return subStr.count == 0 ? [""]:subStr
   }
    
    func getSingleScenicInfo(htmlStr:String){
        let pattern = "<li c>"
    }
//    //获取头部div标签数据
//    let headTop =  "<divclass=\"main-top\">(.*?)</div><ulclass=\"trigger-menu\""
//    let topInfo:String = self.extractStr(str, headTop)
//
//    //获取头像url
//    let headImagRegex = "(?<=aclass=\"avatar\"href=\".{0,200}\"><imgsrc=\")(.*?)(?=\"alt=\".*?\"/></a>)"
//    let headImge = self.extractStr(topInfo, headImagRegex)
//
//    //用户名
//    let nameRegex = "(?<=aclass=\"name\"href=\".{0,200}\">)(.*?)(?=</a>)"
//    let name = self.extractStr(topInfo, nameRegex)
//
//    //性别
//    let sexRegex = "(?<=iclass=\"iconfontic-)(.*?)(?=\">.*?</i>)"
//    let sex = self.extractStr(topInfo, sexRegex)
//
//    //[关注，粉丝，文章，字数，收获喜欢] 。 li标签一般是多个，匹配出来自然是数组
//    let infoListRegex = "(?<=li><divclass=\"meta-block\">.{0,200}<p>)(.*?)(?=</p>.*?</li>)"
//    let infoList = self.regexGetSub(infoListRegex, topInfo)
//
//    //总页数（PC默认每页9个数据，所以可以通过文章总数计算总页数）
//    let articleCount = Int(Double((infoList[2]))!)
//    let totalPage = articleCount % 9 > 0 ? (articleCount / 9 + 1) : articleCount / 9
//
//    //个人介绍
//    let introRegex = "(?<=divclass=\"js-intro\">)(.*?)(?=</div>)"
//    var intro = self.regexGetSub(introRegex, str)[0]
//    intro = intro.replacingOccurrences(of: "<br>", with: "\n")
//
//    //返回头部信息(存入自定义元组：typealias Yuanzu = (headImge: String, name: String, sex:String, infoList: Array<String>, totalPage: Int, intro: String, headerH:CGFloat))
//    let headCallBackInfo = (headImge:headImge, name:name, sex:sex, infoList:infoList, totalPage:totalPage, intro:intro, headerH:headerH)

}
