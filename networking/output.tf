output "vpc_id" {
  value = aws_vpc.client-vpc.id
}

output "cidr_public_subnet" {
  value = {
    for subnet in aws_subnet.customize-client-pub-sub :
    subnet.tags_all["Name"] => subnet.id
  }
}

output "cidr_private_subnet" {
  value = {
    for subnet in aws_subnet.customize-client-prv-sub :
    subnet.tags_all["Name"] => subnet.id
  }
}