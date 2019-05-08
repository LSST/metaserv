#!/usr/bin/env python

# This file is part of dax_metaserv.
#
# Developed for the LSST Data Management System.
# This product includes software developed by the LSST Project
# (http://www.lsst.org).
# See the COPYRIGHT file at the top-level directory of this distribution
# for details of code ownership.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

"""
This is RESTful LSST Metadata Server. It handles /api/meta.
"""

from flask import Flask, request
import json
import os

from configparser import RawConfigParser

from sqlalchemy import create_engine

from lsst.dax.metaserv import api_v1 as ms_api_v1

app = Flask(__name__)

# Initialize configuration
metaserv_parser = RawConfigParser()
metaserv_parser.optionxform = str

# Configure DB Engine
defaults_file = "~/.lsst/webserv.ini"

with open(os.path.expanduser(defaults_file)) as cfg:
    metaserv_parser.read_file(cfg, defaults_file)

database_config = dict(metaserv_parser.items("webserv"))
meta_db_url = database_config.get("dax.metaserv.db.url")
if "pymysql" not in meta_db_url:
    # FIXME: Using pymysql to bypass the SSL_CTX_set_tmp_dh error
    meta_db_url = meta_db_url.replace("mysql", "mysql+pymysql")
app.config["default_engine"] = create_engine(meta_db_url)


@app.route('/')
@app.route('/api')
def route_root():
    fmt = request.accept_mimetypes.best_match(['application/json', 'text/html'])
    s = '''Test server for testing metadata. Try adding /meta to URI.'''
    if fmt == "text/html":
        return s
    return json.dumps(s)


@app.route('/api/meta')
def route_meta():
    """Lists supported versions for /meta."""
    fmt = request.accept_mimetypes.best_match(['application/json', 'text/html'])
    s = '''v1'''
    if fmt == "text/html":
        return s
    return json.dumps(s)


app.register_blueprint(ms_api_v1.meta_api_v1, url_prefix='/api/meta/v1')

if __name__ == '__main__':
    try:
        app.run(
                host=app.config.get("dax.webserv.host", "0.0.0.0"),
                port=int(app.config.get("dax.webserv.port", "5000")),
                debug=app.config.get("dax.webserv.debug", True),
                **werkzeug_options
                )
    except Exception as e:
        print("Problem starting the Meta Server.", str(e))

