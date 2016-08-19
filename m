From: mcgrof@kernel.org
Date: Fri, 19 Aug 2016 21:34:00 +0000
Subject: [PATCH v4 02/16] dell-smo8800: include uaccess.h
Message-Id: <1471642454-5679-3-git-send-email-mcgrof@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
In-Reply-To: <1471642454-5679-1-git-send-email-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, jpoimboe@redhat.com, bp@alien8.de, linux@arm.linux.org.uk, mhiramat@kernel.org, masami.hiramatsu.pt@hitachi.com, jbaron@akamai.com, heiko.carstens@de.ibm.com, ananth@linux.vnet.ibm.com, anil.s.keshavamurthy@intel.com, davem@davemloft.net, realmz6@gmail.com
Cc: gnomes@lxorguk.ukuu.org.uk, linux-ia64@vger.kernel.org, jkosina@suse.cz, benh@kernel.crashing.org, ming.lei@canonical.com, linux@rasmusvillemoes.dk, platform-driver-x86@vger.kernel.org, James.Bottomley@HansenPartnership.com, paul.gortmaker@windriver.com, paulus@samba.org, sparclinux@vger.kernel.org, mchehab@osg.samsung.com, linux-arch@vger.kernel.org, markus.heiser@darmarit.de, xen-devel@lists.xensource.com, msalter@redhat.com, linux-sh@vger.kernel.org, mpe@ellerman.id.au, x86@kernel.org, fontana@sharpeleven.org, linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com, dvhart@infradead.org, dwmw2@infradead.org, linux-xtensa@linux-xtensa.org, pali.rohar@gmail.com, keescook@chromium.org, arnd@arndb.de, jani.nikula@intel.com, will.deacon@arm.com, rusty@rustcorp.com.au, rostedt@goodmis.org, acme@redhat.com, ak@linux.intel.com, andriy.shevchenko@linux.intel.com, mcb30@ip

From: "Luis R. Rodriguez" <mcgrof@kernel.org>

sections.h is currently included and it provides dell-smo8800
with what it needs, an upcoming change will decouple uaccess.h
from sections.h. This driver needs to explicitly require uaccess.h
before this change.

v3: new to this series -- needed due to collateral of the split of
    old linker tables from tables.h into 3 files: sections.h, ranges.h
    and tables.h

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 drivers/platform/x86/dell-smo8800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86/del=
l-smo8800.c
index 0aec4fd4c48e..37e646034ef8 100644
--- a/drivers/platform/x86/dell-smo8800.c
+++ b/drivers/platform/x86/dell-smo8800.c
@@ -24,6 +24,7 @@
 #include <linux/acpi.h>
 #include <linux/interrupt.h>
 #include <linux/miscdevice.h>
+#include <linux/uaccess.h>
=20
 struct smo8800_device {
 	u32 irq;                     /* acpi device irq */
--=20
2.9.2

