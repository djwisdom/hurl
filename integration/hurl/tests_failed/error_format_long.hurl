# Using --error-format long, the response body
# is logged when there are errors. If the response is a kind of
# text (like text/html or application/json), the body is logged as text,
# otherwise as a binary.
GET http://localhost:8000/error-format-long/html
HTTP 200
Content-Type: text/html
[Asserts]
xpath "string(//head/title)" == "Welcome!"
xpath "//foo" isEmpty
xpath "//title" count == 2


GET http://localhost:8000/error-format-long/json
HTTP 200
Content-Type: application/json
[Asserts]
jsonpath "$.books" count == 12


# RFC-7807 application/problem+json is also supported
GET http://localhost:8000/error-format-long/rfc-7807
HTTP 200
Content-Type: application/problem+json
[Asserts]
jsonpath "$.title" == "You have enough credit."


# "JSON like" mimetype are supported, like [FHIR](https://www.hl7.org/fhir/json.html)
GET http://localhost:8000/error-format-long/fhir
HTTP 200
Content-Type: application/fhir+json
[Asserts]
jsonpath "$.id" == "foo"


# Text like mimetype like CSV are supported
GET http://localhost:8000/error-format-long/csv
HTTP 200
Content-Type: text/csv; charset=utf-8
[Asserts]
body split "\n" nth 9 split "," nth 2 == "\"Taxi\""


# Bytestream are dumped as a raw bytes stream
GET http://localhost:8000/error-format-long/bytes
HTTP 200
Content-Type: application/octet-stream
[Asserts]
bytes == hex,beef;
