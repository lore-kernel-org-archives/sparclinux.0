Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021137.outbound.protection.outlook.com [40.107.130.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F62738E12B;
	Sun, 18 Oct 2026 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792317226; cv=fail; b=jlUq8HLgmv4E0tlHQmDzmnrDpsUMfISgCzUPXgyIeEkk9QeR5u7/0ugO9sOnPP4Hu4Y8ENhj/j7FalfyLmtoNgo7N9cPf3z1Ab61sdt7pyZ1ZbOzSlq8lctVGY3mPeLw88LntTzsYcSM+6Mqz8Efr+1LJJJwTXwuEJXtmaa3XqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792317226; c=relaxed/simple;
	bh=rKFqGGXsBKbFYNTCROcAuNIv2ZAAZtPpV0/v4CQKuoo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RdzeNm7VnMBVO2aAjfNH3RpFJqQ17FnP+vo0CAXApWLFcaPEvbp2QEgJS9aIsOFUkMbvvTy2OiCRfUYpxsibXqiGNK32YpeNX2PfXnbJUOB0UmzUL/1SGLP74XJMcGOTqTgGtSr4dvbvbrJjE7WHhg4ib65lPmUL3OnHR7Kx4SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=T4T9xLAB; arc=fail smtp.client-ip=40.107.130.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="T4T9xLAB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCWgthAsag0cU5REErMhx7dd0ieyUc+EJNbzzarFDBYmhVdao3afwZYZHo6qqWaVI+XXOyIMjnJgOWkSFU1/xfThDmh4zJGqhAECuN/C74mJuJX4K1fFtnZMdQ6zATTQrov2Lg21bk9i53N5dnJd5guwSRoEWU2BKJwLZLMbUaum0vp514vh3xQsDnH6trn49p73yS2I4FfO6zCzjVQVmE1lbc+kpVySkbeDBxaDxjRjWaYQLB2gTpTFa2Qlsp4bI9ZQzTXfpUT6C8XoU6F+aRvk6LcEk0ovqyS2z4OnzCMcyYRGbiW6oM03kP1X9WtMCxHOZ/+p7+Iir0vdd4K7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XzItvqAjpyVZmvsppl/J8YJ54NAey/+HkVFATwi0KpA=;
 b=cDAdmLjFH4VPRTiMtpyAHyPRBUcHb/Mx6KbtGziQQllIDO9jmupo9rqta/RVhBLYzsx0BPobyWU6+D//oFvwIrCnQleVAD93hzg73ZRdBPst8KDufX53iUizXqGQQ8LCAVE5wQjGV3YYHdwLi0FUi6rqUSi8gyXREUbuJL8NNBl2sZGrceefzqTZsRB0bjzxUszRR9ycPT+kqNSi9pPYTXPcae01j8NNhr79HZMtvrhHPSZ34xhVpIMTlB3bX5LDW2bLww0j6+aJtrh6xtQz0BFSCiwkYWLd39+wG5pjo6ECM6MfvYkr8hC+dwnCvo+mooS1qzqrbCSrGw4CBh/IgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzItvqAjpyVZmvsppl/J8YJ54NAey/+HkVFATwi0KpA=;
 b=T4T9xLABVvM0yRz0xXpvY2AvHrKo/H9Z1U9eZjl6rYoPyZZLDfyyRJp7hY3CXCU1NS+MBOrcYrQbWWDWYMmRoU7NbA/O2/imPYoydXioCESJUdjJhPblH/y//3jb1/4xroftg3CD0LPTbIsGNoE5Kahd96xVBXY/J5EpSDN/u/KGsRTnRy359Gb14Pulu/rR+9bZ7SNq7PpCj0I1Q2tXOCr82/UTF/e9MM3S3BtDtF6N6KQidKqrquQZ2Ntv1RApkkxVXgBfpgetJywkt1jS1AclwtOMLZCMwD/SseBGF07tYalXv2ZRFzh0+4Lq5Ose7lSLjxor+hDqfTUcJ1OQGQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AMBPR04MB11787.eurprd04.prod.outlook.com (2603:10a6:20b:6ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 09:53:40 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 09:53:40 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S . Miller" <davem@davemloft.net>
Cc: Daniel Hellstrom <daniel@gaisler.com>,
	Imre Kaloz <kaloz@kernel.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc32: sun4m: do not clear IPIs that were not handled
Date: Sun, 18 Oct 2026 11:53:34 +0200
Message-ID: <20261018095334.869926-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::14) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|AMBPR04MB11787:EE_
X-MS-Office365-Filtering-Correlation-Id: c8237641-20fd-4016-41a7-08df2cfdafe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xuaPevCT9ypQXZMzZrZsZQos8Kaz+VaYIzcCFTbEw0iWLy/XuADLU00PsuFMuOuc4Cwa/CaU/f+LuTVi9pUGN8+6i4/PWWGI5M+AAYANXHOeaxutvLj/qhLewcnvebLbWLP40QK7UtEYoWkGbQb6657bG2BTdG3o3x/ydM0mds4IoUAfsdrxBuYf/y8MDpdF/fLQqzyiE8rvAsd6NAnlGnObQWtkvnWIVOQnTIUnLbM/irtv6o+8J0RhLn2YlLIu5cv7KeCmVgfa/mf/F8L833xnYd5KDkupGIa9oQLV0o2TXEs8iFnuYgfuRX6xfjDJNxn81yDAt10mQZkTc5g1L5qYYyUN101l62zmGLOe1VbdTVpTG8vGnC55/qLtDX/1z3Ra62oQ9eyMmpLowYIvqrQjPr+YNq/aKFZyOafagsNNyItaxQYOOYad+x/Et9ReToZh2w90SH+s68adIKtfpBdjcQJ+2pqq5HWV8+0XnIlJEH5cFuZ077jwG0MUKCYr6PmzFJdRTFad+7foks0xcHPQChim0fzP0kHIsDG3tkXcJejAGBK0U3swVsd1mSw2HAXSk0dzK6LeMANsgNaX00hYpmzFq9g+1mmFvGdmWIUCc9PC5buuafT1qcy87R22eQTsqm+AqOi0isG8CP9Mj0d7Ez5PjpEI7B7WDoXuOZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XIU5zs+ALVDcqDh6fppKaYpLydCdeKeqYwZQUR1wt5ovyr5I1+bzegmjUa5?=
 =?us-ascii?Q?4LTTBNwYj/t3MrioTCTcAyqzLLBz5dQ10zosLQ5tniqxB7Rfnlhi4knRcdKM?=
 =?us-ascii?Q?INrU5oh33rdu5WcURrySrcbN4+P8QB18mvEdrhrveuXedb68pWcW3jjtxHGS?=
 =?us-ascii?Q?hz/3x2jtCOUeFTZjEtZmjQUbivm8I3yzP/haEvkN4fC2oOZcHf0n/fBnI9k4?=
 =?us-ascii?Q?5hIkbmSV83MLBYe3npeI+nFdMEvCmom06ZDSAVPh1Jhau16J2WgIsiLTo10h?=
 =?us-ascii?Q?nE0CaQ4urgLaKeCtn9dzVMQUopfFYNSr0D213qzjKpv7YXbg5CoXxHSSKoMS?=
 =?us-ascii?Q?AQRi1VeJqt1OJMgMRbPYm62FkH6TGO3VLedwz62OsALa6oItELTmr9VW/00Z?=
 =?us-ascii?Q?VwD5ibkXI95p3pKl6TqjEyn3rr36LZ3ilWxayqTAqNU94yDQ0BnnLCeBoY8C?=
 =?us-ascii?Q?+scWVKlvcQusbFEfpwREIelNoHQXYH7S1J0HVx7f6cD/F6Pjt26K9+JcBA82?=
 =?us-ascii?Q?PfGAW1F+mEgjVBo3EKI0Sh4YCOVApy1QIQ5FuYBmNny0W+Amj+5PdMvsV179?=
 =?us-ascii?Q?65sUa5qqAc+eBfEaYYs7UbjG+gF7bVI6Qoa7l/vKqsTyEfjOZGWbRoHIgIXs?=
 =?us-ascii?Q?ST1wYYSQFrYoOGvZJnNu0JJZArKceEWVf4h4jK32Gucqs7nO0FUAVhQF80td?=
 =?us-ascii?Q?YuAD39VWmhiBd7itfx41BBz7zlVtAsDYlqD9t8lG0qXpEpFbpvbP4HJuxscP?=
 =?us-ascii?Q?xi3Ghq/KnVRZAaW2grEYz9BxUVs/AKaAlY8m0rvIvCSj8uXOHwF0fcUY6k4E?=
 =?us-ascii?Q?BOHih4CZFNi/cEzMtMixTVG8sMXaW3J2M2S3/OpX+pht8qBmv80gZMAtiuhn?=
 =?us-ascii?Q?eiQAlrbqvcroGlO6FMuUjljHnNE3VtSPajSweARCz1qZ2rt7+2rqWuyIt6Th?=
 =?us-ascii?Q?uM2gqtVTyp0uwghmZTtrSd82b3TYro+RuodHTw8mavoBVk0PBzCtGzyV686y?=
 =?us-ascii?Q?VXefEvfigow91MD+ygzCUZ3v3iZU8OpdLjkJ9lDWXvFQdqQGg0/ZPVEE+1Qm?=
 =?us-ascii?Q?fkXxZmOu+z6ZK6Rp6OzpHfDHl/hUyOCbospjDnz5nxIMLSZZN7UJpwVr/yJy?=
 =?us-ascii?Q?oTKl+R336FWRvQBq78E+vx1PPwAbOqpZ0tQ5aAirDJZQDgg04Nb7bDO0Wini?=
 =?us-ascii?Q?WJigJLN7RTRHqyzFiNLQSyizjO88eF8YPN4Fe8/QfmFbZONWFCa2uCvvE7tB?=
 =?us-ascii?Q?vyoGMx/dSHuvsHk6fON3DQK+MSAmyKp4y4G9z7UzJeEBCqbKQ3ojMv4GqpjD?=
 =?us-ascii?Q?dxcc5zPlT0LEe+8ER1l7yxAC88Cr9bAniyTmgGlZeJUomcdwu5tnhZO9xrH8?=
 =?us-ascii?Q?CJQwMXUB9/ua98o20YMutExZYhNaWcENYAxNgyPbq0f9M7hRNFZiLaBx8AM0?=
 =?us-ascii?Q?vRWdMyfzxezUdCnaJdP8uQnqHyq1H6RHm4GsZ2lCZayL00tFG5aMLee9bbt2?=
 =?us-ascii?Q?Lo/wa0vjGXmpop25/9o9GvNufy4EcWNiOr7ams7Oy7cbW2RfqmiZCYchH7GJ?=
 =?us-ascii?Q?y7BmqFFkwIR937yy0vBULbPCt/kyr9vX3u++4wGBBsCdnk8x1JsZm2LhEV6P?=
 =?us-ascii?Q?gV29B9OVpNmYQ2t2IGQKwSJu2Dj/U9a5dTO6ikDX3BUyWXvOWFjU/Rzajunv?=
 =?us-ascii?Q?YnHNQ7JfUhL4BZZCPiR5T3ZGF4r/7hDB0PVd06Mfa6jnOe2zbTXtdqkjwO2o?=
 =?us-ascii?Q?gwsbthlvDg=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c8237641-20fd-4016-41a7-08df2cfdafe9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 09:53:40.0604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XySxDGpOzrp31Ke1LFQ9tvY9szOhux/A4ZQRe3nc8d0WqcHnl+8oGGzuFRLo4VSYkMVtmUIo1tIWcsESjN+6EeYPrHQC2Ml0NmMWnFsxsdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11787

