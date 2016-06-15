//
//  AdMobCell.swift
//  AdMobSample
//
//  Created by shoji on 2016/06/15.
//  Copyright © 2016年 com.shoji. All rights reserved.
//

import UIKit
import GoogleMobileAds

class AdMobCell: UITableViewCell {

    var admob: GADNativeAd? {
        didSet { updateLayout() }
    }

    override func sizeThatFits(size: CGSize) -> CGSize {
        if admob == nil {
            return CGSize.zero
        }

        return CGSize(width: size.width, height: 105.0)
    }

    private func updateLayout() {
        contentView.subviews.forEach { $0.removeFromSuperview() }

        switch admob {
        case let ad as GADNativeContentAd: updateLayoutWithContentAd(ad)
        case let ad as GADNativeAppInstallAd: updateLayoutWithAppInstallAd(ad)
        default: break
        }
    }

    private func updateLayoutWithContentAd(ad: GADNativeContentAd) {
        let adView = NSBundle.mainBundle().loadNibNamed("AdMobNativeContentAdView", owner: nil, options: nil).first as! GADNativeContentAdView
        contentView.addSubview(adView)
        contentView.addConstraintsForAllEdgesWithItem(adView)

        adView.nativeContentAd = ad
        adView.headlineLabel?.text = ad.headline
        adView.bodyLabel?.text = ad.body
        adView.mainImageView?.image = ad.mainImage
        adView.advertiserLabel?.text = ad.advertiser
        adView.callToActionButton?.setTitle(ad.callToAction, forState: .Normal)
        adView.callToActionButton?.userInteractionEnabled = false
        adView.logoImageView?.image = ad.logoImage
    }

    private func updateLayoutWithAppInstallAd(ad: GADNativeAppInstallAd) {
        let adView = NSBundle.mainBundle().loadNibNamed("AdMobNativeAppInstallAdView", owner: nil, options: nil).first as! GADNativeAppInstallAdView
        contentView.addSubview(adView)
        contentView.addConstraintsForAllEdgesWithItem(adView)

        adView.nativeAppInstallAd = ad
        adView.headlineLabel?.text = ad.headline
        adView.iconImageView?.image = ad.iconImage
        adView.bodyLabel?.text = ad.body
        adView.mainImageView?.image = ad.mainImage
        adView.callToActionButton?.setTitle(ad.callToAction, forState: .Normal)
        adView.callToActionButton?.userInteractionEnabled = false
        adView.starRatingImageView?.image = ad.starRatingImage
        adView.storeLabel?.text = ad.store
        adView.priceLabel?.text = ad.price
    }
}


// MARK: - GADNativeContentAdView

private extension GADNativeContentAdView {

    var headlineLabel: UILabel? { return headlineView as? UILabel }
    var bodyLabel: UILabel? { return bodyView as? UILabel }
    var mainImageView: UIImageView? { return imageView as? UIImageView }
    var logoImageView: UIImageView? { return logoView as? UIImageView }
    var callToActionButton: UIButton? { return callToActionView as? UIButton }
    var advertiserLabel: UILabel? { return advertiserView as? UILabel }
}


// MARK: - GADNativeAppInstallAdView

private extension GADNativeAppInstallAdView {

    var headlineLabel: UILabel? { return headlineView as? UILabel }
    var callToActionButton: UIButton? { return callToActionView as? UIButton }
    var iconImageView: UIImageView? { return iconView as? UIImageView }
    var bodyLabel: UILabel? { return bodyView as? UILabel }
    var storeLabel: UILabel? { return storeView as? UILabel }
    var priceLabel: UILabel? { return priceView as? UILabel }
    var mainImageView: UIImageView? { return imageView as? UIImageView }
    var starRatingImageView: UIImageView? { return starRatingView as? UIImageView }
}


// MARK: - GADNativeContentAd

private extension GADNativeContentAd {

    var mainImage: UIImage? { return (images?.first as? GADNativeAdImage)?.image }
    var logoImage: UIImage? { return logo?.image }
}


// MARK: - GADNativeAppInstallAd

private extension GADNativeAppInstallAd {

    var mainImage: UIImage? { return (images?.first as? GADNativeAdImage)?.image }
    var iconImage: UIImage? { return icon?.image }
    var starRatingImage: UIImage? {
        guard let rating = starRating?.floatValue else { return nil }

        switch rating {
        case 5.0..<Float.infinity:
            return UIImage(named: "stars_5")
        case 4.5..<5.0:
            return UIImage(named: "stars_4_5")
        case 4.0..<4.5:
            return UIImage(named: "stars_4")
        case 3.5..<4.0:
            return UIImage(named: "stars_3_5")
        default:
            return nil
        }
    }
}
