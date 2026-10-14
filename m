Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020138.outbound.protection.outlook.com [52.101.75.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBF49480B;
	Wed, 14 Oct 2026 08:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965285; cv=fail; b=eyjc6H+FybS+zliueFZqsfb748RL+Zo/iBqXGrEtGk6rDQZR9KkjEZb6sMxP6H54hHzGlOGgax39rl0qmfulexOrPLxmhK5qoqU5B9VH5tYawrTxg+inSxDcZ8xObR4wRQxvmF3AXjMYM5GvXxwGa6y6l1+XnMG6x0xevp0bhlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965285; c=relaxed/simple;
	bh=M7kjKp2bp5q2ZbYIEw92tirgvHK9CqIrXOGM1QuSRg8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kc4N06H46WfnIuaSQBDK6naETlYhq7ITYth21jJGgYVMO+3YIQwacDXZOd5QEcrtUrbhVELCxSlzeb3SrRj+4fHm99UJ7CZwClOPzzPSJ6sEix8zP8MJmHbQO3e/IZgLVOdBvKVRFvPe+M1jLUW3zihGNIJgPssu/Q9vUcSRjuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=aKBnXoft; arc=fail smtp.client-ip=52.101.75.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="aKBnXoft"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9TGxNgPP0V1iFZ2k5zZhpPHXM0T/Cevw25XA4c68ZkI4NcU/UpSEoj7MX/JHlz/4BE5pUfItJzS8Q+ymnY0d5R6y5n0N6XyBAk/dVGALIa3lZJ30Xskzt9CMEabAzb1hdZjYCg5TzUlAeFj5ZiJTzRvT0Cv+ERnGT0ZGTEhmKmScjBBpIF8We/C0igx95gFt/Z4RCX7oxQkQBh7wdype4VUXCQl2PQ7rvaoqoY/9YLzJmtpp2dJnbvuZnoEM530/KXxuR9Ly10auZM5kozUbevwDo64frSiybnB3cX1lfMyX9MU3GPyCb5kNkKYshU8wkNGngj1E5KT93WaM8kIQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4RW1ZWQ+EAy6wwhi1XVGC6L3vUgdx/vGhWWf8YCB3o=;
 b=VK+rxY2noJ2kmsdW0cTirMh8ZIEBi3NV0xc5DUDV7CztxCJpLvZoINAjcttc0l2C7IttsXcmT+ekS6r66oHG/OGfJbFVUgCtV5/MUi6oQL3+dz8cbF3dyV/FiGaMPTxjYiulLWkHJsijYnSXO45fefoCIoqFdw5YH1GDvTfClsqlzkKn5OtcQYxkvdiZStrNPOLKe7+iQenzMFn4YhddwMTeGN0phgt+xgt84nJbBqqvmwdkXu7+Jh7G4JHlNVC2phi0AjTGKFTV9mcP1cxvNFeE/6Yq2XdPkve/vD4oN0Tmgna4Z94n3OiN92inEOlRIUzhSxalQAnXSyX3/dhSDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4RW1ZWQ+EAy6wwhi1XVGC6L3vUgdx/vGhWWf8YCB3o=;
 b=aKBnXoft1uoQrrgjytyDyDvSgPBIFe8nV7G7EnzIKm0fbLhcjOJDkb7Ffpi8xl923yvliPX/LwMbz4faE7CO0Qz2pCJiBN/tC72Rxag6JeZX1KtUtIfDa5Vs3uSZb52XvBmd1Na/u1S+3r09dLcuB9TxUILRnDG21/cFkX1+EGNwHYJBgFo3WYucFvC2ZzcvQXtWOsHwwfhUZ4e0g0iO9sXaYU4QI6jN/wvmLB6wmAoc6QF6uUtQVSd3W4wk1HP7F4vgcIIIM9WsKxdgqQ0R2YVK3WiANH4f06JtIlgbCvHFx9XF4wgYU8WGjTjVN+p1C3ML7xu+6Re/Y6/u3Tcaeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GVYP280MB0208.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:1a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 08:07:59 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 08:07:59 +0000
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Kees Cook <kees@kernel.org>,
	sparclinux@vger.kernel.org
Cc: Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Stian Halseth <stian@itx.no>,
	Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: [PATCH 2/3] sparc32: add seccomp filter support
Date: Wed, 14 Oct 2026 10:07:29 +0200
Message-Id: <20261014080730.8817-3-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
References: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::16) To MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB1058:EE_|GVYP280MB0208:EE_
X-MS-Office365-Filtering-Correlation-Id: acdaeeff-f6bd-47bc-be9e-08df29ca42c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|38350700014|56012099006|11063799006|261009223027099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zDGvw1Wf1dYEe4j+Z2T0AmbFAtsRoIWWPrBw9O30vTBeVkUyQq+a/6f+s500jaMTiaAGvTE/JjKseZ++T1O9MiirIP8Rt6o9xzqv59obDHyXfRHz38Lt503cTNvgRIjYtYwiktlerkGyrXODNJoZRtdYEv5n05Cdng53sOBAqfQ/8ysf0F8w48KQCbJebyDRAEbaGxCLU13lsdnyUhsf04/qj4udRogZmUeRe53pc2xmcF9MjFWgUzEmvTb66Vt7gkqUvyPEJMsZXLsnIBcqb0dcKDHComqu7JyfJJeNr//UjrcKrnZ/b0V99FW4Rm/RqkjCAvbZn4+ZeVRII+nLIk2poTt32knSBV5JfyimbUynZo1iSh7YpOZMV2cuW68JVoObsQMaVI2ulszNxPiUt/aiLSzVPgT0PsYnkTSIYCH5VRTBNkGxDzW+osXQaY+9oBnnlBHtAod646K6jTqA7JAGwTGFPxUmAgfscMvwR5L/vjTtOyMjt0PLmSHH+FrdBb8kOdVBcKl6BaJdjT1PxMZCbiJFkLy4BryiMIY35qpN2sgGZ6Bwj5Reekr+bwD9vODh7y+pGyDmlMdYg7g7YsoxbYoZIsZ/qMzVGXMPS4sGcwVzOjO/L1/gNFDVR151O6jloqYhx1c3/m2if5N8Vwqa+NBQV8vAk2/92y+m+1tURLv1e2rxRf1koXGJozGd5u1yZgvvex/BHbXppQeJxj09JRlk2mlzEFcGo4cnzxA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(38350700014)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WKDoNB5m4YS1GclRQrUqGcrwlAQ/iEIk3dCiBU9ezrmhskQ24FmukWj8Ofo1?=
 =?us-ascii?Q?a2CJaaWzAQAMw49OgwZvwEfQ8v7PJsEbytxvBMy9ZDcrl5EwOU5Bpu8b20zo?=
 =?us-ascii?Q?TFRtpJsnFtN4hIYqOwwQoGVO2yQietzMIKGWTjp07NXS9IjnrksOfdZA/Ggb?=
 =?us-ascii?Q?2TVwVZAUOMX66QyGNKsXak7DoG59XBhR9Y4IXMv5p1xvwb+i6YIrCZZSGAUp?=
 =?us-ascii?Q?tE2ebvpa+KtbPFnlHhbtn1MaMzHGfTEZGpoi16GnzQWoSX5pPFH17wN6BQ6o?=
 =?us-ascii?Q?i48AxXXJBlvG3VpUhBAvk4JRUz63/rWKalkCKazUx3eD6giXB7j75dckDfoA?=
 =?us-ascii?Q?d1tSp8MuZyfXMVSbkkUJvkUZZOy7+cjfOdgycvHWhSw0kiasFXFE4QyV5Epj?=
 =?us-ascii?Q?Xp3gRt5d7RWpotbffLryRzI3iRZwzjvJ7Np4OOB3Xht+cPVZQaRRsz2x2Zlf?=
 =?us-ascii?Q?lKfnvsyuD2pIE4zBji4GRRPoJFv3Jx1F/8BVcE47buBs5Mg04OKGjqHf1MMU?=
 =?us-ascii?Q?JWXDtIU2kAMm+3p0YUDqqvQqxQwkhFhUAN1rff1WzpdLlYBFnPX82B2/PI68?=
 =?us-ascii?Q?9PeYCjwFn4xI7uvWjce7uE8zuyrJ3Y2vZqkD7sILDsAmBqp0XmBqhxvk4cq2?=
 =?us-ascii?Q?41YNPpkiwK4q+twuuIHrbDqWzb69Qd87pqHR+AxpMMoYrDsw0Le0my3sntMj?=
 =?us-ascii?Q?kD9JOJ++oIQwD9QehMJQ3znzDIAiPX3hTn8Kc4tYFFx1m6c+RMVHdAhnk0rX?=
 =?us-ascii?Q?635t+I1DkzREX3Nt+ls7BK4BciaXA+ivZD0xkj9fjXTZcGrKv2DG4abfVPjv?=
 =?us-ascii?Q?H26LM28g0p0k0LL/plVGeMpklNfuxoTWos0nNWNCx5mKSJxTX5GEYajyIlk8?=
 =?us-ascii?Q?KJ4gkuAWOmwnylDKpKzlj7gKQEodb+3zRXoii4JiNzcpDHnr0D4uSkTzpIl/?=
 =?us-ascii?Q?ICueo8oRUK49OYb7zIflG0au1oiKFY8PdsRY1Y0zIB4ZFr0SwVNY7k/IjRaF?=
 =?us-ascii?Q?39DvegTjdncLvvCFvInj9EB1DwkoFEToo9LgTvvv3BAeNHdyg4jAsIyRNA1m?=
 =?us-ascii?Q?epUFi3bJCXRqighm+GRjONplUtQpctEtZBmwI7H/iX/thtbmkYSaW+FnaTaU?=
 =?us-ascii?Q?3Gri1jks8vZfSr4hkyJZ56C1PsX8WukowazV9oamlOyBQiQa3fys2FH/khwZ?=
 =?us-ascii?Q?48Z04vzZsahab3dfh8NQ9eo8vlGXHEs4GRyzs/co9V2CKPnLOc4iix0dswib?=
 =?us-ascii?Q?CUB0/eWGWIJ3h+MeZo0cvbjpMCkZAbd/lu5ayUcmAxCRGlTaakF62l119Ytl?=
 =?us-ascii?Q?WMNQmBgu30CBfX5oZFy/KNRtwhAVnNPQ6XLKINreyRFxlnUY/SgPGQ+DAFM2?=
 =?us-ascii?Q?LPM256HNrL44AZJbBUkpqcU2WzZS+YcF2oGSR/XNo6wR8z4JPfWoIjniibhn?=
 =?us-ascii?Q?E09wU1QtELrY6RuRQIDnnChMAx08cBE4AqXrysW03pS7Ls5XCOPGDgYWbXpC?=
 =?us-ascii?Q?/0Q3qBrgL6zNteQAlcOQsuJ3ULgw6afO/OPymttXgqBFZmYDdHx1iPryKmjC?=
 =?us-ascii?Q?vF7vJs7XhCv73zCfJ5W75eGf2iX1dr3oobC/bHIILg4HJzuZhgkwjN38nMUW?=
 =?us-ascii?Q?gAwk0v1zGshMscRZZ7+NrvEz3lZFfP8RAKQPoY+F1fTAQRtveSEe3SrIS7vc?=
 =?us-ascii?Q?O6ZnEZZw9nvlU4vdAxQzItsJur2xgqAqpZsPpnl5Nts1VcIoP7ioPLNiajyz?=
 =?us-ascii?Q?EOlimBFS4/3Fva4+kn/ofWq0DAwzxu8=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acdaeeff-f6bd-47bc-be9e-08df29ca42c1
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:07:59.2113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puEZCNYZbEjlRNPrkKN0Shex6ZKdDfpq6n8jmsWYRLiO+471Fd1Zsm6KWlVodEjhwaFdSUOewARuHf4JczMbrITB7vtYR8u3tsNp3Bpwioo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0208

