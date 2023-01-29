resource_group_name     = "tf-foundation-test"
resource_group_location = "uksouth"

  name          = "vnet1"
  address_space = "10.0.0.0/16"

  subnets = [
    {
      name = "subnet1"
      address_prefixes = ["10.0.0.0/24"]
    }
  ]