//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit
import Kingfisher
import SwiftAudioEx

class HomeViewController: HomeBaseViewController, HomeViewOutput {
    
    private var vm: HomeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        vm = HomeViewModel(view: self)
        initTableView()
        setupListener()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        startIndicatingActivity()
        vm?.getSongs(keyword: nil)
    }
    
    func initTableView() {
        tableView.register(HomeMusicCell.self, forCellReuseIdentifier: HomeMusicCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupListener() {
        homeMiniView.playPauseButton.addTarget(
            self,
            action: #selector(didPlayTapped),
            for: .touchUpInside
        )
        
        homeMiniView.forwardButton.addTarget(
            self,
            action: #selector(didNextTapped),
            for: .touchUpInside
        )
        
        homeMiniView.backwardButton.addTarget(
            self,
            action: #selector(didPreviousTapped),
            for: .touchUpInside
        )
        
        searchField.delegate = self
    }
    
    func updateUI() {
        self.stopIndicatingActivity()
        self.tableView.reloadData()
    }
    
    func updateStateUI(state: AudioPlayerState) {
        DispatchQueue.main.async {
            switch state {
            case .playing:
                self.homeMiniView.setupState(.paused)
            case .paused:
                self.homeMiniView.setupState(.play)
            case .stopped:
                self.homeMiniView.setupState(.play)
            default:
                break
            }
        }
    }
    
    
    @objc func didPlayTapped() {
        if vm?.isPlaying == true {
            vm?.pause()
        } else {
            vm?.resume()
        }
    }
    
    @objc func didNextTapped() {
        vm?.next()
    }
    
    @objc func didPreviousTapped() {
        vm?.previous()
    }
    


}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm?.songs?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeMusicCell.identifier, for: indexPath) as! HomeMusicCell
        
        let data = vm?.songs?[indexPath.row]
        cell.artistLabel.text = data?.artistName ?? "Unknown"
        cell.songNameLabel.text = data?.trackName ?? "-"
        
        if let urlImage = URL(string: data?.artworkUrl60 ?? "") {
            cell.artworkImageView.kf.indicatorType = .activity
            cell.artworkImageView.kf.setImage(with: urlImage, options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        }
        
        
        return cell
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        vm?.play(index: indexPath.row)        
    }
}



extension HomeViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            startIndicatingActivity()
            vm?.getSongs(keyword: text)
        } else {
            startIndicatingActivity()
            vm?.getSongs(keyword: nil)
        }
    }
}
