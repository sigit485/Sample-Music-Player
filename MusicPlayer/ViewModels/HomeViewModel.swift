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
    func updateSlider(position: Double?, maxTime: Double?, elapsedTime: Double?)
}

protocol HomeViewModelProtocol {
    var service: HomeServices? { get set }
    var songs: [HomeSongResult]? { get set }
    var view: HomeViewOutput? { get set }
    var player: QueuedAudioPlayer? { get set }
    var isPlaying: Bool? { get set }
    var currentTitleSong: String? { get set }
    
    func getSongs(keyword: String?)
    func play(index: Int)
    func next()
    func previous()
    func pause()
    func resume()
    func seek(to: TimeInterval)
}

class HomeViewModel: HomeViewModelProtocol {
    var player: QueuedAudioPlayer?
    var service: HomeServices?
    var songs: [HomeSongResult]?
    var view: HomeViewOutput?
    var isPlaying: Bool?
    var currentTitleSong: String?
    
    init(view: HomeViewOutput? = nil) {
        self.service = HomeServices()
        self.view = view
        self.player = QueuedAudioPlayer()
        self.player?.event.playWhenReadyChange.addListener(self, handlePlayWhenReadyChange)
        self.player?.event.stateChange.addListener(self, handleAudioPlayerStateChange(state:))
        self.player?.event.updateDuration.addListener(self, handleAudioPlayerUpdateDuration(data:))
        self.player?.event.secondElapse.addListener(self, handleAudioPlayerSecondElapsed)
    }
    
    private func renderTimes() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let position = player?.currentTime
            let maxTime = player?.duration
//            let elapsedTime = player?.currentTime.secondsToString()
//            let remainingTime = ((player?.duration ?? 0) - (player?.currentTime ?? 0)).secondsToString()
            
            view?.updateSlider(
                position: position,
                maxTime: maxTime,
                elapsedTime: player?.currentTime
            )
        }
    }
    
    func handlePlayWhenReadyChange(data: AudioPlayer.PlayWhenReadyChangeData) {
        print("playWhenReady=\(data)")
        self.currentTitleSong = self.player?.currentItem?.getTitle()
        view?.updateUI()
    }

    
    func handleAudioPlayerUpdateDuration(data: AudioPlayer.UpdateDurationEventData) {
        renderTimes()
    }
    
    func handleAudioPlayerSecondElapsed(data: AudioPlayer.SecondElapseEventData) {
        renderTimes()
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
            return DefaultAudioItem(audioUrl: $0.previewURL ?? "", artist: $0.artistName, title: $0.trackName, sourceType: .stream)
        } ?? []
        
        player?.clear()
        player?.add(items: items, playWhenReady: false)
        
        try? player?.jumpToItem(atIndex: index, playWhenReady: true)
    }
    
    func next() {
        player?.next()
        currentTitleSong = self.player?.currentItem?.getTitle()
        view?.updateUI()
    }
    
    func previous() {
        player?.previous()
        currentTitleSong = self.player?.currentItem?.getTitle()
        view?.updateUI()
    }
    
    func pause() {
        player?.pause()
    }
    
    func resume() {
        player?.play()
    }
    
    func seek(to time: TimeInterval) {
        guard isPlaying == true else { return }
        player?.seek(to: time)
    }
}
