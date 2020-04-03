//
//  AppleSignInRxExtension.swift
//  EazelIOS
//
//  Created by Pumpkin-Sweet Potato on 2020/04/03.
//  Copyright (c) RxSwiftCommunity
//

import Foundation
import RxSwift
import RxCocoa
import AuthenticationServices

@available(iOS 13.0, *)
open class RxAppleSignInDelegateProxy: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate>, DelegateProxyType, ASAuthorizationControllerDelegate {
    public weak private(set) var asAuthorizationController: ASAuthorizationController?
    
    var authorizationControllerSubject = PublishSubject<ASAuthorizationController>()
    var authorizationSubject = PublishSubject<ASAuthorization>()
    
    public init(asAuthorizationController: ParentObject) {
        self.asAuthorizationController = asAuthorizationController
        super.init(parentObject: asAuthorizationController, delegateProxy: RxAppleSignInDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxAppleSignInDelegateProxy(asAuthorizationController: $0) }
    }
    
    open class func currentDelegate(for object: ParentObject) -> ASAuthorizationControllerDelegate? {
        return object.delegate
    }
    
    open class func setCurrentDelegate(_ delegate: ASAuthorizationControllerDelegate?, to object: ParentObject) {
        object.delegate = delegate
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        authorizationControllerSubject.onNext(controller)
        authorizationSubject.onNext(authorization)
    }
    
    deinit {
        self.authorizationControllerSubject.onCompleted()
        self.authorizationSubject.onCompleted()
    }
}

@available (iOS 13.0, *)
extension Reactive where Base: ASAuthorizationController {
    public var delegate: DelegateProxy<ASAuthorizationController, ASAuthorizationControllerDelegate> {
        return self.authorizationControllerDelegate
    }
    
    public var authorization: Single<ASAuthorization> {
        let proxy = self.authorizationControllerDelegate
        proxy.authorizationSubject = PublishSubject<ASAuthorization>()
        return proxy.authorizationSubject
            .asObservable()
            .do(onSubscribed: {
                proxy.asAuthorizationController?.performRequests()
            })
            .take(1)
            .asSingle()
        
    }
    
    private var authorizationControllerDelegate: RxAppleSignInDelegateProxy {
        return RxAppleSignInDelegateProxy.proxy(for: base)
    }
}
