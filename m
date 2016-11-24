From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 17:33:29 +0000
Subject: [PATCH] silo: Add 64-bit support
Message-Id: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Dave!

As promised in another mail earlier today, here is the current patch
changes that we are currently using on top of silo HEAD to build
it as a 64-bit package in Debian unstable (sparc64).

The silo package has been shipped in Debian with 64-bit support for
a while now without any major issues for most people. So far, I
only know of two cases where people had issues but this seems to
affect Serengeti and Amazon machines only and not a result of this
particular patch.

Thanks,

Adrian

> [1] http://marc.info/?l=linux-sparc&m7363964605901&w=2

