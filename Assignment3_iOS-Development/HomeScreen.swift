import SwiftUI
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
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
    
    var body: some View {
        NavigationView {
            VStack {
                // Top navigation bar
                HStack {
                    // User's current location
                    if let location = locationDelegate.currentLocation {
                        Text("Current Location: \(location.latitude), \(location.longitude)")
                            .font(.headline)
                    } else {
                        Text("Unknown Location")
                            .font(.headline)
                    }
                    
                    Spacer()
                    
                    // Profile icon
                    NavigationLink(destination: Profile()) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                    .padding()
                    
                    // Cart icon
                    NavigationLink(destination: Cart()) {
                        Image(systemName: "cart")
                            .font(.title)
                    }
                }
                .padding()
                
                // Search bar
                HStack {
                    TextField("Search", text: $searchText)
                        .padding(.horizontal)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button(action: {
                        // Perform search action
                    }) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                    }
                    .padding(.trailing)
                }
                .padding()
                
                // Icons
                HStack {
                    Image("offer")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.horizontal)
                    Image("grocery")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.horizontal)
                    Image("convenience")
                        .resizable()
                        .frame(width: 65, height: 65)
                        .padding(.horizontal)
                    Image("alcohol")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                // Separator line
                Divider()
                    .padding(.horizontal)
                
                // Trending icons
                HStack {
                    Image("trending")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.horizontal)
                    Image("burgers")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.horizontal)
                    Image("fastfood")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.horizontal)
                    Image("coffee")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                .padding()
                // Image slideshow
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
                
                Spacer()
            }
        }
        .onAppear {
            checkLocationAuthorization()
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
    }
    
    private func checkLocationAuthorization() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = locationDelegate
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
