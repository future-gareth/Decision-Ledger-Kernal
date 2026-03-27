// Generates a GitHub deploy key pair under .deploy-keys/ (gitignored) and prints the public key.
// Usage: go run ./scripts/gen_deploy_key (from repo root)
package main

import (
	"crypto/ed25519"
	"crypto/rand"
	"encoding/pem"
	"fmt"
	"os"
	"path/filepath"

	"golang.org/x/crypto/ssh"
)

func main() {
	const outDir = ".deploy-keys"
	const keyName = "github_deploy_ed25519"
	const comment = "github-deploy-decision-ledger-kernal"

	if err := os.MkdirAll(outDir, 0700); err != nil {
		panic(err)
	}
	pub, priv, err := ed25519.GenerateKey(rand.Reader)
	if err != nil {
		panic(err)
	}
	sshPub, err := ssh.NewPublicKey(pub)
	if err != nil {
		panic(err)
	}
	authLine := ssh.MarshalAuthorizedKey(sshPub)
	pubPath := filepath.Join(outDir, keyName+".pub")
	if err := os.WriteFile(pubPath, authLine, 0644); err != nil {
		panic(err)
	}
	block, err := ssh.MarshalPrivateKey(priv, comment)
	if err != nil {
		panic(err)
	}
	privPath := filepath.Join(outDir, keyName)
	if err := os.WriteFile(privPath, pem.EncodeToMemory(block), 0600); err != nil {
		panic(err)
	}
	fmt.Print(string(authLine))
}