maybe_smp4m_msg reads the per-cpu interrupt pending register and then
writes 0x70000000 to the clear register, acknowledging all three soft
interrupt levels used for IPIs (12, 13 and 14) whether or not they were
pending in the value it read. An IPI that another CPU raises between the
read and the write is acknowledged without ever being handled.

For IRQ_IPI_SINGLE this is not just a delay. __smp_call_single_queue()
only sends the IPI when the target's call_single_queue was empty, so
once one IPI is lost no further IPI is sent to that CPU, and every
remote wakeup queued there waits until the CPU next goes idle and
flushes the queue. Under CPU-bound load that does not happen: woken
tasks show up as R in /proc, with a vruntime below that of the tasks
that keep running, and still do not run until the load ends.

Seen on a 4-CPU SPARCstation 20 under qemu with eight threads doing
syscalls and window flushes next to threads that wake each other
through condition variables and pipes: 7 of 8 runs had tasks starving
for as long as the load lasted (up to 25 minutes), 0 of 4 runs with a
single CPU. With this change 0 of 8 runs starved.

Acknowledge only the levels that were seen. A level raised after the
read stays pending and traps again once PIL allows.

Fixes: ecbc42b70acb ("sparc32, sun4m: Implemented SMP IPIs support for SUN4M machines")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/sparc/kernel/entry.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..0bc30436f028 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -275,11 +275,11 @@ maybe_smp4m_msg:
 	sethi	%hi(0x70000000), %o2	! Check all soft-IRQs
 	ld	[%o5 + %o3], %o1
 	ld	[%o1 + 0x00], %o3	! sun4m_irq_percpu[cpu]->pending
-	andcc	%o3, %o2, %g0
+	andcc	%o3, %o2, %o4
 	be,a	smp4m_ticker
 	 cmp	%l7, 14
-	/* Soft-IRQ IPI */
-	st	%o2, [%o1 + 0x04]	! sun4m_irq_percpu[cpu]->clear=0x70000000
+	/* Soft-IRQ IPI: clear only the ones we saw, a later one must stay */
+	st	%o4, [%o1 + 0x04]	! sun4m_irq_percpu[cpu]->clear
 	WRITE_PAUSE
 	ld	[%o1 + 0x00], %g0	! sun4m_irq_percpu[cpu]->pending
 	WRITE_PAUSE
-- 
2.53.0

