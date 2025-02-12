function DoesExportExist(resource, export)
    if GetResourceState(resource) == "started" then
        local resourceExports = exports[resource]
        if resourceExports and resourceExports[export] then
            return true
        end
    end
    return false
end