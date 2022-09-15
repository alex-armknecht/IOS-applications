import SwiftUI

struct PlanetList: View {

    @EnvironmentObject var modelData: ModelData
    @State private var showRealPlanetsOnly = false
    @State private var showFavoritePlanetsOnly = false
    
    @State private var angle: Double = 0
    let imageSource = UIImage(named:"sources")
    
    var filteredPlanets: [Planet] {
        modelData.planets.filter { planet in
            ((!showFavoritePlanetsOnly || planet.isFavorite) && (!showRealPlanetsOnly || planet.isReal))
        }
    }

    var body: some View {
        
        NavigationView {
            List {
                Button("By Alex and Abe (click me!)") {
                            angle += 360
                        }
                .padding()
                .rotationEffect(.degrees(angle))
                .animation(.spring(), value: angle)


                Toggle(isOn: $showFavoritePlanetsOnly) {
                    Text("Favorite Planets")
                }
                Toggle(isOn: $showRealPlanetsOnly) {
                    Text("Real planets only")
                }

                ForEach(filteredPlanets) { planet in
                    NavigationLink {
                        PlanetDetail(planet: planet)
                    } label: {
                        PlanetRow(planet: planet)
                    }
                }
            }
            .navigationTitle("Planets")
        }
    }
}

struct PlanetList_Previews: PreviewProvider {
    static var previews: some View {
        PlanetList()
            .environmentObject(ModelData())
    }
}
