test_that("ratio names generates correct name for calf:(cow + calf) ratio", {
  expect_equal(bpt_ratio_names(c("f0", "m0", "u0"), "fa"), "calf:(cow + calf)")
  expect_equal(bpt_ratio_names(c("m0", "u0", "f0"), "fa"), "calf:(cow + calf)")
  expect_equal(bpt_ratio_names(c("u0", "f0", "m0"), "fa"), "calf:(cow + calf)")
})

test_that("ratio names generates correct name for calf:(bull + calf) ratio", {
  expect_equal(bpt_ratio_names(c("f0", "m0", "u0"), "ma"), "calf:(bull + calf)")
  expect_equal(bpt_ratio_names(c("f0", "m0", "u0"), "ma"), "calf:(bull + calf)")
  expect_equal(bpt_ratio_names(c("f0", "m0", "u0"), "ma"), "calf:(bull + calf)")
})

test_that("ratio names generates correct name for cow:(bull + cow) ratio", {
  expect_equal(bpt_ratio_names("fa", "ma"), "adult cow:(bull + cow)")
})

test_that("ratio names generates correct name for bull:(cow + bull) ratio", {
  expect_equal(bpt_ratio_names("ma", "fa"), "adult bull:(cow + bull)")
})

test_that("ratio names generates correct name for cow:(bull + cow) ratio", {
  expect_equal(bpt_ratio_names("fa", c("ma", "m2", "m3")), "mature cow:(bull + cow)")
  expect_equal(bpt_ratio_names("fa", c("m3", "ma", "m2")), "mature cow:(bull + cow)")
})

test_that("ratio names generates correct name for bull:(cow + bull) ratio", {
  expect_equal(bpt_ratio_names(c("ma", "m2", "m3"), "fa"), "mature bull:(cow + bull)")
  expect_equal(bpt_ratio_names(c("m3", "m2", "ma"), "fa"), "mature bull:(cow + bull)")
})

test_that("ratio names generates correct name for yearling female:(male + female) ratio", {
  expect_equal(bpt_ratio_names("f1", "m1"), "yearling female:(male + female)")
})

test_that("ratio names generates correct name for yearling male:(female + male) ratio", {
  expect_equal(bpt_ratio_names("m1", "f1"), "yearling male:(female + male)")
})

test_that("ratio names generates correct name for calf female:(male + female) ratio", {
  expect_equal(bpt_ratio_names("f0", "m0"), "calf female:(male + female)")
})

test_that("ratio names generates correct name for calf male:(female + male) ratio", {
  expect_equal(bpt_ratio_names("m0", "f0"), "calf male:(female + male)")
})

test_that("ratio names generates correct name for female:(male + female) ratio without unknowns", {
  expect_equal(
    bpt_ratio_names(c("f0", "f1", "fa"), c("m0", "m1", "ma", "m2", "m3")),
    "female:(male + female)"
  )
  expect_equal(
    bpt_ratio_names(c("f1", "fa", "f0"), c( "m3", "ma", "m0", "m1", "m2")),
    "female:(male + female)"
  )
})

test_that("ratio names generates correct name for total female:(male + female) ratio", {
  expect_equal(
    bpt_ratio_names(c("f0", "f1", "fa", "fu"), c("m0", "m1", "ma", "m2", "m3", "mu")),
    "female:(male + female)"
  )
  expect_equal(
    bpt_ratio_names(c("f1", "fa", "fu", "f0"), c("mu", "m3", "ma", "m0", "m1", "m2")),
    "female:(male + female)"
  )
})

test_that("ratio names generates correct name for total male:(female + male) ratio", {
  expect_equal(
    bpt_ratio_names(c("m0", "m1", "ma", "m2", "m3"), c("f0", "f1", "fa")), 
    "male:(female + male)"
  )
  expect_equal(
    bpt_ratio_names(c("m1", "ma", "m0", "m2", "m3"), c("f0", "fa", "f1")), 
    "male:(female + male)"
  )
})
