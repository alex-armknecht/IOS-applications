import SwiftUI

struct PlanetRow: View {
    var planet: Planet
    
    var body: some View {
        HStack {
            CircleImage(image: planet.image)
                .frame(width: 65, height: 65)
                

            Text(planet.name)

            Spacer()
            
            if planet.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct PlanetRow_Previews: PreviewProvider {
    static var planets = ModelData().planets

    static var previews: some View {
        Group {
            PlanetRow(planet: planets[0])
            PlanetRow(planet: planets[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
