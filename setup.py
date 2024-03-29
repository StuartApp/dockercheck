from setuptools import setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="dockercheck",
    install_requires=["CherryPy", "docker", "prometheus-client", "psutil"],
    version="0.4",
    scripts=["dockercheck"],
    author="Davide Ferrari",
    author_email="d.ferrari@stuart.com",
    description="Check and expose containers health",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/StuartApp/dockercheck",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: GNU General Public License v3 (GPLv3)",
        "Operating System :: OS Independent",
    ],
)
