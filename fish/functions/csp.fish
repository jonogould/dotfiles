function csp
  cloud_sql_proxy -instances=$argv[1]=tcp:$argv[2]
end
