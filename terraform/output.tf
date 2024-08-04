output "aws_ygn_admin_arn" {
  description = "Unique identifier of the calling entity for ygn-admin"
  value       = data.aws_caller_identity.ygnadmin.arn
}

output "aws_mdy_admin_arn" {
  description = "Unique identifier of the calling entity for mdy-admin"
  value       = data.aws_caller_identity.mdyadmin.arn
}

output "aws_mandalay_vpc_arn" {
  description = "Details about the default VPC in the Mandalay region"
  value       = data.aws_vpc.mandalay_vpc.arn
}