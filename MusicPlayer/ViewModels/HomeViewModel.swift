//
//  HomeViewModel.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import Foundation

protocol HomeViewOutput {
    func updateUI()
}

protocol HomeViewModelProtocol {
    var service: HomeServices? { get set }
    var songs: [HomeSongResult]? { get set }
    var view: HomeViewOutput? { get set }
    
    func getSongs(keyword: String?)
}

class HomeViewModel: HomeViewModelProtocol {
    
    var service: HomeServices?
    var songs: [HomeSongResult]?
    var view: HomeViewOutput?
    
    init(view: HomeViewOutput? = nil) {
        self.service = HomeServices()
        self.view = view
    }
    
    func getSongs(keyword: String?) {
        self.service?.getSongItunes(keyword: keyword, successHandler: { [weak self] song in
            self?.songs = song
            self?.view?.updateUI()
        })
    }
}
