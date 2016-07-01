# www to non-www redirect -- duplicate content is BAD:
# https://github.com/h5bp/html5-boilerplate/blob/5370479476dceae7cc3ea105946536d6bc0ee468/.htaccess#L362
# Choose between www and non-www, listen on the *wrong* one and redirect to
# the right one -- http://wiki.nginx.org/Pitfalls#Server_Name
server {
  # don't forget to tell on which port this server listens
  listen [::]:80;
  listen 80;

  # listen on the www host
  server_name www.example.com;

  # and redirect to the non-www host (declared below)
  return 301 $scheme://example.com$request_uri;
}

server {
  # listen [::]:80 accept_filter=httpready; # for FreeBSD
  # listen 80 accept_filter=httpready; # for FreeBSD
  # listen [::]:80 deferred; # for Linux
  # listen 80 deferred; # for Linux
  listen [::]:80;
  listen 80;

  # The host name to respond to
  server_name example.com;

  # Path for static files
  root /sites/example.com/public;

  # Specify a charset
  charset utf-8;

  # Custom 404 page
  error_page 404 /404.html;





  # client_max_body_size   300m;
  # proxy_connect_timeout  900;
  # proxy_send_timeout     900;
  # proxy_read_timeout     900;
 
# location / {
#    proxy_pass  http://apachephp;
   
#    #Proxy Settings
#    proxy_redirect     off;
#    proxy_set_header   Host             $host;
#    proxy_set_header   X-Real-IP        $remote_addr;
#    proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
#    proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
#    proxy_max_temp_file_size 0;
#    proxy_connect_timeout      90;
#    proxy_send_timeout         90;
#    proxy_read_timeout         90;
#    proxy_buffer_size          4k;
#    proxy_buffers              4 32k;
#    proxy_busy_buffers_size    64k;
#    proxy_temp_file_write_size 64k;
#  }




# location ~ \.php$ {
#     root           html;
#     fastcgi_pass   127.0.0.1:9000;
#     fastcgi_index  index.php;
#     fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
#     include        fastcgi_params;
# }
 
}