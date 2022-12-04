//
//  PhotoOperations.swift
//  YYJ_ClassicPhotos
//
//  Created by yoon-yeoungjin on 2022/11/26.
//

import UIKit

enum PhotoRecordState {
    case New, Download, Filtered, Failed
}

/**
    해당 프로젝트에서 사용할 데이터 구조를 가지고 있습니다.
 
    name, url, state, image로 구성되어있습니다.
 */
class PhotoRecord {
    let name: String
    let url: URL
    var state = PhotoRecordState.New
    var image = UIImage(named: "Placeholder")
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}


/**
  PendingOperation class 는 해당 프로젝트에서 사용할 queue를 선헌하는 class 입니다.
*/
class PendingOperation {
    lazy var downloadsInProgress = [IndexPath:Operation]()    // IndexPath 는 tableView의 행을 식별하는 인덱스 경로
    lazy var downloadQueue: OperationQueue = {              // 사용자 queue를 생성
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1               // queue를 Sync 로 동작 하게끔 한번에 하나의 작업을 하게 끔 한다.
        return queue
    }()
    
    lazy var filtrationsInProgress = [IndexPath:Operation]()
    lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

/**
    이미지를 다운로드 하고 이에 대한 정보를 PhotoRecord 구조체에 업로드 합니다.
 */
class ImageDownloader: Operation {
    let photoRecord: PhotoRecord
    
    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        do {
            let imageData = try Data(contentsOf: photoRecord.url)
            if self.isCancelled {
                return
            }
            
            if imageData.count > 0{
                photoRecord.image = UIImage(data: imageData)
                photoRecord.state = .Download
            } else {
                photoRecord.state = .Failed
                photoRecord.image = UIImage(named: "Failed")
            }
        } catch let error as NSError {
            print("\(photoRecord.url) - \(error.domain)")
        }
    }
}

class ImageFiltration: Operation {
    let photoRecord: PhotoRecord
    
    init(photoRecord: PhotoRecord) {
        self.photoRecord = photoRecord
    }
    
    func applySepiaFilter(image: UIImage) -> UIImage? {
        let inputImage = CIImage(data: image.pngData()!)
        
        if isCancelled {
            return nil
        }
        
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CISepiaTone")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(0.0, forKey: "inputIntensity")
        
        if isCancelled {
            return nil
        }
        
        if let outputImage = filter?.outputImage,
           let outImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: outImage)
        } else {
            return nil
        }
    }
    override func main() {
        if isCancelled {
            return
        }
        
        if self.photoRecord.state != .Download {
            return
        }
        
        if let image = photoRecord.image,
           let filteredImage = applySepiaFilter(image: image) {
            photoRecord.image = filteredImage
            photoRecord.state = .Filtered
        }
    }
}
