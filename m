Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022114.outbound.protection.outlook.com [52.101.77.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0458B22157B;
	Wed,  7 Oct 2026 05:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352628; cv=fail; b=rVlovrXUQr436cHS4kWrZy4dQ9/ppkSyAQyiAuSbyLg7Jkaf46Qr4EORDmVLv8yByQTbOM1xDxu7aV6hy93DIaNRCOWKlFNLchHnD+xcFzWDFMXmP5oeSE65pD6PiuQnliQcW407ZsKfJ+ylzZCxehhK7qq6iWsCsIPC5WwnuZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352628; c=relaxed/simple;
	bh=R7ukRC4N2TIU3wPeT6dOPWNnfH3XvbJvH6SdIc71igw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q8iU0DnKSdHcj49mPkVShLtX5LjehAD4m4qXeh6b9trGl4v26jx2SCY/75tgL/PzmR7yGqjbLq3ytfggo3gBv9cgouvZ/qAeK8f5MMLLkOh9aDOgX1Kx8TWUK18RcjsLueilE/0hq1p3RxmNJAGYjB5URySJutWQaab0lEAAnzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=DgLC+6VC; arc=fail smtp.client-ip=52.101.77.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="DgLC+6VC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEvRo1u+e8uyaWrY2UF/thYyB0vJW4WA2SlGyFiOLR/Q8QFpXyVTwQcxWLQ4GoGv9wSN+bgVRgnbC7fVmIMjsBdCdH1WZJ0pEZfCvHVK80J1tPTWkIwc0Je3XQ6GW8fxeN2MVA3qEaNtqQ3sVY7fVNRH1gaMhWNqbTQha1vFK32/ReYk4K9ewlvdp8xKmh82GYvUw1pE2IY26YGFjve/Cdj4avP1Q2RzK+LAPiZubAhBSNp1HZ0H2iBAjtnvU0kLwtkwbJs9PhnUm/MQUNjWRLFgRPqrHvTI80BUw/LsDoMawEclhslMSZ2lj4fg/S7jBQE2cX7Oqm1mTe5ssAMs9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gncYjaI/qFSw8MTeEHHeK2eW3Kh8lZZeaA+SysWEut8=;
 b=Yj28fZYrJ3czHKz432lkqHSQJwK2j0ASuCO5khBZhSvcPqMtnquCgBFDUFV8+REkR+8/SKOo6e3aVV3qZvKuD7Jfur3xWWMNp9wSPl4aODLmGmw1c4iiGaCUY+n8xBwkXT1LdE2wT6CC/5y7Rmq2zcBYi6GCrD/tH3mZhsG2P9mHIL04+OG4QeZoQqqmQPmbxBz3MrntxybFh7rWxZiCY71M93qOX6rH/CXCdawpWLpL5kT5DdKuSFhA/R8b82O5OpiQXaUORiSM90YMgrilASLe1DuE/rtfTFWoYcUFQ+lqD/C6YGOXKIxD/ZONfnp1PYWc/+htwgrPRr+ODnrVfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gncYjaI/qFSw8MTeEHHeK2eW3Kh8lZZeaA+SysWEut8=;
 b=DgLC+6VCq5mR1BJOgtcrArqC4nOHuGO59ELfLTw5cx0KO+asxdDiOXaF+5L5qxQLsg9++IlM4n2B9+fPSuOupJzYlJZ1HsEQZJJv3p2j+55eXNhDSU4lRYq7zd6GKR8u4wTOxl6RQUTJcZy1juB/z61RrIWJUaIzDToWsTKsfwiTr9CVSg0MPRR7dIzE6cFC/JiQeD4W547zbwVCdFpBp1KOloKz341K8wTzN6dFesm7WsMYG2CHLe70oON1rBPMAVpnmtnVhi52t4/sBP3bczqDRwMDDV6kz+5QeQnkooCH2NamUXQGrbnToJf1CJkmXo2BDZ5iRAsjbD+D9Hz3ig==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB2223.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:34d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 05:57:00 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 05:57:00 +0000
Message-ID: <8f605908-3315-4e05-b30a-5f298f93635e@gaisler.com>
Date: Wed, 7 Oct 2026 07:56:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc64: Fix comparator problem with timer interrupts
To: Stian Halseth <stian@itx.no>, tglx@kernel.org, davem@davemloft.net,
 sparclinux@vger.kernel.org
Cc: Tony Rodriguez <unixpro1970@gmail.com>, linux-kernel@vger.kernel.org,
 thomas.weissschuh@linutronix.de, regressions@lists.linux.dev,
 glaubitz@physik.fu-berlin.de, linux@leemhuis.info,
 torvalds@linux-foundation.org
References: <20260519022421.5978-1-unixpro1970@gmail.com>
 <20260831180728.3097740-1-stian@itx.no>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260831180728.3097740-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0001A334.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::699) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB2223:EE_
