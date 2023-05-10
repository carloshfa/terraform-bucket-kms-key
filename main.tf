provider "aws" {
  region = var.region
  default_tags {
    tags = var.tags_padrao
  }
}
