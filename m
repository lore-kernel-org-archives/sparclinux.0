From: Andres Salomon <dilinger@queued.net>
Date: Mon, 30 Aug 2010 03:53:52 +0000
Subject: [PATCH 1/9] of: move phandle/ihandle into types.h
Message-Id: <20100829235352.1744e7e3@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20100628215407.2017bf2f@debian>
	<20100829235100.6dcedcb8@debxo>
In-Reply-To: <20100829235100.6dcedcb8@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree-discuss@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org, x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, cjb@laptop.org, Mitch Bradley <wmb@laptop.org>, pgf@laptop.org, linux-kernel@vger.kernel.org, davem@davemloft.net, grant.likely@secretlab.ca, Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>


We need phandle for some exported sparc headers; of.h isn't an
exported header, and it would be silly to export it when all we
really need is one or two types from it.  So, move the phandle/ihandle
definitions into types.h.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 include/linux/of.h    |    3 ---
 include/linux/types.h |    4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index cad7cf0..db184dc 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -25,9 +25,6 @@
 
 #ifdef CONFIG_OF
 
-typedef u32 phandle;
-typedef u32 ihandle;
-
 struct property {
 	char	*name;
 	int	length;
diff --git a/include/linux/types.h b/include/linux/types.h
index 01a082f..26526ea 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -219,6 +219,10 @@ struct ustat {
 	char			f_fpack[6];
 };
 
+/* Basic openboot/openfirmware types */
+typedef u32 phandle;
+typedef u32 ihandle;
+
 #endif	/* __KERNEL__ */
 #endif /*  __ASSEMBLY__ */
 #endif /* _LINUX_TYPES_H */
-- 
1.5.6.5

