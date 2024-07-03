//
//  SemaphoreViewController.swift
//  TrafficLights
//
//  Created by Alin Petrus on 02.07.2024.
//

import Combine
import UIKit

final class SemaphoreViewController: UIViewController {
    private let viewModel: SemaphoreViewModel
    private var disposables: Set<AnyCancellable> = Set()
    private var trafficLightsView: TrafficLightsView
    
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
        self.trafficLightsView = TrafficLightsView(redConfiguration: viewModel.redLightConfiguration,
                                                   orangeConfiguration: viewModel.orangeLightConfiguration,
                                                   greenConfiguration: viewModel.greenLightConfiguration)
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.addSubview(self.trafficLightsView)
        self.trafficLightsView.setActiveLight(self.viewModel.currentLight)
        
        self.setupBindings()
        self.setupConstraints()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = self.viewModel.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.viewModel.startSemaphore()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.viewModel.invalidate()
    }
    
}

private extension SemaphoreViewController {
    
    func setupBindings() {
        self.viewModel.$currentLight
            .sink { [weak self] light in
                guard let self else { return }
                
                self.trafficLightsView.setActiveLight(light)
            }
            .store(in: &self.disposables)
    }
    
    func setupConstraints() {
        self.trafficLightsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, 
                                                    constant: 64.0).isActive = true
        self.trafficLightsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -64.0).isActive = true
        self.trafficLightsView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,
                                                        constant: 16.0).isActive = true
        self.trafficLightsView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor,
                                                         constant: -16.0).isActive = true
    }
}
