@requirejs_paths = {
  'app': 'js/app'
  'module01': 'js/module01'
  'module_ixxa': 'js/module_ixxa'
  'module_sune': 'js/module_sune'

  'jquery': 'lib/jquery/js/jquery'
  'bootstrap': 'lib/bootstrap/js/bootstrap'
}
@requirejs_shim = {
  'bootstrap': ['jquery']
}
requirejs.config(
  baseUrl: '/'
  paths: @requirejs_paths
  shim: @requirejs_shim
)