Add handling of seccomp_permit_syscall() in syscall_trace_enter() to filter
system calls. Make the syscall_trace_enter() return -1 (skipped syscall)
and adapt callers to the new return value convention.

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/Kconfig                      |  2 +-
 arch/sparc/include/asm/thread_info_32.h |  2 ++
 arch/sparc/kernel/entry.S               | 12 ++++++++----
 arch/sparc/kernel/ptrace_32.c           | 11 +++++++++--
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 8dd15256edf6..56d5ac7b228a 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -23,7 +23,7 @@ config SPARC
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_ARCH_KGDB if !SMP || SPARC64
 	select HAVE_ARCH_TRACEHOOK
-	select HAVE_ARCH_SECCOMP_FILTER if SPARC64
+	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_EXIT_THREAD
 	select HAVE_PCI
 	select SYSCTL_EXCEPTION_TRACE
diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index fdaf7b171e0a..b51b080f1810 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -110,6 +110,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TIF_POLLING_NRFLAG	9	/* true if poll_idle() is polling
 					 * TIF_NEED_RESCHED */
 #define TIF_MEMDIE		10	/* is terminating due to OOM killer */
+#define TIF_SECCOMP		11	/* secure computing */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -119,6 +120,7 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
+#define _TIF_SECCOMP		(1<<TIF_SECCOMP)
 
 #define _TIF_DO_NOTIFY_RESUME_MASK	(_TIF_NOTIFY_RESUME | \
 					 _TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 7218208e0a65..db732395c048 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -930,9 +930,9 @@ linux_sparc_ni_syscall:
 linux_syscall_trace:
 	call	syscall_trace_enter
 	 add	%sp, STACKFRAME_SZ, %o0
