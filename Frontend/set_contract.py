"""Paste-and-run helper: updates CONTRACT_ADDRESS in app.html.

Usage:
    py set_contract.py 0xYourDeployedContractAddress
    py set_contract.py            (prompts for the address)

Only the CONTRACT_ADDRESS line is touched; nothing else in app.html changes.
"""
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
TARGET = HERE / "app.html"
PATTERN = re.compile(r'(const CONTRACT_ADDRESS\s*=\s*")([^"]*)(")')


def main() -> int:
    if len(sys.argv) > 1 and sys.argv[1] == "--current":
        m = PATTERN.search(TARGET.read_text(encoding="utf-8"))
        print(m.group(2) if m else "not set")
        return 0
    if len(sys.argv) > 1:
        addr = sys.argv[1].strip()
    else:
        addr = input("Paste deployed contract address (0x...): ").strip()

    if re.fullmatch(r"0x[0-9a-fA-F]{64}", addr):
        print(
            "That looks like a transaction hash (66 chars). "
            "A contract address is 42 chars — copy the address under "
            "'Deployed Contracts' in Remix."
        )
        return 1
    if not re.fullmatch(r"0x[0-9a-fA-F]{40}", addr):
        print("Invalid address. Paste a 42-character address starting with 0x.")
        return 1

    text = TARGET.read_text(encoding="utf-8")
    new_text, n = PATTERN.subn(r"\g<1>" + addr + r"\g<3>", text, count=1)
    if n == 0:
        print("CONTRACT_ADDRESS line not found in app.html.")
        return 1
    TARGET.write_text(new_text, encoding="utf-8")
    print(f"Updated CONTRACT_ADDRESS to {addr}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
