from contextlib import closing
import http.client
import json

failures = 0
total = 0


def pytest_addoption(parser):
    parser.addoption("--testing_board:port",
                     action="store",
                     default="8080",
                     type=int,
                     help="port of testing_board server")
    parser.addoption("--testing_board:host",
                     action="store",
                     default="localhost",
                     help="host of testing_board server")
    parser.addoption("--testing_board:game",
                     action="store",
                     type=int,
                     default=0,
                     help="game id")
    parser.addoption("--testing_board:user",
                     action="store",
                     help="user id")


def pytest_runtest_logreport(report):
    global total
    global failures
    if report.when == 'call':
        if report.outcome == 'failed':
            failures += 1
        total += 1


def pytest_sessionfinish(session, exitstatus):
    host = session.config.getoption("--testing_board:host")
    port = session.config.getoption("--testing_board:port")
    game_id = session.config.getoption("--testing_board:game")
    user = session.config.getoption("--testing_board:user")

    with closing(http.client.HTTPConnection(host=host, port=port)) as conn:
        headers = {"Content-type": "application/json"}
        url = '/results/{}'.format(game_id)
        results = {
            'results': {
                'user': user,
                'total': total,
                'failures': failures,
            }
        }
        params = json.dumps(results)
        conn.request("POST", url, params, headers)