-	cmp	%o0, 0
-	bne	3f
-	 mov	-ENOSYS, %o0
+	cmp	%o0, -1
+	be	linux_syscall_trace_exit
+	 nop
 
 	/* Syscall tracing can modify the registers.  */
 	ld	[%sp + STACKFRAME_SZ + PT_G1], %g1
@@ -1004,7 +1004,7 @@ do_syscall:
 
 	ld	[%curptr + TI_FLAGS], %l5
 	mov	%i3, %o3
-	andcc	%l5, _TIF_SYSCALL_TRACE, %g0
+	andcc	%l5, _TIF_SYSCALL_TRACE | _TIF_SECCOMP, %g0
 	mov	%i4, %o4
 	bne	linux_syscall_trace
 	 mov	%i0, %l6
@@ -1047,6 +1047,10 @@ ret_sys_call:
 	b	ret_trap_entry
 	 st	%l2, [%sp + STACKFRAME_SZ + PT_NPC]
 
+linux_syscall_trace_exit:
+	/* The syscall was skipped - exit tracing */
+	ld	[%sp + STACKFRAME_SZ + PT_NPC], %l1
+
 linux_syscall_trace2:
 	call	syscall_trace_leave
 	 add	%sp, STACKFRAME_SZ, %o0
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 3cd3a31ce677..25d10c1b075f 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -24,6 +24,7 @@
 
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/syscall.h>
 
 #include "kernel.h"
 
@@ -436,8 +437,14 @@ long arch_ptrace(struct task_struct *child, long request,
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !ptrace_report_syscall_permit_entry(regs))
-		return 1;
+	    !ptrace_report_syscall_permit_entry(regs)) {
+		syscall_set_return_value(current, regs, -ENOSYS, 0);
+		return -1;
+	}
+
+	/* Do seccomp after ptrace; syscall may have changed. */
+	if (!seccomp_permit_syscall())
+		return -1;
 
 	return 0;
 }
-- 
2.35.3

