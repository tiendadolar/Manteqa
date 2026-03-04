@Integrations @NotFound
Feature: Not Found Integrations

    Background:
        Given The urlBase is available "https://sandbox.manteca.dev/crypto"

    # ------------------------------- Orders Not Found -------------------------------

    @ErrorPath
    Scenario: Validate error when fetching non-existent order
        Given The API key is available "B8HJ3SS-2JQM6XD-HW4Z877-KZCESAV"
        And login user admin "andresperalta@manteca.dev"
        When Execute the GET method on the endpoint "/v2/orders/nonexistent-order-id-999"
        Then Obtain a response 404
        And Validate response attributes with internalStatus: "ORDER_NF" and message: "Order not found."

    # ------------------------------- Withdrawals Not Found -------------------------------

    @ErrorPath
    Scenario: Validate error when fetching non-existent withdraw
        Given The API key is available "PRAJYCG-71RM2H7-HSQK3BN-0NDD7MY"
        And login user admin "andresperalta@manteca.dev"
        When Execute the GET method on the endpoint "/v2/withdraws/nonexistent-withdraw-id-999"
        Then Obtain a response 404
        And Validate response attributes with internalStatus: "WITHDRAW_NF" and message: "Withdraw not found"

    # ------------------------------- Price Locks Not Found -------------------------------

    @ErrorPath
    Scenario: Validate error when fetching non-existent or expired price lock
        Given The API key is available "95ZZHZT-CRH4PM9-K1NQA51-DXYVTX6"
        And login user admin "andresperalta@manteca.dev"
        When Execute the GET method on the endpoint "/v2/price-locks/cc22e6af-d3c9-426d-acff-cc1f9e40a137"
        Then Obtain a response 404
        And Validate response attributes with internalStatus: "PRICE_LOCK_NF" and message: "Price lock not found, most likely it expired."
