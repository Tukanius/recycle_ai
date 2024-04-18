//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

<<<<<<< HEAD

void fl_register_plugins(FlPluginRegistry* registry) {
=======
#include <smart_auth/smart_auth_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) smart_auth_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SmartAuthPlugin");
  smart_auth_plugin_register_with_registrar(smart_auth_registrar);
>>>>>>> 54f30e55e2db4fbcb8ea3c5ebb8f39069abed74a
}
