Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023129.outbound.protection.outlook.com [52.101.72.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF04E8E0F;
	Thu, 15 Oct 2026 08:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054565; cv=fail; b=f6NqWWakgxK/H5s4AjbVSjDMA9O/anUkyPz0f3ydPkut/2zOhZyn2gw++QQzBDLTVGx2OOVWseCHz0tr866UYwNhIQP3NPKf/HLMa7EcBWugHbXTL7Fp+Myh8FLayVYknZDUDi9O5j6eZA4uh5as8t9Yc0tn7b8I1D4XKY+ZLhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054565; c=relaxed/simple;
	bh=YnTBzllt+63oOnnl17iIH9aUFYl0JFHKIwpOU93fQ2E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u+yK88GCV0KDH4lt+oiUAR+PGO3GY6hfu8Uz1iimNkkMb1HBdYy43TMvvVThQ37hH12UXareV8FdnB2CfTkV9IgXjX3+ZzjLpicanxPyv6t3tiZYg5ewUGADJP0cye5YA/vIIHm11DZSJSKm6LQP19dHCelcbxpUN6jLKddW8vw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=eO1Ij0Rx; arc=fail smtp.client-ip=52.101.72.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="eO1Ij0Rx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qD7/k66je9765gjsUFYGoXLCz9TVUi2jR3eblBrNNPoCXBBQgIT/8v1I5njBuwzCtbC98s5BMnmfoP9HpgNiLF4ofVi5HnLxqDC/4FNxTHYJE7SboVdhuUW3bY1o1lFYQsDK9QtovxogP1a1RWnWZDFvtB+5axVnQ9p0W2sJ7+I7aWq3QuhPrJd7bmhhznuWXPcdJ3uFdlqJZ/URQKA/ZcQy3zBkFXSeAVVtIUdmwyy6DACGo7njaNKdrfiYxRgLPLwAzlve/BYXxot2UWNVZNJurkO0VNQELWpGzLf041XqFbnyY0zUeBY+Fm6IgXm/g/tTzs5KQ5JvcwIPUs6pnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iML0WE6CYoLwrsoWj1hoamgHpZhaTsnr4gKyKDfy1M8=;
 b=ZTX1i2LExxXvtwOo/4JrIYeebYGkGpZSp6ASJHILhaiG9vlUO4MvNDijMGCeQh/BfyIRkcz+6fHjs3h85qQ4+pYhodoyag5IGSZH8N0zcleFiKN0gWJ2K2uTU9shHUcTL4YROeR13Wde9+q9LZ1A/2bxBF1xjUw8z22C3xGIaLDz6gNKQ0a6AVrWiF6CzekpwnTyjg9arVDvxKkmTLeXWxtwzwVPIm/FuaK+ROCUMVdKc56Zht5ugXFx4JN7EvGftmo875r1n5JHZv3DQTsIjdLIZF3BVV2JiZFffhK6kVkJ+kgsTBb0N/u/pdTS3Q5SOjYU8KWKhzikoaRwFCp7wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iML0WE6CYoLwrsoWj1hoamgHpZhaTsnr4gKyKDfy1M8=;
 b=eO1Ij0RxdtOx1ZqOHTRAioBtZzqL91PmBJ7PEvQ7qOP4PBdgW6iW11Y3rLDJskLFL73MRqwjALgxnm97S5Gj1LUyRbMgq7aDWZ6TJPfB06urTd5kiypyyphKK+mpo8bVoGAwfjif8hBU6yo5ccDGwywHHTAXxldAvTE34aFZY9ZE1lYqPcV9kTq+B7rGgEhNTlIVYFE9ShelWhyY9CCXlsBsDG4r7FfRkMCiHi4+d0ldYx7buVf1YUACYDqZaFwxM6fdl21sqxYjDdFZMZALCQMo8iZ76e3kH/RRUqaVPP9s2JP5N1YGuWuQwCrKtOHYW+BwljuSqSoXiJOPZg3KoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:55:56 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 08:55:55 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sparc32: add the sparc_atomic_cmpxchg_32 system call
Date: Thu, 15 Oct 2026 10:55:45 +0200
Message-ID: <20261015085545.3246951-5-ramin.moussavi@yacoub.de>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0e5f28-b617-4a1f-fb5b-08df2a9a1e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LxCG3OKp/ECXQDVqHGqebof+gqBEsQPHXE4xmJq5Lw58gvYQxi5UAmZlOhdSXua3a3ZfanWR3lWnt/gEfRrI2EygKomOJ4Z4KPisqfr8gujBH0b3J0OZHLmQRgo3vCVvg1vtDARK0ZRx4Lc3f2TIOh4HUuotzLRfx5/XvVXy7glWoeh+pRWCwnvnKh2a1u9XwG9cgxyjVNZHz9mlWR7nLqmvW9FA9rUOYdbllldJOmqpTZIlVEqY8QLbKlci/J9Xmc+gerhhwkcUIvN7vE0G9osbXFIu80VPgHDV8mZYmVVSqWcaoQtHppQaqL/UraV5zDExliNDcdjfxZlSl5KVCNw5j0UwDieGUKqyf3avGu2M8/n3JU8/9Ed7Jjj0FQenrpOQ8PtKd6IZg7ENYOmOry5Rp8XXSIMYkjUr2c5BpZoXxu/YQ8yhfLyCROSYRou+9OI3kzWX7P75AHaKIHoTg70P/3vMomobYjbWFh8tm38+tzxeVGcHKceQSDfMI0hmBoZbcUuacl72ughAWI3lLcotAwF5B5tL68z7nTOcjZC2WQIHtRD7f+ZY2UJW0XAPETozWhOg0/3L03n2J8kNHOmuVZf8/rScG7PJ02G62HHWBX3BjDeuXbn+QUxr4rDnHkEtPf/qdXT9JI/2PR96OGVZk123CRvGL9GAbgG5OrI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RcAfk+QAOzYn2uXH+ZdDlUe/bQoOWGZUpkm+tRLXzr4YFg8UrzrdgR6X3nSq?=
 =?us-ascii?Q?MUQmx7YLlWtGSpn9G+CEkR2SrPnEjlWUfHrr9Xvd1XQYHohnnUmUAmUMIZnL?=
 =?us-ascii?Q?h9KMhYYHnxKoFq3h7Ah4ABWkJju+oXJ9JKC1Af1yw7kQhjIUHtz+3mS1P149?=
 =?us-ascii?Q?tuVGoctSHv0Iq/MDlwqWyPUfo22KsyHe92IK2p0hdjo7Pfki/4Bbwa1pQZdq?=
 =?us-ascii?Q?ByhDYb2wHxAYFwtRqkBELB1Rw8SUV50eXP4LM6qEwZfDzAEjZzKjd4m8FwLh?=
 =?us-ascii?Q?2RMzHZn/yW1ieMeaHw3hSnx7GDe70mPEvXb1oEmWwvA3cpNdtmOlSplRDwRE?=
 =?us-ascii?Q?b9taRkEUHywqkgxn3Kc32O9orR7FTNHkXdWe7CzzCyVsxa4e8vvOtweceAd9?=
 =?us-ascii?Q?UzHq0kiY3pY/HedWiyVn5d+abB/hTT9bJPRDGx4S+LLFSheP2Lc6AgBX64s8?=
 =?us-ascii?Q?QnU2BqBUL0eHwCv3XHn6q7LHEsiinx8HywNIn9AID6n0r2VRdFg9kQPs9817?=
 =?us-ascii?Q?aRvseCg5y6xfPG4zuQfvrEWoJbDXR+U+V/qSoQ7d8q+NRF/K7MiSfVlGWevZ?=
 =?us-ascii?Q?EcZ/OwqK+CP2T+2QTqfM6vLqP1KI3cqenM302OY1nu7aHSQl62Ot0/3vPPLa?=
 =?us-ascii?Q?hnZQNfoHpxVwKDYKdcBWIKPUcFNPMlLDTPOZ6zqEJyETWPoFq1J1nr053GWR?=
 =?us-ascii?Q?jhUItkhCe2aC4lcTJIpk16cKjgEuA0zTXptcmz+dxpBss5EQkLvAi0PQsd/8?=
 =?us-ascii?Q?nP5bC5tJsIZjBpuz1yYS1ZkjX1GZaWhhE7meJHgqFS+3TvKGNhT6DNMIFADf?=
 =?us-ascii?Q?IcGXxFhKiAzbTC4AxNG2I74yL6ze7frrSvBIq3d/M3HB4qfevWB5dyceYeSv?=
 =?us-ascii?Q?atOJzCtm/WQ+mUrTDDkhbgcw4B4ilsbRrxUDH9zlh6OWPqZ0veDry63s77Up?=
 =?us-ascii?Q?cBGz1CBEk7dGxNpHUyi38ulfpgAj6EjmUp8jNM6e/qVytYpZEJ+LEl5FgZuh?=
 =?us-ascii?Q?tS5GJeriahFF5NUvJwj1DhsI0r7s4H86t8+gAy4vZMZ6mURzYCx+vQg4m0f6?=
 =?us-ascii?Q?l2XSOxMQfcNBjstHzvwPSv53IzpOwQdBQ/DDA4MxKy6Cd0mwsWf3HemVZGyV?=
 =?us-ascii?Q?i0SZKXPsEEafGSsQ0G5IeQYqKqlYHhyNlUw517bzgiR8mGq+79iMXSt82F3B?=
 =?us-ascii?Q?RPrupoLSj0vpmymHhSr7UAhZ6K23WewvoM5+F6VP4oBzgIMGYCD3xNnZNGv8?=
 =?us-ascii?Q?qiDGXa58fO++qttqXNtshEggSWDJyVScDd8xjfsabD8sSvh4LTeqfKbjyrr9?=
 =?us-ascii?Q?asVqpO+M6HDle4bFSkxDfO1xvBUa+TsO6MowlZ2die2jyBhj6xPu/iGaxkK5?=
 =?us-ascii?Q?MMKXqW4Tv/lzk/h5P3xR65wuvXFapqbxy8+xU0cRodil04SQgCOvTx6F+Gf0?=
 =?us-ascii?Q?RnsHv2bB1RFSZGuUKs0CRjCe8TqWhu4mJwDMTNaYjV+t8KCix8eLs5oaexpv?=
 =?us-ascii?Q?lzS6dyAb+AKjVXtJv+3y0mOVcgRMeOWNf4prPnKh9NOXj2/enamxRoMeZIOZ?=
 =?us-ascii?Q?q4hWTYTQhCMs804CODAsVuoHCVMlrfUedy/dG738GiaqXUMplFlXx0wV6euL?=
 =?us-ascii?Q?e5fwnj5kiFX0Ai/8JNxg+pehsJqTRLzWfN/nQ/KE+elqBZuBY3GzHogV2LSZ?=
 =?us-ascii?Q?QCS3cJIrXfz4ZjzXO//GMvM/N/XRoImhtvpb/oFJd0MeLUaCQHLVchQzJESH?=
 =?us-ascii?Q?LZKFTjkWJg=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0e5f28-b617-4a1f-fb5b-08df2a9a1e84
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:55:53.6144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vf3ipQptq7IrtgR9iAUeu+b3JXWP+o/Oh7G3pyxJMsI5ZE3RSjFsYcZiuaDF6BVYa4qA/cjtuTII0MXa2RTqhk4ml17lPD3VBMAfWBGowo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272

User space built for v8 has no compare-and-swap. C libraries emulate it
with ldstub locks of their own, and those have two problems the kernel
cannot see. They are not async-signal-safe: a handler that reaches an
atomic while the code it interrupted holds the lock spins forever. And
the kernel does not know them: FUTEX_WAKE_OP and robust futexes write
the same words without taking those locks.

Let user space ask the kernel instead. The call goes through
futex_atomic_cmpxchg_inatomic(), so it agrees with whatever the futex
code does to the same word, casa on LEON or the hashed lock otherwise,
and a single system call cannot be interrupted by a signal halfway.
m68k solved the same problem the same way with atomic_cmpxchg_32.

The previous value goes back in %o1 and the return value is 0 or an
error, so that every 32-bit value can be told apart from an error; the
carry flag decides. A misaligned word gives -EINVAL. On a fault the
page is faulted in for writing and the operation retried, so a
copy-on-write page breaks first and a read-only one gives -EFAULT.

The 64-bit kernel leaves the compat slot empty: a 32-bit program on a
v9 CPU gets -ENOSYS and keeps its own emulation, which works there.

Tested on qemu 11.1.0 (SS-20 UP, SS-20 -smp 4, leon3_generic) with a
test program: hit and miss, a word of 0xffffffff, a misaligned word,
NULL, a read-only page, copy-on-write after fork(), and two processes
counting to 40000 on a shared page. A kernel without the call gives
-ENOSYS. A uClibc-ng that probes for the call at startup and uses it
for all its atomics passes its full test suite on UP and on -smp 4,
and a loop of 3000 runs of tst-mallocfork, which forks from a signal
handler, no longer hangs.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/sparc/kernel/sys_sparc_32.c       | 35 ++++++++++++++++++++++++++
 arch/sparc/kernel/syscalls/syscall.tbl |  1 +
 arch/sparc/kernel/systbls.h            |  1 +
 3 files changed, 37 insertions(+)

diff --git a/arch/sparc/kernel/sys_sparc_32.c b/arch/sparc/kernel/sys_sparc_32.c
index fb31bc0c5b48..d065f0a41b04 100644
--- a/arch/sparc/kernel/sys_sparc_32.c
+++ b/arch/sparc/kernel/sys_sparc_32.c
@@ -26,6 +26,7 @@
 #include <linux/hugetlb.h>
 
 #include <linux/uaccess.h>
+#include <asm/futex.h>
 #include <asm/unistd.h>
 
 #include "systbls.h"
@@ -95,6 +96,40 @@ SYSCALL_DEFINE0(sparc_pipe)
 	return error;
 }
 
