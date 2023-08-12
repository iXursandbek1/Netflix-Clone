//
//  SearchResultsViewController.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 12/08/23.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    private var titles: [Title] = [Title]()
    
    private let searchResultCollectioinView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectioinView)
        
        searchResultCollectioinView.delegate = self
        searchResultCollectioinView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultCollectioinView.frame = view.bounds
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.backgroundColor = .green
        return cell
    }
    
    
}
