#!/bin/bash

api_key=""   
secret_key=""

timestamp=$(date +%s)
resource_path="payments/v1/sales"
query="apiKey=$api_key"
request_body='{"amount":5,"currency":"USD","payment":{"cardNumber":"4111111111111111","cardExpirationMonth":"7","cardExpirationYear":"2017","cardType":null,"cardVerificationIndicator":null,"cvn":null,"encryptedData":null,"encryptedDescriptor":null,"encryptedEncoding":null,"encryptedKey":null,"cavv":null,"xid":null,"ucafAuthenticationData":null,"ucafCollectionIndicator":null,"networkTokenTransactionType":null,"networkTokenRequestorId":null},"billTo":null,"shipTo":null,"vcOrderId":null,"commerceIndicator":null,"ignoreAvs":null,"ignoreBadCvn":null,"referenceId":"123","paymentSolution":null,"merchantDefinedData":null,"items":[],"merchantDescriptor":null}'

message=$timestamp$resource_path$query$request_body
digest=$(echo -n $message | openssl dgst -sha256 -hmac $secret_key | sed 's/^.* //')
token="xv2:$timestamp:${digest}"

curl -v -d "$request_body" -H "Content-Type: application/json" -H "x-pay-token: $token" https://sandbox.api.visa.com/cybersource/$resource_path?$query