X-MS-Office365-Filtering-Correlation-Id: c2552528-8fc1-4191-0f09-08df2437cdb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uKPVBsYLJVktFpS0wPdMCg/KbKgINs9vOBWCVuBOqmQchokgPc8O3u/3GWBS8B2QIAlKD9R7+zgeKRJXoU0+36FJYdXyduq0PEZqNg4hWaQu0oVNOwTposTm6EJdDbG5dIGWpxUs7XiHm8gdzSF/2YULOmUNWCKJnsE93eIYpIq33fIQYPYC/hx1CVOW+fB0mHTgpzhClNT4Dfgy0KieLtiT15C/SbLDj8znThvo4f3E296j97j+B0+XicATujrRc8bwqGlAHbfVGTQ19qJbhHJrfEOUnXN90isil2doQlawHshb4vC1YXV9F8jWzU2OyCmDJTW3q1fIlp1UcrPzxtSUV80E21JJjqi5R819cHOJkdj5TiNaSECNsxqMXsljtiv1XAeRHWENsrjbFll4hNVkeqaCH13xOj57QSk8DuGQu0G+Ryjy33CMHnZZeSvq2ExlKSShkQ4ubg7LHvPJO+gJiH4M4sGQOZki2DsEjOSKHNQbScfYk7K+OqTE/MwNke9ljEea0MildpWmezgLibzoCUvEqGvbRLJS1FNqTAj01C4xPJE6uwMEDU36dH8pEV+Ho2C+0l7RdXLrERulc+DZGUDqP/C9wPhwEsZk16LZuGoylU1KuxiaTy/Ge4A9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFBrNXJidmJJRDVueHM4cmJiS3JKMFhHUGYrOEVJTS9xQ1lXdlptSUFBK3ky?=
 =?utf-8?B?NWlldDEwMWllOTRaTUY0N2NrYmltalhsbllsTzdnb1VnaWphaWN2amZONitV?=
 =?utf-8?B?VTRtYldsRFVsOThSaVJXeGhXWi9LaXVENTh0cmlxQ2d4N0dIRkFEbFJhVzgz?=
 =?utf-8?B?dzJtbjhDaThSclVOeStHRFZYbndFL1JLOXdTQzRBaWxkZnRqRncvSWJ0TTFk?=
 =?utf-8?B?Rmg5N3lJNlYrVi82eHpPQjZ4RWtzNmFRa1RRTStkaVdKL3lwZm5ka1hUOG5N?=
 =?utf-8?B?RUtYMG9RYXNBZFFmK1R3cE1PRjJ3M0dKUlloZ0gwWTdxTXZWTFhjQ0RoTGw1?=
 =?utf-8?B?MkVMMUVPNUEwbHZKNmVSb2M0SVZmVGlLNHkwMDRUdFFuSHBab3l5YTNCRFov?=
 =?utf-8?B?bEdHNHVHOXVCTDZYZVNDRTFhMXBtRHd3QWV1STFHekpxZlpsVUJ2dnFDejJv?=
 =?utf-8?B?dEh4UGxlWlBTTHMrV29PZ2xnY3RkSEpmaHM1MWZva2Q0VTZGV2FqYUVYcENB?=
 =?utf-8?B?YWh4L3UvM29UcWNScmtGZWp6em5XNnZMbzJ2L3dsbGNXQVJlbE5TeGxpWGdH?=
 =?utf-8?B?MkZaaE92anJIR2NydDVwYmxVTnNtdVVBQUZFTlQ2bGRGb2o0dHdtNHJkVDcy?=
 =?utf-8?B?TWdBOGozRVBRZENCSkJrc0F6L3FpWXk3dnQ0d2tGMXR2UHdYaHQ3Tm9PWVlz?=
 =?utf-8?B?MmxWRlczY2J5NmRPNlRnSGRzZkpzY0IxaFVBeVJqUlJYalV4TW84WGc4dUlC?=
 =?utf-8?B?MlM4RjhXUjRiZzlpVkVaNnNJVnkrbTRwQTd5S0RhbUFwYkZweFpCRnVMamJ6?=
 =?utf-8?B?M0FUVmlDYUkzakFlcmdoU0ZlMEVxTzhwazN4dFJBcDNDNW5PTUt4a1hFSjRX?=
 =?utf-8?B?Wk1ZYTJ4TXp4UGxwUmkrY291Kzh2aFlGQUdpTWZ5Q1I3am5VKzU0N3gxdHIz?=
 =?utf-8?B?VjhlOGs4bmxKcnJkRmRBTnVGd2dIODh0a1o0eWhMWFVXNzJrNGJaQnlyK3Zi?=
 =?utf-8?B?VVNOdlo0ZmliYmt4bERCL1g4TnlHb3BrWGt5K3hpcS84dWFMZHFHTEJaMm5X?=
 =?utf-8?B?UUQwM0dPdFQ3bzI0RUxicWdmMmV4VlBOa1lycEIyVTI2ZkZoeG1McHB3MzFZ?=
 =?utf-8?B?MW1FVWNtUWUzQm5LY3ExRzlBUDFvaThnbHUwb0tuQkdSUHVSbDFwN0E3N091?=
 =?utf-8?B?QzczZGRMZnpSR1hoN1VPaEJ1bHkrYjN4YjNTQ1FiQ1JpeGI1UTJUVXloYTlr?=
 =?utf-8?B?SmkyUnV0bDRuVFhPcmJYN2NwbEhaNXZKbDBjdzFrS1E3bEliQTJMTUlOWjNs?=
 =?utf-8?B?dTE4TkpYckNWWUFrbnY3TXNFT0JzTGp5Y2hKaytFZTZPZzc2czF1bWFxSjh1?=
 =?utf-8?B?WmxNU0RxSnRJTmhDMWpzMm1keTl3NTd3MjNqTUZONWFtaEJIMnQzR1ZxaWVk?=
 =?utf-8?B?YWJ3cUx6VmlkSnJ6S2xTLzFUY1ZGRjRKNmI2TzlqNWJKZzBxeFhQelR1Tmgy?=
 =?utf-8?B?UW8vSWVMNjRvM2pHcnk5TFZhTjFrY1k0OUo3bGtGYTJoOS9uQkRSeTNrZThq?=
 =?utf-8?B?ZUgxdHdVQUlaR2dqTldMVHovSXM2MnlRUEdlSlE2Wm05dFhtRWprclpnd3ll?=
 =?utf-8?B?cXBGemhCVDg3TUxjTXpKWDBmR2d4c3BxNEJkK0thQTZqRzVJSzhMRi9pVUNs?=
 =?utf-8?B?UVlQR21iZWx6NTBzODVYaWpoNzlRQjV0VkFEZ3IrNitGQ0dYOW9YekhOeXdz?=
 =?utf-8?B?OXBQWmNlQzVjTTJMQ3FSbGlHZzliWVd4eWdIMjQxNENvZnFQeHRhTHFJakRp?=
 =?utf-8?B?eVg1R1hSSDFSUkRBQ0JYeHNjRmc5R3NteWlaVjdRanNUOC84VU0xZ3R3M3dp?=
 =?utf-8?B?Y2pqak1IdkM4SldLZVAxOXdVRHg0b3VXdDl2RVRhOUlmWVRrMmpiQXdlZHdX?=
 =?utf-8?B?RmVFeGFFVDRtWGVrb2d1ckVkWldWcXk4MjR2NHp3UjcxNXRwWlc2S090R0xK?=
 =?utf-8?B?UVAxSVRBK2lDV1VIUHNUZnllMkE4dEduZC9sTGZBYU1ZdEcwZ0g1ZDU0bVlI?=
 =?utf-8?B?S2FDZVFPb25XWmh6WUZFbnRlclBNT0ZBR1RmMGxRNU84TXVSYmM3cDcvcysv?=
 =?utf-8?B?alJmMy9HOEFES0RwOHNKTWU4NXhGZXhnUE04VUJJQjlhbUpPNU5kNHhqZ0s2?=
 =?utf-8?B?K0hRQ0JEU2FPa1hpNWpISXJLSXc4VmdjNGg2clk1VHMrZDVUa3JWYXJLZ1kv?=
 =?utf-8?B?ZGpnKzkxaG9JSkUxOWJzbWlmVldicHBIOGdOTEk0Z3Z3Ymt4R3BINnZQanNO?=
 =?utf-8?B?a0ZOaWhyU1dXR2tHN09UNEdmWGFwYVJ0a0ZlQ0RLQ0VzSmVMZkZONmVEcGxM?=
 =?utf-8?Q?gm8gJOufUUGwmP48=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2552528-8fc1-4191-0f09-08df2437cdb4
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:57:00.3833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y61bDqNuANMZ4t+SYH1SHD6MPO3Y8G57yNBEsgGmOrNAEV8ntl0f5lf6K+cZTS/yRlDCCCpxUrKwtOWn2jNeqc55V5sm6TmGEcZCZBBliTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB2223

