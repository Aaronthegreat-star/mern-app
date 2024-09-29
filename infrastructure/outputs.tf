output "lb_name" {
  value = aws_lb.my_mern_lb.dns_name
}

# output "ecr_repo_id" {
#   value = aws_ecr_repository.ecr_repo.id
# }