//
//  ContentView.swift
//  Dakoo
//
//  Created by apple on 10/03/2023.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        
        let parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            // handle page loading completion
            
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            // handle page loading error
            
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
                     decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // handle links
            guard let url = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }
            let scheme = url.scheme?.lowercased()
            if scheme == "tel" || scheme == "mailto" || scheme == "whatsapp" {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                decisionHandler(.cancel)
            } else {
                decisionHandler(.allow)
            }
        }
        
    }
}




struct ContentView: View {
    
    let url = URL(string: "https://master.d1i420jov9ptun.amplifyapp.com/")!
    
    var body: some View {
        ZStack {
            WebView(url: url)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2.0, anchor: .center)
                .padding(16)
        }
        .onAppear {
            // show loader while page is loading
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
