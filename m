Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022084.outbound.protection.outlook.com [52.101.82.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1C46D555;
	Wed, 14 Oct 2026 08:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965278; cv=fail; b=en2QboJPrn/tEISRcWDUBhXbYeNK1GWXPWcY3BlQNE2kGtGWHA4uMxI0QwZnZUkDieHf9y0ICyK2keFg/if1SugOGoVWa0ImC1pHta3zf4FxSaY9Sx9hWWcBB04mgN+6J0SCyqdMTOta80tVnecNdo8t7RrNJgLW1C+I4zfP2jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965278; c=relaxed/simple;
	bh=BEUBvPm0NLLox2I+0/FHlGJacqDQxL3ZkwJ63SNmcug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=onNjX1V+rx34L2bVaqq8jruV/djJDhNWD0eiTp5997YcA9F8u8UXJe809eHkj7c4qCmEpHWS5PyzxGiR1xRO+cLSJiHXcWBTfhtMT34O7iCXFfr6GbzgrtFlirRn+eUb8J0c1JhS8eWz8dKGK27Uro/p+q/dT32TEezTuRVIcEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Em8jnvwY; arc=fail smtp.client-ip=52.101.82.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Em8jnvwY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6OC/O8YBi79LMS2ASDzKZPOqEOn7HQGXaJHS95nqlV3+Lv3eEp/c3DCGZ03MU6froMCGws8DpHEOI+RAux2Wx3pzFr0+hJe195Uz2IsZjD29pz+iZU5sH7XCjXI9rs9JHv8/gqcuyR6XLAstNN2UsyenydOo9rWjBRKXAREpCjCskIfpFYBZQNzXTT8f/I5IhoFZDPsaf7pJbPzFCg1DMfeUhCxW0w+8qloy7Z9SYqMm7jem8VmQyD4e+m525+9gu71VyqDhQjh9jPwHHtQFRin/A97DMZL+ifPpiNnEybYshgfhmYdb7HRMeZTWfWEH9OI0HAwo7YBVF0pBTDI+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZqSS6QRIJxTubyRbeeSTVDyCU81vUWZ6DsxvLeCloQ=;
 b=ZoCghX6H1F1lLg2/4tIONAMF4qbFfXjOWRrRmOWcAw+absC7/1x+/P0OkTNatJGEzIKkn8UCJmsV26T96gvnN9KvIAzv/NfwgZjTP9M5419amdfkO9P6eQ1pNihZS7TFEGe9b5vB34I5Axz9kmRyfjdinZeGX7gQkyH5UwFReBItJs4RVndpG5+pYnSl9Pjir8y1HkSPzWI02lzVQd7bun9vpxq1SnPkk8Qzp/Ddc+9eWCHmMd9pYR/p75Vei0Rxpi8haZYPEg4c6Z5Pkw2FZx8aca8vHGou37oxLxSAjImq1BTNVfQ+bJvwU6CfbUtL2Y3tgXbVFM6v3lrJnh6JIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZqSS6QRIJxTubyRbeeSTVDyCU81vUWZ6DsxvLeCloQ=;
 b=Em8jnvwY0lexqD0ym1vWnd671EykZ32kdH9I4NmvySgT4CfwM7kU9vukOOiBCiljMY6aA1+j6kfZeknQX6mn05Dmz9y6vCctlMftTQ0SXlVcG17XKEWLZq79VPvP7LbQlHZI8aZo+gtGw8idvY/DISUw90kaIUfWHzBcA1hjnDLtvQmjvZxemiAU5mJpryT07RGfJk2Ddnu/zH1B5Q934vjnholtHBqD5fxDeNYbFOLh9a0xGRlFidCuD213kKc9U0S2wsOQjTg9yr1/NjSQ9namhLFqejoN5GOTV7vxAmNcXwCq9btgL4V7B835A4m2OQaqUhL53Xb+4049vEVnTw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GVYP280MB0208.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:1a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 08:07:50 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 08:07:50 +0000
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
Subject: [PATCH 1/3] sparc32: Split common syscall_trace() to syscall_trace_{enter|leave}()
Date: Wed, 14 Oct 2026 10:07:28 +0200
Message-Id: <20261014080730.8817-2-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
References: <20261014080730.8817-1-ludwig.rydberg@gaisler.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB1058:EE_|GVYP280MB0208:EE_
X-MS-Office365-Filtering-Correlation-Id: 3244951f-d8b6-43b5-c814-08df29ca3d62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|38350700014|56012099006|11063799006|261009223027099003|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	TqVACfLVG0rDdVvQKe4fgiMS72nG9Zs1E3pg+vxWMqOBKwHf3gIN2OhftuZBi7XnoOS2mJhMtflcZLChKZbPQaRmZYl7tIWaVzTU5vs7ydPEeaOgE5iGx3VKzNiz+Menwg4nuN3OrxZ41DgxvLtajW8twuWZ0w+XxbTy0eXxh7S5ONOtrGKH2CVmAADzP8BgyoZ6WAUaWY0GmJ8tn2p4217tGhiWfeWqNICn5MTtTdTnwQXe0LOC2F2k6BAggMS3HIKhdzhd/DM9OA4DzRs0hn6Ur03PSGE2xPvKeoWMviAteX++KsT4podAiAUcWATTSkcBsEh2vzL3hhKWJWT96QjllcqhTPlvh4pQ8JS/xMuyezqGM5vlN6RP2SWqKVQX8S1LdB/+OOP5/dMsPRD8IyQpMhGOzEJzzKlzBytbENVpfobgXKuQfX1klrhngGYKtilHZoiFe1FnQPVPFuNXP/o10RR3P4lcRwsWo+bEJCSTVF+0/DVL+ZoztfXF6C1djwZcdl1ooAMCEezbyRhBDsvXGjrFZK794HEZt7dGueRKo55RYukpOaR3pqpV9gcXy96N4W0rLWP/7XI5/3jowVxsSNkKTECFNOZ45+5PCvuV6v17c2SgVxOTu7rQr8NjcSxU4tPywMhPm3uHfn8ij1Ei+mPRG37bNR2HfU2IKjuc4bv3MHrujFG8uSpjRrAvVtN/b8zlHeRuMJ5FS50YvF12aJDVrv6xShXIYK8+C7A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(38350700014)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KwojXGAGVtsV8FeP1+Z40mB3b6XGjfyibwmgkHU+GGFtWp8mbvvXyKvve4mD?=
 =?us-ascii?Q?TZ35xLQeDRQxJFTKp81DIanLtBFJFT5loCzaGk39FLlXyYDDnyhb5NQOoaWy?=
 =?us-ascii?Q?nCz8bfvfdUla25G514DWv+/3zZmlRpuNVdWtdeJkL+X0OwBJNOgWsT4vtLXk?=
 =?us-ascii?Q?3jv06xo/VJA4F06aGAEVK833Qu429UCZ5HRfsU2X4Xop+qK5EKWaxEq0Xyrd?=
 =?us-ascii?Q?VsoDQAIWjY/VXjWSbDkwm+4h7MC3sqJLneGuWXFzCvzMKPS8fz480QKSyFMw?=
 =?us-ascii?Q?iVhZnMQB1Eqrm6wkHDco7Ogruuv0RqHbk+M53L3iZHpRmDIonTaPX7utEFfb?=
 =?us-ascii?Q?aRShyeEtRF7gbmTUs2gpN6o/+POL1D/UOlq2mFJyyWBl9PHW0UmJwmije7SW?=
 =?us-ascii?Q?Z6vG7/WpVXQC2CnftNHdojvqWu8sWiox9nydy63FQLU3L5vZKNoZuTj+mT/e?=
 =?us-ascii?Q?u3s8bzYHdf+gWcyaR3Vog5t+Z6qnsI1X+LT5MsY97zU7SpLSHVnd/pItQTju?=
 =?us-ascii?Q?oc5p3laJJDNN+RFOYnKzAs6IburDc+9nTxKBKV22CxkodDFjWBQ1dP0lDFI+?=
 =?us-ascii?Q?W7JaJ0UPrcp2zWrc+gFoCY1xtV/ayLkGuI2yVZ/uw0asWxG0qmTbBmFa5Rtc?=
 =?us-ascii?Q?e7kHFv/5hGcMjvI+Ur2biCndLaV9il8qg8aesCwKhW1XBF+HqeGk1ffif4wy?=
 =?us-ascii?Q?+8fIwgfbC7Ulzd7emWZabTNOrn0PlY7wJVwbC5xdlr5ENrVV3/qGKE2Zl4Nt?=
 =?us-ascii?Q?WEQ1Bll2gjhrtaUE1n6GRa4fjbxTNopsOxQzpb+fGm0MqzyxGM2cYgOOA5IL?=
 =?us-ascii?Q?VT7m/fC3mJ3wlqgc3sEJgYciZONEU22WbQm2+sC8kN6qWJhO3qnOsvp3QACx?=
 =?us-ascii?Q?27FhdYSPQry6RBRaFLb2RC+8e1NLFLF8wzyLWYhCbmlN/oydeh4I9wS0vSXv?=
 =?us-ascii?Q?D8yC7Lc/ecrY8dSC9gGkP9YAYtkwCw3T/pQlotiiwLwQ/GNFAvGsXBZNuw5W?=
 =?us-ascii?Q?J4nVb2RdSbkaGFYLu6Tre4aDtkGP+mpBse7/4abFPk50vDRseoUdcqYzECLL?=
 =?us-ascii?Q?xaZQURKRnIcmhKGmdgpxcXKhJFyIXxJbgS/+N9OzGmr5rY07/+hYd//8e8C3?=
 =?us-ascii?Q?E+y0x5sJi6ihLQb3szrteG1znXBT4YSu2oqhvdeFzB78a0LlX+JyjPtSUvJv?=
 =?us-ascii?Q?A2uE6ovE4ol6gvRXvERPjTUSpcAoJ60v2L9KQwb6cBKGxj/Qwe78NJggZR7v?=
 =?us-ascii?Q?98mUx2IdYXwcbOu/QU1725u5H/ZT4PBGjN7ve62cUA8Upc+2eM9fLHEvNdht?=
 =?us-ascii?Q?JlalZ8OC79WHJugBK9oD7cTiOyG79Y3XvSlgk1jJ9gerWiqwAY35UFngW+V8?=
 =?us-ascii?Q?dPhkAvt+Co4aDfNrqmYyjMJccQJfcc4IwWnQv8o6M3mFNjBrlRxR/jbKegG+?=
 =?us-ascii?Q?h5RqnZLnIghQw0sQCuMjLqzJLiiVD4bzMhTiO1Zug4RmeJu70jtFtAq2hAtW?=
 =?us-ascii?Q?geQpJNEan+KNGIHwa7fgrfh6vwt41IR8cTL1z6aw2yeEkjfFnc/2eY4/35/s?=
 =?us-ascii?Q?mymrqEEQzSfp3DL28Vsw8Tm2FhDVGATyH9LE5n5+PVyp/2YplFOwU9wAt5j4?=
 =?us-ascii?Q?mV/PFXn1f58yXG+DATnqqICeeYgwiVVdhcRQXLB0elxTXc8euNPRPSKm7ESS?=
 =?us-ascii?Q?KX/pyL5qgJrm3T8bt7tkONIwdegtCXO8KUJlSwWrFliXlTX6ivzzdGcj2WNH?=
 =?us-ascii?Q?CgM9UdYz2f08+g5w/7vvNj9hs2CI68E=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3244951f-d8b6-43b5-c814-08df29ca3d62
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:07:50.5528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4o8sX4tli9iIAnMt0+9z2p1IuwP7nwmtRLlUGXt8J+I2pmYfTSV2EIOaaItIbbVy8un6LnMOSKN6+o4MZx3NizzqyEv9VLPNskEqIC8ZkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0208

Drop the common syscall_trace() function and follow the pattern
that many other archs (including SPARC64) by having two explicit
functions called syscall_trace_{enter|leave}() instead.

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/kernel/entry.S     | 21 +++++++++------------
 arch/sparc/kernel/kernel.h    |  3 ++-
 arch/sparc/kernel/ptrace_32.c | 19 ++++++++++---------
 3 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index ea51ef52c952..7218208e0a65 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -825,8 +825,8 @@ sys_sigreturn:
 	be	1f
 	 nop
 
-	call	syscall_trace
-	 mov	1, %o1
+	call	syscall_trace_leave
+	 nop
 
 1:
 	/* We don't want to muck with user registers like a
@@ -845,9 +845,8 @@ sys_rt_sigreturn:
 	be	1f
 	 nop
 
-	add	%sp, STACKFRAME_SZ, %o0
-	call	syscall_trace
-	 mov	1, %o1
+	call	syscall_trace_leave
+	 add	%sp, STACKFRAME_SZ, %o0
 
 1:
 	/* We are returning to a signal handler. */
@@ -929,9 +928,8 @@ linux_sparc_ni_syscall:
 	 or     %l7, %lo(sys_ni_syscall), %l7
 
 linux_syscall_trace:
-	add	%sp, STACKFRAME_SZ, %o0
-	call	syscall_trace
-	 mov	0, %o1
+	call	syscall_trace_enter
+	 add	%sp, STACKFRAME_SZ, %o0
 	cmp	%o0, 0
 	bne	3f
 	 mov	-ENOSYS, %o0
@@ -1050,10 +1048,9 @@ ret_sys_call:
 	 st	%l2, [%sp + STACKFRAME_SZ + PT_NPC]
 
 linux_syscall_trace2:
-	add	%sp, STACKFRAME_SZ, %o0
-	mov	1, %o1
-	call	syscall_trace
-	 add	%l1, 0x4, %l2			/* npc = npc+4 */
+	call	syscall_trace_leave
+	 add	%sp, STACKFRAME_SZ, %o0
+	add	%l1, 0x4, %l2			/* npc = npc+4 */
 	st	%l1, [%sp + STACKFRAME_SZ + PT_PC]
 	b	ret_trap_entry
 	 st	%l2, [%sp + STACKFRAME_SZ + PT_NPC]
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 4ee85051521a..e215157d5120 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -172,7 +172,8 @@ asmlinkage int do_sys_sigstack(struct sigstack __user *ssptr,
                                unsigned long sp);
 
 /* ptrace_32.c */
-asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p);
+asmlinkage int syscall_trace_enter(struct pt_regs *regs);
+asmlinkage void syscall_trace_leave(struct pt_regs *regs);
 
 /* unaligned_32.c */
 asmlinkage void kernel_unaligned_trap(struct pt_regs *regs, unsigned int insn);
diff --git a/arch/sparc/kernel/ptrace_32.c b/arch/sparc/kernel/ptrace_32.c
index 5991b1731fee..3cd3a31ce677 100644
--- a/arch/sparc/kernel/ptrace_32.c
+++ b/arch/sparc/kernel/ptrace_32.c
@@ -433,16 +433,17 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-asmlinkage int syscall_trace(struct pt_regs *regs, int syscall_exit_p)
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
-	int ret = 0;
+	if (test_thread_flag(TIF_SYSCALL_TRACE) &&
+	    !ptrace_report_syscall_permit_entry(regs))
+		return 1;
 
-	if (test_thread_flag(TIF_SYSCALL_TRACE)) {
-		if (syscall_exit_p)
-			ptrace_report_syscall_exit(regs, 0);
-		else
-			ret = !ptrace_report_syscall_permit_entry(regs);
-	}
+	return 0;
+}
 
-	return ret;
+asmlinkage void syscall_trace_leave(struct pt_regs *regs)
+{
+	if (test_thread_flag(TIF_SYSCALL_TRACE))
+		ptrace_report_syscall_exit(regs, 0);
 }
-- 
2.35.3

