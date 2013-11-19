# vim: ft=sh:
# only run on rhel
@test "should have carbon running" {
  [ "$(ps aux | grep carbon | grep -v grep)" ]
}
