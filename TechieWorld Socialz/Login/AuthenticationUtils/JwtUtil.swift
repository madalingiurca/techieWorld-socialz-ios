//
//  JwtUtil.swift
//  TechieWorld Socialz
//
//  Created by Madalin Giurca on 03.10.2022.
//
import SwiftJWT
import Foundation

struct JWTClaims: Claims {}

func decodeJWTPart(part: String) -> AuthToken? {
    let payloadPaddingString = base64StringWithPadding(encodedString: part)
    guard let payloadData = Data(base64Encoded: payloadPaddingString) else {
        fatalError("payload could not converted to data")
    }
    
    return try? JSONDecoder().decode(AuthToken.self, from: payloadData)
}

func base64StringWithPadding(encodedString: String) -> String {
    var stringTobeEncoded = encodedString.replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")
    let paddingCount = encodedString.count % 4
    for _ in 0..<paddingCount {
        stringTobeEncoded += "="
    }
    return stringTobeEncoded
}



func validateJwtSignature(signedJwt: String) -> Bool {
    let dataPublicKey = "my_very_secret_word_for_jwt_generation".data(using: .utf8)!
    let verifier: JWTVerifier = JWTVerifier.hs256(key: dataPublicKey)
    
    return JWT<JWTClaims>.verify(signedJwt, using: verifier)
}
