import SwiftUI
import CoreLocation

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
                    
                    NavigationLink(destination: LogIn()) {
                        Image(systemName: "person.circle")
                            .font(.title)
                    }
                }
                .padding(.top, 40)
                .padding()
                .foregroundColor(Color.primary)
                
                // Search bar added to the navigation bar
                SearchBar(text: $searchText)
                
                HStack {
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
                .padding(.horizontal)
                
                Divider()
                    .padding(.horizontal)
                
                HStack {
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
                
                Text("Check out our latest promotions!")
                    .font(.headline)
                
                // Replace TabView with ScrollView and LazyHGrid
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: [GridItem(.fixed(150))]) {
                        ForEach(0..<2) { index in
                            Button(action: {}) {
                                VStack {
                                    Image("restaurant\(index + 1)")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .cornerRadius(10)
                                        .padding(.horizontal)
                                    
                                    Text("Restaurant \(index + 1)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .frame(width: 120, height: 120)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .frame(height: 240)
                .padding(.horizontal)
                
                Spacer()
            }
        }
        
        Spacer()

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

            if CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.startUpdatingLocation()
        }
    }
}


//SEARCH BARR
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
