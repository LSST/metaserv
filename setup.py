from setuptools import setup

setup(
    name='metaserv',
    package_dir={'lsst': 'python/lsst'},
    package_data={'lsst': ['dax/metaserv/config/*', 'dax/metaserv/templates/*',
                           'dax/metaserv/static/*']},
    packages=['lsst', 'lsst.dax.metaserv'],
    zip_safe=False,
    use_scm_version={'version_scheme': 'post-release'},
    setup_requires=['setuptools_scm']
)
