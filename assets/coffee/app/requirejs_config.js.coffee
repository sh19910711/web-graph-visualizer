@requirejs_paths = {
  'app': 'js/app'
  'module01': 'js/module01'
  'module_ixxa': 'js/module_ixxa'
  'module_sune': 'js/module_sune'
}
requirejs.config(
  baseUrl: '/'
  paths: @requirejs_paths
)
