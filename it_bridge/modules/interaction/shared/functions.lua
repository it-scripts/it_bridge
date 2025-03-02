function ExtractOptionNames(options)
    local optionNames = {}
    if it.interaction == Interactions.OX then
        for _, optionData in pairs(options) do
            table.insert(optionNames, optionData.name)
        end
    end

    if it.interaction == Interactions.QB then
        for _, optionData in pairs(options) do
            table.insert(optionNames, optionData.label)
        end
    end

    return optionNames
end