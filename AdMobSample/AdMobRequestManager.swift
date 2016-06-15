//
//  AdMobRequestManager.swift
//  AdMobSample
//
//  Created by shoji on 2016/06/15.
//  Copyright © 2016年 com.shoji. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdMobRequestManager: NSObject {

    private let loader: GADAdLoader
    private let completion: (GADNativeAd -> Void)
    private let adUnitID = ""
    private var loading = false

    deinit {
        print("deinit AdMobRequestManager")
    }

    init(rootViewController: UIViewController, handler: (GADNativeAd -> Void)) {
        loader = GADAdLoader(
            adUnitID: adUnitID,
            rootViewController: rootViewController,
            adTypes: [kGADAdLoaderAdTypeNativeAppInstall, kGADAdLoaderAdTypeNativeContent],
            options: nil)
        completion = handler

        super.init()

        loader.delegate = self
    }
}


// MARK: - Request

extension AdMobRequestManager {

    func request() {
        guard !loading else { return }

        loading = true
        dispatch_async(dispatch_get_main_queue()) {
            let request = GADRequest()
            request.testDevices = [kGADSimulatorID]
            request.gender = .Female
            self.loader.loadRequest(request)
        }
    }
}


// MARK: - GADAdLoaderDelegate

extension AdMobRequestManager: GADAdLoaderDelegate {

    func adLoader(adLoader: GADAdLoader, didFailToReceiveAdWithError error: GADRequestError) {
        loading = false
    }
}


// MARK: - GADNativeAppInstallAdLoaderDelegate

extension AdMobRequestManager: GADNativeAppInstallAdLoaderDelegate {

    func adLoader(adLoader: GADAdLoader!, didReceiveNativeAppInstallAd nativeAppInstallAd: GADNativeAppInstallAd!) {
        loading = false
        completion(nativeAppInstallAd)
    }
}


// MARK: - GADNativeContentAdLoaderDelegate

extension AdMobRequestManager: GADNativeContentAdLoaderDelegate {

    func adLoader(adLoader: GADAdLoader!, didReceiveNativeContentAd nativeContentAd: GADNativeContentAd!) {
        loading = false
        completion(nativeContentAd)
    }
}
