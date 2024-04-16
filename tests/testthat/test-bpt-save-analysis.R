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

analysis <- readRDS(
  file = system.file(package = "bisonpictools", "test-objects/analysis.RDS")
)

dir <- tempdir()

bpt_save_analysis(analysis, file = paste0(dir, "/analysis"))

files <- list.files(dir)

test_that("analysis file was saved to temporary directory", {
  expect_true("analysis.RDS" %in% files)
})

analysis2 <- readRDS(file = paste0(dir, "/analysis.RDS"))

test_that("analysis file read back in is the same as the initial file", {
  expect_identical(analysis, analysis2)
})
