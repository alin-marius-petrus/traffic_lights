//
//  SemaphoreViewController.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import UIKit

final class SemaphoreViewController: UIViewController {
    private let viewModel: SemaphoreViewModel
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Use the designated initializer with a datasource")
    }
    
    @available(*, unavailable)
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        fatalError("Use the designated initializer with a datasource")
    }
    

    init(viewModel: SemaphoreViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = self.viewModel.title
    }
    
}
