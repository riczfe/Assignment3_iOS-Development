import SwiftUI
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var currentLocationName: String = "" // Initialize as empty string
    
    private let geocoder = CLGeocoder()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        
        // Perform reverse geocoding to get the location name
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            if let placemark = placemarks?.first {
                self?.currentLocationName = placemark.name ?? placemark.locality ?? "Unknown Location"
            } else {
                self?.currentLocationName = "Unknown Location"
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
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Display location name if available, otherwise show "Unknown Location"
                    Text(locationDelegate.currentLocationName.isEmpty ? "Unknown Location" : locationDelegate.currentLocationName)
                        .font(.headline)
                    
                    Spacer()
                    
                    // Dark Mode icon
                    Image(systemName: darkModeEnabled ? "moon.fill" : "sun.max.fill")
                        .font(.title)
                        .onTapGesture {
                            darkModeEnabled.toggle()
                        }
                        .foregroundColor(darkModeEnabled ? .yellow : .blue) // Customize icon color
                    
                    // Profile icon
                    NavigationLink(destination: Profile()) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                    // Cart icon
                    NavigationLink(destination: Cart()) {
                        Image(systemName: "cart")
                            .font(.title)
                    }
                }
                .padding()
                .foregroundColor(Color.primary)
                
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
                
                Divider()
                    .padding(.horizontal)
                
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
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
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
