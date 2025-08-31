//
//  MainDepsProviding.swift
//  Afterschool
//
//  Created by 임영택 on 8/28/25.
//

import Foundation

protocol MainDepsProviding {
    var navigationRouter: NavigationRouter { get }
    func getMainViewModel() -> MainViewModel
}
