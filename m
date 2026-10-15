Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022073.outbound.protection.outlook.com [52.101.66.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB47E4E36E3;
	Thu, 15 Oct 2026 08:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054562; cv=fail; b=kDHNjcU3AOJkOcaAz58qKDEWaqh2TVCVl+pwSPSuOE1Os6xff8LapDtV6uFOrBpXdBV5TUb2NUxSoRssps3eJqeQcC9MZ2TlLl2WHNtKJitHGamywOlJnDVpV3zaLlXkf7eena5TRXqwhPHELu7Lv6/D9cujDIxm2/XdOh5VVa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054562; c=relaxed/simple;
	bh=d/iQyTDtU6jfRX/oQe9pwJOhD0wsayeQU41Dxm09gXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t90YQV+zsYVC48t2xXifAXgqZnF1YXltXODqI0ExsLTvCXwe8sykLJqaZAKjuW8XMgjmDZf4Jc8joRL/8QRRxFnc8m9RY9iMsAlFZi/NbZ0wjSIc5oo5EAUSVAHrihtQHFcb0GPkv50VtW8fa/K+yJ32fccopGsvl54A+dlbDKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=HwAssURQ; arc=fail smtp.client-ip=52.101.66.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="HwAssURQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P75isKazpUceJfeFieJWg5j0tBZK4vRcHqIewqSah2cPheQZrLXrdU5qXnA/DJDPr4BH/yk+4AvrUUstrNONABihNPHjVOfcmovl+lIf8JzBsvQjmeHjGlLXNIIBL5yGl85+rUHrfSTHID83rspkcucw8MKfIIB3zypG7Dk+v6bhPtRO4ihmOhgCrNmLK+owwHWNVPsB3TQ0dv/q7y6n61sOSwttUZrlSYCAqiDYWbwOP2P97Ofyq/kun/S9/LQUxbPm0ymupUI0tJJiXKcPRq/O1Q/p5j9Ixmbxou/8fXJR8pGzVr6AbAhpS7PB/1sZuu7kihL5XTeVvVbAMul8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYnsVZrMyahsHRjzI5HAur08vcr2bmzu1lx8nrt7VJ0=;
 b=tc3O145nXM0WMdM4vtBAUGN15ojyIVBEB01LJtN77kw7/p+q3i//xNZ2juoOJK4Ir9ci5Yhrbf6pIBHiBHByoRs2XayLW+jiRlCAji8Y5V/4rWltFqcC0HGt7FI91vS7mDxLrZywcCD36/+iFUjgxukmAlr5aT0+oSZWc7cVKrcYei21bG9AuWYT4ZSTfj9tqPtPVWr8lIuXQhzoFqWkXKBF45ZQEkyAU8X+kUlNkwiKoB4e2TzjvXQbuH07jDgk7FeqyYn/tU06GHjPIYtwRhMpgL0fOdsV7HTQbkQsrTXTj36XwAl6G9Lt+JfUehyLAwnVRM38CS0+tLH9xg7DYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYnsVZrMyahsHRjzI5HAur08vcr2bmzu1lx8nrt7VJ0=;
 b=HwAssURQlcPFF17MZmcYYwTGbrf8VtDkB696wg0cNzgXqhrIZm4zFmxa5v6LIMpGe0sw38CeNESsppVZ9iQ4K5m/CJxppRifwahRaZzMtGU0bSpY/36LJR7CjZzQjBI6USQKKgFk2HTf6tioRFsqTa1QneqETqfUbOZWiOkYihUlDeQ4cLBgfEHCP3lpk62p+92fOrk8Wzl4LWXrrTdIktZhHrofAU+4a9ZlR6EhDHzvOu0geDb3xNdS7TRbfyx2Nvl4gtzyQkDOlermqKDWvam+dCx5TL0z1hVtrYFm+fIZbC6Kg95EUIUGqCWSbNh/9QisYNsglLc86+nCsz2HdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by MMZPR04MB084377.eurprd04.prod.outlook.com (2603:10a6:190:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:55:55 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 08:55:53 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sparc32: implement futex atomics, with casa detected at run time
Date: Thu, 15 Oct 2026 10:55:44 +0200
Message-ID: <20261015085545.3246951-4-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
References: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::17) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|MMZPR04MB084377:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a5bb2a-3d89-46c8-3731-08df2a9a1e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZvcvhSAVWlDBsWAXPI2+3lEw/Q7aTF0WMmfFuef4/NLkG8DFLWAocGpi7Clav8rWHU/zYrZ0Sg5DdqPNBS4dFbvn51t6ABlZhHJZVOG792PZIPX1enNg+GohY8FkUYC4AsssanL4KbzA60V/XCufz0rRJ76OCZUi8FAy8p14J0h75J2SVwknLa8ejYbGTKmnqyW3vskj088ZJMm7M44cLnAY/OFkAD7jN/aDi/OC7cinBC2C/n8Zq/6wVee40w7FgFwCzcG1n/4qNDbqS1G3sly4/PGNntIiHgBEILXqH+hNkLGoHa1sJ3ZLoEjLbpjAe7/l7cXWpWrkFisdwkNiGsFWBj5Ly0RlNlgHdx/F57CVNSYQvrzK+XUv/+uzm6YUDE3udghcdAhFF91Yr1BgizKPBu4NeOIiy6pK3oPTN8xU0RlQC6ujWq2vzclkfeJMF2EPmeHXulMYGlG4+A6JSCHkem6lCkIB7dYDfVocoPJLfRcYHHq/CBcnULsd8CmMk8Cy82WoK17FWaHNicjJndrtrGByvlWbLSzq64L4FqmhJe1RoqKOTuUhPninGS+Y19PSPrmSzQQ2n/D7xBnbYxUhM47IV51+QdFtUeCY6c+vjD51PgQADULilmEM+QpoR7KLMF20tznGGglFNITEm66y1ZsknoyHrhvlRMDVDFw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9LSEIfc95e35bcNUpmCb20unJIPrQJ2W8I62RP5nrvlLojLXHtES9s54OmW0?=
 =?us-ascii?Q?eFzre7zauMa6CwsFyTEBLuUEnls3BFCm95kHfaqxg/h3BB5NSxoFcuhqugIE?=
 =?us-ascii?Q?3mF/hOki05KUcHhM5V+5/3LboscbAghFH+YhO3yg3PC/nA58yvNnEKYZAjF1?=
 =?us-ascii?Q?a++D7MTzwGqHF6Cfj9HjnpbHKfkoVd7kzrWczhi7mOEFBcKG8Y0h/IaSlq/z?=
 =?us-ascii?Q?cw843rLsAc5DQHMvpfYt2tn/SfYWJOz5cNuQrT8z39fiISsHgVitvvWcPgjb?=
 =?us-ascii?Q?Ot4koxfUR7Iq21YlyvMTgbGe5AzqVbfWer5AxRRYpoml80LJTBKNSj0uLYrX?=
 =?us-ascii?Q?ltAWS1GHcWVg/PBFOvR3MjDEntHYbL9CZyXz/EnpXhdTcIpMak55KMCTBRCI?=
 =?us-ascii?Q?7AnZjPxNaN+LJl1mxzPBn9b5ZG3VUOVjwpzGz5xGnLDJTS7IzgLS7ARPVsDj?=
 =?us-ascii?Q?PgAh8koaZEUAXk3Ed03JMPew2dh8RbMr/CH7oHh9ldkoijEuh21sHa9eIiQD?=
 =?us-ascii?Q?WMuzEwUyD9J5/0tT/xs19bDDxjyKK/DjDSsDPkTt/4RqAT0HYU0Q634dRbcw?=
 =?us-ascii?Q?LtJQ3GZWkhGOBykgV33XnyGjOAD77DQJX5BqLP5Tm3BJbGnqQNbvkXXLUCWh?=
 =?us-ascii?Q?T+CWRdru+5uM1Mu2Bmxxj9IXMXDSTSHGlZvED2ahWDM2rV8h2tWRfAZXmxqp?=
 =?us-ascii?Q?75U/6KkVLAkHCCIo/K2mYU3JOonD7kmyEl4VjEC1LiyY/1ZvwO/ck/0PyAMV?=
 =?us-ascii?Q?XF5deDb4dzSu4TddaKtswB6N9cn9UaaFKgYDmFRf/zCwzXAdHR4TNYMx7whj?=
 =?us-ascii?Q?1rF0XErO+JCScbt8pUM+8Gr3Hw2QVr+MLS4nrm6wUGzMUcSLQd/RNYEAv8+f?=
 =?us-ascii?Q?rcy1X3KmqskKM/53Qp5tadSNzAebJXpS+JonldAN3meNcGBkro3s3XepA9fP?=
 =?us-ascii?Q?/OAy5MeGkuQFMioCuyAcW77H3K9R3AWkbtEhyIoBi2P+CioznA9OW8sURg7O?=
 =?us-ascii?Q?lPBLnwXHJvR/t2tFcd72flMKhtOa3i5YcNdpg9wCuw8/HG8dV46h0hU1ChSs?=
 =?us-ascii?Q?tLh84Smw7VHaIqOKRH5S3GgXJyfpE7JODMcAFdtRjorMxYkEEfG1I6+i61EC?=
 =?us-ascii?Q?jC3sxjNJsPXwj/yQ5WMMl9sx1Z/bsu1JcpNk3z2sLac4Be+wazN1X+nDTsUQ?=
 =?us-ascii?Q?2O5dXBPvvggPf2MEiok1wZ1l9RUP3HJgovPV+VKhb3axm7c5mKbJ8oQ7uQDw?=
 =?us-ascii?Q?vNR7smSU+6NKt/v8WfbwtWAilkRpFO8931Etd1eqE9b0bJpZBgYUxKj7WgBW?=
 =?us-ascii?Q?GUtfpZHCJyKVtdr/NT/cqiCsHaOWqO9qbux8jVc6yWOz3pgoF/ZfSwfuqvaJ?=
 =?us-ascii?Q?CGCSL+hZOto2zdszzeLKEG1Qq/zmr/GhpxEMSNwi7StQoBEV98w/eyDEu7Kl?=
 =?us-ascii?Q?TIyTHyjawdyXQIGFNoTdlree0gITpPlFNKWA9UR/LAi3F61DEDlH8rFr3t9E?=
 =?us-ascii?Q?IhvIT54G0jpPrWTh8cA4hA61sjP1bZbBr7klv40jkJG0T+kdelPrFDSWsXz+?=
 =?us-ascii?Q?xED7chRrquvtm1W2hVXHFD2tz1Dv1aaewaNmIixoszlS2EkZQW+zurvd3R6H?=
 =?us-ascii?Q?Eo01qxsqq+12ann9NOcxhd41gqAdK4nhHIwRgPH/ZR5y4lTdhL9Gn7JtYUAi?=
 =?us-ascii?Q?rsOnL3YloQCP7j0BzvPhLXb8Y4oeW6WO1gpTebZZmfgZDbBi83ur7pmjIIvK?=
 =?us-ascii?Q?E99dnkdYjA=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a5bb2a-3d89-46c8-3731-08df2a9a1e32
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:55:53.0867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRh+msrxZFdsImwMXXa1rqQJ8xLPmkr/MOzRcOaDxVjhzKXnNLdwos/Kx+8/VevUtpOeIbOxvYogp5+hNdZwJQYZoWRZLSRJdi2JY6VCsKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR04MB084377

sparc32 has no futex_atomic_cmpxchg_inatomic() or
arch_futex_atomic_op_inuser() of its own. The generic versions only
work on UP, so FUTEX depends on !(SPARC32 && SMP) and an SMP kernel
has no futexes at all; NPTL cannot run on it.

Provide both. CPUs with casa use it on the user word. That is optional
on LEON and absent from every other sparc32, so instead of a config
option, probe for it once at boot: execute casa under an exception
table entry, and let do_illegal_instruction() fix up a kernel mode
trap that has one. One kernel then runs on v8 and on LEON. casa sits
in a file of its own that is assembled for LEON; the rest of the kernel
stays at -Av8.

Without casa, the word is updated under the hashed spinlock the kernel
already uses for its own atomics. The hash only takes address bits
within the page offset, so every mapping of a shared page ends up on
the same lock, which process-shared futexes need. Page faults are
disabled while it is held; the futex core faults the page in and
retries.

The FUTEX_OP_* operations are a compare-and-exchange loop, so the
instruction or the lock appears in one place only. The structure
follows the LEON futex support Andreas Larsson keeps in Gaisler's
patch set, which chooses casa at configuration time.

Tested on qemu 11.1.0:
  - SS-20, -smp 4: futexes come up; with the next patch and a C
    library that uses it, the uClibc-ng NPTL tests pass
  - SS-20, UP: unchanged results
  - leon3_generic: "sparc32: casa present", futex path through casa
  - SS-20 with the probe forced on: "casa absent", the illegal
    instruction trap is fixed up and boot continues

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/sparc/include/asm/cmpxchg_32.h |  4 ++
 arch/sparc/include/asm/futex_32.h   | 72 ++++++++++++++++++++++++++++-
 arch/sparc/kernel/traps_32.c        | 13 +++++-
 arch/sparc/lib/Makefile             |  3 +-
 arch/sparc/lib/atomic32.c           | 53 +++++++++++++++++++++
 arch/sparc/lib/casa_32.S            | 30 ++++++++++++
 init/Kconfig                        |  1 -
 7 files changed, 172 insertions(+), 4 deletions(-)
 create mode 100644 arch/sparc/lib/casa_32.S

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 8c1a3ca34eeb..c08c14b62ab5 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -64,6 +64,10 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new);
 #define arch_cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 
