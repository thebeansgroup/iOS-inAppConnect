//
//  ViewController.swift
//  SBConnectDemo
//
//  Created by Jack Smith on 13/11/2020.
//

import UIKit
import SBConnect

class ViewController: UIViewController {
    // MARK: - UI Elements
    
    lazy var connectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.setTitleColor(.palette(.uiBlue300), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.buttonFontSize)
        button.addTarget(self, action: #selector(didTapConnect), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    var sbConnect: SBConnectProtocol.Type = SBConnect.self
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        layout()
    }

    // MARK: - Public Methods
    
    func configure() {
        view.backgroundColor = .white
    }
    
    func layout() {
        view.addSubview(connectButton)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        connectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc func didTapConnect() {
        sbConnect.connect(presentingViewController: nil,
                          slug: Constants.dummySlug,
                          countryCode: Constants.dummyCountryCode) { [weak self] response in
            self?.handleSBConnectResponse(response)
        }
    }
    
    // MARK: - Private Methods
    
    private func presentErrorAlert(_ error: SBConnectError) {
        let alertController = UIAlertController(title: Constants.errorTitle,
                                                message: error.errorDescription,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: Constants.errorActionText, style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    private func handleSBConnectResponse(_ response: SBConnectResponse) {
        switch response {
        case .success(let discountCode):
            print("User retrieved discount code: \(discountCode ?? "")")
        case .failure(let error):
            print("Error: \(error.self) - \(error.errorDescription ?? "")")
            presentErrorAlert(error)
        case .closed:
            print("User exited SBConnect.")
        }
    }
}

// MARK: - Constants

extension ViewController {
    private struct Constants {
        static let buttonFontSize: CGFloat = 24
        static let dummySlug = "gymshark"
        static let dummyCountryCode = "uk"
        static let buttonTitle = "Connect"
        static let errorTitle = "Uh Oh!"
        static let errorActionText = "Okay"
    }
}
