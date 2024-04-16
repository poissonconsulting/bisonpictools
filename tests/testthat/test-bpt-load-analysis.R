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

path <- system.file(package = "bisonpictools", "test-objects/analysis.RDS")
# Remove file extension from path (to be added in by bpt_load_analysis)
path_no_ext <- tools::file_path_sans_ext(path)

analysis <- bpt_load_analysis(
  file = path_no_ext
)

analysis2 <- readRDS(path)

test_that("analysis object is an smb.analysis object", {
  expect_identical(class(analysis), c("smb_analysis", "mb_analysis"))
})

test_that("analysis object loaded is identical to that loaded by readRDS", {
  expect_identical(analysis, analysis2)
})
