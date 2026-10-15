Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021076.outbound.protection.outlook.com [40.107.130.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B854A4EE3;
	Thu, 15 Oct 2026 08:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792054557; cv=fail; b=oCOlsuwoa3KEh4/hvhXLXnuYPm3aFc/vwdNvT2P6NweXX8EHeDucugCNLTXO6pLp+pkVGUEyR+jDdC6tk1BM1LQy1y5c4GG43gEwqE0jMHzr8M85z6XX0HOfcBfmVsKWXrpn9shpF7UgucilD/OUqJP8PW/nMlrudticinxMvfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792054557; c=relaxed/simple;
	bh=IubG3/h9ejeXCJMHjMPIS/2ND1VXEFjbWVffOnxQVFA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=RYF+5K2XH9FrnItSNY//+9BbFgr5RVG17lQkGP4kr8LJbkiVtdWg8CwxdJ3/oFv98A35Wc/TCPNjPEi8JPU2zvWwVyXXY3L5m1RTlQp1/YMXxgcAXMnJI2e23CwzAnjviUSKeTgwgVy79Eimg7vZvZIaXdIv9h/f+Q2MWbPkiDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=aMFXoDLx; arc=fail smtp.client-ip=40.107.130.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="aMFXoDLx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1NO2D59aonek4SL1uGMN1oAGwr0g1DwPC1MR/rQUqA47BV2LdtCgs8nhlKwunodgvSRXWYIq5ExBHXQLQ6+utj6qCVeVtWSLwiKN5VaeDMxMg7CDXp+g5pn+sSIzUx0X7s7Yc1IulhPbdVs/0jS5uGCq8/X4UzlZ13eEn6zDbcNHyJhaQ0h95vc08WsGnVbE9biYyl+h9fpZhyKRDb4Ynjtde9CNxaynfbosOHNlZiIH1pVl9J0x/5SbHXn7wdvYo4RK3np5N+5g2A973hzl1uR6ZJiCdhTH+oR3ZmRe8Ca2zRat5s6rVfCUjKCxIkSIZpc8n6sAUPx/++AAy3nTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jYxqQmnvwiHYMie/OnY6oLweSf11UFuT2n8WcijJRe4=;
 b=pGfmrwwTsevwOXlzV0AjZzMG8J3olVbpelHKTCeoalTkSumfMtLGGfPpcJURluOAEv5u1tfjho1YDByvbl7ItWP60zG1Inp2Zpw0FBu9AiXHRTdw6guixM0N+YfiFP6CfU7z49MAtrpobaChe9xROxbskUFrnRbrKXtFvUwstRbPfNWqGcLC6Sg6GfmUifWVVzQ/Ws5W5sZGNxEj0Rp7aUVrYNVXW79KqyLPmkUaTewgzlvxPVf624/0U9KNA7slkg4Y0/QGbZ7n4RpUSu/MP6nWA4kTpkayoqZ0rByhzMvdEBwHpC0T+lFtVnhzA8iFHd39TqbgRnjly96MLrtvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jYxqQmnvwiHYMie/OnY6oLweSf11UFuT2n8WcijJRe4=;
 b=aMFXoDLxxU9kvJsXAnEHJnOJSyM7xQyMU/qQTHEV7+2OQ24rMcc2aeKLM4ZiiTrZEmmDA1yIs83e2a5jIIQK2BsVJmm57KsdQnEj//JaPUcAQAuBJ/5HtHcdL4DCMYbe1rABXxJKHSXi3NDyCXirdCTcA2Eh4sTPszQ3BtLJEDJF+nc31S1ClOQK4hr48fddq7PrIoZ6kQfgfMCZzVrLusQgc7sdBhcN/QFO3UCSaGkfsfxLz1aH1j5eYsf02uzOrgslp5+kAtvQAehQIrBkHikZdmLfPTFHdiCjUOR46qejjclDlDAMPPMBKVTb9qaU4I9Vt/P+UZInpGHkH/y8RQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by PAXPR04MB8605.eurprd04.prod.outlook.com (2603:10a6:102:218::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:55:51 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 08:55:51 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guenter Roeck <linux@roeck-us.net>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] sparc32: SMP fixes, futexes on SMP, and a cmpxchg system call
Date: Thu, 15 Oct 2026 10:55:41 +0200
Message-ID: <20261015085545.3246951-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|PAXPR04MB8605:EE_
X-MS-Office365-Filtering-Correlation-Id: efee1457-0b3e-4466-c395-08df2a9a1d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/asbjvTbBaaCzz/VLL4SUdM/twnBLQoqqx2viSJMgNjh+WuUibUxGgYQB53/cE6PtStZGhq6UYjejcR/vYP9/wU4AIkVe0rC7aQaSuaWeGIKye8svFLMlR1OWSv3qnwGeNCcFGSBX9Z3smLtFW7oCH6IZHiCpiJQhhstc6q1KcnAnQpbpRNr7udDXpfe98RzBnLWyztE/OyPbKsOHIfYkfKUnFNqoDawvyONs61aHL0qLrhpLttsm8l6XllyXznT1k8zYE7fMAUhZpxPywRzKLV0CEGOMv97lNmbM7N+lTh+JhGNfCm5Ix5D93s63QO6Jinil7UEB53WVCyRFKdP8byHZuwTFzf12L/H5G9m660vnJSY6tqxeHHQirrbiPqShivM6XxtTVL5tgUzmo6576he5d+TQglNqTyrvKH7oGW6KwWyzwR/Ls/jdsIErW84o0Axo06H7e5ceCK5JepqiglQo+86s4giLMc3P8k7X2k5QamH4hYUGlr4x2P4CXTYb5sZG5QA68MiSgyWOuZqV8PZF01+uY7/IC+oQRT+LKLRS1x5iWUMHFXm3ptGIImp/NNSjZKeGErvCexPplzLtJOKSb3CFIwVS+Net3OlAxhLWpe7KE4voQhCsDCLUCcrz8cSbnsYleThwvF2zP83IYL4Kmhgt2MFOOjIRpGsB1A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TV/1EaLyCXQ+THdg1GvuBbM/tiNCnYoRPKjURE6MHZhMQqlso2Hs3yojcCFw?=
 =?us-ascii?Q?QBLyLCF9JPJ+E5c3vFHwdrYT7MIHC3BPTohANjBtPTDgyeD22y6CPRoad+cv?=
 =?us-ascii?Q?cjY0Bnn0DjpXJUtNlS6tzAiawFDh8yzWlUCu0Z28BUbB2+ZuSNTzQ6R3Ssf0?=
 =?us-ascii?Q?2r8nEG4eDhjyrjME0SQmdowkOVkXwWbwaq3DHrZEiDw+f8fM7Ricq9zNo/D7?=
 =?us-ascii?Q?EAZiOGvBQsXopj+dq83d5A8/WmBKQOYd7vg2oTGBLfUv4RUI+NnIzLu1Gn5T?=
 =?us-ascii?Q?AiWt1Q38+OJL1lIrQPTZ2wczDhYbRr4SXtRYsRbpiUFbXGi+SpwiD0dKUj1k?=
 =?us-ascii?Q?JeCkrUD6+4/p9e2bx3D53+IIEQ12wal8dBXRil6tQe7QhceX4eLXWZ0unuJJ?=
 =?us-ascii?Q?lIaNebIcuxd1guVUxw8ad0AWPvH3yD7OoMqBExjjXXddP0KY8nkc9YUkAyvg?=
 =?us-ascii?Q?8euta4aoTVyrvWVGFZSz9Z4dbr+aq+/SohZGolXnfWCrvE8qaQWsCb+QqgWN?=
 =?us-ascii?Q?jdjP3ev4mI+pITN5eMhkdrmfgc2bTmaQhqngvQFw60muAy3wvL29PjkLuLzs?=
 =?us-ascii?Q?8I+fNcwFLGai2r5+4TwTCT7kZ1vDxl14l+PQN8F0329PmaBsbb8l3aYsiiuy?=
 =?us-ascii?Q?U1PqSCNmkdYECEYiQjKmZwLV+IZjq4s47WlehSs1RHDgrb/bGZPPvie7Gwr4?=
 =?us-ascii?Q?hQ5Gy4H67+TwHawKa5eec+pfOaxccIRWRwQKt44KzBtKt4OHwHPWuHK6LGQu?=
 =?us-ascii?Q?bwtSLWjS7HPV2S0yB7yVBgyxJN/PJ6f36pT6MYP3av4TeshTZYT5aEmO3tI0?=
 =?us-ascii?Q?gM6IjQqga+FrPdsLGWTLZOHknSEDx6jEKKapl1ypQXgjR6qg9x5yoPdeSFZu?=
 =?us-ascii?Q?2aicyk0Nvb3OAnkJUm7e9bMOqtM/9abt5ezng8Nl/T314LyNzHhXFttO+mos?=
 =?us-ascii?Q?rIbzip+LXKm3AyuBwB/rl+Dzao5dGFyoBPuB8epmvx6oe41cgm9wwhQp2LkU?=
 =?us-ascii?Q?EeB08gEsA0OMejRrryR0hOtnL1ueIzabX5s8YibD7tOUCd636sA/Gk4k4iqL?=
 =?us-ascii?Q?ELb7VA/SCuh3vN6XRfO2DZTFvhVhWXsRp03OXwXwmCV/U0mFeaifbSdVOBd1?=
 =?us-ascii?Q?btYWSxn+66MX3D12ph1DsycnPg1SIXhqVNPADEgOhrinNcKDj648XfFzN/K9?=
 =?us-ascii?Q?prZwTJykX8DOc50EXeA1KrCrT7wF1ArVqxe4qwrTZkHMPZ4pVVILPZcTAFSg?=
 =?us-ascii?Q?NPrWAXqvlvueUMP1ud4SPK2K5Z5uhIbP6BbLsE+JP1MQm3ClWYlWvwy/k979?=
 =?us-ascii?Q?EyT1GxhVVmJfujkyqAUmUgvnoZzLMdHmgWExQlgZETEdvJmMoqVroGXX3YIB?=
 =?us-ascii?Q?x0flmIcqLEoFwV6S7nCEiqSlH1xk6zQ/bly3qCFsY2miaS6CSLpyHjUsbv0U?=
 =?us-ascii?Q?ljfsdjsjB0dYqw31oKscComEFvWme16wCvAGIRfUS47k9RVaD/y58gxP1XqC?=
 =?us-ascii?Q?AY/A5v2pFzgk5K3D2XzlsZOWPM8IGUKyZ8vk/2ybtixknnpGGxhThSCCVn9D?=
 =?us-ascii?Q?FCSa7TC8Onh5BwfFl7H5jh35Hjcxt0CbVdaihDhnI3yHQgiXuyTYu+OEaUZJ?=
 =?us-ascii?Q?ImPDzzxF7xnWbwr0Gf9GRxHUCPOwhmC89Hs7TrbLBeGvfySH0yyGfmWT6Cdz?=
 =?us-ascii?Q?4szqIIujuGDT7AnKBxTAL+uFRpcqP5F9BACwEy0zIOosho4v1sP6+3cXx4h1?=
 =?us-ascii?Q?giaAG0jG84oQgAjFd3DwckMSh7MO39c=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: efee1457-0b3e-4466-c395-08df2a9a1d1e
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:55:51.2763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L47JIDeHlHWrL0DSPucY/jvCPB+wCpB366pPI23XYYiKcOLdxRrPau/IwOtwJynferd1IKzeTNhkK5AstlX25pz3WO4MD7KJzUWGeQdQ7UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8605

This series makes NPTL usable on sparc32 SMP kernels. It started with
the uClibc-ng test suite on qemu's SS-20 with -smp 4: the kernel went to
error state under console load, sometimes hung at boot, and had no
futexes at all.

Patches 1 and 2 are fixes and do not depend on the rest:

  1. The per-cpu timer interrupts on sun4m/sun4d and the LEON IPI leave
     their handler with traps enabled at the PIL of the interrupted
     code while the trap frame is still on the stack, so interrupts can
     nest without bound until the CPU goes to error state. The generic
     path was fixed in 2.1.129; these three exits never got the change.

  2. A secondary CPU gets 10000 rounds of udelay(200) to call in. Under
     qemu the delay loop calibration depends on host load, the wait can
     shrink to a few milliseconds, and a CPU that calls in late blocks
     RCU and hangs the boot. Wait by jiffies instead.

Both are marked for stable but have no Fixes: tag. The sun4m and sun4d
code they change is already in 2.6.12-rc2, the start of the git history;
the LEON variants were copied from it in 2011.

Patches 3 and 4 add what user space needs on SMP:

  3. Futex atomics for sparc32, so FUTEX no longer depends on !SMP.
     casa is probed at boot (LEON); without it the word is updated
     under the hashed spinlock the kernel already uses for its atomics.

  4. sparc_atomic_cmpxchg_32, a compare-and-exchange system call for
     user space built for v8, which has no CAS of its own. The ldstub
     emulation C libraries use instead is not async-signal-safe and is
     invisible to the futex code. It takes the same path as the futex
     atomics, like atomic_cmpxchg_32 does on m68k. The uClibc-ng side
     that uses it is ready and waits for this.

Tested on next-20261014 under qemu 11.1.0: the uClibc-ng suite on SS-20
with -smp 4 and UP and on leon3_generic with -smp 4, plus a test
program for the system call; the details are in each patch. sun4d was
only built, qemu has no sun4d machine.

Testing under qemu
------------------

Three qemu problems get in the way of reproducing this, none of them
caused by the series:

- leon3_generic does not boot an image passed with -kernel since qemu
  9.0: the synthetic bootloader no longer sets %sp (92688a91c358 took
  it out of the reset handler). Gaisler's own prebuilt images fail the
  same way.

- leon3_generic does not bring up a second CPU under Linux. The IRQMP
  model never sets the broadcast-available bit, and Linux stops with a
  BUG in leon_smp.c; with that bit set, the secondary CPU dies on the
  swapa with ASI 0x01 (forced cache miss) in leon_cpu_pre_online(),
  which qemu does not decode.

- On sun4m, qemu's ESCC drives only the interrupt line of the channel
  it was called for; the board ORs both lines, and a stale line keeps
  level 12 asserted. Boots then hang at random with an RCU stall about
  20 seconds in (4 of 40 boots with -smp 4 here). That looks like a
  problem with this series but is not.

The LEON SMP results were taken with these fixed in qemu; the fixes are
going to be reported to qemu.

These patches were developed with the help of Claude (Anthropic), as
the Assisted-by tags say. I have reviewed them and tested them as
described.

Ramin Moussavi (4):
  sparc32: keep PIL raised until the IRQ frame is gone
  sparc32: wait for secondary CPUs by time, not by loop count
  sparc32: implement futex atomics, with casa detected at run time
  sparc32: add the sparc_atomic_cmpxchg_32 system call

 arch/sparc/include/asm/cmpxchg_32.h    |  4 ++
 arch/sparc/include/asm/futex_32.h      | 72 +++++++++++++++++++++++++-
 arch/sparc/kernel/entry.S              |  9 ++--
 arch/sparc/kernel/leon_smp.c           |  8 ++-
 arch/sparc/kernel/sun4d_smp.c          |  8 ++-
 arch/sparc/kernel/sun4m_smp.c          |  8 ++-
 arch/sparc/kernel/sys_sparc_32.c       | 35 +++++++++++++
 arch/sparc/kernel/syscalls/syscall.tbl |  1 +
 arch/sparc/kernel/systbls.h            |  1 +
 arch/sparc/kernel/traps_32.c           | 13 ++++-
 arch/sparc/lib/Makefile                |  3 +-
 arch/sparc/lib/atomic32.c              | 53 +++++++++++++++++++
 arch/sparc/lib/casa_32.S               | 30 +++++++++++
 init/Kconfig                           |  1 -
 14 files changed, 224 insertions(+), 22 deletions(-)
 create mode 100644 arch/sparc/lib/casa_32.S


base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
-- 
2.53.0

