# -*- coding: utf-8 -*-
# align plugin
#
# For now only aligns usernames.
#
# Configure like this:
#
# Earthquake.config[:plugin_align] = {
#     :name_maxlen => 10,
#     :more_char => '…'
# }

Earthquake.init do
    cfg = config[:plugin_align] ||= {}
    cfg[:name_maxlen] ||= 12
    cfg[:more_char] ||= '…'

    maxlen = cfg[:name_maxlen]
    output_filter do |item|
        next unless item['user']
        username = item['user']['screen_name']
        if username.length > maxlen
            username = username[0..maxlen-2] + cfg[:more_char]
        end
        username = username.ljust(maxlen)
        item['user']['screen_name'] = username
        true
    end
end
