//
//  GenreVO.swift
//  Movie
//
//  Created by THEIN PYAE PHYO on 2020/12/07.
//  Copyright © 2020 THEIN PYAE PHYO. All rights reserved.
//

import Foundation
import RealmSwift

class GenreVO: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
}
