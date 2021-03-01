From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 01 Mar 2021 16:10:38 +0000
Subject: [PATCH 5.10 390/663] sparc64: only select COMPAT_BINFMT_ELF if BINFMT_ELF is set
Message-Id: <20210301161201.158319182@linuxfoundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20210301161141.760350206@linuxfoundation.org>
In-Reply-To: <20210301161141.760350206@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Sasha Levin <sashal@kernel.org>

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 80bddf5c93a99e11fc9faf7e4b575d01cecd45d3 ]

Currently COMPAT on SPARC64 selects COMPAT_BINFMT_ELF unconditionally,
even when BINFMT_ELF is not enabled. This causes a kconfig warning.

Instead, just select COMPAT_BINFMT_ELF if BINFMT_ELF is enabled.
This builds cleanly with no kconfig warnings.

WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
  Depends on [n]: COMPAT [=y] && BINFMT_ELF [=n]
  Selected by [y]:
  - COMPAT [=y] && SPARC64 [=y]

Fixes: 26b4c912185a ("sparc,sparc64: unify Kconfig files")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/sparc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6ca135442f9a..530b7ec5d3ca9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -496,7 +496,7 @@ config COMPAT
 	bool
 	depends on SPARC64
 	default y
-	select COMPAT_BINFMT_ELF
+	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
-- 
2.27.0
