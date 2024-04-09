//
//  TagsModel.swift
//  Swift-Karaoke
//
//  Created by Ruiyang Chen on 2024/4/8.
//

import SwiftUI

struct TagsModel: Identifiable {
    var id: UUID = .init()
    var tag: String
}

var sampleTagList: [TagsModel] = [
    TagsModel(tag: "Romance"),
    TagsModel(tag: "Feel Good"),
    TagsModel(tag: "Party"),
    TagsModel(tag: "Relax"),
    TagsModel(tag: "Commute"),
    TagsModel(tag: "Workout"),
    TagsModel(tag: "Sad"),
    TagsModel(tag: "Focus")
]

