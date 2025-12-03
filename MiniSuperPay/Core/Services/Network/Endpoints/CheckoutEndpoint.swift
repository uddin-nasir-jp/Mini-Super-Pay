
import Foundation

struct CheckoutEndpoint {
    static func create(cartItems: [CartItem]) -> APIEndpoint {
        let items = cartItems.map { item in
            return [
                "productId": item.product.id,
                "productName": item.product.name,
                "quantity": item.quantity,
                "price": item.product.price
            ] as [String : Any]
        }
        
        let body: [String : Any] = [
            "items": items,
            "totalAmount": cartItems.reduce(0) { $0 + ($1.product.price * Double($1.quantity)) }
        ]
        
        return APIEndpoint(
            path: APIConstants.checkout(),
            method: .post,
            headers: nil,
            queryParameters: nil,
            body: body
        )
    }
}
