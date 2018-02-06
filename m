From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue, 06 Feb 2018 19:34:23 +0000
Subject: [PATCH net-next] sun: Add SPDX license tags to Sun network drivers
Message-Id: <1517945663-3214-1-git-send-email-shannon.nelson@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, davem@davemloft.net
Cc: sparclinux@vger.kernel.org

Add the appropriate SPDX license tags to the Sun network drivers
as outlined in Documentation/process/license-rules.rst.

Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/sun/Kconfig          | 1 +
 drivers/net/ethernet/sun/cassini.c        | 1 +
 drivers/net/ethernet/sun/cassini.h        | 1 +
 drivers/net/ethernet/sun/ldmvsw.c         | 1 +
 drivers/net/ethernet/sun/niu.c            | 1 +
 drivers/net/ethernet/sun/sunbmac.c        | 1 +
 drivers/net/ethernet/sun/sungem.c         | 1 +
 drivers/net/ethernet/sun/sunhme.c         | 1 +
 drivers/net/ethernet/sun/sunqe.c          | 1 +
 drivers/net/ethernet/sun/sunvnet.c        | 1 +
 drivers/net/ethernet/sun/sunvnet_common.c | 1 +
 11 files changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/sun/Kconfig b/drivers/net/ethernet/sun/Kconfig
index b2caf51..7b982e0 100644
--- a/drivers/net/ethernet/sun/Kconfig
+++ b/drivers/net/ethernet/sun/Kconfig
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Sun network device configuration
 #
diff --git a/drivers/net/ethernet/sun/cassini.c b/drivers/net/ethernet/sun/cassini.c
index 113bd57..9020b08 100644
--- a/drivers/net/ethernet/sun/cassini.c
+++ b/drivers/net/ethernet/sun/cassini.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* cassini.c: Sun Microsystems Cassini(+) ethernet driver.
  *
  * Copyright (C) 2004 Sun Microsystems Inc.
diff --git a/drivers/net/ethernet/sun/cassini.h b/drivers/net/ethernet/sun/cassini.h
index 882ce16..13f3860 100644
--- a/drivers/net/ethernet/sun/cassini.h
+++ b/drivers/net/ethernet/sun/cassini.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /* $Id: cassini.h,v 1.16 2004/08/17 21:15:16 zaumen Exp $
  * cassini.h: Definitions for Sun Microsystems Cassini(+) ethernet driver.
  *
diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/ldmvsw.c
index 5ea0376..a5dd627 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* ldmvsw.c: Sun4v LDOM Virtual Switch Driver.
  *
  * Copyright (C) 2016-2017 Oracle. All rights reserved.
diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 06001ba..8dd545f 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* niu.c: Neptune ethernet driver.
  *
  * Copyright (C) 2007, 2008 David S. Miller (davem@davemloft.net)
diff --git a/drivers/net/ethernet/sun/sunbmac.c b/drivers/net/ethernet/sun/sunbmac.c
index 0b1f41f..f047b27 100644
--- a/drivers/net/ethernet/sun/sunbmac.c
+++ b/drivers/net/ethernet/sun/sunbmac.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* sunbmac.c: Driver for Sparc BigMAC 100baseT ethernet adapters.
  *
  * Copyright (C) 1997, 1998, 1999, 2003, 2008 David S. Miller (davem@davemloft.net)
diff --git a/drivers/net/ethernet/sun/sungem.c b/drivers/net/ethernet/sun/sungem.c
index a7afcee..7a16d40 100644
--- a/drivers/net/ethernet/sun/sungem.c
+++ b/drivers/net/ethernet/sun/sungem.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* $Id: sungem.c,v 1.44.2.22 2002/03/13 01:18:12 davem Exp $
  * sungem.c: Sun GEM ethernet driver.
  *
diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index 0431f1e..06da2f5 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* sunhme.c: Sparc HME/BigMac 10/100baseT half/full duplex auto switching,
  *           auto carrier detecting ethernet driver.  Also known as the
  *           "Happy Meal Ethernet" found on SunSwift SBUS cards.
diff --git a/drivers/net/ethernet/sun/sunqe.c b/drivers/net/ethernet/sun/sunqe.c
index a6bcdcd..7fe0d5e 100644
--- a/drivers/net/ethernet/sun/sunqe.c
+++ b/drivers/net/ethernet/sun/sunqe.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* sunqe.c: Sparc QuadEthernet 10baseT SBUS card driver.
  *          Once again I am out to prove that every ethernet
  *          controller out there can be most efficiently programmed
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/sunvnet.c
index 27fb226..63d3d6b 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* sunvnet.c: Sun LDOM Virtual Network Driver.
  *
  * Copyright (C) 2007, 2008 David S. Miller <davem@davemloft.net>
diff --git a/drivers/net/ethernet/sun/sunvnet_common.c b/drivers/net/ethernet/sun/sunvnet_common.c
index 8aa3ce4..d8f4c3f 100644
--- a/drivers/net/ethernet/sun/sunvnet_common.c
+++ b/drivers/net/ethernet/sun/sunvnet_common.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /* sunvnet.c: Sun LDOM Virtual Network Driver.
  *
  * Copyright (C) 2007, 2008 David S. Miller <davem@davemloft.net>
-- 
2.7.4

