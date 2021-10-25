# @param v1: version number 1 string
# @param v2: version number 2 string
# @return
# 1 if v1 > v2,
# -1 if v1 < v2,
# 0 otherwise
def cmp(v1, v2)
    v1_subversions = v1.split(".")
    v2_subversions = v2.split(".")

    v1_parts_count = v1_subversions.count
    v2_parts_count = v2_subversions.count

    for i in 0 .. [v1_parts_count, v2_parts_count].min do
      result = single_version_part_compare(v1_subversions[i], v2_subversions[i])
      return result unless result == 0
    end

    # version prefixes match

    # same number of version parts
    return 0 if v1_parts_count == v2_parts_count

    return 1 if v1_parts_count > v2_parts_count

    return -1
end

def single_version_part_compare(part1, part2)
  return 0 if part1 == part2
  return 1 if part1.to_i > part2.to_i
  return -1
end

require 'test/unit'
extend Test::Unit::Assertions
def test_cmp
  ordered = ["0.1", "1.1", "1.2", "1.2.9.9.9.9", "1.3", "1.3.4", "1.10", "2", "2.13", "3"]

  # equality
  for i in 0 .. ordered.count - 1
    assert_equal(cmp(ordered[i], ordered[i]), 0)
  end

  # greater than
  for i in 1 .. ordered.count - 1
    assert_equal(cmp(ordered[i], ordered[i-1]), 1)
  end

  # less than
  for i in 1 .. ordered.count - 1
    assert_equal(cmp(ordered[i-1], ordered[i]), -1)
  end

  true
end
