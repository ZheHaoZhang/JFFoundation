//
//  StringExtension.swift
//  JFFoundation
//
//  Created by 張哲豪 on 2020/3/6.
//  Copyright © 2020 張哲豪. All rights reserved.
//

import UIKit
import CommonCrypto

public extension String {
    var localized: String {
        let localizedStr = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
        if localizedStr == self {
            //待翻譯
//            print("🌐"+"\""+self+"\""+" = "+"\"\";")
        }
        return localizedStr
    }
    func longValue() -> Int64 {
        return Int64(self) ?? 0
    }
    var isValidNumber: Bool{
        let emailRegEx = "[0-9]*"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isChinesePhone: Bool {
        // 判断是否中国电话号码，1位=1，2位2-9，後面9位 0-9 共11碼
        let emailRegEx = "^1[2-9][0-9]{9}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isValidPassword: Bool{
        let emailRegEx = "[a-zA-Z0-9]{6,20}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    var isNumberOrLetter: Bool{
        let emailRegEx = "[a-zA-Z0-9]*"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
   func isEmptyOrWhitespace() -> Bool {

        // Check empty string
        if self.isEmpty {
            return true
        }
        // Trim and check empty string
        return (self.trimmingCharacters(in: .whitespaces) == "")
    }
    
    
    var MD5: String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                return ""
            }
        }
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
    
    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    subscript (i: Int) -> Character {
      return self[index(startIndex, offsetBy: i)]
    }
    
    ///長度裁切
    func trunc(maxLength: Int) -> String {
        return self.utf16.count > maxLength ? String(self.prefix(maxLength)) : self
    }
    ///字串長度
    func SizeOf(_ font: UIFont) -> CGSize {
        return self.size(withAttributes: [NSAttributedString.Key.font: font])
    }
    ///特殊的長度計算
    /**
        utf8長度大於 1 長度算2
     */
    func lengthOfSpecial() -> Int{
        return self.reduce(0) { (sum, num) -> Int in
            let length = num.utf8.count == 1 ? 1 : 2
            return sum + length
        }
    }
    ///中文表情符等比较宽的字段 减半的规则
    mutating func prefixSpecial(count: Int) {
        self = String(self.prefix(count))
        while self.lengthOfSpecial() > count {
            self.removeLast()
        }
    }
    ///取字首BySize
    /**
       裁切長度由字符計算長度
       超出長度 裁切 Last 直到符合長度
    */
    mutating func prefix(maxSize: Int) {
        //使用字串寬度計算 Font1 的表情符號為width 1
        while Int(self.SizeOf(UIFont.systemFont(ofSize: 1)).width)*2 > maxSize {
            self.removeLast()
        }
    }
    ///取字尾BySize
    /**
        裁切長度由字符計算長度
        超出長度 裁切 First 直到符合長度
     */
    mutating func suffix(maxSize: Int) {
        //使用字串寬度計算 Font1 的表情符號為width 1
        while Int(self.SizeOf(UIFont.systemFont(ofSize: 1)).width)*2 > maxSize {
            self.removeFirst()
        }
    }
}

public extension String{
    var htmlToAttributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
}
