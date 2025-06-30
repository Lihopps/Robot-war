local handler = require("__core__.lualib.event_handler")

handler.add_libraries({
    require("script.main"),
    require("script.base-builder"),
    require("script.entity"),
    require("script.platform"),
    require("script.force"),
    require("script.tool")
})
