import SwiftUI
import WebKit

// 1. Create a UIViewRepresentable for WKWebView
struct WebView: UIViewRepresentable {
    @Binding var urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
               webConfiguration.preferences.setValue(true, forKey: "developerExtrasEnabled")
               
               let webView = WKWebView(frame: .zero, configuration: webConfiguration)
               return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct ContentView: View {
    @State private var urlString: String = "https://secure-me.au10tixservices.com/app.html?api=aHR0cHM6Ly9ldXMtYXBpLmF1MTB0aXhzZXJ2aWNlcy5jb20vc2VjdXJlLW1lL3Yy&bcd=%231f1d2a&bcl=%23ffffff&isWebView=true&pc=%23040024&themeName=light&token=OpX9FeaC0y4oHDfpYkaZ" // Default URL
    
    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlString, onCommit: {
                // Hide keyboard
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()  // This padding respects safe areas by default
            
            WebView(urlString: $urlString)
                .edgesIgnoringSafeArea(.all)  // Only the WebView will ignore safe areas
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
