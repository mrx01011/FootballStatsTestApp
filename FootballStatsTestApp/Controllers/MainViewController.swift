//
//  MainViewController.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 29.09.2023.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    private let mockMatchData = [MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: GlobalConstants.Images.chelseaLogo, secondTeamImage: GlobalConstants.Images.chelseaLogo, time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09"),
                         MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC Royal Phoenix FC Royal Phoenix FC Royal Phoenix FC ", secondTeamName: "Royal Phoenix FC ", firstTeamImage: GlobalConstants.Images.chelseaLogo, secondTeamImage: GlobalConstants.Images.chelseaLogo, time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09"),
                         MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: GlobalConstants.Images.chelseaLogo, secondTeamImage: GlobalConstants.Images.chelseaLogo, time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09"),
                         MatchData(score: "1:2", firstTeamName: "Royal Phoenix FC", secondTeamName: "Royal Phoenix FC", firstTeamImage: GlobalConstants.Images.chelseaLogo, secondTeamImage: GlobalConstants.Images.chelseaLogo, time: "18:00", minuteMatch: "59'", league: "London Blitz", date: "29.09")]
    //MARK: UI elements
    private let headerImageView = UIImageView(image: UIImage(named: GlobalConstants.Images.mainVCHeader))
    private let pathImageView = UIImageView(image: UIImage(named: GlobalConstants.Images.headerVector))
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "AER"
        label.textColor = .white
        label.font = GlobalConstants.Fonts.black48
        label.textAlignment = .left
        return label
    }()
    private let footballMatchesTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MatchTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        return tableView
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
        view.backgroundColor = GlobalConstants.Colors.black
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
        view.addSubview(footballMatchesTableView)
        footballMatchesTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
        view.bringSubviewToFront(headerImageView)
    }
    
    private func setupDelegates() {
        footballMatchesTableView.delegate = self
        footballMatchesTableView.dataSource = self
    }
}
//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? MatchTableViewCell else { return UITableViewCell() }
        cell.setData(mockMatchData[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMatchViewController(matchData: mockMatchData[indexPath.section])
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mockMatchData.count
    }
   
}
//MARK: - Constants
extension MainViewController {
    enum Constants {
        static let cellIdentifier = "MatchCell"
    }
}
