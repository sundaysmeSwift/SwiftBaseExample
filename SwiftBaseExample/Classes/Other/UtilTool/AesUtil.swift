//
//  AesUtil.swift
//  Quantbroker
//
//  Created by 曹亮亮 on 2019/11/25.
//  Copyright © 2019 huoju. All rights reserved.
//

import UIKit
import CryptoSwift

let keyStr:String = "1234123412ABCDEF"
let ivStr:String = "ABCDEF1234123412"

func aesEncryptedCBCStrBase64(text:String) -> String {
    do{
        let aesVar = try AES(key: keyStr.bytes, blockMode:CBC.init(iv: ivStr.bytes), padding: .pkcs7)
        let encryptedStr = try aesVar.encrypt(text.bytes)
        return "\(encryptedStr.toBase64() ?? "")"
    }catch{
        return ""
    }
    
}

func aesEncryptedCBCStrHex(text:String) -> String {
    do{
        let aesVar = try AES(key: keyStr.bytes, blockMode:CBC.init(iv: ivStr.bytes), padding: .pkcs7)
        let encryptedStr = try aesVar.encrypt(text.bytes)
        return "\(encryptedStr.toHexString() ?? "")"
    }catch{
        return ""
    }
    
}
