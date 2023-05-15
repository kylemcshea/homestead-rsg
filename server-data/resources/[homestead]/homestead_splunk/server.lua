function send_to_splunk(data, source_type)
    local endpointUrl = GetConvar('webhook:splunkLink', '')
    local authToken = GetConvar('webhook:splunkToken', '')

    if (endpointUrl == '' or authToken == '') then
        print('[INFO] Splunk webhook not configured')
        print('[INFO] Please check your webhooks.cfg file')
        return
    end

    local index = "main"
    local sourcetype = source_type
    local headers = {
      ["Authorization"] = "Splunk " .. authToken,
      ["Content-Type"] = "application/json",

    }
    local body = json.encode({
      index = index,
      sourcetype = sourcetype,
      event = data
    })
    PerformHttpRequest(endpointUrl, function(statusCode, responseBody, responseHeaders)
      if statusCode ~= 200 then
        print("Failed to send data to Splunk:", responseBody)
      end
    end, "POST", body, headers)
end

exports('send_to_splunk', send_to_splunk)