//
//  SchoolSearchDepsProviding.swift
//  Afterschool
//
//  Created by 임영택 on 8/29/25.
//

import Foundation

protocol SchoolSearchDepsProviding {
    var navigationRouter: NavigationRouter { get }
    func getSchoolSearchViewModel() -> SchoolSearchViewModel
}
