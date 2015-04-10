class dotcms::plugin{

  anchor { 'dotcms::plugin::start': } ->
  class { 'dotcms::plugin::config': } ~> 
  class { 'dotcms::plugin::reload': } ->
  anchor { 'dotcms::plugin::end': }

}

