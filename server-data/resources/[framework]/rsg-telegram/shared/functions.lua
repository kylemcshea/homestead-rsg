-- Debug Function
Debug = function(args1, args2)
    if not Config.Debug then return end

    if args1 ~= nil and args2 ~= nil then
        print(tostring(args1), tostring(args2))
    end

    if args1 ~= nil and args2 == nil then
        print(tostring(args1))
    end
end