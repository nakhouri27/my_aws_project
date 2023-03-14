<!-- BEGIN_TF_DOCS -->
#### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

#### Modules

No modules.

#### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | common tags | `map(any)` | n/a | yes |
| <a name="input_domain_naming_construct"></a> [domain\_naming\_construct](#input\_domain\_naming\_construct) | n/a | `string` | n/a | yes |
| <a name="input_alternative_domain"></a> [alternative\_domain](#input\_alternative\_domain) | n/a | `string` | `" "` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | n/a | `string` | `"eu-central-1"` | no |
| <a name="input_bucket_suffix"></a> [bucket\_suffix](#input\_bucket\_suffix) | name of bucket\_suffix | `string` | `"bucket"` | no |
| <a name="input_business_scope"></a> [business\_scope](#input\_business\_scope) | n/a | `string` | `"app"` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | n/a | `string` | `" "` | no |
| <a name="input_cf_suffix"></a> [cf\_suffix](#input\_cf\_suffix) | name of cf\_suffix | `string` | `"cf-dist"` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `string` | `"dev"` | no |
| <a name="input_error_code"></a> [error\_code](#input\_error\_code) | n/a | `number` | `403` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | For setting up value of force destroy attribute for s3 bucket | `bool` | `false` | no |
| <a name="input_origin_path"></a> [origin\_path](#input\_origin\_path) | n/a | `string` | `"/live"` | no |
| <a name="input_response_code"></a> [response\_code](#input\_response\_code) | n/a | `number` | `200` | no |
| <a name="input_response_page_path"></a> [response\_page\_path](#input\_response\_page\_path) | n/a | `string` | `"/index.html"` | no |
| <a name="input_ssl_method"></a> [ssl\_method](#input\_ssl\_method) | n/a | `string` | `"sni-only"` | no |
| <a name="input_web_acl_arn"></a> [web\_acl\_arn](#input\_web\_acl\_arn) | n/a | `string` | `""` | no |

#### Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_dns"></a> [cloudfront\_dns](#output\_cloudfront\_dns) | n/a |
| <a name="output_cloudfront_hosted_zone_id"></a> [cloudfront\_hosted\_zone\_id](#output\_cloudfront\_hosted\_zone\_id) | n/a |
| <a name="output_cloudfront_id"></a> [cloudfront\_id](#output\_cloudfront\_id) | n/a |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | n/a |
<!-- END_TF_DOCS -->