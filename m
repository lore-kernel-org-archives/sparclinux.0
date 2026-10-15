Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023117.outbound.protection.outlook.com [40.107.159.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A154E66CB;
	Thu, 15 Oct 2026 08:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054560; cv=fail; b=e/gRzkl+0ub8F8aoUIvuSxo2LfRNmw0xTjm8NnqSxfvwuo8OcC6Qi3RwMDHEHMLPSQoNkeb+kGoXJUVSmEn+pI2yRp6tUb9YFkhZ4Sge7rbI9liTVO8ZWUzHftGuOW5NQjf/QNWtSGoe1OVcI5NLi69HaKboxqDqCzfmJau63/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054560; c=relaxed/simple;
	bh=SdByEZ2XFc+8c2mh4V2W3HogC9ts5H3Xiosxka7ms9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ATQuY+iN0jGhsXm8GWVxC7GAN2x4OOPhpv2X78Xlku4vFHWKiG9blVIWAxgO2x2Wb8WOT5CFfWpQZsFFvha8e9uc5IXCUaohsVoC+qM9Eb2PNZwZpxVcx4qov71Mj8EvIo3ebgAm7AKI6zMYpg9s0J8j4gWVJpnDgts5ZHh/zzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=BxTdd+IN; arc=fail smtp.client-ip=40.107.159.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="BxTdd+IN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m1Q7R/1LpVqwzlm6ykdq1VD0cePviB2MFYU1eeHbnDGjnMOJ5Puw+b1yyk5vzQUNiSnq7ZJaNFdc63DaiXuIxDdtRU7kz5gW+LSw44gVtV2ENJ7N5LEAGDftBnEJ6AY1CxKXkv+tPyZlw/pVKwa0LageNqOUWfZaFBO7+RYELxOIECZMwhf89xxsqkoCcsThyuQ4WckQWwBfM70bt8adVNAs8MoskwSQ1NDsYWA5mQFdjgkIGhECWjLW71CiEzaeBvQqfhMe7Ncub8JYhGWYo27nlenL9aiBqWsQfCSrCdKlrjB0ZottiRbIBKP7/0K9FVTT9a2x6drZqODBqCqcOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NxFl50WzGtu8zsDikMm+ovXWraUwP7/KPw/aNpUU2B0=;
 b=pFv+GIG9TqX2b9v0Fob5HYS9bLmFkMBHenbS5sMRnNmIZBt/5vDsltSCqBoTNikA8vrXimXiNhp5M++dC/uHpUAl+Iid0TaX51ZZwNeJzUu0GQWOI8MyH4mFFD1GutOvUXOCScxNMTgiXdHxGRmshemaEGKu0gfPSQ+N7MG+LXN/acobrIx9LlJ1qmgMKPdo14MsuPHE+HcG5Zfa0bARvENPWUpALNTmmVAu/oO2EmLciBG09A6EMVJ9Kj64SQJE13SOqh3O/qmsPy6pUqYLmUm4Od82OM+528MlsLKjBk4DQVIs9WkaAy5SknubQykwb+Qo848Kv2SpobWkfF1exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NxFl50WzGtu8zsDikMm+ovXWraUwP7/KPw/aNpUU2B0=;
 b=BxTdd+INhDh3mJ3UHnnZDQZPwRKHPCx3v+9DaTMN5GznvB9f8IlJp8zjiIWSe+N5A3sF+nKlqEYXCvjdg5HBTUspkr58bpvcdmGP7hhTF2RvI9v4WjZz/6iLx6SWknXpMS/saOoNOgkO162Xf0wM+J6V8jdc9r1rbDoimFvlZUL/jRRinDGarNxPtgWvyVxaxXwAqYRtMoDpSdwFEv12DJ3EqnPSvMIDTw+5OzTZhhJMJSpUXufO3XwYoo9sAuTCHdZ129iS5RIeI/mHvnhc7JlC58PDvyzwkd4dVt5WonUpPUKf6deUPHptDu8qWdRf7RHExY1gyeXtkBC7FfXANQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by DB9PR04MB10035.eurprd04.prod.outlook.com (2603:10a6:10:4ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:55:53 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 08:55:52 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] sparc32: wait for secondary CPUs by time, not by loop count
Date: Thu, 15 Oct 2026 10:55:43 +0200
Message-ID: <20261015085545.3246951-3-ramin.moussavi@yacoub.de>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|DB9PR04MB10035:EE_
X-MS-Office365-Filtering-Correlation-Id: f171f89b-765e-4c42-abf1-08df2a9a1deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	F38rVSK+Xk3qXVe78Ly8EEFg/qee8nKo7wA/Yz3AJYV4FbyMDxPyGGnxQB2s1cZh/WB8WOy2j6TpSDqDNJnAyPm0pR1elWvSKb3d17/N5dFm/kNlRqSJ1Cw1mLwYAP/o4jY545+mcqE2xPz+YozhXAeZJ+cJJ7y4iIyjvaTRtP51SuhGgLWpAX7mPORZvBSwSFTEBT4xYf18H0ClgsbECCpEY2/uYwZI5zh3pTuDaTjOCkzxKRcEMFlbiqHWqO1274t+Vty+rx2lqaWMV4ztxQRSqgnfcAYDVshH+Prk1T0RgRSyu3mjtJdykPtOO8DpDYbHM38mFlRq1kwBhImO8fC2rvfCCj55UBk4gacR6bju70t+9WrzxoL+UnTM/UGaS3jFsHZCvrw+xwFTNVn7x3sJazO94SuQI1It9+xAxG+/u3qy2hdY3YU0f2fBCje/kMVlmL/+ph+Ex70nmcb7yoO8XX2uQmwdSWsUBEpaqOOSmjyUDE2p1Fbi9OM9AS81DV8ZZo0yKYa66b95brG+NpQi0fd6/1Ib9rcv21Kk3JF7x1M6XfkjWyKPu1PmRWTOPB2pQGhqUYnwv6YAeEwSIJ5XxarQ2Oujmt8m6ep9Vd7jxOLl99rM6Mgb1lHwGErXwbMU6YtGTpSwXGUzs2wc1S5My2dnym6inZ2exbz+xoo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7cHk5eAIEgTkaa2yPqSw5Y8vi6lQOtbPQjKvt9qcDnj0vk51gLQvlji59jlb?=
 =?us-ascii?Q?qt01USJXD5MtZEFZUFCtn+8Qf8LHRcp4gAwda5Imw9sGs0+k60bSDwAXTFMy?=
 =?us-ascii?Q?2iCUPUh0j5S4jliXgiL7YVNixoi+qSDdKFpfylqvliDSWgUEhY0/0nra8m6x?=
 =?us-ascii?Q?jo/Wd7wA1nZN2KAnnzLlv3Da1tH/6S/9LRVRvEPsNgomqKTgL9AcqMHOIeNI?=
 =?us-ascii?Q?MyAO6QrmlbfbMwBEZM6AvIHWiuKZFAwjwnYjk2O9QAHTkwHtTDsCbG0+Sqsj?=
 =?us-ascii?Q?ovbQV3TJDAaJBxDbfsC1T6u37IEZflWiqoXfiDBAmVUCwqrjYNv0nYNQxdvl?=
 =?us-ascii?Q?H/k+4kSx1l1Tc1lZrtfTTvPrd4Cfze6BCu1XGPVl9I3Ahs5Q44Ihpqu7piKH?=
 =?us-ascii?Q?8/0HCGT+s4ho7173oCQgw9DIy4SVW/mdgmKyabi8LxrtMdtEhkjbed57oR64?=
 =?us-ascii?Q?IRq9Ehw2/BuSbDkxLUIW/WzjZ45Ck/3pi353hG9J/m5PNLB7iatP2fBs4p39?=
 =?us-ascii?Q?N986QlSMCIHkOxNhAi0AqAQ23eJXUnwJezNSJGyu/I7yhA+eeBOD0mSirhsW?=
 =?us-ascii?Q?c8Yf5xD0TR7nBf92M50tT/8Zx/ti4RGugDYcbFeiIbF4yOCcBUGipqoVbfoS?=
 =?us-ascii?Q?BmkPnKA9a8LgdZ4QNtPPar5N5VSV4/qCkxsQRxOmAoJSq0LQapxt4TEbotsM?=
 =?us-ascii?Q?wIdSKjNk6ZNzsJYHuXeC02gHyJdx3OgxwooKHIkI0NP+L9ni/qh/KDaI9M5j?=
 =?us-ascii?Q?2fDXtb8duN8AY/furkn21+6dOBb0uZlRIKSCvXb1S2Gn0PhdTgIs/8Tpw0UP?=
 =?us-ascii?Q?7bUFHWDkYPOgSUORwaq5S4zs6M9VifGJgo3FC5qnRRRZat3iyGpqAFNFbhf3?=
 =?us-ascii?Q?2wZbPfJDGmgmdOWU4aCa509j29avkiXsKSzLdU+LU9fUy5ozxCKqKbATx2lj?=
 =?us-ascii?Q?qWj1HdCkhbt6jZ2p5cT99rT92TY1igsUaIksL/Fhzu2qb4pFNgL0SF+if44h?=
 =?us-ascii?Q?Z05odHMQfoMOUzfC6RLLTUvwUNTgdK1VARub9PPsinPJkcAOCIuQEjWQCYR0?=
 =?us-ascii?Q?L2y+RIlIdeuEPhOJkxw6gldJ0MpTix6S+apgrCEv1ABEmm3Qpx741ltvNntv?=
 =?us-ascii?Q?QX1EahHRH07mBiCjBD4V9nYUgFbwbb60xhCVkzpTNZZsHX9Tsa26djKBY+ub?=
 =?us-ascii?Q?2Skp780Y++cCCDVHmDYoXeH+gMAAJQ5UBzhnVfaKGTITyYzGuOVXOv7JXiEt?=
 =?us-ascii?Q?ZE5rwEKs/ITTYj630HrJl5myzPYQwtVSYvLzOfdtbSpdbL5v7PEEDkA0zk1N?=
 =?us-ascii?Q?a1eXM2uBR55VnT9g8rT462lseptNTMID7Lvej8rmTuqd+gaj5pGHBnvgtX9O?=
 =?us-ascii?Q?pNBMjo5XP77ioyU84gb4C180FV6F7RWlRs7HdGm/1bPS6H9PRohX4oJ57DWB?=
 =?us-ascii?Q?4mQtS0aVC/5ywTQKKBXfJCu/XSqt980u5tclHUbG8eBSDMgQkIEeGYYiWO5h?=
 =?us-ascii?Q?NxLwafxMeR7acUwBvAOjf1SeWDJ1wcXEkFQ20edG3ERcTdO+dPGG2q1LFz9d?=
 =?us-ascii?Q?m6BF5t0mvkoIQnCI8Ss4+6TfuSB05yH+mRn9gZwP/h9KPxMNU1rJ9095fG8b?=
 =?us-ascii?Q?Y8Gdj27M4gfsnA8/+uUnPAREBLIYtEZPbbS7PidlbFrSqAG92Osb+94LVLB9?=
 =?us-ascii?Q?Spvgei969bnMdcbOV3yuAq09PAgxcl2rZ28dWDGEfWHUvhXmCCZjsfhVoL0J?=
 =?us-ascii?Q?9ytAC4FUCA=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f171f89b-765e-4c42-abf1-08df2a9a1deb
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:55:52.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6APz2rB+UB3yJweH7kxqJZDauskBNlUjUhurH3l95YCer53Nl+fT1llUthHaB0mvzsU4gh5Q4RVB8trdr/xJ+P4LiktW0jZ5yqdLsDb5Ow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10035

smp4m_boot_one_cpu(), smp4d_boot_one_cpu() and leon_boot_one_cpu() give
a starting CPU 10000 rounds of udelay(200) to show up in cpu_callin_map,
which is meant to be two seconds. But udelay() is only as long as
loops_per_jiffy says. Under qemu the delay loop calibration varies from
boot to boot depending on host load -- on an emulated SPARCstation 20
between 4 and 671 BogoMIPS for the same kernel and command line -- and
with a low value the wait shrinks to a few milliseconds. The boot CPU
then reports

  Processor 1 is stuck.

although CPU 1 is just about to call in.

That is worse than losing a CPU. The late CPU still runs
sparc_start_secondary(), calls notify_cpu_starting(), which makes it
known to RCU, and then spins in its pre-online loop waiting for
smp_commenced_mask, which is never set for it. As it never comes
online, the grace period waits for it for good:

  rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
  rcu: Offline CPU 1 blocking current GP.

and the boot hangs.

Wait two seconds by jiffies instead. The timer is already running at
this point; calibrate_delay() has used it.

Booting with lpj=1000 forces the short wait. On qemu's SS-20 with
-smp 4, the unpatched kernel declared all three secondary CPUs stuck
within 4 ms of starting each and hung in 4 of 4 boots; patched, it
brought up all four CPUs in 4 of 4. On leon3_generic, with two fixes
to qemu's LEON SMP support that are yet to be sent to qemu-devel, it
is the same: unpatched, all three secondary CPUs were declared stuck
in the same millisecond they were started and the boot hung with the
RCU stall above, in 2 of 2 boots; patched, all four CPUs came up in
2 of 2. sun4d is build-tested only, qemu has no sun4d machine.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/sparc/kernel/leon_smp.c  | 8 +++-----
 arch/sparc/kernel/sun4d_smp.c | 8 +++-----
 arch/sparc/kernel/sun4m_smp.c | 8 +++-----
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 1ee393abc463..21e7b91cb9ca 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -180,7 +180,7 @@ void __init leon_boot_cpus(void)
 
 int leon_boot_one_cpu(int i, struct task_struct *idle)
 {
-	int timeout;
+	unsigned long timeout;
 
 	current_set[i] = task_thread_info(idle);
 
@@ -205,11 +205,9 @@ int leon_boot_one_cpu(int i, struct task_struct *idle)
 	LEON_BYPASS_STORE_PA(&(leon3_irqctrl_regs->mpstatus), 1 << i);
 
 	/* wheee... it's going... */
-	for (timeout = 0; timeout < 10000; timeout++) {
-		if (cpu_callin_map[i])
-			break;
+	timeout = jiffies + 2 * HZ;
+	while (!cpu_callin_map[i] && time_before(jiffies, timeout))
 		udelay(200);
-	}
 	printk(KERN_INFO "Started CPU %d\n", (unsigned int)i);
 
 	if (!(cpu_callin_map[i])) {
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 9a62a5cf3337..9355171ff792 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -122,7 +122,7 @@ void __init smp4d_boot_cpus(void)
 int smp4d_boot_one_cpu(int i, struct task_struct *idle)
 {
 	unsigned long *entry = &sun4d_cpu_startup;
-	int timeout;
+	unsigned long timeout;
 	int cpu_node;
 
 	cpu_find_by_instance(i, &cpu_node, NULL);
@@ -145,11 +145,9 @@ int smp4d_boot_one_cpu(int i, struct task_struct *idle)
 	printk(KERN_INFO "prom_startcpu returned :)\n");
 
 	/* wheee... it's going... */
-	for (timeout = 0; timeout < 10000; timeout++) {
-		if (cpu_callin_map[i])
-			break;
+	timeout = jiffies + 2 * HZ;
+	while (!cpu_callin_map[i] && time_before(jiffies, timeout))
 		udelay(200);
-	}
 
 	if (!(cpu_callin_map[i])) {
 		printk(KERN_ERR "Processor %d is stuck.\n", i);
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 056df034e79e..4b3fc081f103 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -79,7 +79,7 @@ void __init smp4m_boot_cpus(void)
 int smp4m_boot_one_cpu(int i, struct task_struct *idle)
 {
 	unsigned long *entry = &sun4m_cpu_startup;
-	int timeout;
+	unsigned long timeout;
 	int cpu_node;
 
 	cpu_find_by_mid(i, &cpu_node);
@@ -103,11 +103,9 @@ int smp4m_boot_one_cpu(int i, struct task_struct *idle)
 	prom_startcpu(cpu_node, &smp_penguin_ctable, 0, (char *)entry);
 
 	/* wheee... it's going... */
-	for (timeout = 0; timeout < 10000; timeout++) {
-		if (cpu_callin_map[i])
-			break;
+	timeout = jiffies + 2 * HZ;
+	while (!cpu_callin_map[i] && time_before(jiffies, timeout))
 		udelay(200);
-	}
 
 	if (!(cpu_callin_map[i])) {
 		printk(KERN_ERR "Processor %d is stuck.\n", i);
-- 
2.53.0

