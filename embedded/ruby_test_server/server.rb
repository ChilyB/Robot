require 'socket'               # Get sockets from stdlib

server = TCPServer.open(2010)  # Socket to listen on port 2000
loop {                         # Servers run forever
  client = server.accept       # Wait for a client to connect
    s = client.recv(256)

    printf("received from client >%s<\n", s)

    client.printf("Message from server. Bye!")

  client.close                 # Disconnect from the client
}
