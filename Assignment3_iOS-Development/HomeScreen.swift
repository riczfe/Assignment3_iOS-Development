import SwiftUI
import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var currentLocationName: String = ""
    private let geocoder = CLGeocoder()

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location.coordinate
        
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
                    
                    NavigationLink(destination: Cart()) {
                        Image(systemName: "cart")
                            .font(.title)
                    }
                }
                .padding()
                .foregroundColor(Color.primary)
                
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
                
                TabView {
                    Button(action: {}) {
                        VStack {
                            Image("restaurant1")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            Text("Restaurant 1")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(width: 120, height: 120)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .tabItem {
                        Label("Restaurant 1", systemImage: "square.fill")
                    }
                    
                    Button(action: {}) {
                        VStack {
                            Image("restaurant2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            
                            Text("Restaurant 2")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .frame(width: 120, height: 120)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .tabItem {
                        Label("Restaurant 2", systemImage: "square.fill")
                    }
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
