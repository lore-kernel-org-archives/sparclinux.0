From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 18 Sep 2017 16:53:27 +0000
Subject: [PATCH 0/2] Fix duplicates and change default endian for microblaze
Message-Id: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, babu.moger@oracle.com

This series fixes few Kconfig issues.

Babu Moger (2):
  arch: Fix duplicates in Kconfig for parisc and sparc
  arch: change default endian for microblaze

 arch/microblaze/Kconfig |    2 +-
 arch/parisc/Kconfig     |    3 ---
 arch/sparc/Kconfig      |    3 ---
 3 files changed, 1 insertions(+), 7 deletions(-)

