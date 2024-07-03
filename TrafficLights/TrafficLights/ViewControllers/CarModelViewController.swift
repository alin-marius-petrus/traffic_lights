//
//  CarModelViewController.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Combine
import UIKit

final class CarModelViewController: UIViewController {
    
    private var disposables: Set<AnyCancellable> = Set()
    private let button: UIButton = UIButton(type: .system)
    private let textView: UITextView = UITextView()
    private let textFont = UIFont.systemFont(ofSize: 18)
    
    // MARK: - Initializers
    
    private let viewModel: CarDetailViewModel
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Use the designated initializer with a datasource")
    }
    
    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Use the designated initializer with a datasource")
    }
    
    init(viewModel: CarDetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Car Model"
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.textView)
        self.view.addSubview(self.button)
        
        self.textView.textContainer.maximumNumberOfLines = 1
        self.textView.textColor = .black
        self.textView.layer.borderWidth = 1.0
        self.textView.layer.borderColor = UIColor.lightGray.cgColor
        self.textView.font = self.textFont
        self.textView.delegate = self
        self.button.setTitle("Start Driving", for: .normal)
        self.button.addTarget(self, action: #selector(onStartDriving), for: .touchUpInside)
        
        self.addConstraints()
        self.setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.textView.becomeFirstResponder()
    }

}

// MARK: - Private

private extension CarModelViewController {
    
    @objc 
    func onStartDriving() {
        self.viewModel.onStartDriving()
    }
    
    func addConstraints() {
        self.textView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                               constant: 32.0).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -32.0).isActive = true
        self.textView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,
                                           constant: 32.0).isActive = true
        let insets = self.textView.textContainerInset.top + self.textView.textContainerInset.bottom
        let height = self.textFont.lineHeight + insets
        self.textView.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.button.topAnchor.constraint(equalTo: self.textView.bottomAnchor, constant: 32.0).isActive = true
    }
    
    func setupBindings() {
        self.viewModel.$state
            .sink { [weak self] state in
                guard let self else { return }
                
                self.button.isEnabled = state.isValid
            }
            .store(in: &self.disposables)
    }
}

extension CarModelViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        self.viewModel.updateModelName(textView.text)
    }
    
}
