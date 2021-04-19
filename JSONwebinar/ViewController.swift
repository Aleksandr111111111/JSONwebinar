//
//  ViewController.swift
//  JSONwebinar
//
//  Created by Aleksander Kulikov on 17.03.2021.
//

import UIKit

class ViewController: UIViewController {
    let networkService = NetworkDataFetcher()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    

    @IBOutlet weak var table: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setapTableView()
        setapSearchBar()
        
        
    }
//    func request(urlString: String, completion: @escaping (SearchResponse?, Error?) -> Void) {

    
    private func setapSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
        
    }
    
        private func setapTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let track = searchResponse?.results[indexPath.row]
        cell.textLabel?.text = track?.trackName
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=5"
//        request(urlString: urlString) { (searchResponse, Error) in
//            searchResponse?.results.map({ (track) in
//                print(track.trackName)
//            })
//        }
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.networkService.fetchTracks(urlString: urlString) { (searchResponse) in
                guard let searchResponse = searchResponse else { return }
                self.searchResponse = searchResponse
                self.table.reloadData()
            }
//            self.networkService.request(urlString: urlString) { [weak self] (result) in
//                switch result {
//                case .success(let searhResponse):
//                    self?.searchResponse = searhResponse
//                    self?.table.reloadData()
//    //                searhResponse.results.map { (track) in
//    //                    print("track.trackName:", track.trackName)
//    //                }
//                case .failure(let error):
//                    print("error:", error)
//                }
//            }
        })
    }
    
}







