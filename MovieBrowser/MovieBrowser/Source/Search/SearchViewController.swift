//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var network: NetworkType = NetworkManager()
    var movies: [Movie] = [] {
        didSet {
            guard self.movies != oldValue else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    private func setupUI() {
        self.title = "Movie Search"
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseID)
        
    }
    
    @IBAction func goButtonSelected(_ sender: Any) {
        self.getMovies()
    }
    
    private func getMovies() {
        guard let query = self.searchBar.text else { return }
        
        if query.isEmpty {
            self.movies = []
            return
        }
        
        self.network.fetch(url: NetworkParams.movieSearch(query: query).url) { [weak self] (result: Result<PageResult, Error>) in
            switch result {
            case .success(let page):
                self?.movies = page.results
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.reuseID, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(movie: self.movies[indexPath.row])
        return cell
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = MovieDetailViewController.createVC() else { return }
        vc.movie = self.movies[indexPath.row]
        vc.network = self.network
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
