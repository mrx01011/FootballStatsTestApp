//
//  h2hCollectionViewCell.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 01.10.2023.
//

import UIKit
import SnapKit

final class h2hCollectionViewCell: UICollectionViewCell {
    private let firstTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Royal Phoenix FC"
        label.textColor = .white
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        return label
    }()
    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.text = "Royal Phoenix FC"
        label.textColor = .white
        label.font = UIFont(name: "SFProText-Regular", size: 14)
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "23.09"
        label.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        return label
    }()
    private let firstTeamImageView = UIImageView(image: UIImage(named: "ChelseaLogo"))
    private let secondTeamImageView = UIImageView(image: UIImage(named: "ChelseaLogo"))
    private let firstTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "3"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        return label
    }()
    private let secondTeamScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        return label
    }()
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultConfigurations()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    func setData(date: String, firstTeamImage: String, firstTeam: String, firstTeamScore: String, secondTeamImage: String, secondTeam: String, secondTeamScore: String) {
        dateLabel.text = date
        firstTeamImageView.image = UIImage(named: firstTeamImage)
        firstTeamLabel.text = firstTeam
        firstTeamScoreLabel.text = firstTeamScore
        secondTeamImageView.image = UIImage(named: secondTeamImage)
        secondTeamLabel.text = secondTeam
        secondTeamScoreLabel.text = secondTeamScore
    }
    
    private func defaultConfigurations() {
        backgroundColor = UIColor(red: 0.184, green: 0.184, blue: 0.184, alpha: 1)
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 1).cgColor
    }
    
    private func setupUI() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(firstTeamImageView)
        contentView.addSubview(firstTeamLabel)
        contentView.addSubview(firstTeamScoreLabel)
        contentView.addSubview(secondTeamImageView)
        contentView.addSubview(secondTeamLabel)
        contentView.addSubview(secondTeamScoreLabel)
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.centerY.equalToSuperview()
        }
        firstTeamImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(dateLabel.snp.trailing).offset(12)
            make.width.height.equalTo(24)
        }
        secondTeamImageView.snp.makeConstraints { make in
            make.top.equalTo(firstTeamImageView.snp.bottom).offset(12)
            make.leading.equalTo(dateLabel.snp.trailing).offset(12)
            make.width.height.equalTo(24)
        }
        firstTeamLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstTeamImageView)
            make.leading.equalTo(firstTeamImageView.snp.trailing).offset(8)
        }
        secondTeamLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondTeamImageView)
            make.leading.equalTo(secondTeamImageView.snp.trailing).offset(8)
        }
        firstTeamScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(firstTeamLabel)
            make.trailing.equalToSuperview().inset(12)
        }
        secondTeamScoreLabel.snp.makeConstraints { make in
            make.centerY.equalTo(secondTeamLabel)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
