//  Created by Gagandeep Singh on 6/8/20.

import Combine
import CarsalesAPI

class DetailsProvider: ObservableObject {
    @Published private(set) var car: CarsalesAPI.CarDetails?
    @Published var showFailedAlert: Bool = false
    private let api = CarsalesAPI()
    
    func fetchDetails(path: String) {
        api.getDetails(path: path) { result in
            switch result {
            case .success(let car):
                self.car = car
            case .failure:
                self.showFailedAlert = true
            }
        }
    }
}
