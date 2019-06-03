#!/bin/bash

submodules="apps/blob_utils apps/core_composer_app apps/core_curate_app apps/core_dashboard_app apps/core_dashboard_common_app "
submodules=${submodules}"apps/core_explore_common_app apps/core_explore_example_app apps/core_explore_federated_search_app "
submodules=${submodules}"apps/core_explore_keyword_app apps/core_explore_oaipmh_app apps/core_exporters_app apps/core_federated_search_app "
submodules=${submodules}"apps/core_main_app apps/core_module_blob_host_app apps/core_module_chemical_composition_app apps/core_module_excel_uploader_app "
submodules=${submodules}"apps/core_module_periodic_table_app apps/core_module_text_area_app apps/core_oaipmh_common_app apps/core_oaipmh_harvester_app "
submodules=${submodules}"apps/core_oaipmh_provider_app apps/core_parser_app apps/core_website_app apps/signals_utils apps/xml_utils"

origin=`git config --get remote.origin.url`

echo "fixing web..."
cd web;
git checkout central-dev
git remote remove origin
git remote add origin ${origin}
git remote add upstream https://github.com/usnistgov/web.git
cd ..

for f in ${submodules}; do
  repo=`echo $f | cut -d \/ -f 2`
  echo "fixing "${repo}"...";
  cd ${f};
  git checkout central-dev
  git remote remove origin
  git remote add origin ${origin}
  git remote add upstream https://github.com/usnistgov/${repo}.git
  cd ../..
done;
