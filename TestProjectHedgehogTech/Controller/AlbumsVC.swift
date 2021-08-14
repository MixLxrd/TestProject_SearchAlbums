//
//  AlbumsVC.swift
//  TestProjectHedgehogTech
//
//  Created by Михаил on 12.08.2021.
//

import UIKit
import WebKit
import Kingfisher

class AlbumsVC: UIViewController {
    
    let networkDataFetcher = NetworkDataFetcher()
    var searchResponse: SearchResponse? = nil
    private var timer: Timer?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AlbumsCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: AlbumsCollectionViewCell.self))
        collectionView.toAutoLayout()
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private lazy var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

extension AlbumsVC {
    private func setupLayout() {
        view.addSubview(collectionView)
        title = "Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension AlbumsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var offset: CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: (UIScreen.main.bounds.width - offset * 4) / 2, height: (UIScreen.main.bounds.width - offset * 4) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, left: offset, bottom: offset, right: offset)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResponse?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AlbumsCollectionViewCell.self), for: indexPath) as! AlbumsCollectionViewCell
        let unsortedAlbums = searchResponse?.results
        let sortedAlbums = unsortedAlbums?.sorted(by: {$0.collectionName < $1.collectionName})
        let album = sortedAlbums?[indexPath.row]
        cell.albumLabel.text = album?.collectionName
        let urlAlbum = URL(string: album?.artworkUrl100 ?? "")
        DispatchQueue.main.async {
            cell.albumsImageView.kf.setImage(with: urlAlbum)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
        let unsortedAlbums = searchResponse?.results
        let sortedAlbums = unsortedAlbums?.sorted(by: {$0.collectionName < $1.collectionName})
        let album = sortedAlbums?[indexPath.row]
        let urlAlbum = URL(string: album?.collectionViewUrl ?? "")
        
        let request = URLRequest(url: urlAlbum!)
        let vc = DetailAlbumsVC()
        vc.request = request
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension AlbumsVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard let text = searchController.searchBar.text else { return }
        let urlString = "https://itunes.apple.com/search?term=\(text)&media=music&entity=album"
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.networkDataFetcher.fetchAlbums(urlString: urlString) { response in
                guard let search = response else { return }
                self.searchResponse = search
                self.collectionView.reloadData()
            }
        })
        
    }
}
