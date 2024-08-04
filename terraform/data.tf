data "aws_caller_identity" "ygnadmin" {
  provider = aws.ygnadmin
}

data "aws_caller_identity" "mdyadmin" {
  provider = aws.mdyadmin
}

data "aws_vpc" "mandalay_vpc" {
  provider = aws.mandalay
  default  = true
}