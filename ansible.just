alias boot := bootstrap

set working-directory := 'ansible'

# Run bootstrap playbook
[arg('ask_become', short='K', value='-K', help='ask for become password')]
bootstrap ask_become='' *tags:
    ansible-playbook bootstrap.yml \
        {{ ask_become }} \
        {{ if tags != '' { '--tags=' + replace(tags, ' ', ',') } else { '' } }}

# Apply shell and desktop software configuration
config:
    ansible-playbook bootstrap.yml -K --tags=dotfiles,shell,desktop --skip-tags=install,purge