+int sparc32_user_cmpxchg_u32(u32 __user *uaddr, u32 old, u32 new, u32 *prev);
+int __sparc32_casa(u32 *addr, u32 old, u32 new, u32 *prev);
+extern bool sparc32_has_cas;
+
 #include <asm-generic/cmpxchg-local.h>
 
 /*
diff --git a/arch/sparc/include/asm/futex_32.h b/arch/sparc/include/asm/futex_32.h
index 6a332a9f099c..fe2386058a1f 100644
--- a/arch/sparc/include/asm/futex_32.h
+++ b/arch/sparc/include/asm/futex_32.h
@@ -1,6 +1,76 @@
 #ifndef _ASM_FUTEX_H
 #define _ASM_FUTEX_H
 
-#include <asm-generic/futex.h>
+#include <linux/futex.h>
+#include <linux/preempt.h>
+#include <linux/uaccess.h>
+#include <asm/cmpxchg.h>
+#include <asm/errno.h>
+
+/*
+ * Based on the LEON futex support by Andreas Larsson, with casa chosen at
+ * run time instead of at configuration time.  Without casa the word is
+ * updated under the lock the kernel's own atomics use, which also works
+ * on SMP.
+ */
+static inline int
+futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
+			      u32 oldval, u32 newval)
+{
+	int ret;
+
+	if (unlikely(!access_ok(uaddr, sizeof(u32))))
+		return -EFAULT;
+
+	if (!sparc32_has_cas)
+		return sparc32_user_cmpxchg_u32(uaddr, oldval, newval, uval);
+
+	preempt_disable();
+	ret = __sparc32_casa((u32 __force *)uaddr, oldval, newval, uval);
+	preempt_enable();
+	return ret;
+}
+
+static inline int
+arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user *uaddr)
+{
+	u32 old, new, cur;
+	int ret;
+
+	if (unlikely(get_user(old, uaddr)))
+		return -EFAULT;
+
+	for (;;) {
+		switch (op) {
+		case FUTEX_OP_SET:
+			new = oparg;
+			break;
+		case FUTEX_OP_ADD:
+			new = old + oparg;
+			break;
+		case FUTEX_OP_OR:
+			new = old | oparg;
+			break;
+		case FUTEX_OP_ANDN:
+			new = old & ~oparg;
+			break;
+		case FUTEX_OP_XOR:
+			new = old ^ oparg;
+			break;
+		default:
+			return -ENOSYS;
+		}
+
+		ret = futex_atomic_cmpxchg_inatomic(&cur, uaddr, old, new);
+		if (ret)
+			return ret;
+		if (cur == old)
+			break;
+		old = cur;
+	}
+
+	*oval = old;
+	return 0;
+}
 
 #endif
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index bb149f6cc34b..9d77ff2fd6fe 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>
 #include <linux/kdebug.h>
 #include <linux/export.h>
