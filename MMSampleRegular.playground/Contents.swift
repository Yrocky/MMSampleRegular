//: Playground - noun: a place where people can play

import UIKit

/**
 *  一个简单的可以进行正则匹配的结构体，根据`正则规则`、`接收数据`来判断是否可以正确匹配
 */
public struct MMSampleRegular {
    
    /**
     内置的几种匹配规则
     */
    enum MMPatternType{
        enum MMPatternDefaultType : String{
            
            case Phone  = "^((13[0-9])|(147)|(15[0-3,5-9])|(18[0,0-9])|(17[0-3,5-9]))\\d{8}$"
            case Email  = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
            case IP     = "^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$"
            case ID     = "(^[0-9]{15}$)|([0-9]{17}([0-9]|[0-9a-zA-Z])$)"
            // ...
        }
        case Custom(String)
        case Default(MMPatternDefaultType)
    }
    
    private let regex: NSRegularExpression?
    
    /**
     通过`内置的几种正则表达式`创建结构体
     */
    init(_ patternType : MMPatternType) {
        
        switch patternType {
        case let .Custom(text):
            self.init(text)
        case let .Default(defaultType):
            self.init(defaultType.rawValue)
        }
    }
    
    /**
     通过`字符串正则表达式`创建结构体
     */
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    public func match(_ input: String) -> Bool {
        if let matches = regex?.matches(in: input,
                                        options: [],
                                        range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        }
        else {
            return false
        }
    }
}


let phoneRegular = MMSampleRegular.init(.Default(.Phone))// 使用内置的Phone来初始化一个正则匹配对象
let numberRegular = MMSampleRegular.init(.Custom("^[2-9]*$"))// 任意个数的2-9范围内的数字
let alsoNumberRegular = MMSampleRegular.init("^[2-9]{2,4}$")// 2-4位的数字，且数字范围为 2-9

phoneRegular.match("15537890987")
phoneRegular.match("12232098765")
phoneRegular.match("123")

numberRegular.match("1")
numberRegular.match("")

numberRegular.match("13")

alsoNumberRegular.match("29384")












