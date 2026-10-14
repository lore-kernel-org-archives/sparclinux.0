Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020085.outbound.protection.outlook.com [52.101.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FF546D555;
	Wed, 14 Oct 2026 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965295; cv=fail; b=WgVjiMHuxQg+LeIeGChORbSPzHl5mXswFflaurCb6t7xNTDeUJk8f33IP/ApVBQLOW2OVtZ1bWuP0cPht4UP7LWnAyv4J2kVtnfM90CNLCf0VSWetPIhFMskdwE4pIDx0G4lpGUItmFchmoTrfK+9sIl/HNlAXETzvjkrMKHzLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965295; c=relaxed/simple;
	bh=Y6cCbYnDHE0/vh0UVHKkv4nW3du5APyhPOTYlhdoqRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuI91klvw//hA6ekCGBJ+3yDJMpGqSmJkB71FQ+P23RmQQ6OM7q5YjE3vYCAV2pfAYdm3Q4dQmIPtsp/kQBLsbE0kaWu3Zu9Jbn+TOdQ0bizvPhEG7AUWYqoQh7zIboEWaVXu/Jji2/2Fv1D1nu0Q8ZYO6N5PGHIKkZgzQ73IvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=uQk2NgaX; arc=fail smtp.client-ip=52.101.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="uQk2NgaX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D229cPBlalrCa9sLzB0JEwjz/1o6fH/ulFXJbHmSRbzo3m2D12ckyfb4sRC3nz7R/5J2LJr9y3FTkBfCzO7qf26JOH1DhYsVxV0DrADONBlZEwz4j/ipAfM1a+LNRpgxxpATmW1iORfoiJwhS8Nat+EaA0004HJd7XlUjbnAkB0KZxTErJr+d/X74y1kV7WYtEUfz87Ob/MMG+lTgk3WdgN7IwLhNF9gcz2J6DUmhiBOAYdqSvdwrJLxLWis9P0tKOqzjLigerqxb2kD5yuc7rLcs+I6sOTeZGb5aX9XIk2Jc4YK75W7e/3WefLKX6AAr8jLZ0GXjpbVtr3HDUWOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaslWF/DbkpTSyPqrnwHHdJXTD2+Cq4/iiT3YY9tBrY=;
 b=eHvHZAob5/DIbmsdP3N1R6PsPDuGT9APC1UHvYCUcGpzhrchuZ2WCLSHJ0SHbfc5rv0gzHD2GOcQ1eZhsnod9AWwfcUQMHBxV0isVA5XHbgkc/gRIiFpIv4n1AwhKyXsDl74pXeaJ87cLcy5BbanfMEsk1DIcQ7OICmlbIOza/cypx2WdMGEi7QIQxsPrd09/k8ZuQWdXHAbEAUwTlHeBUC5xP0FZvckI37dno9QBUY44N1unApw5aD/gvJi3eqb+DD2tFCTtLIUqcSmN5oUnJiUkzXllQjYWgoxGkM10aNXuV3TotNy560/s+yyLRcCtIzEn3cRnbNgs1wkVN4P7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaslWF/DbkpTSyPqrnwHHdJXTD2+Cq4/iiT3YY9tBrY=;
 b=uQk2NgaXyIJcjX7SeiXmcy3vJ7kk+b4+62Nu+wDnvxvc4HOK+7efoUmtUohExQsQuOM2zxS2dgbkVoDmLsnWudCKcL+N5sGbwQoBixNi3Z4U7xcEHY8G67gqBF++8d77OMVqHQQzs4516t+n3V4GoTQg/bn1qvaulNkKP5ZWuQU3H82WLlapP8goh2Mud2dXCU3qV1C+TGbU/hvw0d+Bja6U+pb3bhuecyeN9sjrsNMVu/ivmEfQ0c0LTyqKr051lUI+xmn6XBmBUnzDOuHMVEUbH9esbxt5HG3da5svmi1pNmmPyrUUJbDxj9qpb/41ZEwNvKNxqurETTOk0r+fsA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2::17) by
 GVYP280MB0208.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:1a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 08:08:09 +0000
