# vim: ft=sh:
# only run on rhel
@test "should have carbon-cache running" {
  [ "$(ps aux | grep carbon-cache | grep -v grep)" ]
}

@test "should have carbon-relay running" {
  [ "$(ps aux | grep carbon-relay | grep -v grep)" ]
}
