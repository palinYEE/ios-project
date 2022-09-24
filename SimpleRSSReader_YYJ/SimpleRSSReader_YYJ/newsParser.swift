//
//  newsParser.swift
//  SimpleRSSReader_YYJ
//
//  Created by yoon-yeoungjin on 2022/09/24.
//

import Foundation


class newsParser: NSObject, XMLParserDelegate {
    let urlString: String = "http://www.apple.com/main/rss/hotnews/hotnews.rss"
    
    fileprivate var currentElement = ""
    var newsItems: [appleNews] = []
    
    fileprivate var newsHead: String = ""
    fileprivate var newsDescription: String = ""
    fileprivate var newsDate: String = ""
    
    fileprivate var parserCompletetionhandler: (([appleNews]) -> Void)?
    
    func loadParsing(completionHandler: (([appleNews]) -> Void)?){
        guard let hasURL = URL(string: urlString) else { return }
        
        parserCompletetionhandler = completionHandler
        
        URLSession.shared.dataTask(with: hasURL) { data, response, error in
            if let error = error {
              print(error)
              return
            }
            
            guard let data = data else {
              print("No data fetched")
              return
            }
            
            DispatchQueue.main.async {
                let parser = XMLParser(data: data)
                parser.delegate = self
                parser.parse()
            }
        }.resume()
        
    }
    
    // XML 파서가 시작 테그를 만나면 호출됨
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if (elementName == "item") {
            newsHead = ""
            newsDescription = ""
            newsDate = ""
        }
    }
    
    // 현재 테그에 담겨있는 문자열 전달
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if(currentElement == "title") {
            newsHead += string
        } else if (currentElement == "description") {
            newsDescription += string
        } else if (currentElement == "pubDate") {
            newsDate += string
        }
    }
    
    // XML 파서가 종료 테그를 만나면 호출됨
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if (elementName == "item") {
            let newsItem: appleNews = .init(head: newsHead, uploadDate: newsDate, description: newsDescription, isExtend: false)
            self.newsItems.append(newsItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletetionhandler?(newsItems)
    }

}
