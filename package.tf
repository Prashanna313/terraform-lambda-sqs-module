module "modules_test" {
  source = ".//package"

  create_function = false

  runtime = "python3.7"
  source_path = [
    {
      path             = "./src/"
      pip_requirements = false
    }
  ]
}