On 2026-08-31 20:07, Stian Halseth wrote:
> From: Tony Rodriguez <unixpro1970@gmail.com>
> 
> The tick/stick/hbtick add_compare() implementations program the
> comparator and then check whether the write took effect in time:
> 
> 	exp = read_cnt() + delta_ticks;
> 	write_cmp(exp);
> 	return (read_cnt() - exp) > 0;
> 
> A nonzero return value means the expiry time was already reached
> before the comparator write could take effect, so the interrupt may
> never fire, and the caller retries with a new expiry:
> 
> 	return tick.add_compare(delta_ticks) ? -ETIME : 0;
> 
> The check only fails the write when the counter has advanced past the
> expiry time, but not when it is equal to it. In the equal case it is
> unknown whether the comparator write took effect before or after the
> counter reached the expiry value, so the compare match - and with it
> the timer interrupt - may have been missed. add_compare() then
> reports success, the caller does not retry, and the CPU is left with
> no pending timer interrupt.
> 
> This results in stalled hrtimers and RCU stalls / hangs under load,
> observed on SPARC S7-2 and T7-1 systems:
> 
>     rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>     rcu: rcu_sched kthread timer wakeup didn't happen for 5259 jiffies!
>     rcu:     Possible timer handling issue on cpu=100 timer-softirq=15
> 
> Treat counter == expiry as failure as well, so the caller retries
> with a new expiry time. After this change S7-2 and T7-1 systems no
> longer hang.
> 
> Diagnosed-by: Thomas Gleixner <tglx@kernel.org>
> Link: https://lore.kernel.org/all/87tssb6olo.ffs@tglx/
> Link: https://lore.kernel.org/all/871pfcznw0.ffs@tglx/
> Link: https://lore.kernel.org/all/20260519022421.5978-1-unixpro1970@gmail.com/
> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
> [stian: rewrote the changelog per review of v2, retested]
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
> v3:
>  - rewrite the changelog: describe the write/readback ordering and the
>    direction of the equal-compare case per Thomas Gleixner's review
>    https://lore.kernel.org/all/878q9fxywc.ffs@tglx/
>    (the code change is identical to v2)
>  - add the Link: tags to the original debugging discussion
>  - picked up with Tony's agreement after v2 stalled
>    https://lore.kernel.org/all/10382506-3f57-4b33-8356-34f23fb5f153@gmail.com/
> 
> Tested on an UltraSPARC T4-1 (sun4v, stick variant): 9.1M hrtimer
> reprograms in 90s across 32 threads with 10-500us expiries, no
> stalls, no lost wakeups (worst oversleep 657us).
> 
>  arch/sparc/kernel/time_64.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
> --- a/arch/sparc/kernel/time_64.c
> +++ b/arch/sparc/kernel/time_64.c
> @@ -146,7 +146,7 @@
>  			     : "=r" (new_tick));
>  	new_tick &= ~TICKCMP_IRQ_BIT;
>  
> -	return ((long)(new_tick - (orig_tick+adj))) > 0L;
> +	return ((long)(new_tick - (orig_tick+adj))) >= 0L;
>  }
>  
>  static unsigned long tick_add_tick(unsigned long adj)
> @@ -277,7 +277,7 @@
>  			     : "=r" (new_tick));
>  	new_tick &= ~TICKCMP_IRQ_BIT;
>  
> -	return ((long)(new_tick - (orig_tick+adj))) > 0L;
> +	return ((long)(new_tick - (orig_tick+adj))) >= 0L;
>  }
>  
>  static unsigned long stick_get_frequency(void)
> @@ -411,7 +411,7 @@
>  
>  	val2 = __hbird_read_stick() & ~TICKCMP_IRQ_BIT;
>  
> -	return ((long)(val2 - val)) > 0L;
> +	return ((long)(val2 - val)) >= 0L;
>  }
>  
>  static unsigned long hbtick_get_frequency(void)
> --
> 2.53.0

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

