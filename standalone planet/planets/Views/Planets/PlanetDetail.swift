import SwiftUI

struct PlanetDetail: View {
    @EnvironmentObject var modelData: ModelData
    
    
    var planet: Planet

    var planetIndex: Int {
        modelData.planets.firstIndex(where: { $0.id == planet.id })!
    }

    var body: some View {
        
        ScrollView {
            Image("space")
                .resizable()
                .offset(y: 10)
                
            
             CircleImage(image: planet.image)
                .offset(y: -37)
                .scaleEffect(5)

            
            VStack(alignment: .leading) {
                HStack {
                    Text(planet.name)
                        .font(.title)
                    favoriteButton(isSet: $modelData.planets[planetIndex].isFavorite)
                }

                Divider()

                Text("About \(planet.name)")
                    .font(.title2)
                Text(planet.description)
            }
            .padding()
        }
        .navigationTitle(planet.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PlanetDetail_Previews: PreviewProvider {
    static var previews: some View {
        PlanetDetail(planet: ModelData().planets[0])
            .environmentObject(ModelData())
        
    }
}
