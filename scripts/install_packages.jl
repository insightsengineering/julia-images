using Pkg;

# ARGS[1] contains the destination image name.

if ARGS[1] == "julia-vscode"
  pkgs=[
    "Distributions",
    "CSV",
    "DataFrames",
    "JSON",
    "BenchmarkTools"
  ]
elseif ARGS[1] == "julia"
  pkgs=[
    "Distributions",
    "CSV",
    "DataFrames",
    "JSON",
    "BenchmarkTools"
  ]
else
  println("Unknown destination image name.")
  exit(1)
end

println("The following Julia packages will be installed:")
display(pkgs)

for i in pkgs
  Pkg.add(i)
end
