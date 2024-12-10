import sys
from pathlib import Path


parent_dir = Path(__file__).parent.parent.parent
if str(parent_dir) not in sys.path:
    sys.path.insert(0, str(parent_dir))

from lib.lib import Plugin

PLUGIN = Plugin(
    name="ripgrep",
    cmd="rg",
    repo_name="BurntSushi/ripgrep",
    filename_template="ripgrep-{version}-{arch}-{platform}.tar.gz",
    platform_map={
        "darwin": "apple-darwin",
        "linux": "unknown-linux-musl",
    },
    bin_path=lambda kwargs: f"{kwargs['filename'].rstrip('.tar.gz')}/rg",
    checksum_filename_template="{filename}.sha256",
)