+#include <linux/extable.h>
 #include <linux/pgtable.h>
 
 #include <asm/delay.h>
@@ -108,8 +109,18 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned long type)
 void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsigned long npc,
 			    unsigned long psr)
 {
-	if(psr & PSR_PS)
+	if (psr & PSR_PS) {
+		const struct exception_table_entry *entry;
+
+		/* The casa probe at boot lands here on CPUs without it. */
+		entry = search_exception_tables(regs->pc);
+		if (entry) {
+			regs->pc = entry->fixup;
+			regs->npc = regs->pc + 4;
+			return;
+		}
 		die_if_kernel("Kernel illegal instruction", regs);
+	}
 #ifdef TRAP_DEBUG
 	printk("Ill instr. at pc=%08lx instruction is %08lx\n",
 	       regs->pc, *(unsigned long *)regs->pc);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index dd10cdd6f062..284236024e6a 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -51,5 +51,6 @@ lib-$(CONFIG_SPARC64) += copy_in_user.o memmove.o
 lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o hweight.o ffs.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
-obj-$(CONFIG_SPARC32) += atomic32.o
+obj-$(CONFIG_SPARC32) += atomic32.o casa_32.o
+AFLAGS_casa_32.o += -Wa,-Aleon
 obj-$(CONFIG_SPARC64) += PeeCeeI.o
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 8ae880ebf07a..8f4b6079bf1c 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -11,6 +11,10 @@
 #include <linux/atomic.h>
 #include <linux/spinlock.h>
 #include <linux/module.h>
+#include <linux/init.h>
+#include <linux/printk.h>
+#include <linux/uaccess.h>
+#include <asm/cpu_type.h>
 
 #ifdef CONFIG_SMP
 #define ATOMIC_HASH_SIZE	4
@@ -195,3 +199,52 @@ unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
 	return (unsigned long)prev;
 }
 EXPORT_SYMBOL(__xchg_u32);
