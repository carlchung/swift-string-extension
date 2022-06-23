//
//  String+AddingPercentEncoding.swift
//  ReEcho
//
//  Created by carl on 21/07/2020.
//  Copyright © 2020 reecho. All rights reserved.
//

import Foundation

extension String {
  func stringByAddingPercentEncodingForRFC3986() -> String? {
    let unreserved = "-._~?"
    let allowed = NSMutableCharacterSet.alphanumeric()
    allowed.addCharacters(in: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
  }
}
