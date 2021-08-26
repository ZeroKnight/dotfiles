# Iosevka Zero

My customized Iosevka font family.

## Building

1. Grab the [iosevka-build][1] Docker image and follow [these instructions][2]
    1. Symlink `private-build-plans.toml` to `iosevka-zero-build-plans.toml`;
      the docker image expects this name
    2. Pass `ttf::iosevka-zero` as an argument to the `docker run` command to
       avoid building more than is necessary
2. Grab the [nerdfonts/patcher][3] Docker image and follow the instructions
    - Also grab the [VSCode Codicons][4] font for LSP Kind icons
        - Include a directory with `codicon.ttf` as a bind mount (`-v`)
        - Run the patcher image *without* `--rm` and with `--entrypoint sh` in order to copy `codicon.ttf` to
          `/nerd/src/glyphs`
        - Start patching via `docker exec <container name> sh /nerd/bin/scripts/docker-entrypoint.sh`. Include
          `--custom codicon` and any other desired font arguments
    - Might need to pass absolute paths to the `-v` options to get it to work
3. (Optional) Use [unitettc][5] to merge the patched ttfs into a single ttc


[1]: https://github.com/avivace/fonts-iosevka
[2]: https://github.com/be5invis/Iosevka#using-a-docker-container
[3]: https://github.com/ryanoasis/nerd-fonts/#font-patcher
[4]: https://github.com/microsoft/vscode-codicons/blob/main/dist/codicon.ttf
[5]: http://yozvox.web.fc2.com/556E697465545443.html
