//  Created by Gagandeep Singh on 6/8/20.

import Combine
import CarsalesAPI

class DetailsProvider: ObservableObject {
    @Published private(set) var car: CarsalesAPI.CarDetails?
    let api = CarsalesAPI()
    
    func fetchDetails(path: String) {
        api.getDetails(path: path) { details in
            if case let .success(car) = details {
                self.car = car
            }
        }
    }
}
