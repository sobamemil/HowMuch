//
//  SMTP_SET.swift
//  얼마면 돼
//
//  Created by 심찬영 on 2021/12/02.
//

import Foundation
import SwiftSMTP

let smtp = SMTP(
    hostname: "smtp.gmail.com", email: "sieh96@gmail.com", password: "12qw4680"
)

//let mail_from = Mail.User(name: "test_from", email: "sieh96@gmail.com")
//let mail_to = Mail.User(name: "test_to", email: "sieh96@naver.com")
//
//let mail = Mail(from: mail_from, to: [mail_to], subject: "testMail", text: "testtesttesttesttesttesttesttest")
