//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2022 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import XCTest
import SwiftSyntax
import SwiftSyntaxBuilder

final class StringLiteralTests: XCTestCase {
  func testStringLiteral() {
    let leadingTrivia = Trivia.unexpectedText("␣")
    let testCases: [UInt: (String, String)] = [
      #line: ("", #"␣"""#),
      #line: ("asdf", #"␣"asdf""#)
    ]

    for (line, testCase) in testCases {
      let (value, expected) = testCase
      let string = Token.stringSegment(value)
      let segment = StringSegment(content: string)
      let builder = StringLiteralExpr(leadingTrivia: leadingTrivia,
                                      openQuote: .stringQuote,
                                      segments: StringLiteralSegments([segment]),
                                      closeQuote: .stringQuote)

      AssertBuildResult(builder, expected, line: line)
    }
  }
}
