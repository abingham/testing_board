import io
import os
import re
from setuptools import setup, find_packages


def read(*names, **kwargs):
    with io.open(
        os.path.join(os.path.dirname(__file__), *names),
        encoding=kwargs.get("encoding", "utf8")
    ) as fp:
        return fp.read()


def find_version(*file_paths):
    version_file = read(*file_paths)
    version_match = re.search(r"^__version__ = ['\"]([^'\"]*)['\"]",
                              version_file, re.M)
    if version_match:
        return version_match.group(1)
    raise RuntimeError("Unable to find version string.")


long_description = read('README.md', mode='rt')


INSTALL_REQUIRES = [
    'aiohttp',
    'aiohttp-cors',
]

setup(
    name='testing_board',
    version=find_version('testing_board/version.py'),
    packages=find_packages(),

    author='Sixty North AS',
    author_email='austin@sixty-north.com',
    description='Leaderboard for unit tests',
    license='MIT License',
    keywords='testing',
    url='http://github.com/sixty-north/testing_board',
    classifiers=[
        'Development Status :: 3 - Alpha',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Topic :: Software Development :: Libraries :: Python Modules',
        'Topic :: Software Development :: Testing',
    ],
    platforms='any',
    include_package_data=True,
    install_requires=INSTALL_REQUIRES,
    long_description=long_description,

    # the following makes a plugin available to pytest
    entry_points={
        'pytest11': [
            'foobar = testing_board.pytest',
        ]
    },
)
