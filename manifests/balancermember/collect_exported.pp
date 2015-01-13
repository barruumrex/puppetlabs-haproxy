# Private define
define haproxy::balancermember::collect_exported (
  $collection_name,
  $collector = undef
) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  Haproxy::Balancermember <<| listening_service == $collection_name |>> {
    collector => $collector
  }
}
