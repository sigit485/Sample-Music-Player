//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit
import SwiftAudioEx
import Kingfisher

class HomeViewController: HomeBaseViewController, HomeViewOutput {
    
    private let player = AudioPlayer()
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
        
        searchField.delegate = self
    }
    
    func updateUI() {
        self.stopIndicatingActivity()
        self.tableView.reloadData()
    }
    
    
    @objc func didPlayTapped() {
        let audioItem = DefaultAudioItem(audioUrl: "https://github.com/rafaelreis-hotmart/Audio-Sample-files/raw/master/sample.mp3", sourceType: .stream)
        player.load(item: audioItem, playWhenReady: true)
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
