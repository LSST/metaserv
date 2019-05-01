#!/bin/bash -ex

echo "MetaServ test at lsst-lsp-int ..."
curl --fail -o /tmp/lsp_int_tb_md.json -L "https://lsst-lsp-int.ncsa.illinois.edu/api/meta/v1/db/1/1/tables/1/"