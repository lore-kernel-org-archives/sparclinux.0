From: Babu Moger <babu.moger@oracle.com>
Date: Fri, 19 May 2017 00:36:06 +0000
Subject: [PATCH 2/6] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Message-Id: <1495154170-854693-3-git-send-email-babu.moger@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, arnd@arndb.de
Cc: babu.moger@oracle.com, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Found this problem while enabling queued rwlock on SPARC.
The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
specific byte in qrwlock structure. Without this parameter,
we clear the wrong byte. Here is the code.

static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
 {
	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
 }

Define CPU_BIG_ENDIAN for SPARC to fix it.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
Reviewed-by: Jane Chu <jane.chu@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 arch/sparc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a2ad946..8787fc4 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -91,6 +91,10 @@ config ARCH_DEFCONFIG
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
=20
+config CPU_BIG_ENDIAN
+	bool
+	default y if SPARC64
+
 config ARCH_ATU
 	bool
 	default y if SPARC64
--=20
1.7.1

