### Elixir Tic Tac Toe Web Server

An Elixir Tic Tac Toe Web Server implemented with [Plug](https://hexdocs.pm/plug/readme.html) and Cowboy to handle incoming HTTP requests, using an Elixir [process registry](https://hexdocs.pm/elixir/master/Registry.html) to encapsulate pid management.


### Usage

Start the web server with `mix run --no-halt`.

Go to `http://localhost:4000/play`.

You will be redirected to `http://localhost:4000/play/:uuid`, where `:uuid` is your game's ID.

To make a move, add `/move/:your_move` to the end of the URL, and press enter.

### 
