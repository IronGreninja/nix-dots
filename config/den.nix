{
  inputs,
  den,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    (inputs.den.namespace "ig" false)
  ];

  _module.args.__findFile = den.lib.__findFile; # experimental den angle bracket syntax
}
