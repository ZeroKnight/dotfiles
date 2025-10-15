-- Additional filetype detection

vim.filetype.add {
  -- NOTE: filetype.add does some implicit anchoring of these patterns
  pattern = {
    -- Podman Quadlet Units
    ['.*/containers/systemd/.*%.container'] = 'systemd',
    ['.*/containers/systemd/.*%.volume'] = 'systemd',
    ['.*/containers/systemd/.*%.network'] = 'systemd',
    ['.*/containers/systemd/.*%.kube'] = 'systemd',
    ['.*/containers/systemd/.*%.image'] = 'systemd',
    ['.*/containers/systemd/.*%.build'] = 'systemd',
    ['.*/containers/systemd/.*%.pod'] = 'systemd',
    ['.*/containers/systemd/.*%.d/.*%.conf'] = 'systemd',
  },
}
