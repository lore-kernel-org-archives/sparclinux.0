From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Sun, 01 Feb 2009 18:54:58 +0000
Subject: make ARCH=sparc allmodconfig change
Message-Id: <20090201190029.GA8962@x200.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

After commit 761b602620b4627dbd8f1b0bd2896022dc168a6d
aka "sparc: Use 64BIT config entry"

	make ARCH=sparc allmodconfig

generates 64-bit kernel, while earlier it generated 32-bit kernel.

It's easy to see why sparc case different from x86 case:
common arch for sparc has same name as one of arches, while for x86
it's different. This makes 64BIT option visible.

Dunno, if this warrants revert, it's trivial to workaround here,
still...
