import SwiftUI
import CoreLocation

struct Restaurant: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let rating: Double
    let imageName: String
}

struct RestaurantDetailScreen: View {
    let restaurant: Restaurant

    var body: some View {
        ZStack(alignment: .top) {
            // Background image taking up to 35% of the screen
            Image(restaurant.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: UIScreen.main.bounds.height * 0.35)
                .clipped()

            VStack(alignment: .center, spacing: 16) {
                // Circular restaurant logo
                Image(restaurant.imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))

                Text(restaurant.name)
                    .font(.title)
                    .foregroundColor(.black)

                // Star ratings
                HStack(spacing: 4) {
                    ForEach(1...Int(restaurant.rating), id: \.self) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 18))
                            .foregroundColor(.yellow)
                    }
                    ForEach(1..<6 - Int(restaurant.rating), id: \.self) { _ in
                        Image(systemName: "star")
                            .font(.system(size: 18))
                            .foregroundColor(.yellow)
                    }
                }

                // Restaurant description
                Text(restaurant.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.25)
        }
        .navigationBarTitle("Restaurant Detail", displayMode: .inline)
    }
}



class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var currentLocationName: String = ""
    private let geocoder = CLGeocoder()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location updated")
        guard let location = locations.last else {
            print("No location data")
            return
        }
        // Perform UI updates on the main thread
        DispatchQueue.main.async { [weak self] in
            self?.currentLocation = location.coordinate
        }
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            // Perform UI updates on the main thread
            DispatchQueue.main.async { [weak self] in
                if let placemark = placemarks?.first {
                    self?.currentLocationName = placemark.name ?? placemark.locality ?? "Unknown Location"
                } else {
                    self?.currentLocationName = "Unknown Location"
                }
            }
        }
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

struct HomeScreen: View {
    @StateObject private var locationDelegate = LocationDelegate()
    @State private var locationManager = CLLocationManager()
    @State private var searchText = ""
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    
    @State private var restaurants: [Restaurant] = []
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text(locationDelegate.currentLocationName.isEmpty ? "Unknown Location" : locationDelegate.currentLocationName)
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: darkModeEnabled ? "moon.fill" : "sun.max.fill")
                        .font(.title)
                        .onTapGesture {
                            darkModeEnabled.toggle()
                        }
                        .foregroundColor(darkModeEnabled ? .yellow : .blue)
                    
                    NavigationLink(destination: Profile()) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                }
                .padding(.top, 40)
                .padding()
                .foregroundColor(Color.primary)
                
                SearchBar(text: $searchText)
                
                HStack {
                    NavigationLink(destination: Offer()){
                        VStack {
                            Image("offer")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding(.horizontal)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                            
                            Text("Offer")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    
                        NavigationLink(destination: Grocery()){
                            VStack {
                                Image("grocery")
                                    .resizable()
                                    .frame(width: 45, height: 45)
                                    .padding(.horizontal)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                
                                Text("Grocery")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    
                            NavigationLink(destination: Convenience()){
                                VStack {
                                    Image("convenience")
                                        .resizable()
                                        .frame(width: 45, height: 45)
                                        .padding(.horizontal)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                    
                                    Text("Convenience")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                    
                                NavigationLink(destination: Alcohol()){
                                    VStack {
                                        Image("alcohol")
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .padding(.horizontal)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                                        
                                        Text("Alcohol")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }
                                }
                }
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                HStack {
                    NavigationLink(destination: Trending()) {
                        VStack {
                            Image("trending")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding(.horizontal)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                            
                            Text("Trending")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                    }
                    NavigationLink(destination: Burger()){
                        VStack {
                            Image("burgers")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding(.horizontal)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                            
                            Text("Burgers")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    NavigationLink(destination: FastFood()){
                        VStack {
                            Image("fastfood")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding(.horizontal)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                            
                            Text("Fast Food")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    NavigationLink(destination: Coffee()){
                        VStack {
                            Image("coffee")
                                .resizable()
                                .frame(width: 45, height: 45)
                                .padding(.horizontal)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.gray, lineWidth: 3))
                            
                            Text("Coffee")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                }
                .padding(.horizontal)
                .padding()
                
                TabView {
                    Image("promo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Image("promo2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    Image("promo3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height: 240)
                .padding(.horizontal)
                .padding(.bottom, 10)
                
                Text("TRENDING CAFE(s) & RESTAURANTS")
                    .font(.title2)
                    .bold()
                    
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 20) {
                        ForEach(restaurants) { restaurant in
                            NavigationLink(destination: RestaurantDetailScreen(restaurant: restaurant)) {
                                VStack {
                                    Image(restaurant.imageName)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    
                                    Text(restaurant.name)
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
                                    
                                    Text(restaurant.description)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    
                                    Text(String(format: "Rating: %.1f", restaurant.rating))
                                                  .font(.caption2)
                                                  .foregroundColor(.gray)
                                }
                                .frame(width: 200, height: 200) // Adjust the frame size as needed
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(height: 200)
                .padding(.horizontal)
                .padding(.bottom, 40)
                
                Spacer()
            }
        }
        .onAppear {
            checkLocationAuthorization()
            loadRestaurantData()
        }
        .background(
            GeometryReader { geometry in
                Color.clear
                    .onAppear {
                        locationDelegate.currentLocation = locationManager.location?.coordinate
                    }
                    .onChange(of: locationDelegate.currentLocation, perform: { newValue in
                        // Handle location updates here if needed
                    })
            }
        )
        .environmentObject(locationDelegate)
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
    }
    
    private func checkLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = locationDelegate

            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
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

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            Button(action: {
                // Perform search action here
            }) {
                Image(systemName: "magnifyingglass")
                    .imageScale(.medium)
                    .foregroundColor(.gray)
                    .padding(.trailing, 8)
            }
        }
        .padding(.bottom, 20)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
