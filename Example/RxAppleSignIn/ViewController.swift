//
//  ViewController.swift
//  RxAppleSignIn
//
//  Created by Minsoo Kim on 04/03/2020.
//  Copyright (c) 2020 Minsoo Kim. All rights reserved.
//

import UIKit
import RxSwift
import AuthenticationServices


class ViewController: UIViewController {
    
    let authorizationButton = ASAuthorizationAppleIDButton(frame: CGRect(origin: CGPoint(x: 100, y: 200), size: .zero))
    let authorizationController: ASAuthorizationController = {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        return authorizationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bind()
        
        authorizationController.presentationContextProvider = self
    }
    
    func configureView() {
        view.addSubview(authorizationButton)
        
        authorizationButton.center = view.center
        
    }
    
    func bind() {
        _ = authorizationButton.rx.controlEvent(.touchUpInside)
            .takeUntil(self.rx.deallocating)
            .subscribe(onNext: { [weak self] _ in
                self?.authorizationController.performRequests()
            })
        
        _ = authorizationController.rx.authorization
            .subscribe(onSuccess: { asAuthorization in
                print("asAuthorization \(asAuthorization)")
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}


@available(iOS 13.0, *)
extension ViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
