variable "domain_naming_construct" {
  type = string
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  description = "common tags"
  type        = map(any)
}

variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "business_scope" {
  type    = string
  default = "app"
}

variable "origin_path" {
  type    = string
  default = "/live"
}

variable "bucket_suffix" {
  description = "name of bucket_suffix"
  type        = string
  default     = "bucket"
}

variable "cf_suffix" {
  description = "name of cf_suffix"
  type        = string
  default     = "cf-dist"
}

variable "web_acl_arn" {
  type    = string
  default = ""
}

variable "certificate_arn" {
  type    = string
  default = " "
}

variable "alternative_domain" {
  type    = string
  default = " "
}

variable "ssl_method" {
  type    = string
  default = "sni-only"
}

variable "error_code" {
  type    = number
  default = 403
}

variable "response_code" {
  type    = number
  default = 200
}

variable "response_page_path" {
  type    = string
  default = "/index.html"
}

variable "force_destroy" {
  description = "For setting up value of force destroy attribute for s3 bucket"
  type        = bool
  default     = false
}

variable "countrycodes" {
  type = list(string)
  default = [
    "IN",
    "PL",
    "NL",
    "GB",
    "BE",
    "DE",
    "GR",
    "EG",
    "US",
    "CA",
    "AD",
    "AE",
    "AF",
    "AL",
    "AM",
    "AO",
    "AQ",
    "AT",
    "AX",
    "AZ",
    "BA",
    "BF",
    "BG",
    "BH",
    "BI",
    "BJ",
    "BL",
    "BV",
    "BW",
    "BY",
    "CD",
    "CF",
    "CG",
    "CH",
    "CI",
    "CK",
    "CM",
    "CV",
    "CW",
    "CY",
    "CZ",
    "DJ",
    "DK",
    "DZ",
    "EE",
    "EH",
    "ER",
    "ES",
    "ET",
    "FI",
    "FO",
    "FR",
    "GA",
    "GE",
    "GF",
    "GG",
    "GH",
    "GI",
    "GL",
    "GM",
    "GN",
    "GP",
    "GQ",
    "GW",
    "HM",
    "HR",
    "HU",
    "IE",
    "IL",
    "IM",
    "IQ",
    "IR",
    "IS",
    "IT",
    "JE",
    "JO",
    "KE",
    "KG",
    "KM",
    "KW",
    "KZ",
    "LB",
    "LI",
    "LR",
    "LS",
    "LT",
    "LU",
    "LV",
    "LY",
    "MA",
    "MC",
    "MD",
    "ME",
    "MF",
    "MG",
    "MK",
    "ML",
    "MQ",
    "MR",
    "MT",
    "MU",
    "MW",
    "MZ",
    "NA",
    "NC",
    "NE",
    "NG",
    "NO",
    "OM",
    "PF",
    "PM",
    "PS",
    "PT",
    "QA",
    "RE",
    "RO",
    "RS",
    "RU",
    "RW",
    "SA",
    "SC",
    "SD",
    "SE",
    "SH",
    "SI",
    "SK",
    "SL",
    "SM",
    "SN",
    "SO",
    "SS",
    "ST",
    "SX",
    "SY",
    "SZ",
    "TD",
    "TF",
    "TG",
    "TJ",
    "TM",
    "TN",
    "TR",
    "TZ",
    "UA",
    "UG",
    "UZ",
    "VA",
    "WF",
    "YE",
    "YT",
    "ZA",
    "ZM",
  "ZW"]
}
