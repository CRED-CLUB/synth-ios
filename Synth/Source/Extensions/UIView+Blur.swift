//
//  UIView+Blur.swift
//  Synth
//
//  Copyright 2020 Dreamplug Technologies Private Limited
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

import UIKit
import Accelerate

extension UIView {
    
    /// applies blur to current state of view, return UIImage
    /// - Parameter blurRadius: sets radius of blur
    ///
    /// - returns: UIImage object which is blurred snapshot of UIView
    func applyBlur(with blurRadius: CGFloat) -> UIImage? {

        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.opaque = false
        rendererFormat.scale = 0

        let modifiedRect = CGRect(origin: .zero, size: CGSize(width: bounds.width + 8 * blurRadius, height: bounds.height + 8 * blurRadius))
        let inputImageWithPadding = UIGraphicsImageRenderer(size: modifiedRect.size, format: rendererFormat).image { (ctx) in
            ctx.cgContext.translateBy(x: 4 * blurRadius, y: 4 * blurRadius)
            layer.render(in: ctx.cgContext)
        }

        guard inputImageWithPadding.size.width > 1 && inputImageWithPadding.size.height > 1 else { return nil }
        guard let inputCGImage = inputImageWithPadding.cgImage else { return inputImageWithPadding }
        guard blurRadius > 0 else { return inputImageWithPadding }

        let inputImageScale = inputImageWithPadding.scale
        let inputImageAlphaInfo = CGImageAlphaInfo(rawValue: inputCGImage.bitmapInfo.rawValue & CGBitmapInfo.alphaInfoMask.rawValue)

        let outputImageSizeInPoints = inputImageWithPadding.size
        let outputImageRectInPoints = CGRect(origin: .zero, size: outputImageSizeInPoints)

        let useOpaqueContext = inputImageAlphaInfo == Optional.none || inputImageAlphaInfo == .noneSkipLast || inputImageAlphaInfo == .noneSkipFirst

        UIGraphicsBeginImageContextWithOptions(outputImageRectInPoints.size, useOpaqueContext, inputImageScale)
        defer { UIGraphicsEndImageContext() }
        guard let outputContext = UIGraphicsGetCurrentContext() else {
            return inputImageWithPadding
        }
        outputContext.scaleBy(x: 1, y: -1)
        outputContext.translateBy(x: 0, y: -outputImageRectInPoints.size.height)

        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
        var format = vImage_CGImageFormat(bitsPerComponent: 8,
                                          bitsPerPixel: 32,
                                          colorSpace: nil,
                                          bitmapInfo: bitmapInfo,
                                          version: 0,
                                          decode: nil,
                                          renderingIntent: CGColorRenderingIntent.defaultIntent)

        var inputBuffer = vImage_Buffer()
        var outputBuffer = vImage_Buffer()

        let e: vImage_Error = vImageBuffer_InitWithCGImage(&inputBuffer, &format, nil, inputCGImage, vImage_Flags(kvImagePrintDiagnosticsToConsole))
        guard e == kvImageNoError else { return inputImageWithPadding }

        vImageBuffer_Init(&outputBuffer, inputBuffer.height, inputBuffer.width, format.bitsPerPixel, vImage_Flags(kvImageNoFlags))

        var inputRadius = blurRadius * inputImageScale
        if inputRadius - 2.0 < .ulpOfOne {
            inputRadius = 2.0
        }

        var radius = UInt32(floor((inputRadius * 3.0 * sqrt(2 * .pi) as CGFloat / 4 + 0.5) / 2) as CGFloat)

        radius |= 1 // force radius to be odd so that the three box-blur methodology works.

        let tempBufferSize = vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageGetTempBufferSize | kvImageEdgeExtend))
        let tempBuffer = malloc(tempBufferSize)

        vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, tempBuffer, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
        vImageBoxConvolve_ARGB8888(&outputBuffer, &inputBuffer, tempBuffer, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
        vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, tempBuffer, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))

        free(tempBuffer)

        let temp = inputBuffer
        inputBuffer = outputBuffer
        outputBuffer = temp

        ///  Helper function to handle deferred cleanup of a buffer.
        func cleanupBuffer(_ userData: UnsafeMutableRawPointer?, _ bufData: UnsafeMutableRawPointer?) {
            free(bufData)
        }

        var effectCGImage = vImageCreateCGImageFromBuffer(&inputBuffer, &format, cleanupBuffer, nil, vImage_Flags(kvImageNoAllocate), nil)?.takeRetainedValue()
        if effectCGImage == nil {
            effectCGImage = vImageCreateCGImageFromBuffer(&inputBuffer, &format, nil, nil, vImage_Flags(kvImageNoFlags), nil)!.takeRetainedValue()
            free(inputBuffer.data)
        }

        // draw effect image
        outputContext.saveGState()
        outputContext.draw(effectCGImage!, in: outputImageRectInPoints)
        outputContext.restoreGState()

        // Cleanup
        free(outputBuffer.data)

        guard let outputImage = UIGraphicsGetImageFromCurrentImageContext() else { return inputImageWithPadding }
        return outputImage
    }
}