+/*
+ * Compare-and-exchange for userspace that cannot rely on casa.  It goes
+ * through the futex primitive, so it agrees with whatever the kernel does
+ * to the same word.  The previous value goes back in %o1, so that every
+ * 32-bit value can be told apart from an error.
+ */
+SYSCALL_DEFINE3(sparc_atomic_cmpxchg_32, u32 __user *, uaddr,
+		u32, old, u32, new)
+{
+	struct mm_struct *mm = current->mm;
+	u32 prev;
+	int ret;
+
+	if ((unsigned long)uaddr & 3)
+		return -EINVAL;
+
+	for (;;) {
+		pagefault_disable();
+		ret = futex_atomic_cmpxchg_inatomic(&prev, uaddr, old, new);
+		pagefault_enable();
+		if (ret != -EFAULT)
+			break;
+		mmap_read_lock(mm);
+		ret = fixup_user_fault(mm, (unsigned long)uaddr,
+				       FAULT_FLAG_WRITE, NULL);
+		mmap_read_unlock(mm);
+		if (ret < 0)
+			return -EFAULT;
+	}
+
+	current_pt_regs()->u_regs[UREG_I1] = prev;
+	return 0;
+}
+
 int sparc_mmap_check(unsigned long addr, unsigned long len)
 {
 	/* See asm-sparc/uaccess.h */
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 5b9fe0e8140f..939e0130b7e2 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -518,3 +518,4 @@
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
 472	common	fchroot				sys_fchroot
+473	32	sparc_atomic_cmpxchg_32		sys_sparc_atomic_cmpxchg_32	sys_ni_syscall
diff --git a/arch/sparc/kernel/systbls.h b/arch/sparc/kernel/systbls.h
index bf014267d619..25e1ceefe323 100644
--- a/arch/sparc/kernel/systbls.h
+++ b/arch/sparc/kernel/systbls.h
@@ -11,6 +11,7 @@
 
 asmlinkage long sys_getpagesize(void);
 asmlinkage long sys_sparc_pipe(void);
+asmlinkage long sys_sparc_atomic_cmpxchg_32(u32 __user *uaddr, u32 old, u32 new);
 asmlinkage long sys_nis_syscall(void);
 asmlinkage long sys_getdomainname(char __user *name, int len);
 void do_rt_sigreturn(struct pt_regs *regs);
-- 
2.53.0

