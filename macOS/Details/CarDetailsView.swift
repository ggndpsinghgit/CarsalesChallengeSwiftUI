//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarDetailsView: View {
    @ObservedObject var viewModel = DetailsViewModel()
    let path: String
    
    var body: some View {
        Group {
            ScrollView {
                if let car = viewModel.car {
                    CarDetailsInnerView(car: car)
                } else {
                    CarDetailsInnerView(car: .sample)
                        .transition(.scale)
                        .redacted(reason: .placeholder)
                }
            }
            .onAppear {
                viewModel.fetchDetails(path: path)
            }
            .alert(isPresented: $viewModel.showFailedAlert) {
                Alert(title: Text("Error!"), message: Text("Failed to load the car details."), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView(path: "")
    }
}
