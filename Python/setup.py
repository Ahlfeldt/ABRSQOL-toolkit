from setuptools import setup, find_packages

from ABRSQOL import __version__


extra_test = [
    'pytest>=4',
    'pytest-cov>=2',
]
extra_dev = [
    *extra_test,
]

extra_ci = [
    *extra_test,
    'python-coveralls',
]

setup(
    name='ABRSQOL',
    version=__version__,
    description='Numerical solution algorithm to invert a quality of life measure.',

    url='https://github.com/Ahlfeldt/ABRSQOL-toolkit/blob/main/Python',
    author='Gabriel M Ahlfeldt',
    author_email='g.ahlfeldt@hu-berlin.de',
    
    setup_requires=["numpy"],
    install_requires=[
        'numpy', 'pandas', 
    ],

    packages=find_packages(exclude=['tests', 'tests.*']),
    
    extras_require={
        'test': extra_test,
        'dev': extra_dev,
        'ci': extra_ci,
    },

    entry_points={
        'console_scripts': [
            'add=my_pip_package.math:cmd_add',
        ],
    },

    classifiers=[
        'Intended Audience :: Researchers',

        'Programming Language :: Python',
        'Programming Language :: Python :: 3',
    ],
)
