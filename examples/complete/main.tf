provider "alicloud" {
  region = "cn-heyuan"
}

module "complete" {
  source = "../.."
  vpc_config = {
    cidr_block = "10.0.0.0/16"
  }
  zone_id = ["cn-heyuan-a", "cn-heyuan-b"]
}
