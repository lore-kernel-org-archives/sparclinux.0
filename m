Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023081.outbound.protection.outlook.com [40.107.159.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126064E1C67;
	Thu, 15 Oct 2026 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054558; cv=fail; b=LBoJAmuVJhTQ+e/IpO35Ts9pxna6LLNNT+/zHg6URbDj4OhooSbBC73qOvo5QSqg6xRMlrvV9CS4uKqschOD3IjD2hWDX2Fxy7YFKUwgnx4epokLz3iHthuRxTnrksADxCBh/xa3ZVfP96HEmO4r/8RngglnClbw1rBPcBGWJSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054558; c=relaxed/simple;
	bh=tpJvjnpSsyfxEaOKjZztr7MZ4WnHbJIrTCkhe8mUaCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dZMwTyAbi1fYlhqNcqppy9g8ayRXNLSnHkiBjE9yOqLGg8An6hHaXAxB49xLjPm1fgd0PJZ0czTTSjNLK20PTn1975rBgIV2AZhElt2rrYkZ3y3SZlWFLjst36g05aT4+MUQ0WvfjsYDZd5kcoV8cN+PLo8ndhMZis15vWYp0AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=YrwZm38v; arc=fail smtp.client-ip=40.107.159.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="YrwZm38v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kk7p1AeCjtbQ1/wt2UL7WM1Hc4Jdqp3Epf8G9fPAYaQH59iJePZvEe2g7wGyFvCsZuuwmL5nHcxA1IUpZmnsEcM8jkvoqGbLSr6r3uAgj5tmxceb2JbiMnsY0O3Npx7QqxMCcqu8sbjaMw8NHjXquz2TW9vS9yFVqmbJdah6uG6UJj7GIIxcT7parunsnN34voK4Tf5QxiBvaz8kcy+Cc4B4ofNAxhFcmIh9ejExyCEb0+dpzPZIeZ0aFhg85NleE+KYLqAsmLa8ww39pwHKhQRY8YukspsgGJyDAJMJfoLqHQh6HAmlG8sg46ow3/fBV2N9AFBvp/Ufqtz+4lkQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwosT6Q+ATzjcNZFT8+Li6EfQ8Rw6f8t2ms+npi/AaA=;
 b=ubrd/ZdSISwLyEoaip/Q1Xk/1ok+qfXrUsqkMGFo997tAj+yC8D//hDkoPCA/q3WPUKqrtx5X9RQnI1Iut4LJnSTumBtTCpTnk4CgT8mY3+hifEd+FUxOPFPh9nuhi1GWu3rP4HAUKVjS1v2f1g09PPulwvDUGMh0oTPv7uRYiDol2AUla/A7+0GsebTC0/pffYnNAaZcmfviby167qoW1oFSniG9ZlgPlHr9k/5PZr8Rq1bON0kN1J+hmdxjZPbHbaHVPQGjuiMObbA599np58t5VpLoAtNqqNElcGIFQEJvNmpRddt3srclVVPO4ZuKKXZ2eQYC2oH3et2FxJNRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwosT6Q+ATzjcNZFT8+Li6EfQ8Rw6f8t2ms+npi/AaA=;
 b=YrwZm38vBVSWbc5RgUGLySblo6TWT3m/H6KcSwgAuhhFQCB9sWhfqaCCtZ/9mXfI4x/f77wdP4LkUWyphBMJqyuUdMhXCA64SK4dwLQVNv+2tq00DY5+cjaEtt2u9+T8Ns89IvuoRl9H8YhQ1BckfesWwy41kMg8rWyHb5wT1c6KywOyy3pANuJ8LhFpb+t2XkriA/3dld4eXS55rbbTUgw0Fe74tcDApOZXeuDpPAbHatOitJWbvlcazr/0pMdoZcRLTaSjN0GjMIhbNa+rr3LHphPtZVXBXJpzncKD4z9SuycB0rTasu9aPRIhntFXBLoCIzWV5KBNtgKxxDdDSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AM0PR04MB430977.eurprd04.prod.outlook.com (2603:10a6:20b:7f5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 08:55:52 +0000
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
Subject: [PATCH 1/4] sparc32: keep PIL raised until the IRQ frame is gone
Date: Thu, 15 Oct 2026 10:55:42 +0200
Message-ID: <20261015085545.3246951-2-ramin.moussavi@yacoub.de>
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|AM0PR04MB430977:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d10403-6fa6-411d-2ae9-08df2a9a1d94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	DfKGQU9yw0Nxr59k2JHxmsKRDk/pGpwcDpqemmgHqKCrg6rGCWkoTMwg8rc1HMFfUhkSwcah7pttIxMqrGuZCflXSYYnvGSzaqgjwvvC44IHrrERuQQOy51HnTE3re36rB1qwYv2Witzxlvf1XNJzT6VnX/x4cYKaa6f1bm7QREwOQ59YPjopdCo7obR2683mbP7s5zVhxr4QgJqEG2uSLL9JXA86uy0WMp6BawWZa3EZwTjb9BdFas1ZMA9WfJCscFWQqIGDKYc//udUTByLVchudcYaNaUP0L8HEg7NGVx4vAZn+aLByFH63czLJ2zJIvQvwiSAnxZ4IKX8W2t9AYk7qKGsM+9P7Z6SkwNrRny4Ej+W5wXT2R/EvhWn+Br5OUCWAG2oi99bTvO5hKMlLZ09ggKmtqyNiQNaIMMMtgr9G0S3EnnqKGZArg6tg4gpU0BA3EseMU6B2wTmnAw7XS3y8TcpD3D9+IYLbcrwgvgTCTA0d2hbl2gHshezYsP1TiMdvCZT50543zQP44wumj7hye4vqqhgRKQkt3le9z2JYF6taJ+ciLG6KSDK7UKoyQE1yBvYzD643zwGjPkIsqqCkzK/g/vrZwS9Ma6KVoVMr62zcu8aDKm+LAU7JRC9FxVAR0dWjSkDDQouKGzrErhRKrxxrfTjMQBY9CuHfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VbhPUVt4DGmRNoefCXlWDSkFGUnP749qnwgm5eBy2GyJoFQSj08dhEMrzPqn?=
 =?us-ascii?Q?3xLeRstusiO3rLJNjc2XKgvAn0N/rzARtGG4O+ryZWzZlj9DkLWOrMAZaRGS?=
 =?us-ascii?Q?gFI0Hxxcq6vxVUTa2+GdCnLskOIZnvr+PT3nwXpQKww1RGUcFxx5TWB8aXNx?=
 =?us-ascii?Q?BzVFAlAhyanOzi54fpXHCmFtqbCLEeyn+98PJL5busFMrKBm6VJFEs0YiD8t?=
 =?us-ascii?Q?klR6zZzGf7I/gxreGQhYrhb7DqHheGFmgC1AAcRVeIQIwUHiamGkDzkO8YCg?=
 =?us-ascii?Q?IeYW49BfhL0EMEalhQZXxpoeM0tas0s7sv1XItg8iJd9IKFchjSXP7g9Iff4?=
 =?us-ascii?Q?DqRyALd4Pf+y9ikmkmY3CkpbMn7E02IbkrA9aLwHxv7AIHIvntl56JTQdKB1?=
 =?us-ascii?Q?+HOEvhDQcBLCwt+URVqZAFlqBFrK3TI2493yLw/l2I8VhZbl2ufecsp2V0om?=
 =?us-ascii?Q?Mb+vaneEsnN0AE6dFW3hVgxTDYY87PAH8FM7DNX1Box9xI3hZVno/sM0J3Dt?=
 =?us-ascii?Q?wPZnhY+9e2CQ1/Vrj2J9P9Li+QZxR/b/BDyNMrrR78ODOozotZMm+cq8YS6/?=
 =?us-ascii?Q?OZ39pI9DyUBVg9ogwPRXxWiCxeRfIS4Uf7hnKtb7HdLgLAS3v5Jut2MqIaWm?=
 =?us-ascii?Q?HA1bK1qdphk5oxgvDYjsANGHJZGv89YQzLeQ0u3zzrKUf3hl49yPpZ1+I7uM?=
 =?us-ascii?Q?UAlxmAx5OFta0Ztp5PebQL8faaaNkgJlLfUmL5hc0GB+qc5PkXtewswbKooy?=
 =?us-ascii?Q?N9y1PplJHaz3yRwg2hl7VMkm1CCPYpyFLKVuc7/l0vF4W7fA94LoBXXODvID?=
 =?us-ascii?Q?gk6UwMeHfkg0JHSvHSdSMBrccCVlndKBJ/1clrMF55oCyAC6iw2v7p/l+4GS?=
 =?us-ascii?Q?MLVopeWYD14HX7B7YCM4xBOH/oHT1xZUP2yvoJrNCdrZiLKLY1zJ8svJ3b9h?=
 =?us-ascii?Q?3mgsEkr3CV5VT5KK6viqWwFFLWvonBtOg6W65BYNnweDvsZgvgksWQHpaXGF?=
 =?us-ascii?Q?gQtw5ynpgRKmXAcD7z8kiLfyU5p85oYLIaFTBGIPiNq4NH19z/KA7GaWXIUv?=
 =?us-ascii?Q?6KghjKwZzziudCU6uWbq4uAqN9GqQRLjoKU+DXDrfTuJARqjfLNrDDQIOgNl?=
 =?us-ascii?Q?p9v4AqvGsD4s0vk9apW6bvk/Fa3f81CKyiFlwz3sfOtpvyxs4PhBjJdnQBEx?=
 =?us-ascii?Q?kv6lS2hdMl85X9/a8Gd8sOmTcb0K9EF5AhYTn6neWsoPNXdAd+XD4bqXlCl+?=
 =?us-ascii?Q?FpJWw1VyI84RX7uT8ugR6U20p2kiP7m1CJ8MHilu6VKuf079vFRkbq2WCOmR?=
 =?us-ascii?Q?1GhcgCu4mkKFlIhB9G9uZkqn3xyz8dXaBtP1H8S9tCYGnzg7j3BtPBB9Vm8B?=
 =?us-ascii?Q?aueHS8oRE3gKUwojtle1OJJmyecrhorYE2j0wYgyDJ5lNXpRQdapBBMetCEQ?=
 =?us-ascii?Q?Yu2uuFuXSlZSGPt+k7HcNuLn1WIg5ihsGsuKesUAVlOMv74q0TgznpKRJNkJ?=
 =?us-ascii?Q?ROZkoEXj4sx67R2BJyynMvHpmGeMlOENt0pzRxWIEDOnoICdONTsevVWpfhr?=
 =?us-ascii?Q?yQWwqnYQx4bRXAMycOp76x+c8af6BtL+INuuTVyEsQre+osU16jAwUIWYCP7?=
 =?us-ascii?Q?/eAhQJC9eJLnxIwmIl9Hb0kz8OQZ6X9R32oKJvSj3o3TAG6XQf4pAY5uvwM6?=
 =?us-ascii?Q?ReR9Sj9Ine2GLsuF4/aYvOY2Ag29i0zIq0fyjgdjOlVovi+JB+FpzR37xyjL?=
 =?us-ascii?Q?0yyjvzWmpA=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d10403-6fa6-411d-2ae9-08df2a9a1d94
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:55:52.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGh7s3lvB4Meawq8mp+dwW7kMvrFjmh1cEIoJei603cD/9MXsaVa0j2X8I+yMdVA7z5eiq+975YSTLtLJ5W/7XT/34ss+Ral3VwLnFOkYZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB430977

The per-cpu timer interrupts on sun4m and sun4d SMP, and the LEON SMP
IPI, leave their handler with

	wr	%l0, PSR_ET, %psr
	WRITE_PAUSE
	RESTORE_ALL

%l0 is the PSR at trap time, so this turns traps back on at the PIL of
the interrupted code, usually 0, while the trap frame is still on the
stack. Any interrupt that is pending at that point is taken on top of
the frame, and if it leaves through the same path it opens the same
window one level deeper. A source that keeps firing makes the nesting
unbounded: the kernel stack runs into its thread_info, w_saved and the
task pointer get overwritten, and the next window trap stores through
them with traps disabled. The CPU goes to error state.

The generic path does not have this problem. real_irq_continue keeps
PIL at 15 after handler_irq and lets ret_trap_entry restore the old PIL
together with the rett. It was fixed that way in Linux 2.1.129
(entry.S 1.153, November 1998):

	-	wr	%l0, PSR_ET, %psr
	+	or	%l0, PSR_PIL, %g2	! restore PIL after handler_irq
	+	wr	%g2, PSR_ET, %psr	! keep ET up

smp_ticker had been added in 2.1.36 with a copy of the old exit, and
kept it through the rename to smp4m_ticker and the addition of
smp4d_ticker in 2.1.97. smpleon_ipi copied the pattern in 2011. Do the
same as real_irq_continue in all three.

On hardware the window is a few instructions long and no interrupt
source refills it that fast. qemu does: its ESCC finishes a transmit
instantly, and since 8.2 it takes a pending interrupt right after rett
(930f1865cc65 "target/sparc: Clear may_lookup for npc == DYNAMIC_PC").
A burst of console output on an SS-20 with -smp 4 is enough. A trap
ring buffer in trap_setup showed the level 12 serial interrupt taken
over and over at smp4m_ticker+0x34, timer ticks nesting further down,
and the frames sinking below the thread_info.

Tested on qemu 11.1.0, SS-20, -smp 4, with a test that writes a few
hundred lines to the serial console from a multithreaded process: the
kernel went to error state in 4 of 4 boots before, and booted cleanly
8 of 8 times after. Two full runs of the uClibc-ng test suite on top
then completed without a crash. LEON SMP was tested on qemu's
leon3_generic with -smp 4, where a full run of the suite completed
without a crash as well. sun4d gets the same one line change but was
not run; qemu has no sun4d machine.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/sparc/kernel/entry.S | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..87d03a58446e 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -252,7 +252,8 @@ smp4m_ticker:
 	WRITE_PAUSE
 	call	smp4m_percpu_timer_interrupt
 	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL up until the frame is gone
+	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
 
@@ -353,7 +354,8 @@ smp4d_ticker:
 	WRITE_PAUSE
 	call	smp4d_percpu_timer_interrupt
 	 add	%sp, STACKFRAME_SZ, %o0
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL up until the frame is gone
+	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
 
@@ -407,7 +409,8 @@ smpleon_ipi:
 	WRITE_PAUSE
 	call	leonsmp_ipi_interrupt
 	 add	%sp, STACKFRAME_SZ, %o1 ! pt_regs
-	wr	%l0, PSR_ET, %psr
+	or	%l0, PSR_PIL, %g2	! keep PIL up until the frame is gone
+	wr	%g2, PSR_ET, %psr
 	WRITE_PAUSE
 	RESTORE_ALL
 

base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.53.0

