From: carbonated beverage <ramune@net-ronin.org>
Date: Mon, 12 Jul 2004 11:36:29 +0000
Subject: mouse in 2.6.8-rc1 not working
Message-Id: <20040712113629.GA3151@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Hi all,

The mouse attached to the Type 5 keyboard on my Ultra 5
stopped working when I upgraded from 2.6.7-rc3 to 2.6.8-rc1.

Previously, even with 2.6.7-rc3, I had to boot into 2.4.x
and "wiggle" the mouse to get it initialized.  2.6.7-rc3
recognizes that a mouse is attached.  2.6.8-rc1 doesn't.

Doing a cat /dev/input/mouse0:

2.6.7-rc3 w/o booting into 2.4.x first:
Nothing is read.

2.6.8-rc1 regardless of 2.4.x being used:
mouse device isn't seen.

2.6.7-rc3 after initializing moue under 2.4.x:
works.

CONFIG_SERIAL_SUNCORE=y
CONFIG_SERIAL_SUNZILOG=y
CONFIG_SERIAL_SUNSU=y
CONFIG_SERIAL_SUNSAB=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y

CONFIG_INPUT=y

CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X24
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
CONFIG_INPUT_EVDEV=y

CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_SUNKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_SPARCSPKR=y

-- DN
Daniel
