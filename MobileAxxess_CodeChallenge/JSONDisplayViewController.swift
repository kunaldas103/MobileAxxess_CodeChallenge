//
//  ViewController.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import UIKit
import SnapKit

class JSONDisplayViewController: UIViewController {
    lazy var jsonDisplayTableView = UITableView()
    let jsonDisplaycellId = CELL_ID
    var presenter: PresenterProtocol?
    private var jsonFieldsArr = Array<ResponseArray>()
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        
        jsonDisplayTableView.dataSource = self
        jsonDisplayTableView.delegate = self
        
        self.title = TITLE_JSON_FIELDS
        showActivityIndicator()
        setUpNavigationBar()
        presenter?.startFetchingJSONResponse()
    }
    
    private func setupTableView() {
        view.addSubview(jsonDisplayTableView)
        
        jsonDisplayTableView.snp.makeConstraints { (make) in
            make.top.equalTo(additionalSafeAreaInsets)
            make.bottom.equalTo(additionalSafeAreaInsets)
            make.left.equalTo(additionalSafeAreaInsets)
            make.right.equalTo(additionalSafeAreaInsets)
        }
        

        
        jsonDisplayTableView.register(JSONDisplayTableViewCell.self, forCellReuseIdentifier: jsonDisplaycellId)
    }
    
    private func showActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func setUpNavigationBar() {
        let sortBtn = UIBarButtonItem(title: "Sort By", style: .plain, target: self, action: #selector(showSortOption))
        self.navigationItem.rightBarButtonItems = [sortBtn]
    }
    
    @objc private func showSortOption() {
        if jsonFieldsArr.count > 0 {
            let alert = UIAlertController(title: "", message: "Please Select an Option", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Image", style: .default, handler: { (_) in
                self.jsonFieldsArr = self.jsonFieldsArr.sorted(by: {$0.type ?? "" < $1.type ?? ""})
                self.jsonDisplayTableView.reloadData()
            }))
            
            alert.addAction(UIAlertAction(title: "Text", style: .default, handler: { (_) in
                self.jsonFieldsArr = self.jsonFieldsArr.sorted(by: {$0.type ?? "" > $1.type ?? ""})
                self.jsonDisplayTableView.reloadData()
            }))
            
            
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
                
            }))
            
            self.present(alert, animated: true, completion: {
                
            })
        }
    }


}

extension JSONDisplayViewController: ViewProtocol {
    func displayJSONFields(responseArray: [ResponseArray]) {
        hideActivityIndicator()
        jsonFieldsArr = responseArray
        jsonDisplayTableView.reloadData()
    }
    
    func showError() {
        hideActivityIndicator()
        let alert = UIAlertController(title: "Error", message: "Unable to load the list",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension JSONDisplayViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: jsonDisplaycellId, for: indexPath) as! JSONDisplayTableViewCell
        cell.idLabel.text = "id: \(jsonFieldsArr[indexPath.row].id ?? "NA")"
        cell.idLabel.numberOfLines = 0
        
        cell.typeLabel.text = "type: \(jsonFieldsArr[indexPath.row].type ?? "NA")"
        cell.typeLabel.numberOfLines = 0
        
        cell.dateLabel.text = "date: \(jsonFieldsArr[indexPath.row].date ?? "NA")"
        cell.dateLabel.numberOfLines = 0
        
        cell.dataLabel.text = "data: \(jsonFieldsArr[indexPath.row].data ?? "NA")"
        cell.dataLabel.numberOfLines = 0
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navigationVC = navigationController else { return }
        presenter?.showDetailController(navigationController: navigationVC, data: jsonFieldsArr[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jsonFieldsArr.count
    }
}

