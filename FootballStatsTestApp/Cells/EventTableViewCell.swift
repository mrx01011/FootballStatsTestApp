//
//  EventCollectionViewCell.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 30.09.2023.
//

import UIKit
import SnapKit

final class EventTableViewCell: UITableViewCell {
    //MARK: Constraints
    private var imageLeadingConstraint: Constraint?
    private var imageTrailingConstraint: Constraint?
    private var eventLeadingConstraint: Constraint?
    private var eventTrailingConstraint: Constraint?
    private var minuteLeadingConstraint: Constraint?
    private var minuteTrailingConstraint: Constraint?
    //MARK: UI elements
    private let eventImageView = UIImageView()
    private let eventTextLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.green
        label.font = GlobalConstants.Fonts.bold12
        return label
    }()
    private let eventMinuteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.bold12
        return label
    }()
    private let outerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = -1
        return stackView
    }()
    private let firstPlayerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    private let secondPlayerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    private let firstPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.regular14
        return label
    }()
    private let secondPlayerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.regular14
        return label
    }()
    private let replaceInLabel: UILabel = {
        let label = UILabel()
        label.text = "IN"
        label.textAlignment = .left
        label.textColor = GlobalConstants.Colors.green
        label.font = GlobalConstants.Fonts.regular14
        return label
    }()
    private let replaceOutLabel: UILabel = {
        let label = UILabel()
        label.text = "OUT"
        label.textColor = GlobalConstants.Colors.red
        label.font = GlobalConstants.Fonts.regular14
        return label
    }()
    //MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultConfigurations()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Methods
    func setData(_ data: EventData) {
        eventImageView.image = UIImage(named: data.imageName)
        eventTextLabel.text = data.event
        eventMinuteLabel.text = data.minute
        firstPlayerLabel.text = data.firstPlayer
        updateConstraints(with: Team(rawValue: data.team) ?? .first)
        if let secondPlayer = data.secondPlayer {
            secondPlayerLabel.text = secondPlayer
        } else {
            secondPlayerStackView.removeArrangedSubview(replaceInLabel)
            secondPlayerStackView.removeArrangedSubview(replaceOutLabel)
            firstPlayerStackView.removeArrangedSubview(secondPlayerLabel)
 
            replaceInLabel.removeFromSuperview()
            replaceOutLabel.removeFromSuperview()
            secondPlayerLabel.removeFromSuperview()
        }
        outerStackView.setNeedsUpdateConstraints()
        outerStackView.layoutIfNeeded()
    }
    
    private func setupUI() {
        contentView.addSubview(eventImageView)
        eventImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            imageLeadingConstraint = make.leading.equalToSuperview().offset(12).priority(.high).constraint
            imageTrailingConstraint = make.trailing.equalToSuperview().inset(12).priority(.low).constraint
            make.width.height.equalTo(20)
        }
        contentView.addSubview(eventTextLabel)
        eventTextLabel.snp.makeConstraints { make in
            make.centerY.equalTo(eventImageView)
            eventLeadingConstraint = make.leading.equalTo(eventImageView.snp.trailing).offset(8).priority(.high).constraint
            eventTrailingConstraint = make.trailing.equalTo(eventImageView.snp.leading).inset(-8).priority(.low).constraint
        }
        contentView.addSubview(eventMinuteLabel)
        eventMinuteLabel.snp.makeConstraints { make in
            make.centerY.equalTo(eventTextLabel)
            minuteTrailingConstraint = make.trailing.equalToSuperview().inset(12).priority(.high).constraint
            minuteLeadingConstraint = make.leading.equalToSuperview().offset(12).priority(.low).constraint
        }
        firstPlayerStackView.addArrangedSubview(replaceInLabel)
        firstPlayerStackView.addArrangedSubview(firstPlayerLabel)
        secondPlayerStackView.addArrangedSubview(replaceOutLabel)
        secondPlayerStackView.addArrangedSubview(secondPlayerLabel)
        outerStackView.addArrangedSubview(firstPlayerStackView)
        outerStackView.addArrangedSubview(secondPlayerStackView)
        contentView.addSubview(outerStackView)
        outerStackView.snp.makeConstraints { make in
            make.top.equalTo(eventImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
    private func updateConstraints(with team: Team) {
        switch team {
        case .first:
            outerStackView.alignment = .leading
            eventTrailingConstraint?.update(priority: .low)
            imageTrailingConstraint?.update(priority: .low)
            minuteLeadingConstraint?.update(priority: .low)
            eventLeadingConstraint?.update(priority: .high)
            imageLeadingConstraint?.update(priority: .high)
            minuteTrailingConstraint?.update(priority: .high)
        case .second:
            outerStackView.alignment = .trailing
            eventLeadingConstraint?.update(priority: .low)
            imageLeadingConstraint?.update(priority: .low)
            minuteTrailingConstraint?.update(priority: .low)
            eventTrailingConstraint?.update(priority: .high)
            imageTrailingConstraint?.update(priority: .high)
            minuteLeadingConstraint?.update(priority: .high)
        }
    }
    
    private func defaultConfigurations() {
        selectionStyle = .none
        backgroundColor = GlobalConstants.Colors.dark
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = GlobalConstants.Colors.border
    }
}
//MARK: - State
extension EventTableViewCell {
    enum Team: Int {
        case first
        case second
    }
}
