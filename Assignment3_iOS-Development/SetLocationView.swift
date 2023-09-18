import SwiftUI

struct SetLocationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var currentLocationName: String

    var body: some View {
        NavigationView {
            VStack {
                Text("Set Your Location")
                    .font(.title)
                    .padding()

                TextField("Enter Your Location", text: $currentLocationName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Spacer()
            }
            .navigationBarTitle("Set Location", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                // Save the user's selected location here
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct SetLocationView_Previews: PreviewProvider {
    static var previews: some View {
        SetLocationView(currentLocationName: .constant("Sample Location"))
    }
}
