# monitor

A monitor for testing-board

## Configuring the environment

This uses the `dotenv` package to support environment configuration. In your
real project, you should copy `dot.env` to `.env` and configure it as necessary.
Generally speaking, you will keep `dot.env` under revision control, but not
`.env`.

## Building

First install the necessary npm dependencies:
```
npm install
```

Then build the Elm code:
```
npm run build
```

If this succeeds, the compiled and web-packed code will be in the `dist`
directory.

## Running the development server

To use this, you'll first need to
install [node-foreman](https://github.com/strongloop/node-foreman):

```
npm install -g foreman
```

You can use node-foreman to run the API server and the client:
```
nf start
```

After that the app should be available on http://localhost:3000.

When the development server is running, it will monitor changes to the source
code and recompile/redeploy as necessary. This is probably what you want to do
if you're hacking around in the code; it provides a very responsive edit-run
cycle.
