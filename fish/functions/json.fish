function json --description "Syntax-highlighted JSON strings or files"
  # requires pip install pigments
  if count $argv > /dev/null
    # argument
    python -m json.tool $argv | pygmentize -l javascript;
  else
    # pipe
    python -m json.tool | pygmentize -l javascript;
  end
end

