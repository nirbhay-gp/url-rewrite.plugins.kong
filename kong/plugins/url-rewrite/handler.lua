local plugin = {
  PRIORITY = 1000, -- set the plugin priority, which determines plugin execution order
  VERSION = "0.0.1", -- version in X.Y.Z format. Check hybrid-mode compatibility requirements.
}

function plugin:init_worker()
  kong.log.debug("url-rewrite: worker init")
end

function plugin:access(config) {
  matched_route = nil
  request_path  = kong.request.get_path()
  
  for _, item in ipairs(config) do
    if item.exact == true and  item.source == request_path then
      matched_route = item
      break
    else if item.exact == false and string.sub(request_path, 1, #item.source) == item.source then
      matched_route = item
      break
    end
  end

  if not matched_route == nil then 
    kong.service.request.set_path(matched_route.target)
    kong.service.request.set_header(match_route.header_name, matched_route.header_value)
  end

}

return plugin