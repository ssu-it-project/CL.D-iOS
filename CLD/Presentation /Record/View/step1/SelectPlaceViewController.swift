//
//  SelectPlaceViewController.swift
//  CLD
//
//  Created by 이조은 on 2023/07/29.
//

import UIKit

import SnapKit

final class SelectPlaceViewController: BaseViewController {
    var placeText: String = ""
    var climbing_gym_id: String = ""
    var gymsArr: [ClimbingGym] = []
    var gymsCount = 0
    
    private let dotDivider: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.dotDivider
        view.tintColor = .CLDDarkDarkGray
        view.backgroundColor = nil
        return view
    }()
    private let searchIconView: UIImageView = {
        let view = UIImageView()
        view.image = ImageLiteral.searchIcon
        view.image = view.image?.withRenderingMode(.alwaysTemplate)
        view.tintColor = .CLDGray
        view.backgroundColor = nil
        return view
    }()
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "장소를 입력해주세요."
        textField.font = UIFont(name: "Roboto-Regular", size: 15)
        textField.textColor = .CLDBlack
        textField.backgroundColor = .CLDLightGray
        textField.borderStyle = .none
        return textField
    }()
    private let underLine: CALayer = {
        let border = CALayer()
        border.frame = CGRect(x: 0, y: 30, width: 312, height: 1)
        border.backgroundColor = UIColor.CLDGold.cgColor
        return border
    }()
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: CGFloat.leastNonzeroMagnitude))
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.identifier)

        return tableView
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        tableView.isHidden = true
        self.view.endEditing(true)
    }

    // 리턴 키를 눌렀을 때 호출되는 메서드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 여기에서 검색 동작을 수행하도록 코드를 작성
        let searchKeyword: String = searchTextField.text ?? ""
        getGyms(searchKeyword,9, 0)
        tableView.isHidden = false
        return true
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        searchTextField.delegate = self
        searchTextField.returnKeyType = .search
        tableView.delegate = self
        tableView.dataSource = self

        searchTextField.addLeftPadding()
        searchTextField.addLeftImageGray(image: ImageLiteral.searchIcon)
        searchTextField.layer.addSublayer((underLine))

        tableView.isHidden = true
        setHierarchy()
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        placeText = searchTextField.text ?? ""
    }
    
    override func setHierarchy() {
        self.view.addSubviews(searchTextField, dotDivider, tableView)
    }
    
    override func setConstraints() {
        dotDivider.snp.makeConstraints {
            $0.top.equalToSuperview().inset(77)
            $0.height.equalTo(1)
            $0.leading.trailing.equalToSuperview().inset(19)
        }
        searchTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(101)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(312)
            $0.height.equalTo(31)
        }
        tableView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(7)
            $0.leading.equalToSuperview().inset(25)
            $0.width.equalTo(312)
            $0.height.equalTo(200)
        }
    }
}

extension SelectPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if gymsCount == 0 {
            tableView.setEmptyMessage("검색 결과가 없습니다.")
            return 0
        } else if gymsCount < 8 {
            tableView.restore()
            return gymsCount
        } else {
            tableView.restore()
            return 8
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.identifier, for: indexPath) as! PlaceTableViewCell
        cell.selectionStyle = .none
        cell.placeLabel.text = self.gymsArr[indexPath.row].place.name
        climbing_gym_id = self.gymsArr[indexPath.row].id
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchTextField.text = self.gymsArr[indexPath.row].place.name
        //클릭한 셀의 이벤트 처리
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
extension SelectPlaceViewController: UITextFieldDelegate {

}

extension SelectPlaceViewController {
    private func getGyms(_ keyword: String, _ limit: Int, _ skip: Int) {
        NetworkService.shared.gyms.getGyms(keyword: keyword, limit: limit, skip: skip) { [weak self] result in
                switch result {
                case .success(let response):

                    guard let data = response as? GetGymsDTO
                    else {
                        self?.gymsCount = 0
                        self?.gymsArr = []
                        self?.tableView.reloadData()
                        return
                    }
                    self?.gymsCount = data.pagination.total
                    self?.gymsArr = data.climbingGyms
                    self?.tableView.reloadData()

                case .requestErr(let errorResponse):
                    dump(errorResponse)
                    guard let data = errorResponse as? ErrorResponse else { return }
                    print(data.message)
                case .pathErr:
                    print("pathErr")
                case .serverErr:
                    print("serverErr")
                case .networkFail:
                    print("networkFail")
                }
            }
        }
}
