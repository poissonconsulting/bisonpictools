# Copyright 2023 Province of Alberta
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

## code to prepare `event_data` dataset goes here
path <- system.file(
  package = "bisonpictools",
  "example-data/data-raw.xlsx"
)

sheets <- readxl::excel_sheets(path)
event_data <- readxl::read_excel(path, 2)
usethis::use_data(event_data, overwrite = TRUE)
