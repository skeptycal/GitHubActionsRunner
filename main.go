// Package actionsrunner provides setup and config for the
// Google Actions Runner local
package actionsrunner

import (
	"fmt"
	"net/url"
	"os"
	"path/filepath"
	"strings"
)

func IsUrl(str string) bool {
	u, err := url.Parse(str)
	return err == nil && u.Scheme != "" && u.Host != ""
}

func main() {

	if len(os.Args) != 2 {
		fmt.Println("usage: setup <URL>")
		os.Exit(1)
	}

	repoURL := strings.TrimSpace(os.Args[1])
	repoPath, err := filepath.Abs(strings.TrimSpace(os.Args[0]))
	if err != nil {
		fmt.Printf("absolute path of script %s could not be determined: %v", repoPath, err)
		os.Exit(1)
	}

	if !IsUrl(repoURL) {
		fmt.Printf("invalid url %v: %v", repoURL, err)
		os.Exit(1)
	}

	repoURL, err := url.ParseRequestURI(os.Args[1])
	if err != nil {
		fmt.Printf("invalid url %v: %v", repoURL, err)
		return
	}

}