+
+/*
+ * Compare-and-exchange on a user word for CPUs without casa, under the
+ * lock that covers the same word in the kernel's own atomics.  The hash
+ * only uses bits within the page offset, so every mapping of a shared
+ * page takes the same lock.
+ *
+ * Page faults cannot be served here.  Returns -EFAULT if the word is not
+ * mapped writable; the caller faults it in and calls again.
+ */
+int sparc32_user_cmpxchg_u32(u32 __user *uaddr, u32 old, u32 new, u32 *prev)
+{
+	unsigned long flags;
+	int ret = 0;
+	u32 val;
+
+	spin_lock_irqsave(ATOMIC_HASH(uaddr), flags);
+	pagefault_disable();
+	if (get_user(val, uaddr))
+		ret = -EFAULT;
+	else if (val == old && put_user(new, uaddr))
+		ret = -EFAULT;
+	pagefault_enable();
+	spin_unlock_irqrestore(ATOMIC_HASH(uaddr), flags);
+
+	*prev = val;
+	return ret;
+}
+
+/*
+ * casa is optional on LEON and absent from every other sparc32.  Probe for
+ * it rather than trusting the configuration, so that one kernel runs on
+ * both.  User words must then always go through casa: userspace built for
+ * LEON uses it directly, and a lock would not exclude that.
+ */
+bool sparc32_has_cas __ro_after_init;
+
+static int __init sparc32_probe_cas(void)
+{
+	u32 word = 0, prev;
+
+	if (sparc_cpu_model != sparc_leon)
+		return 0;
+
+	sparc32_has_cas = !__sparc32_casa(&word, 0, 1, &prev) && word == 1;
+	pr_info("sparc32: casa %s\n", sparc32_has_cas ? "present" : "absent");
+	return 0;
+}
+early_initcall(sparc32_probe_cas);
diff --git a/arch/sparc/lib/casa_32.S b/arch/sparc/lib/casa_32.S
new file mode 100644
index 000000000000..eab7a5969e3f
--- /dev/null
+++ b/arch/sparc/lib/casa_32.S
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * casa for the LEON CPUs that implement it.  This file alone is assembled
+ * for LEON, the rest of the kernel stays at v8.  Callers check
+ * sparc32_has_cas first, except the boot probe, which relies on the
+ * illegal instruction trap being fixed up through the exception table.
+ */
+
+#include <linux/linkage.h>
+#include <asm/errno.h>
+
+/*
+ * int __sparc32_casa(u32 *addr, u32 old, u32 new, u32 *prev)
+ *
+ * Returns 0 and the previous value in *prev, or -EFAULT if the access
+ * faulted or the CPU has no casa.
+ */
+ENTRY(__sparc32_casa)
+1:	casa	[%o0] 0xb, %o1, %o2
+	st	%o2, [%o3]
+	retl
+	 clr	%o0
+2:	retl
+	 mov	-EFAULT, %o0
+ENDPROC(__sparc32_casa)
+
+	.section __ex_table, "a"
+	.align	4
+	.word	1b, 2b
+	.previous
diff --git a/init/Kconfig b/init/Kconfig
index 54f78d87344a..8fd656bbc4e0 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1682,7 +1682,6 @@ config BASE_SMALL
 
 config FUTEX
 	bool "Enable futex support" if EXPERT
-	depends on !(SPARC32 && SMP)
 	default y
 	imply RT_MUTEXES
 	help
-- 
2.53.0

