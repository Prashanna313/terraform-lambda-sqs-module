# Deployment package

output "package_name" {
  value = data.external.archive_prepare[0].result.filename
}