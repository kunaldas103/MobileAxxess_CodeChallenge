//
//  DetailViewController.swift
//  MobileAxxess_CodeChallenge
//
//  Created by Kunal Das on 26/09/20.
//  Copyright © 2020 Kunal Das. All rights reserved.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {

    var dataToDisplay: ResponseArray?
    var presenter: DetailPresenterProtocol?
    private var activityIndicator = UIActivityIndicatorView()
    
    private var imageView = UIImageView()
    private var label = UILabel()
    private var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = TITLE_DETAIL
        setUpScrollView()
        if let dataUnwrapped = dataToDisplay, let type = dataUnwrapped.type, let dataToShow = dataUnwrapped.data {
            if type == IMAGE {
                setUpImageView()
                showActivityIndicatory()
                presenter?.startFetchingImageData(imageUrl: dataToShow)
            } else {
                setUpLabel()
                showTextData()
            }
        }
        // Do any additional setup after loading the view.
    }
    
    private func setUpScrollView() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            scrollView.snp.makeConstraints { (make) in
                make.top.equalTo(additionalSafeAreaInsets)
                make.bottom.equalTo(additionalSafeAreaInsets)
                make.left.equalTo(additionalSafeAreaInsets)
                make.right.equalTo(additionalSafeAreaInsets)
            }
        }
    }
    
    private func setUpImageView() {
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
        
        imageView.contentMode = .scaleAspectFit
    }
    
    private func setUpLabel() {
        scrollView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(10)
            make.bottom.equalTo(scrollView).offset(-10)
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
        }
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  .black
        label.numberOfLines = 0
    }
    
    private func showTextData() {
        label.text = dataToDisplay?.data ?? ""
    }
    
    private func showActivityIndicatory() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: DetailViewProtocol {
    func displayImage(imageData: Data) {
        hideActivityIndicator()
        imageView.image = UIImage(data: imageData)
    }
    
    func showError() {
        hideActivityIndicator()
        let alert = UIAlertController(title: "Error", message: "Unable to load image",
                                      preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {[weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
