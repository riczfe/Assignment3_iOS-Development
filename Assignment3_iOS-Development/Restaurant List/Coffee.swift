import SwiftUI

struct Coffee: View {
    @State private var restaurants: [Restaurant] = [] // Load your restaurant data here
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Coffee")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Image("promo1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                
                Text("Your Best Deals")
                    .font(.title)
                    .bold()
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(restaurants.filter { [9, 10, 11,12].contains($0.id) }) { restaurant in
                            NavigationLink(destination: RestaurantDetailScreen(restaurant: restaurant)) {
                                VStack {
                                    Image(restaurant.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(10)
                                    
                                    Text(restaurant.name)
                                        .font(.title3)
                                    
                                    Text(String(format: "Rating: %.1f", restaurant.rating))
                                        .font(.caption2)
                                        .foregroundColor(.gray)
                                    
                                    Button(action: {
                                        // Implement your favorite/love button action here
                                    }) {
                                        Image(systemName: "heart.fill") // Use "heart.fill" for a filled heart
                                            .font(.system(size: 20)) // Increase the font size for a bigger heart
                                            .foregroundColor(.red)
                                    }
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .frame(height: 180) // Adjust the height of the ScrollView container
                    .padding(.horizontal)
                }
                .frame(width: UIScreen.main.bounds.width) // Set the width of the ScrollView to match the screen width
            }
        }
        .onAppear {
            // Load your restaurant data here, similar to HomeScreen
            loadRestaurantData()
        }
    }
    
    private func loadRestaurantData() {
        if let path = Bundle.main.path(forResource: "restaurants", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decodedRestaurants = try JSONDecoder().decode([Restaurant].self, from: data)
                restaurants = decodedRestaurants
            } catch {
                print("Error loading restaurant data: \(error.localizedDescription)")
            }
        }
    }
}

struct Coffee_Previews: PreviewProvider {
    static var previews: some View {
        Coffee()
    }
}
