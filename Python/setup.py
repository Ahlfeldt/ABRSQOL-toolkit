from setuptools import setup, find_packages


extra_test = [
    'pytest>=4',
    'pytest-cov>=2',
]
extra_dev = [
    *extra_test,
    'twine>=4.0.2'
]

extra_ci = [
    *extra_test,
    'python-coveralls',
]

name='ABRSQOL'

with open('./README.md', 'r') as f:
    long_description = f.read()

setup(
    name=name,
    version="0.1.0",
    description='Numerical solution algorithm to invert a quality of life measure.',
    long_description=long_description,
    long_description_content_type='text/markdown',
    url='https://github.com/Ahlfeldt/ABRSQOL-toolkit/blob/main/Python',
    author='Gabriel M Ahlfeldt',
    author_email='g.ahlfeldt@hu-berlin.de',
    license='MIT',
    install_requires=['numpy', 
                      'pandas', 
    ],

    packages=[name],
    # packages=find_packages(where='app'),
    # package_dir={"":"app"}
    extras_require={
        'test': extra_test,
        'dev': extra_dev,
        'ci': extra_ci,
    },

    entry_points={
        # 'console_scripts': [
        #     'add=my_pip_package.math:cmd_add',
        # ],
    },

    classifiers=[

        'Programming Language :: Python',
        'Programming Language :: Python :: 3',
    ],
)
