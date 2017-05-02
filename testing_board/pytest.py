failures = 0
count = 0


def pytest_runtest_logreport(report):
    global count
    global failures
    if report.when == 'call':
        if report.outcome == 'failed':
            failures += 1
        count += 1


def pytest_sessionfinish(session, exitstatus):
    print('PLUGIN: {} failures / {} tests'.format(failures, count))
