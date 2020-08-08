//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarListCellView: View {
    let car: CarsalesAPI.ListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(car.title)
                .font(.headline)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
            
            Text(car.priceString)
                .font(.subheadline)
            
            Text(car.locationString)
                .font(.caption)
            .foregroundColor(.secondary)
        }
        .padding([.top, .bottom], 8)
    }
}

struct ListItemImageView: View {
    let photoPath: String
    
    var body: some View {
        Text("")
            .aspectRatio(1.5, contentMode: .fit)
            .foregroundColor(.primary)
    }
}

struct CarListCellView_Previews: PreviewProvider {
    static var previews: some View {
        CarListCellView(car: .sample)
            .preferredColorScheme(.light)
    }
}
