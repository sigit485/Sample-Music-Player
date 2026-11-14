//
//  HomeViewModel.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import Foundation
import SwiftAudioEx

protocol HomeViewOutput {
    func updateUI()
    func updateStateUI(state: AudioPlayerState)
}

protocol HomeViewModelProtocol {
    var service: HomeServices? { get set }
    var songs: [HomeSongResult]? { get set }
    var view: HomeViewOutput? { get set }
    var player: QueuedAudioPlayer? { get set }
    var isPlaying: Bool? { get set }
    
    func getSongs(keyword: String?)
    func play(index: Int)
    func next()
    func previous()
    func pause()
    func resume()
}

class HomeViewModel: HomeViewModelProtocol {
    var player: QueuedAudioPlayer?
    var service: HomeServices?
    var songs: [HomeSongResult]?
    var view: HomeViewOutput?
    var isPlaying: Bool?
    
    init(view: HomeViewOutput? = nil) {
        self.service = HomeServices()
        self.view = view
        self.player = QueuedAudioPlayer()
        self.player?.event.stateChange.addListener(self, handleAudioPlayerStateChange(state:))
    }
    
    func handleAudioPlayerStateChange(state: AudioPlayerState) {
        self.isPlaying = false
        
        switch state {
        case .playing:
            self.isPlaying = true
            self.view?.updateStateUI(state: state)
        case .paused:
            self.view?.updateStateUI(state: state)
        default:
            break
        }
    }
    
    func getSongs(keyword: String?) {
        self.service?.getSongItunes(keyword: keyword, successHandler: { [weak self] song in
            self?.songs = song
            self?.view?.updateUI()
        })
    }
    
    func play(index: Int) {
        self.view?.updateStateUI(state: .stopped)
        
        let items = songs?.map {
            return DefaultAudioItem(audioUrl: $0.previewURL ?? "", sourceType: .stream)
        } ?? []
        
        player?.clear()
        player?.add(items: items, playWhenReady: false)
        
        try? player?.jumpToItem(atIndex: index, playWhenReady: true)
    }
    
    func next() {
        player?.next()
    }
    
    func previous() {
        player?.previous()
    }
    
    func pause() {
        player?.pause()
    }
    
    func resume() {
        player?.play()
    }
}
