From: carbonated beverage <ramune@net-ronin.org>
Date: Sun, 15 Feb 2004 00:23:14 +0000
Subject: [Q] sun mouse on 2.6.x
Message-Id: <20040215002314.GH19221@net-ronin.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi all,

I'm unable to get the mouse recognized by gpm or X under 2.6.x
bk pulls although the kernel recognizes it.  I'm using the input
layer and tried specifying /dev/input/{mice,mouse0} to both gpm
and X.  /dev/psaux (I have the legacy option turned on) doesn't
work either.

The kernel seems to find it fine:

mice: PS/2 mouse device common for all mice
input: Sun Mouse on su/serio0

And everything's enabled in .config:

CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X24
CONFIG_INPUT_MOUSEDEV_SCREEN_Yv8
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m
CONFIG_MOUSE_SERIAL=m

But nothing from gpm or X.

I'm using a debian/testing setup on an Ultra 5.

Anyone have a suggestion on how to go about debugging this?

-- DN
Daniel
