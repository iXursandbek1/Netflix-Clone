//
//  DowloandsViewController.swift
//  Netflix Clone
//
//  Created by Xursandbek Qambaraliyev on 09/08/23.
//

import UIKit

class DownloandsViewController: UIViewController {
    
    private var titles: [TitleItem] = [TitleItem]()
    
    private let downloadedTable: UITableView = {
        let tableView = UITableView()
        tableView.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(downloadedTable)
        downloadedTable.delegate = self
        downloadedTable.dataSource = self
        fetchLocalStorageForDownload()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
    }
    
    private func fetchLocalStorageForDownload() {
        
        DataPersistenceManager.share.fetchingTitlesFromDataBase {[weak self] result in
            
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadedTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        downloadedTable.frame = view.bounds
    }
}

extension DownloandsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let titleName = title.original_name ?? title.original_title ?? "Unknown title name"
        cell.configure(with: TitleViewModel(titleName: titleName, posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle {
        case .delete:
            
            DataPersistenceManager.share.deleteTitleWith(model: titles[indexPath.row]) {[weak self] result in
                
                switch result {
                case .success():
                    print("Delate from DataBase")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
        default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_name ?? title.original_title else { return }
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeVideo: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
