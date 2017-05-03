# testing_board

This is a silly implementation of a leader-board for pytest.

The idea is that a small webserver will accept test reports and make them
available through HTTP endpoints. Testers can use a pytest plugin to send their
test results to this server. An Elm web page will poll the server for results
and show a graph. The point is that you could us this in e.g. a workshop on TDD
where students start with a failing test suite and progressively pass more
tests; the chart will show this progress.

## Server and pytest plugin

To install the server and/or pytest plugin, use:

```
python setup.py install
```

You can then run the server with:

```
python -m testing_board.server
```

To use the pytest plugin, you'll need to pass some command-line arguments to pytest. At a minimum you need to provide a user name:

```
python -m pytest --testing_board:user=<your name> . . .
```

The score tracker keeps track of result on a per-name basis, so users should use
the same name consistently. You can also specify a game ID (defaults to 0) as
well as a host and port of the server with:

```
--testing_board:host
--testing_board:port
--testing_board:game
```

## Elm client

Ultimately there are many ways to deploy the Elm client, but a simple way is
using a developmnent server through node foreman. First, you need to be in the
`elm/monitor` directory. Then install the node dependencies:

```
npm install
```

Then you need to create a `.env` file. Generally do this by copying `dot.env` to
`.env` and editing it as necessary.

Once this is done, you can optionally test that everything builds:

```
npm run build
```

To run things from a dev server, use:

```
nf start
```

This will serve the app on port 3000. It will also monitor changes to the source
and recompile it as needed.

(Note: if you don't have the `nf` command you probably need to install node
foreman with `npm install -g foreman`)

The Elm client will poll the server for scores.
