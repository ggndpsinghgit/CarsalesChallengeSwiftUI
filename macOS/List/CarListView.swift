//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarListView: View {
    @ObservedObject var listViewModel = ListViewModel()
    private var columns: [GridItem] = [GridItem(.adaptive(minimum: 400, maximum: 600))]
    
    var body: some View {
        NavigationView {
            Group {
                if listViewModel.cars.isEmpty {
                    List(listViewModel.cars) { car in
                        CarListCellView(car: car)
                    }
                    .redacted(reason: .placeholder)
                } else {
                    List {
                        Section(header: ListHeader()) {
                            ForEach(listViewModel.cars) { car in
                                NavigationLink(destination: CarDetailsView(path: car.detailsURL)) {
                                    CarListCellView(car: car)
                                }
                            }
                        }
                    }
                }
            }
            .frame(minWidth: 300)
            .listStyle(SidebarListStyle())
            .navigationTitle("Carsales.com.au")
            .padding(.top, 24)
            
            Text("Select a car to start").font(.title)
        }
        .onAppear {
            listViewModel.fetchList()
        }
    }
}

extension CarListView {
    private func makeRedactedViews() -> [CarsalesAPI.ListItem] {
        [.sample, .sample, .sample, .sample]
    }
}

struct ListHeader: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Carsales.com.au").font(.largeTitle).foregroundColor(.primary)
            Divider()
        }
    }
}

struct CarListView_Previews: PreviewProvider {
    static var previews: some View {
        CarListView()
    }
}
