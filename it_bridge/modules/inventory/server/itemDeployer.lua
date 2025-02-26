function it.itemDeployer(items)


end

exports("itemDeployer", function(items)
    -- Check if items is a table
    if type(items) ~= "table" then
        it.print.error("itemDeployer: items must be a table")
        return
    end

    return it.itemDeployer(items)
end)