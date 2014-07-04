# define: config_ci
#
# This define handles the export of xldeploy_ci if this module is used in conjunction with shared resources
# The trick here is that the puppet run is able to determine if a xldeploy ci is too old to maintain
# and should be removed from the xldeploy configuration once the last export is too long ago.
#
#
# == parameters
#
# [*type*]
# [*properties*]
# [*discovery*]
# [*discovery_max_wait*]
# [*id*]

# [*export_maxage*]
define xldeploy::client::config_user(
  $password,
  $id                     = $name,
  $ensure                 = 'present',
  $rest_url               = $xldeploy::rest_url
){

  # if the age exceeds the export_maxage and remove_when_expired is set to true then set ensure to absent
  if str2bool($use_exported_resources) {
    @@xldeploy::client::exported_user{"${::hostname}_${id}":
      password             => $password,
      rest_url             => $rest_url
    }

  }else{
    xldeploy_user{ $id:
      ensure             => $ensure,
      password           => $password,
      rest_url           => $rest_url }
    }
}