Received: from MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192]) by MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
 ([fe80::8e01:811a:7101:e192%5]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 08:08:07 +0000
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
Subject: [PATCH 3/3] selftests/seccomp: add sparc32 support
Date: Wed, 14 Oct 2026 10:07:30 +0200
Message-Id: <20261014080730.8817-4-ludwig.rydberg@gaisler.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8eef99ca-12d0-48dd-ee52-08df29ca47ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|23010399003|38350700014|56012099006|11063799006|261009223027099003|18002099003|22082099003|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	shp2s1aaclDLg250v5YBTCgxw8fNCfFABQ2CFrvNr+KaniIhK+UNd2nQcc9K0wy7K/NRx64NXAKFYpNqUtUK1PNDxTWcEXkZr4y7ef50fJv4wX0b2Fh5p1BXUm5tsPohTg2z57rYibGtiuelxe2/PjXuIFgsdHpeMsn3wgiph8rHJz4bLPVakd3pcNp7ghfxqhhlEmvuRe9yQj0Q0EwjsuhLVtAUXLNw+TDvZrsYbkqkv/x3vcU1c8qh8umiiPckdTGB/eYMx14XJ2mBNU4JSFdyqKJw3C8CS5TwQjlMR/Hb/B9jJaBFD+86TqGNWRgK7rCeCf72L/7qpX/46iYgzQzwowA1aP1ijTn4SwFmILsmeBKI4vl17uzgK+hKWq6/C5A60cGk3SigJgrYZToQIeDz0GtBf68DinpfVzRPlMg9n8qmrxNmkVem3UkBvuYZ91N3xLP3MvotMdlPum2X7Zlks5EB4YY/mA78wksqLT5y1i24dv0US+Cry5t4vZ/mifYQcqx4Jw8r8jWboUnnHBbRMVIsf8nqnOtakpFZ5R7zZCsNRZfbAnKLLw4q9liDRnWnEdN+wqypFN2cfh52UkVDHAXVZyoSgWLxc/McT+0EYxBEIUjFOBRjmIt2eRXkHMuCNizoXEudbrgHDiZQ+7mAyBotFv77zGORGjm2Lajwql7e7Fl0tXMVp9PXN/0UeiYtBCnEYK5X8FMKz28v3+YXiUblHNhP/WFv68cRlZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(23010399003)(38350700014)(56012099006)(11063799006)(261009223027099003)(18002099003)(22082099003)(10067099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZTwvxb911BLTn2HokeXeOEmUWmrO8zU/ffxfiAiqIuuGOk/K2t+jHkstF2ug?=
 =?us-ascii?Q?VMRNplE42qhbhkB2c8T+XNooHT4ZeHbGGDeexutBdEVaxI249ZcIyy7apiqt?=
 =?us-ascii?Q?sQZIyoqL7in58RDMzTpf2Ig7zg+AokE1lpyh83J5kVVGyuA1dRkj2ynxNEJ3?=
 =?us-ascii?Q?b/M2jKUF079clcmamipPHGyZYUyYammF63SeEkgskpkJ/N3qq7g/Rld97Fzd?=
 =?us-ascii?Q?PilabjRgeX4omwSBQn09oc2Nsm4nbbbB5J8SncN/gYk2n3WYe1HPXkDpjpqo?=
 =?us-ascii?Q?mr+il0+DmsO4ls6fYs7+9+WqS6t+i26ycDYnkeOCjNS/ZYe4S9CubRhScRfp?=
 =?us-ascii?Q?z0uXWWc++kIWMHBzSwByb+gtFuT935V+6GC+DUOWAwZQCuGCYwQFelqfDV1a?=
 =?us-ascii?Q?GAeQwJZnExtQWHFWzU6GLRD+Q3bPCubflIz/NN2645auuOzytqGDYPjZYANM?=
 =?us-ascii?Q?gcgoHBHC5xG8Borx6yuxrFn6VM8u1VxN1/U0hXc5ZYdJvFOhRHWXFrEEuP4N?=
 =?us-ascii?Q?aGn9MEFfPTdZZJ2mQm4mCKLej2jLzee0eMcJYGo/zMjzEp6svVGvgYwqhGrJ?=
 =?us-ascii?Q?OMFgnoqHdWYnBTxnUXMiK+xS84yypr+J4Yj8fma/Ndnp047i3k9cV7lOcSac?=
 =?us-ascii?Q?W0qOpRxdCEOajXbPin9tq3Rrte6iR0Iqvo205icdF4fkDn/opWDb+Z2QNLQk?=
 =?us-ascii?Q?Bf0G62a7NR/XH+UK1a+SF51oOQb59Tp1BrwPcBbOtziZGXi98PmhPeK4dLvN?=
 =?us-ascii?Q?GeVIma0gK22gB5tVd2uybVQ2r7J7MQpqgzSvwwLunBLgO4B+fEugod16M5gi?=
 =?us-ascii?Q?1V1VYNhrT+do0sq5tV/tS/j/zKThYVKBcwqzMIG9fB72y9M/A7AraYnpd4ew?=
 =?us-ascii?Q?ILSyuQYyP5mjOe1MCfx61wB1d/TVbMm5k63dt4WpvrmYjOsbpZtS9/f8JumY?=
 =?us-ascii?Q?qEfYiP2PRyT6Mj8A0yEKPHJOf7tnDQas3ByhN6+4kaU68ord6rL9ThnQKXWT?=
 =?us-ascii?Q?jeB1+bRZ9nrvxYT0W9v+a04psaLCc4vzFFetYB538d5FLSxjDxTXzRlXCtMA?=
 =?us-ascii?Q?HTXJ3XmKTRiaQ6jHHxadZHqK3xeqh7vV/xL8TiLEDiU0sUpMudnP0cplRqyT?=
 =?us-ascii?Q?J+ZGsMnLjaZrk2D/J+J7MRY3rC1CjuGSzBAi9ubJN+qS2IB5DOGEPN9udYQ6?=
 =?us-ascii?Q?z/lk6+f6WV/gAJNqiLAYduOCrJwSzegfEwTpK8EpXknk+6LpYUv6sKdupeQ0?=
 =?us-ascii?Q?FAIs3U8zoa5njebrYzqPITTocCbXerVWJjVEncVQIKeMQ3t2U1GA4ncZeLt2?=
 =?us-ascii?Q?P9eCY8XBdm/MgOfXlZRZT5bbxx5scCwNcNoCzS9Y3xuM5RsUlff8ICLHeljP?=
 =?us-ascii?Q?zLJkAVDxBOww3P0X5gI4cEbth5VWBpUEWHnRlfA6l+pJXvAA79L4wJT47RHJ?=
 =?us-ascii?Q?Ldif6Vjvm7X2/eJj+Mid693Y8WYzITNNcyXze91Q3zd9nN2TTe0KC8vEaspR?=
 =?us-ascii?Q?6obo76CZ6Hf9Q90ysl4vJ8OUtvXUGq0909+mZtDVRHQdsm5c1ZBlJaxRMvTm?=
 =?us-ascii?Q?BAr529mUcKuZXDJqVeVsY6WYO40MEl07tmwKxn3n8vWrWDGGjeNtrrYryS2l?=
 =?us-ascii?Q?WaP0Luz8dI1XAfi9YUz4h0eZ99g38ERtkJUKaErAQ6vXDA21+rRApWX3YD4U?=
 =?us-ascii?Q?C4wtpEomHlkwEcb4qaUtmnt+tgBBpckBxDUZnXf1Tea7W/Z1/xo+NVjwf4X/?=
 =?us-ascii?Q?HT3iv44pCqFYaMYrdaSWX7GPeGnRjIk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eef99ca-12d0-48dd-ee52-08df29ca47ae
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB1058.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:08:07.4407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVAhsP8eR9K0WA+iU45d9XsUzhob3YnyEwoN40X0svJ/8Gjf7b61utJBa360bi0nbnS0NQYAigYLGwj6a8lXdWm0te4qtneOs7hrHt5sjZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0208

Add SPARC32 definitions to seccomp_bpf selftest.

Reuse the sparc64 register handling on sparc32 but adapt the carry
bit handling to use %tstate on sparc64 and %psr on sparc32.

Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 3711060c22a7..60ae1de8201d 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1872,10 +1872,21 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define ARCH_REGS		struct user_regs_struct
 # define SYSCALL_NUM(_regs)	(_regs).orig_d0
 # define SYSCALL_RET(_regs)	(_regs).d0
-#elif defined(__sparc__) && defined(__arch64__)
+#elif defined(__sparc__)
 # include <asm/ptrace.h>
+
+# if defined(__arch64__)
+#  include <asm/pstate.h>
+#  define CARRY_MASK			(TSTATE_ICARRY | TSTATE_XCARRY)
+#  define SPARC_CARRY_REG(_regs)	((_regs).tstate)
+# else
+#  include <asm/psr.h>
+#  define CARRY_MASK			PSR_C
+#  define SPARC_CARRY_REG(_regs)	((_regs).psr)
+# endif
+
 /*
- * PTRACE_GETREGS64/PTRACE_SETREGS64 transfer the uapi struct pt_regs,
+ * PTRACE_GETREGS{64}/PTRACE_SETREGS{64} transfer the uapi struct pt_regs,
  * but in the historical layout that omits %g0: the blob starts at %g1,
  * so every u_regs index is one lower than the register number suggests.
  */
@@ -1883,20 +1894,20 @@ TEST_F(TRACE_poke, getpid_runs_normally)
 # define SYSCALL_NUM(_regs)	(_regs).u_regs[0]	/* %g1 */
 # define SYSCALL_RET(_regs)	(_regs).u_regs[7]	/* %o0 */
 /*
- * A syscall error is signaled by the carry bit in tstate, with the
- * errno held in %o0 as a positive value; the carry can only be
- * written reliably once the syscall has been skipped or has run.
+ * A syscall error is signaled by the carry bit in tstate (SPARC64) or
+ * psr (SPARC32), with the errno held in %o0 as a positive value;
+ * the carry can only be written reliably once the syscall has been
+ * skipped or has run.
  */
-# define SPARC64_TSTATE_CARRY	0x0000001100000000UL	/* xcc.c | icc.c */
 # define SYSCALL_RET_SET(_regs, _val)				\
 	do {							\
 		typeof(_val) _result = (_val);			\
 		if (_result < 0) {				\
 			SYSCALL_RET(_regs) = -_result;		\
-			(_regs).tstate |= SPARC64_TSTATE_CARRY;	\
+			SPARC_CARRY_REG(_regs) |= CARRY_MASK;	\
 		} else {					\
 			SYSCALL_RET(_regs) = _result;		\
-			(_regs).tstate &= ~SPARC64_TSTATE_CARRY; \
+			SPARC_CARRY_REG(_regs) &= ~CARRY_MASK;	\
 		}						\
 	} while (0)
 # define SYSCALL_RET_SET_ON_PTRACE_EXIT
@@ -1967,14 +1978,19 @@ const bool ptrace_entry_set_syscall_ret =
 #if defined(__x86_64__) || defined(__i386__) || defined(__mips__) || defined(__mc68000__)
 # define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS, tracee, 0, &(_regs))
 # define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS, tracee, 0, &(_regs))
-#elif defined(__sparc__) && defined(__arch64__)
+#elif defined(__sparc__)
+# if defined(__arch64__)
 /*
  * The NT_PRSTATUS regset appends the register window, which struct
  * pt_regs does not carry; the sparc-specific requests transfer
  * struct pt_regs directly (and take the buffer in addr).
  */
-# define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS64, tracee, &(_regs), 0)
-# define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS64, tracee, &(_regs), 0)
+#  define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS64, tracee, &(_regs), 0)
+#  define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS64, tracee, &(_regs), 0)
+# else
+#  define ARCH_GETREGS(_regs)	ptrace(PTRACE_GETREGS, tracee, &(_regs), 0)
+#  define ARCH_SETREGS(_regs)	ptrace(PTRACE_SETREGS, tracee, &(_regs), 0)
+# endif
 #else
 # define ARCH_GETREGS(_regs)	({					\
 		struct iovec __v;					\
-- 
2.35.3

