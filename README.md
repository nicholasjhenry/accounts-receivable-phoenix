# Accounts Receivable

Welcome to the Accounts Receivable system! This system is responsible for
creating, sending, and tracking invoices sent to clients so we can be paid for
our products and services.

## Getting started

### Prerequisites

Before you get started, be sure to:

* Be running a supported version of Elixir (we'd recommend version 1.9.2 or higher)
* Be running a supported version of Node (we'd recommend version 12.8.0 or higher)
* That you have a recent version of git installed (e.g. `brew install git` on a Mac)

### Initial setup

This is a conventional Phoenix, so you should be able to get up and
running with the following commands:

```
$ mix deps.get
$ mix ecto.setup
$ (cd assets && npm install)
```

(Note that in addition to running migrations, we're also loading the app's
seeds into the development database to help move things along.)

If nothing blew up, you should be able to start the Rails server:

```
$ mix phx.server
```

And then you should be able to see pre-generated invoices in a browser:
[http://localhost:4000](http://localhost:4000)
