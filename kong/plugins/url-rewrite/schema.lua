local typedefs = require "kong.db.schema.typedefs"


local PLUGIN_NAME = "url-rewrite"

local schema = {
    name = PLUGIN_NAME,
    fields = {
      { consumer = typedefs.no_consumer },
      { route = typedefs.no_route },
      { config = {
          type = "array",
          elements = {
            type = "record",
            fields = {
              { source = typedefs.path { required = true } },
              { target = typdefs.path { required = true } },
              { header_name = { type = "string", required = true } },
              { header_value = { type = "string", required = true } },
              { exact = { type="boolean", default=true } },
            },
          }, 
        }, 
      },
    },
}

return schema