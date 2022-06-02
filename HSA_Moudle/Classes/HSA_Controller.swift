//
//  HSA_ViewController.swift
//  HSA_Moudle
//
//  Created by jikuan zhang on 2022/6/1.
//

import UIKit
import SnapKit

//MARK: - 进入该页面不需要传入参数的演示
public class HSA_Controller: UIViewController {
    
    private lazy var titleLabel = UILabel()
    private lazy var jumpButton = UIButton(type: .system)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "A_Controller"
        self.view.backgroundColor = .white
        
        setupUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

//MARK: - UI
extension HSA_Controller {
    private func setupUI() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(jumpButton)
        
        titleLabel.text = "A_Controller"
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        jumpButton.setTitle("点击 push A_Moudle.A_DetailController", for: .normal)
        jumpButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        jumpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
}

//MARK: - Action
extension HSA_Controller {
    /**
     点击跳转按钮
     */
    @objc private func clickButton() {
        let datailParameters: [String: Any] = ["id": "id123", "name": "name123", "image": UIImage()]
        self.pushRouterControllerWithUrl("hsapps://path/a/detail", parameters: datailParameters, animated: true) { parameters in
            // 页面参数回调
            print("==========")
            print("页面参数回调")
            print("当前页面: A_Controller")
            print("参数来自: apps://pathA_Detail")
            print("参数内容: \(parameters)")
            print("==========")
        }
    }
}

