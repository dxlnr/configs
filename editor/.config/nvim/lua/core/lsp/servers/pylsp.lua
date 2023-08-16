return {
  settings = {
    pylsp = {
      plugins = {
        pylint = {
          args = { {'--ignore=E501,E231', '-'}, enabled=true, debounce=200 }
        },
        pycodestyle = {
          enabled=true,
          ignore={'E501', 'E231', 'E121', 'E126', 'E203', 'E731', 'W503'},
          maxLineLength=96
        },
      }
    }
  }
}
