import os
from pathlib import Path
from typing import NamedTuple


class FLAGS:
    script_path = Path(__file__).resolve()
    ckpt_dir = Path(os.path.join(script_path.parent.parent.parent, "assets/infore/hifigan"))
