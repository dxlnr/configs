return {
    cmd = {
	    "clangd",
    	"--background-index",
        "--include-ineligible-results",
	    "--clang-tidy",
	    "--header-insertion=iwyu",
        "--enable-config",
    },
}
