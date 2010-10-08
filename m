From: Andres Salomon <dilinger@queued.net>
Date: Fri, 08 Oct 2010 18:34:24 +0000
Subject: [PATCH] sparc: stop exporting openprom.h header
Message-Id: <20101008113424.2249c2df@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20101008171210.GE3863@angua.secretlab.ca>
	<20101008.101759.193728130.davem@davemloft.net>
	<20101008173650.GH3863@angua.secretlab.ca>
	<20101008.104557.59696706.davem@davemloft.net>
In-Reply-To: <20101008.104557.59696706.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: grant.likely@secretlab.ca
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org, devicetree-discuss@lists.ozlabs.org


It's unknown why openprom.h was being exported; there doesn't seem to be any
reason for it currently, and it creates headaches with userspace being able
to potentially use the structures in there.  So, don't export it anymore.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 arch/sparc/include/asm/Kbuild |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index deeb0fb..3c93f08 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -7,7 +7,6 @@ header-y += display7seg.h
 header-y += envctrl.h
 header-y += fbio.h
 header-y += jsflash.h
-header-y += openprom.h
 header-y += openpromio.h
 header-y += perfctr.h
 header-y += psrcompat.h
-- 
1.5.6.5

