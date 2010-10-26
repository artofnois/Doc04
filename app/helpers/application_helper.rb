module ApplicationHelper
 # All the modules in smartclient
  #  (actually there's a few more -- but less useful)
  ISC_MODULES = [
    [:core,         'ISC_Core.js'],
    [:foundation,   'ISC_Foundation.js'],
    [:containers,   'ISC_Containers.js'],
    [:grids,        'ISC_Grids.js'],
    [:forms,        'ISC_Forms.js'],
    [:data_binding, 'ISC_DataBinding.js']
  ]

   # Helper to generate paths to static urls
  #
  # Useful when you deploy under a path prefix
  # (for example, --prefix with mongrel)
  def static_url_for(path)
    "#{ActionController::Base.relative_url_root}#{path}"
  end

  # Load smartclient javascript framework (via script tags)
  #
  # Options are:
  #  :modules => array of js modules to load
  #  :skin    => skin name, as per subfolder in /isomorphic/skins
  #
  # Skins include:
  # BlackOps, Cupertino, Enterprise, fleet, SilverWave,
  # SmartClient, standard, ToolSkin or TreeFrog
  #
  # Loadable modules include:
  # :core, :foundation, :containers, :grids, :forms, :data_binding
  #
  # By default loads ALL modules, with Enterprise skin
  def load_smart_client(opts={})
    skin = opts[:skin] || 'Enterprise'
    modules_to_load = opts[:modules] || ISC_MODULES.map(&:first)

    # Set isomorphic dir
    out = "<script>var isomorphicDir='#{static_url_for('/isomorphic')}/';</script>"

    # Load each module
    ISC_MODULES.each do |key, js_file|
      if modules_to_load.include?(key)
        js_url = static_url_for("/isomorphic/system/modules/#{js_file}")
        out += "<script src='#{js_url}'></script>\n"
      end
    end

    # Load skin
    js_url = static_url_for("/isomorphic/skins/#{skin}/load_skin.js")
    out += "<script src='#{js_url}'></script>\n"
  end
end
