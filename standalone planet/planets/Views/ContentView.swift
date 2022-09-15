import SwiftUI

struct ContentView: View {
    var body: some View {
        PlanetList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
