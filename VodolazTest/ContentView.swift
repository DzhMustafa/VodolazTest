import SwiftUI

struct ContentView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        TabView(selection: $tabIndex) {
            VStack {
                MainView()
            }
            .tabItem { Image(systemName: "house") }
            
            VStack {
                Text("MainView")
            }
            .tabItem { Image(systemName: "text.magnifyingglass") }
            
            VStack {
                Text("MainView")
            }
            .tabItem { Image(systemName: "basket") }
            
            VStack {
                Text("MainView")
            }
            .tabItem { Image(systemName: "heart") }
            
            VStack {
                Text("MainView")
            }
            .tabItem { Image(systemName: "person") }
        }
    }
}

#Preview {
    ContentView()
}
