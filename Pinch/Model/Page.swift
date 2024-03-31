//
//  Page.swift
//  Pinch
//
//  Created by Hasan on 3/31/24.
//

import Foundation


struct Page : Identifiable {
    let id : Int
    let imageName : String
}


extension Page {
    var thumbName : String {
        return "thumb-" + imageName
    }
}
