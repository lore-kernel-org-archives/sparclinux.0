From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 07 Dec 2013 23:26:49 +0000
Subject: [PATCH 00/10] SILO/TILO/sun4u: support TFTP booting modern kernels
Message-Id: <1386458819-6590-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Linux 3.13 exposes some limitations on old UltraSPARCs where the PROM
maps only 10 MB - the standard kernel TFTP boot no longer works very
well... See e-mail thread <http://marc.info/?t8592472200001&r=1&w=2>.

This patch set makes some improvements to TILO to help on that. I'm now
able to boot a bloaty 3.13-rc2 (kernel+initramfs, > 10 MB) on Sun Ultra
5/10 with an image created with:

	maketilo out=tftpboot.img sun4u=zImage size4u=`zcat zImage|wc -c`

External root/initramfs image does not work at the moment. You need to
use initramfs embedded into the kernel.

I'm currently using a little-endian host to compile OS images for all
of my computers, so also some cross-compilation fixes are included.

Aaro Koskinen (10):
  tilo: convert data to big endian
  tilo: compile maketilo with host toolchain
  tilo: support latest binutils
  tilo: fix typo in tilo.sh
  tilo: make root image optional
  tilo: sanity check image sizes
  tilo: support super large images
  tilo: check kernel space limits
  tilo: support ELF binaries
  tilo: allocate kernel memory dynamically on sun4u

 tilo/Makefile   |  24 +++++-
 tilo/crt0.S     |   4 +
 tilo/maketilo.c |  73 +++++++++++++-----
 tilo/tilo.c     | 236 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tilo/tilo.sh    |  13 ++--
 5 files changed, 312 insertions(+), 38 deletions(-)

-- 
1.8.4.4

