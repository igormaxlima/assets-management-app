//
//  ConvertData.swift
//  assets-management-app
//
//  Created by Igor Max de Lima Nunes on 05/05/24.
//

import Foundation

class ConvertData {
    static func convertDateStringToDateAndFormat(_ dateString: String, from inputFormat: String, to outputFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // Definir a localização para inglês (Estados Unidos) para garantir a formatação correta do mês

        // Converter a string para uma data
        if let date = dateFormatter.date(from: dateString) {
            // Agora você tem a data, pode formatá-la para o formato desejado
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = outputFormat

            // Formatar a data para o formato desejado
            let formattedDateString = outputDateFormatter.string(from: date)
            return formattedDateString
        } else {
            print("Failed to convert string to date. Invalid format: \(dateString)")
            return nil
        }
    }
}
