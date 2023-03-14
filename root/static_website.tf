module "static_website" {
  source                        = "../modules/static-site"
  acm_certificate_arn       =  ""
  hosted_zone_id            =  ""
  path_to_source_directory  =  ""
  project_name              =  ""
}



