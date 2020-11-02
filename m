From: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Date: Mon, 02 Nov 2020 23:06:02 +0000
Subject: [PATCH] sparc64: fix kconfig dependency bug for COMPAT
Message-Id: <20201102230601.644472-1-fazilyildiran@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, paul@pgazz.com, jeho@cs.utexas.edu, Necip Fazil Yildiran <fazilyildiran@gmail.com>

When COMPAT is enabled and BINFMT_ELF is disabled, it results in the
following Kbuild warning:

WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
  Depends on [n]: COMPAT [=y] && BINFMT_ELF [=n]
  Selected by [y]:
  - COMPAT [=y] && SPARC64 [=y]

The reason is that COMPAT selects COMPAT_BINFMT_ELF without depending on
or selecting BINFMT_ELF while COMPAT_BINFMT_ELF depends on BINFMT_ELF.
This can also fail building the kernel as demonstrated in a bug report.

Honor the kconfig dependency to remove unmet direct dependency warnings
and avoid any potential build failures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id 9885
Signed-off-by: Necip Fazil Yildiran <fazilyildiran@gmail.com>
---
 arch/sparc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a6ca135442f9..22df5f0beed5 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -496,6 +496,7 @@ config COMPAT
 	bool
 	depends on SPARC64
 	default y
+	select BINFMT_ELF
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select ARCH_WANT_OLD_COMPAT_IPC
-- 
2.25.1
