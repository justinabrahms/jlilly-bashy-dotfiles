/^[0-9]/ {
  file = $3
  add[file] += $1
  rm[file] += $2
  tot[file] += 1
}

END {
  for (file in tot) {
    printf "%s times: %s\n", tot[file], file
  }	
}
