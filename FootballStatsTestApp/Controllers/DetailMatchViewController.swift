//
//  DetailMatchViewController.swift
//  FootballStatsTestApp
//
//  Created by MacBook on 29.09.2023.
//

import UIKit
import SnapKit

final class DetailMatchViewController: UIViewController {
    private let mockEvents = [EventData(imageName: "yellowCard", event: "YELLOW CARD", minute: "89❜", firstPlayer: "Ryan Botosh", secondPlayer: nil, team: 0),
                              EventData(imageName: "ball", event: "GOAL!!!", minute: "81❜", firstPlayer: "Corey Westervelt", secondPlayer: nil, team: 1),
                              EventData(imageName: "redCard", event: "RED CARD", minute: "76❜", firstPlayer: "Jaylon Carder", secondPlayer: nil, team: 0),
                              EventData(imageName: "switch", event: "REPLACE", minute: "72❜", firstPlayer: "Jaylon Carder", secondPlayer: "Scott Herwitz", team: 0),
                              EventData(imageName: "yellowCard", event: "YELLOW CARD", minute: "68❜", firstPlayer: "Scott Herwitz", secondPlayer: nil, team: 1),
                              EventData(imageName: "yellowCard", event: "YELLOW CARD", minute: "66❜", firstPlayer: "Corey Westervelt", secondPlayer: nil, team: 0)]
    private let mockH2H = [H2HData(date: "23.09", firstTeamImage: GlobalConstants.Images.chelseaLogo, firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: GlobalConstants.Images.chelseaLogo, secondTeam: "Harbor City FC", secondTeamScore: "4"),
                           H2HData(date: "23.09", firstTeamImage: GlobalConstants.Images.chelseaLogo, firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4"),
                           H2HData(date: "23.09", firstTeamImage: "ChelseaLogo", firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4"),
                           H2HData(date: "23.09", firstTeamImage: "ChelseaLogo", firstTeam: "Harbor City FC", firstTeamScore: "3", secondTeamImage: "ChelseaLogo", secondTeam: "Harbor City FC", secondTeamScore: "4")]
    private var state: TypeActivity = .events {
        didSet {
            infoTableView.reloadData()
        }
    }
    //MARK: UI elements
    private let headerImageView = UIImageView(image: UIImage(named: "DetailVCHeader"))
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: GlobalConstants.Images.leftArrow), for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = GlobalConstants.Colors.whiteTransparent02
        return button
    }()
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dots"), for: .normal)
        return button
    }()
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = GlobalConstants.Colors.dark
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = GlobalConstants.Colors.border
        return view
    }()
    private let leagueLabel: UILabel = {
        let label = UILabel()
        label.font = GlobalConstants.Fonts.regular12
        return label
    }()
    private let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = -1
        return stack
    }()
    private let verticalFirstTeamStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    private let verticalStatsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    private let verticalSecondTeamStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 0
        return stack
    }()
    private let firstTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let secondTeamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let firstTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = GlobalConstants.Fonts.condensedMedium16
        return label
    }()
    private let secondTeamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = GlobalConstants.Fonts.condensedMedium16
        return label
    }()
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = GlobalConstants.Fonts.heavy32
        return label
    }()
    private let timeFromStartLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.green
        label.font = GlobalConstants.Fonts.bold17
        return label
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.whiteTransparent05
        label.font = GlobalConstants.Fonts.regular12
        return label
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = GlobalConstants.Colors.whiteTransparent05
        label.font = GlobalConstants.Fonts.regular12
        return label
    }()
    private let eventsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
        let button = UIButton()
        button.setTitle("Events", for: .normal)
        button.layer.cornerRadius = 16
        button.isHighlighted = false
        button.configuration = configuration
        button.titleLabel?.font = GlobalConstants.Fonts.medium17
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = GlobalConstants.Colors.green
        return button
    }()
    private let h2hButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16)
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 16
        button.configuration = configuration
        button.setTitle("H2H", for: .normal)
        button.titleLabel?.font = GlobalConstants.Fonts.medium17
        button.setTitleColor(GlobalConstants.Colors.green, for: .normal)
        button.backgroundColor = GlobalConstants.Colors.greenTransparent
        return button
    }()
    private let infoTableView: UITableView = {
        let tableView = UITableView()
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: Constants.eventCellIdentifier)
        tableView.register(h2hTableViewCell.self, forCellReuseIdentifier: Constants.h2hCellIdentifier)
        return tableView
    }()
    lazy private var activityButtons = [eventsButton, h2hButton]
    //MARK: Initialization
    init(matchData: MatchData) {
        super.init(nibName: nil, bundle: nil)
        leagueLabel.attributedText = configureLeagueLabelTextColor(labelText: matchData.league)
        firstTeamImageView.image = UIImage(named: matchData.firstTeamImage)
        firstTeamLabel.text = matchData.firstTeamName
        secondTeamLabel.text = matchData.secondTeamName
        secondTeamImageView.image = UIImage(named: matchData.secondTeamImage)
        scoreLabel.attributedText = configureScoreLabelTextColor(labelText: matchData.score)
        timeFromStartLabel.text = matchData.minuteMatch
        timeLabel.text = matchData.time
        dateLabel.text = matchData.date
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultConfigurations()
        setupUI()
        addTargets()
        setupDelegates()
    }
    //MARK: Methods
    private func defaultConfigurations() {
        view.backgroundColor = GlobalConstants.Colors.black
    }
    
    private func configureScoreLabelTextColor(labelText: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: labelText)
        attributedText.addAttribute(.foregroundColor, value: GlobalConstants.Colors.whiteTransparent05, range: NSRange(location: 0, length: 1))
        
        return attributedText
    }
    
    private func configureLeagueLabelTextColor(labelText: String) -> NSMutableAttributedString {
        let newLabelText = "League: " + labelText
        let attributedText = NSMutableAttributedString(string: newLabelText)
        attributedText.addAttribute(.foregroundColor, value: GlobalConstants.Colors.whiteTransparent05, range: NSRange(location: 0, length: 7))
        attributedText.addAttribute(.foregroundColor, value: GlobalConstants.Colors.green, range: NSRange(location: 6, length: newLabelText.count - 6))
        return attributedText
    }
    
    private func addTargets() {
        eventsButton.addTarget(self, action: #selector(activitySelected(_:)), for: .touchUpInside)
        h2hButton.addTarget(self, action: #selector(activitySelected(_:)), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func setupDelegates() {
        infoTableView.delegate = self
        infoTableView.dataSource = self
    }
    
    private func setupUI() {
        view.addSubview(headerImageView)
        headerImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(38)
        }
        headerImageView.addSubview(moreButton)
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(backButton)
        }
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(90)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        containerView.addSubview(leagueLabel)
        leagueLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
        }
        //first team vertical stack
        verticalFirstTeamStackView.addArrangedSubview(firstTeamImageView)
        verticalFirstTeamStackView.addArrangedSubview(firstTeamLabel)
        //stats vertical stack
        verticalStatsStackView.addArrangedSubview(scoreLabel)
        verticalStatsStackView.addArrangedSubview(timeFromStartLabel)
        //second team vertical stack
        verticalSecondTeamStackView.addArrangedSubview(secondTeamImageView)
        verticalSecondTeamStackView.addArrangedSubview(secondTeamLabel)
        //horizontal stack
        horizontalStackView.addArrangedSubview(verticalFirstTeamStackView)
        horizontalStackView.addArrangedSubview(verticalStatsStackView)
        horizontalStackView.addArrangedSubview(verticalSecondTeamStackView)
        
        containerView.addSubview(horizontalStackView)
        horizontalStackView.snp.makeConstraints { make in
            make.top.equalTo(leagueLabel).offset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        containerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(horizontalStackView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().inset(12)
        }
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(timeLabel)
            make.trailing.equalToSuperview().inset(24)
        }
        view.addSubview(eventsButton)
        view.addSubview(h2hButton)
        eventsButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        h2hButton.snp.makeConstraints { make in
            make.leading.equalTo(eventsButton.snp.trailing).offset(10)
            make.centerY.equalTo(eventsButton)
        }
        view.addSubview(infoTableView)
        infoTableView.snp.makeConstraints { make in
            make.top.equalTo(eventsButton.snp.bottom).offset(22)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
        }
    }
    
    private func getSelectedActivity() -> TypeActivity {
        for (index, button) in activityButtons.enumerated() {
            if button.backgroundColor == GlobalConstants.Colors.green {
                return TypeActivity(rawValue: index) ?? .events
            }
        }
        return .events
    }
    
    @objc private func activitySelected(_ sender: UIButton) {
        activityButtons.forEach({
            $0.titleLabel?.textColor = GlobalConstants.Colors.green
            $0.backgroundColor = GlobalConstants.Colors.greenTransparent
        })
        
        sender.backgroundColor = GlobalConstants.Colors.green
        sender.setTitleColor(.white, for: .normal)
        
        state = getSelectedActivity()
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension DetailMatchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch state {
        case .events:
            return mockEvents.count
        case .h2h:
            return mockH2H.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch state {
        case .events:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.eventCellIdentifier, for: indexPath) as? EventTableViewCell else { return UITableViewCell() }
            cell.setData(mockEvents[indexPath.section])
            return cell
        case .h2h:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.h2hCellIdentifier, for: indexPath) as? h2hTableViewCell else { return UITableViewCell() }
            cell.setData(mockH2H[indexPath.section])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
}
//MARK: - State
extension DetailMatchViewController {
    enum TypeActivity: Int {
        case events
        case h2h
    }
}
//MARK:
extension DetailMatchViewController {
    enum Constants {
        static let eventCellIdentifier = "EventsCell"
        static let h2hCellIdentifier = "H2HCell"
    }
}
