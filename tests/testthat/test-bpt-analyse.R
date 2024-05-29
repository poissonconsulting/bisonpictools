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

test_that(
  "analysis fails with negative thinning rate",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        location_data = location_data,
        census_data = census_data,
        proportion_calf_data = proportion_calf_data,
        nthin = -1L,
        analysis_mode = "quick"
      ),
      "`nthin` must be greater than or equal to 1."
    )
  }
)

test_that(
  "analysis fails with unrecognized analysis mode",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        location_data = location_data,
        census_data = census_data,
        proportion_calf_data = proportion_calf_data,
        nthin = 1L,
        analysis_mode = "hurry"
      ),
      "`analysis_mode` must match"
    )
  }
)

test_that(
  "analysis fails with decimal thinning rate",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        location_data = location_data,
        census_data = census_data,
        proportion_calf_data = proportion_calf_data,
        nthin = 0.1,
        analysis_mode = "quick"
      ),
      "`nthin` must be integer."
    )
  }
)

test_that(
  "analysis fails with no inputs",
  {
    expect_error(
      analysis <- bpt_analyse(),
      "argument \"event_data\" is missing, with no default"
    )
  }
)

test_that(
  "analysis fails missing event_data input",
  {
    expect_error(
      analysis <- bpt_analyse(
        location_data = location_data,
        proportion_calf_data = proportion_calf_data,
        census_data = census_data,
        nthin = 1L,
        analysis_mode = "quick"
      ),
      "argument \"event_data\" is missing, with no default"
    )
  }
)

test_that(
  "analysis fails missing location_data input",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        proportion_calf_data = proportion_calf_data,
        census_data = census_data,
        nthin = 1L,
        analysis_mode = "quick"
      ),
      "argument \"location_data\" is missing, with no default"
    )
  }
)

test_that(
  "analysis fails missing census_data input",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        location_data = location_data,
        proportion_calf_data = proportion_calf_data,
        nthin = 1L,
        analysis_mode = "quick"
      ),
      "argument \"census_data\" is missing, with no default"
    )
  }
)

test_that(
  "analysis fails missing proportion_calf_data input",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        location_data = location_data,
        census_data = census_data,
        nthin = 1L,
        analysis_mode = "quick"
      ),
      "argument \"proportion_calf_data\" is missing, with no default"
    )
  }
)

test_that(
  "analysis fails providing wrong data",
  {
    expect_error(
      analysis <- bpt_analyse(
        event_data = event_data,
        location_data = location_data,
        census_data = census_data,
        proportion_calf_data = census_data,
        nthin = 1L,
        analysis_mode = "quick"
      ),
      "Column names in data must include 'proportion_calf', 'proportion_calf_cv', 'proportion_calf_day', 'proportion_calf_month' and 'proportion_calf_year'."
    )
  }
)
