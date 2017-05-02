failures = 0
count = 0


def pytest_addoption(parser):
    parser.addoption("--testing_board:port",
                     action="store",
                     default="8080",
                     help="port of testing_board server")
    parser.addoption("--testing_board:host",
                     action="store",
                     default="localhost",
                     help="host of testing_board server")
    parser.addoption("--testing_board:game",
                     action="store",
                     help="game id")
    parser.addoption("--testing_board:user",
                     action="store",
                     help="user id")


def pytest_runtest_logreport(report):
    global count
    global failures
    if report.when == 'call':
        if report.outcome == 'failed':
            failures += 1
        count += 1


def pytest_sessionfinish(session, exitstatus):
    print('HOST:', session.config.getoption("--testing_board:host"))
    print('PORT:', session.config.getoption("--testing_board:port"))
    print('PLUGIN: {} failures / {} tests'.format(failures, count))
    # TODO: Post results to testing_board server
