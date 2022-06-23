//
//  String+SplitIntoTags.swift
//  ReEcho Dev
//
//  Created by carl on 19/10/2020.
//  Copyright © 2020 reecho. All rights reserved.
//

import Algorithms
import Foundation

extension String {
    func splitIntoTags() -> [String] {
        let separators = CharacterSet(charactersIn: ",;")
        if self == "" || self == " " {
            return []
        }
        return components(separatedBy: separators).filter { $0.count > 0 }
    }

    func splitTagsInChunksOf(num: Int) -> [[String]] {
        let chunks = self.splitIntoTags().chunks(ofCount: num)
        return chunks.map { Array($0) }
    }
}
