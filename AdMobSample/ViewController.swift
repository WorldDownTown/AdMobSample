//
//  ViewController.swift
//  AdMobSample
//
//  Created by shoji on 2016/06/15.
//  Copyright © 2016年 com.shoji. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UITableViewController {

    private let textCellIdentifier = "cell"
    private let admobCellIdentifier = "AdMobCell"
    private let frequency = 10
    private var admobManager: AdMobRequestManager!
    private var ads = [GADNativeAd]()

    deinit {
        print("deinit ViewController")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: textCellIdentifier)
        tableView.registerClass(AdMobCell.self, forCellReuseIdentifier: admobCellIdentifier)
        setupAdMobManager()
    }
}


// MARK: - Private

extension ViewController {

    private func setupAdMobManager() {
        admobManager = AdMobRequestManager(rootViewController: self) { [weak self] ad in
            self?.ads.append(ad)
            self?.tableView.reloadData()
        }
    }

    private func ad(row row: Int) -> GADNativeAd? {
        let index = row / frequency
        return ads.count > index ? ads[index] : nil
    }

    private func isAd(indexPath: NSIndexPath) -> Bool {
        return indexPath.row % frequency == frequency - 1
    }

    private func shouldRequest(indexPath: NSIndexPath) -> Bool {
        let preloadCount = ads.count - indexPath.row / frequency
        let threshold = 3
        return preloadCount < threshold
    }
}


// MARK: - UITableViewDataSource

extension ViewController {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 500
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if shouldRequest(indexPath) {
            admobManager.request()
        }

        if isAd(indexPath) {
            let cell = tableView.dequeueReusableCellWithIdentifier(admobCellIdentifier, forIndexPath: indexPath) as! AdMobCell
            cell.admob = ad(row: indexPath.row)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath)
            cell.textLabel?.text = "\(indexPath.row)"
            return cell
        }
    }
}


// MARK: - UITableViewDelegate

extension ViewController {

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isAd(indexPath) {
            if let _ = ad(row: indexPath.row) {
                return 105.0
            } else {
                return 0.0
            }
        } else {
            return 44.0
        }
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if isAd(indexPath) {
            return
        }

        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
