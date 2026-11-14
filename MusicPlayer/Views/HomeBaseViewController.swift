//
//  HomeBaseViewController.swift
//  MusicPlayer
//
//  Created by Sigit on 14/11/26.
//

import UIKit

class HomeBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initConstraint()
    }
    

    private func initConstraint() {
        view.addSubview(headerView)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            headerView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        headerView.addSubview(searchField)
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            searchField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            searchField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            searchField.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10)
        ])
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        view.addSubview(homeMiniView)
        NSLayoutConstraint.activate([
            homeMiniView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            homeMiniView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            homeMiniView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let searchField: UISearchTextField = {
        let view = UISearchTextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    
    
    lazy var homeMiniView: HomeMiniPlayerView = {
        let view = HomeMiniPlayerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
}
