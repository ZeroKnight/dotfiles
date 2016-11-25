#
# ZeroKnight's .zlogin
#

(
  # Compile configuration files in the background

  setopt EXTENDED_GLOB NULL_GLOB

  # zcompile the completion cache; siginificant speedup.
  for f ($ZDOTDIR/.zcomp^(*.zwc)(.)) zcompare $f

  # zcompile .zshrc
  zcompare $ZDOTDIR/.zshrc

  # zcompile all module config files
  for cfg ($ZDOTDIR/modules/**/*.zsh(.)) zcompare $cfg

  # zcompile all autoloaded functions
  for func ($ZDOTDIR/modules/*/functions/^(*.zwc)(.)) zcompare $func
) &!

