//  Created by Gagandeep Singh on 6/8/20.

import SwiftUI
import CarsalesAPI

struct CarListCellView: View {
    let car: CarsalesAPI.ListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ListItemImageView(photoPath: car.photoPath)

            VStack(alignment: .leading, spacing: 8) {
                Text(car.title)
                    .font(Font.system(size: 24, weight: .semibold, design: .rounded))
                
                Text(car.priceString)
                    .font(Font.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.primary)
                
                HStack {
                    Image(systemName: "mappin.circle")
                    Text(car.locationString)
                }
                .font(Font.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .background(Color(UIColor.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding()
        .shadow(color: Color.black.opacity(0.3), radius: 16, x: 0, y: 1)
    }
}

struct ListItemImageView: View {
    let photoPath: String
    
    var body: some View {
        AsyncImageView(path: photoPath)
            .background(Color(UIColor.secondarySystemBackground))
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
