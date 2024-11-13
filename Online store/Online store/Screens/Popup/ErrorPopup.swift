import SwiftUI

struct ErrorPopup: View {

    // MARK: - Property

    @Environment(\.colorScheme) var colorScheme
    var errorText: String
    var closeButtonCompletion: () -> ()

    // MARK: - View

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(colorScheme == .dark ? .black : .gray)
                .shadow(color: .blue, radius: 15)

            VStack(alignment: .center) {
                Text(errorText)
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25, weight: .medium))
                    .foregroundColor(.black.opacity(0.7))
                    .minimumScaleFactor(0.5)
                    .padding()
                    .frame(maxWidth: UIScreen.main.bounds.width / 1.5)

                Spacer()

                Button {
                    closeButtonCompletion()
                } label: {
                    Text("OK")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.blue.opacity(0.8))
                        .padding(.horizontal, 65)
                        .padding(.vertical, 5)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.blue)
                }
            }
            .frame(width: UIScreen.main.bounds.width / 1.5)
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width / 1.5, height: UIScreen.main.bounds.width / 2)
    }
}

#Preview {
    ErrorPopup(errorText: "Some error", closeButtonCompletion: {})
}
