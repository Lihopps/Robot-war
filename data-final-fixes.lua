local raw = require("prototypes.util.raw_counter")



local raw_compil=raw.compil()
helpers.write_file("raw.json",helpers.table_to_json(raw_compil))

-- envoi vers control stage
data:extend({
  {
    type = "mod-data",
    data_type = "rawResource_per_item",
    data = raw_compil,
    name = "rw_rawR"
  }
})