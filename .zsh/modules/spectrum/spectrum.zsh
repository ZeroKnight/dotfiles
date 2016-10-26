#
# Formatting and 256-Color Helper
#
# Authors:
# P.C. Shyamshankar <sykora@lucentbeing.com>
# Sorin Ionescu <sorin.ionescu@gmail.com>
# Alex "ZeroKnight" George <xzeroknightx@gmail.com>

typeset -gA FX FG BG

FX=(
                          reset         "\e[00m"
                          normal        "\e[22m"
  bold        "\e[01m"    no-bold       "\e[22m"
  italic      "\e[03m"    no-italic     "\e[23m"
  underline   "\e[04m"    no-underline  "\e[24m"
  blink       "\e[05m"    no-blink      "\e[25m"
  reverse     "\e[07m"    no-reverse    "\e[27m"
)

FG[reset]="$FX[reset]"
BG[reset]="$FX[reset]"
colors=(black red green yellow blue magenta cyan white)
for color in {0..$#colors}; do
  FG[$colors[$(($color+1))]]="\e[38;5;${color}m"
  BG[$colors[$(($color+1))]]="\e[38;5;${color}m"
done
for color in {0..255}; do
  FG[$color]="\e[38;5;${color}m"
  BG[$color]="\e[48;5;${color}m"
done
unset color{,s}

