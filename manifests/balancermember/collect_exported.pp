# Private define
define haproxy::balancermember::collect_exported (
  $collection_name,
  $collector = ''
) {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  Haproxy::Balancermember <<| listening_service == $collection_name and collector == $collector |>> 

}
