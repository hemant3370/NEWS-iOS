//
//  UISearchController+Rx.swift
//  RxCocoa
//
//  Created by Segii Shulga on 3/17/16.
//  Copyright © 2016 Krunoslav Zaher. All rights reserved.
//

#if os(iOS)
    
#if !RX_NO_MODULE
    import RxSwift
#endif
    import UIKit

    extension UISearchController {
        /// Factory method that enables subclasses to implement their own `delegate`.
        ///
        /// - returns: Instance of delegate proxy that wraps `delegate`.
        public func createRxDelegateProxy() -> RxSearchControllerDelegateProxy {
            return RxSearchControllerDelegateProxy(parentObject: self)
        }
    }
    
    @available(iOS 8.0, *)
    extension Reactive where Base: UISearchController {
        /// Reactive wrapper for `delegate`.
        /// For more information take a look at `DelegateProxyType` protocol documentation.
        public var delegate: DelegateProxy {
            return RxSearchControllerDelegateProxy.proxyForObject(base)
        }

        /// Reactive wrapper for `delegate` message.
        public var didDismiss: Observable<Void> {
            return delegate
                .methodInvoked( #selector(UISearchControllerDelegate.didDismissSearchController(_:)))
                .map {_ in}
        }

        /// Reactive wrapper for `delegate` message.
        public var didPresent: Observable<Void> {
            return delegate
                .methodInvoked(#selector(UISearchControllerDelegate.didPresentSearchController(_:)))
                .map {_ in}
        }

        /// Reactive wrapper for `delegate` message.
        public var present: Observable<Void> {
            return delegate
                .methodInvoked( #selector(UISearchControllerDelegate.presentSearchController(_:)))
                .map {_ in}
        }

        /// Reactive wrapper for `delegate` message.
        public var willDismiss: Observable<Void> {
            return delegate
                .methodInvoked(#selector(UISearchControllerDelegate.willDismissSearchController(_:)))
                .map {_ in}
        }
        
        /// Reactive wrapper for `delegate` message.
        public var willPresent: Observable<Void> {
            return delegate
                .methodInvoked( #selector(UISearchControllerDelegate.willPresentSearchController(_:)))
                .map {_ in}
        }
        
    }
    
#endif