From: Babu Moger <babu.moger@oracle.com>
Date: Mon, 18 Sep 2017 16:53:29 +0000
Subject: [PATCH 2/2] arch: change default endian for microblaze
Message-Id: <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: monstr@monstr.eu, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org, babu.moger@oracle.com

Fix the default for microblaze. Michal Simek mentioned default for
microblaze should be CPU_LITTLE_ENDIAN.

Fixes : commit 206d3642d8ee ("arch/microblaze: add choice for endianness
	and update Makefile")

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Cc: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 9d26abd..4f798aa 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -39,7 +39,7 @@ config MICROBLAZE
 # Endianness selection
 choice
 	prompt "Endianness selection"
-	default CPU_BIG_ENDIAN
+	default CPU_LITTLE_ENDIAN
 	help
 	  microblaze architectures can be configured for either little or
 	  big endian formats. Be sure to select the appropriate mode.
-- 
1.7.1

