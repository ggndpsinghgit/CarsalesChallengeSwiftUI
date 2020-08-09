//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    
    @ObservedObject var viewModel = DetailsViewModel()
    
    var body: some View {
        Group {
            NavigationView {
                ScrollView {
                    if let car = viewModel.car {
                        CarDetailsInnerView(car: car)
                            .animation(.easeIn(duration: 0.2))
                    } else {
                        CarDetailsInnerView(car: .sample)
                            .redacted(reason: .placeholder)
                    }
                }
                .navigationTitle(viewModel.car?.title ?? "")
                .navigationBarItems(trailing:
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                )
            }
        }
        .onAppear {
            if let path = listViewModel.selectedCar {
                viewModel.fetchDetails(path: path)
            }
        }
        .alert(isPresented: $viewModel.showFailedAlert) {
            Alert(
                title: Text("Error!"),
                message: Text("Failed to load the car details."),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                })
        }
    }
}

struct CarDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CarDetailsView()
            .environmentObject(ListViewModel())
    }
}
