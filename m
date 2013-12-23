From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 23 Dec 2013 19:43:22 +0000
Subject: [PATCH v2 00/11] SILO/TILO/sun4u: support TFTP booting modern kernels
Message-Id: <1387827813-8279-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Linux 3.13 exposes some limitations on old UltraSPARCs where the PROM
maps only 10 MB - the standard kernel TFTP boot no longer works very
well... See e-mail thread <http://marc.info/?t8592472200001&r=1&w=2>.

This patch set makes some improvements to TILO to help on that. Basically
it enables to boot a compressed kernel from dynamically allocated
space. I'm now able to tftpboot a bloaty 3.13-rc5 + initramfs on Sun
Ultra 5/10 with an image created by tilo.

The patch set also allows to cross-compile and run tilo e.g. on x86.

Aaro Koskinen (11):
  tilo: convert data to big endian
  tilo: compile maketilo with host toolchain
  tilo: support latest binutils
  tilo: replace sed with dirname in tilo.sh
  tilo: make root image optional
  tilo: sanity check image sizes
  tilo: support super large images
  tilo: check kernel space limits
  tilo: support ELF binaries
  tilo: allocate kernel memory dynamically on sun4u
  tilo: adjust comments/documentation

 tilo/Makefile   |  24 +++++-
 tilo/crt0.S     |   4 +
 tilo/maketilo.c |  88 ++++++++++++++------
 tilo/tilo.c     | 244 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tilo/tilo.sh    |  13 +--
 5 files changed, 327 insertions(+), 46 deletions(-)

-- 
1.8.5.1

