data "utils_deep_merge_json" "conf" {
  input = [
    jsonencode(local.defaults),
    var.defaults,
    var.repository,
  ]
}
