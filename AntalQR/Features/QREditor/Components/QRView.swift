//
//  QRView.swift
//  AntalQR
//
//  Created by antonio dante arista rivas on 12/3/25.
//

// 🎨 QREditorFeature/Components/QRView.swift

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QRView: View {
    let message: String
    let color: Color

    // Convertimos SwiftUI.Color a UIColor para usarlo en Core Image/UIKit
    private var uiColor: UIColor {
        UIColor(color)
    }

    var body: some View {
        // Usamos la función modificada para generar la imagen
        // y la envolvemos en la vista Image de SwiftUI
        if let uiImage = generateQRCodeImage(from: message, color: uiColor) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
        } else {
            // Manejo de error simple si la generación falla
            Color.gray
                .aspectRatio(1.0, contentMode: .fit)
        }
    }

    // Alojamos la lógica de generación dentro de la vista como un método privado
    private func generateQRCodeImage(
        from string: String,
        color: UIColor
    ) -> UIImage? {

        guard let data = string.data(using: .utf8) else { return nil }

        // 1. Generar QR base
        guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        qrFilter.setValue(data, forKey: "inputMessage")
        qrFilter.setValue("Q", forKey: "inputCorrectionLevel")

        guard let outputImage = qrFilter.outputImage else { return nil }

        // 2. Escalar para alta nitidez
        let scale: CGFloat = 20
        let scaledImage = outputImage.transformed(by: CGAffineTransform(scaleX: scale, y: scale))

        // 3. Suavizado súper ligero (evita bordes pixel rotos)
        let blurredQR = scaledImage.applyingFilter("CIGaussianBlur", parameters: [kCIInputRadiusKey: 0.4])

        // 4. Invertir (lo oscuro será lo que pintemos con color)
        let invertedQR = blurredQR.applyingFilter("CIColorInvert")

        // 5. Blanco → alpha (transparente donde esté claro)
        let transparentQR = invertedQR.applyingFilter("CIMaskToAlpha")

        // 6. Convertir CIImage → UIImage
        let context = CIContext()
        guard let cgImage = context.createCGImage(transparentQR, from: transparentQR.extent) else { return nil }
        let maskImage = UIImage(cgImage: cgImage)

        // 7. Pintar solo los módulos oscuros con el color
        let renderer = UIGraphicsImageRenderer(size: maskImage.size)
        let finalImage = renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: maskImage.size)

            color.setFill()
            ctx.fill(rect)

            maskImage.draw(in: rect, blendMode: .destinationIn, alpha: 1.0)
        }

        return finalImage
    }
}
