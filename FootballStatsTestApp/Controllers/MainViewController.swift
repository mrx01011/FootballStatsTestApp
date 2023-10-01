//
//  MainViewController.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 29.09.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    let mockMatchData = [MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: "ChelseaLogo", secondTeamImage: "ChelseaLogo", time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09"),
                         MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: "ChelseaLogo", secondTeamImage: "ChelseaLogo", time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09"),
                         MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: "ChelseaLogo", secondTeamImage: "ChelseaLogo", time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09"),
                         MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: "ChelseaLogo", secondTeamImage: "ChelseaLogo", time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09")]
    //MARK: UI elements
    private let headerImageView = UIImageView(image: UIImage(named: "MainVCHeader"))
    private let pathImageView = UIImageView(image: UIImage(named: "path125"))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "AER"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Black", size: 48)
        label.textAlignment = .left
        return label
    }()
    private let footballMatchesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(MatchCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        return collectionView
    }()
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
        setupUI()
        setupDelegates()
    }
    //MARK: Methods
    private func defaultConfigurations() {
        view.backgroundColor = UIColor(red: 0.141, green: 0.141, blue: 0.141, alpha: 1)
    }
    
    private func setupUI() {
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        headerImageView.addSubview(pathImageView)
        pathImageView.snp.makeConstraints { make in
            make.width.equalTo(350)
            make.height.equalTo(230)
            make.leading.equalToSuperview().offset(-28)
            make.bottom.equalTo(headerImageView.snp.top).offset(55)
        }
        headerImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(44)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        view.addSubview(footballMatchesCollectionView)
        footballMatchesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        view.bringSubviewToFront(headerImageView)
    }
    
    private func setupDelegates() {
        footballMatchesCollectionView.delegate = self
        footballMatchesCollectionView.dataSource = self
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockMatchData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? MatchCollectionViewCell else { return UICollectionViewCell() }
        cell.setData(mockMatchData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailMatchViewController(matchData: mockMatchData[indexPath.row])
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
//MARK: - Constants
extension MainViewController {
    enum Constants {
        static let cellIdentifier = "MatchCell"
    }
}