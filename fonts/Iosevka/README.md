# Iosevka Zero

My customized Iosevka font family.

## Build via Ansible

1. Install Docker
2. Install Ansible

Then just run the [ansible playbook](../../ansible/iosevka.yml).

## Building Manually

### Prerequisites

1. Install Docker
2. Clone the [Iosevka repository][1]
    - Or at least just the `docker` subtree
3. Pull the [`nerdfonts/patcher`][2] Docker image

### Building

1. Build the Iosevka `fontcc` [docker image][2]
    1. `cd Iosevka/docker`
    2. `docker build -t=fontcc .`
2. Symlink `private-build-plans.toml` to `iosevka-zero-build-plans.toml`; the docker image expects this name
3. Spin up a `fontcc` container to build the base font family
    - `docker run -it --rm -v "dotfiles/fonts/Iosevka:/work" fontcc 'ttf::iosevka-zero'`
    - Passing `ttf::iosevka-zero` as an argument avoids building more than is necessary
    - Built fonts will be output to the `dist` directory
4. Spin up a `nerdfonts/patcher` container to [patch the font family][3]
    - `docker run -it -v ./dist/iosevka-zero/TTF:/in:Z -v ./../nerdfont:/out:Z -e 'PN=16' nerdfonts/patcher -c --makegroups -1`
5. (Optional) Use [unitettc][4] to merge the patched ttfs into a single ttc


[1]: https://github.com/be5invis/Iosevka
[2]: https://github.com/be5invis/Iosevka/blob/main/docker
[3]: https://github.com/ryanoasis/nerd-fonts/#font-patcher
[4]: http://yozvox.web.fc2.com/556E697465545443.html
