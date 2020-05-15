function rgb2hex --description "Convert RGB values to HEX color"
  for var in $argv
    printf '%x' "$var";
  end
  printf '\n'
end

