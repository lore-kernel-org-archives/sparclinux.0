From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 09 Jun 2011 12:51:46 +0000
Subject: PATCH 0/2] sparc32: SMP bugfixes
Message-Id: <4DF0C1E2.2040502@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

During LEON testing and code inspection of the sun4m IPI traphandler 
problems were discovered. The patches have been made against sparc-2.6 
branch but also apply on v3.0-rc2.

Best Regards,
Daniel Hellstrom


---
 arch/sparc/kernel/entry.S       |    4 ++--
 arch/sparc/kernel/leon_kernel.c |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

