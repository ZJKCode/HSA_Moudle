//
//  HSA_DetailController.swift
//  HSA_Moudle
//
//  Created by jikuan zhang on 2022/6/1.
//

import UIKit

//MARK: - 进入该页面需要进行传参演示
public class HSA_DetailController: UIViewController {
    /* 传参演示 */
    private var id: String
    private var name: String
    private var image: UIImage?
    
    /* 参数回调 */
    private var callBackParameters: (([String : Any]) -> Void)?
    
    private lazy var titleLabel = UILabel()
    private lazy var jumpButton = UIButton(type: .system)
    private lazy var backButton = UIButton(type: .system)
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "A_DetailController"
        self.view.backgroundColor = .orange
        
        setupUI()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    deinit {
        callBackParameters?(["deinit": "A_DetailController", "abc": "12321321313"])
    }
}

//MARK: - UI
extension HSA_DetailController {
    private func setupUI() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(jumpButton)
        self.view.addSubview(backButton)
        
        /* titleLabel */
        titleLabel.text = "A_DetailController \n id: \(id) \n name: \(name) \n image: \(image ?? UIImage())"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(100)
        }
        
        /* jumpButton */
        jumpButton.setTitle("点击 present B_Moudle.B_DetailController", for: .normal)
        jumpButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        jumpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
        
        /* backButton */
        backButton.setTitle("点击返回上一页", for: .normal)
        backButton.addTarget(self, action: #selector(clickBackButton), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jumpButton.snp.bottom).offset(20)
        }
    }
}

//MARK: - Action
extension HSA_DetailController {
    /**
     点击跳转按钮
     */
    @objc private func clickButton() {
        self.presentRouterControllerWithUrl("hsbpps://path/b/detail")
    }
    
    /**
     点击返回上一页
     */
    @objc private func clickBackButton() {
        self.dismissRouterController(animated: true)
    }
    
    /**
     重写该方法进行参数获取
     
     - parameter parameters: 传入的参数
     - parameter callBackParameters: 数据回调
     */
    public override class func routerController(_ parameters: [String : Any]? = nil, callBackParameters: (([String : Any]) -> Void)? = nil) -> UIViewController? {
        
        if let id = parameters?["id"] as? String,
           let name = parameters?["name"] as? String{ // 拿取参数
            
            // 可以使用任何方式自定义初始化传参的方式
            let vc = HSA_DetailController(id: id, name: name)
            vc.image = parameters?["image"] as? UIImage
            
            // 这个是传参回调，如果当前新的页面有参数需要返回上一个页面，则可以使用该闭包进行传参。
            // 如果没有的话可以不使用
            vc.callBackParameters = callBackParameters
            
            return vc
        }else {
            // 如果当前页面必须拿到参数才能跳转，则拿不到必要参数返回空页面
            // 当 Router 收到空页面时，会在 present 或 push 的时候发送错误通知，并停止跳转
            // 如果 app 监听了错误通知，可以手动弹出一个错误页面
            
            return nil
        }
    }
}
