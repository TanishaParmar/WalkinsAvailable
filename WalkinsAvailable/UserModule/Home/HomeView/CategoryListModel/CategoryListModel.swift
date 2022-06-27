//
//  CategoryListModel.swift
//  WalkinsAvailable
//
//  Created by MyMac on 6/27/22.
//

import Foundation

// MARK: - CategoryListModel
class CategoryListModel: Codable {
    var code, status: Int?
    var message: String?
    var data: [CategoryList]?

}

class CategoryList: Codable {
    var businessTypeId, title, image, imageBgcolor: String?
    var bgColor, textColor, disable: String?

}
