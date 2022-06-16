//
//  AboutUsVC.swift
//  WalkinsAvailable
//
//  Created by apple on 29/04/22.
//

import UIKit
import WebKit

class AboutUsVC: UIViewController {

//    MARK: OUTLETS
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var wkWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicator.sharedInstance.showActivityIndicator()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func loadData() {
        // loading URL :
        let myBlog = "https://dharmani.com/WalkIns/about.php"
        let url = NSURL(string: myBlog)
        let request = NSURLRequest(url: url! as URL)
        wkWebView.navigationDelegate = self
        ActivityIndicator.sharedInstance.hideActivityIndicator()
        wkWebView.load(request as URLRequest)
    }
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}


//MARK: - WKNavigationDelegate
extension AboutUsVC: WKNavigationDelegate {
    func webView(webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError) {
        print(error.localizedDescription)
    }
    
    func webView(webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
    }

}
