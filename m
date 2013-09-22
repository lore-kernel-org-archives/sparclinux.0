From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 22 Sep 2013 19:33:02 +0000
Subject: [PATCH 0/2] SILO: support cross-compilation
Message-Id: <1379878384-26476-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Here's two simple patches to enable cross-compilation of SILO. The main
issue is that little-endian host produces a broken binary (only "SIL"
gets displayed and the boot hangs).

Aaro Koskinen (2):
  second/util: convert data to big endian
  silo: compile host-side tools with HOSTCC

 Rules.make      |  2 ++
 common/Makefile |  3 +++
 second/Makefile |  2 +-
 second/util.c   | 11 +++++++----
 4 files changed, 13 insertions(+), 5 deletions(-)

-- 
1.8.4.rc3

