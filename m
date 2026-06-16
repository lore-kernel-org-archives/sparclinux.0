Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021097.outbound.protection.outlook.com [52.101.76.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2F51946DA;
	Tue, 16 Jun 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619524; cv=fail; b=mjfNmoOlHDAAtMvBARDMH+ZjyoWbBhbesqshxHuSeNemyQQwHyfmDsPY9u7mJyjNRVALWLiSgODQlzMzaJ1JPFS0PdpuDY1cAArtSDBGoUC3XBn8FbuUhLKCL4xoR7nrxpt610f6ZIud00Ptlz6t6sxIdGQONOWFxErt7+YWzNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619524; c=relaxed/simple;
	bh=KjvNEVf9Z5BXddugvv0Fsq+zxk3WI6MiPy0neDiX4Sw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0LDQQF9zlVJHJKMNCGIpfOX4hOY394SJYya0ZMoQzqZ1ff8gx0Lywdlgpil2PiY+bvQsgonbrHKXbZGrojzK8jXJuPoO9sEYKT8CeK7N6TEdlklNFzJQyBkOddRKpd0PYTlJ0bC2yfeMDqI64LNaVdBMGUdVunMpMHa+oat6ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=GcaXWsMp; arc=fail smtp.client-ip=52.101.76.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="GcaXWsMp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwhWlre+94HRjkwe67U31HPtEGimP4MOHdgj7Oj9RXS7iLXySn37eUDzorQ4MSbpwRBFvu0QA8uHaZGk0IknDECywXOlZHH66khIOqnLZlF3Ld/MNQGXNqEn3Y4DW15ys1BpeGjFOXa9wh+aYdNvHKlJtxsxERGjkFIncZZRSmUyd3flJSVx2sIYXMtB7h9j8sGVfEfY+azyEvX85TD+bF4TIU7J8Y1A+9BS6wagsZFlODzlImM1tSZJTvzkUw4w+RhqYzIAfq38+dFnh4xgzlzDikzwGiJWFLejQ2LtdXneve5YQPf5PETGP3mHWHqVZ/nvrIN/Vmx5FU04OP3IeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=461xVZcqRhC28Rb5EpMtSH1D0RrjjoNwuoVTlBFJTtY=;
 b=o84IuTTIWQJCOrwVxvQFPFslGG1ZHeOK2B4NUrccM6+wIndrPSJ5aVao2jSIkaaAEHZcnAiROtVskYys8hJJ0Pftvm8TDSX7z6BRvfh02aChecmLrJRYZUwfS9TPXlRLpFwTBxlYWWj40UCGl8WmLBbSb5wwcSIvSxuPkkHZqPknOeJlC84A7VcdxbmXlNRJPf0J1Mq6sCPo2qt8pGi2ba1y6B3Ohmeh72Wupgg6l1Sq6mzFlzR0SV2ZvoffFV9hPablaevT1MZT/X+Mj37gbaF1kMuE21U2xL7lgJkQ3S51K9YD0e5nSf3EIv3cIri2t9pnkbwzeSsNauZPD+YuhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=461xVZcqRhC28Rb5EpMtSH1D0RrjjoNwuoVTlBFJTtY=;
 b=GcaXWsMp18Ee2i17zR+7ssfrFWKDK5a/O6aPiGjVrY2bq7VzurO/pu8OJ2od4qsvQ/RJI8QbeAG92rCepWSs5RR6vMEnlGSIFmPgHfiB7fJTRJ+mCfE28QYHkkOZIuQfkeHcunIlNZpkJU6gToPxJiBxm0OflfWbYAM7x8uUUm7w4AMuzoa7amMoWgxztS620WkPA2GySDkPt7+0DYCameeoL812ITn9/1A2Dmdzc44oezo09FHGKjTQQ0yFRYqA4V4d5QNqDCJhN+2pIsKkc6h8c1YUv7QcMWpussIQBAj2nHYqPCkTV3pLSR/S150siI9a8AhichUDwXts8ONZhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVYP280MB1132.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:19b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 14:18:34 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 14:18:34 +0000
Message-ID: <03111ac5-0055-425f-a7f2-54d4f2bb4988@gaisler.com>
Date: Tue, 16 Jun 2026 16:18:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
To: Tony Rodriguez <unixpro1970@gmail.com>, davem@davemloft.net,
 sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andreas@gaisler.com, thuth@redhat.com,
 regressions@lists.linux.dev, glaubitz@physik.fu-berlin.de,
 David Laight <david.laight.linux@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
 <20260519075809.8993-2-unixpro1970@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas.larsson@gaisler.com>
In-Reply-To: <20260519075809.8993-2-unixpro1970@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0005F688.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::3a4) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVYP280MB1132:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ba88f8a-e283-4376-38b5-08decbb2264a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	QyUnLBHG4N7Rg25aBAi0gp17nuJTTtwJkWEdOVqBOKkOXypreMKF6vwhHD/wuT2B7GBG4vBv1nQiJ9Qf77QB4a/IRVCwAAwL5fpl1ovvHrKe9DzW7KhM6RfRmX61UOvVq+kmKX+UMxE9Zgs9vktbTAZons8ZpLN4tpp3tNxtqoImxqzB4p4XzZIgyZGtE/eEwApOHb4QBCQR1FziR7cVKfYghTASJf3WE2SMJM4ofmNP1AuNRxMh9avPUXet5E6dPOXB2ZT1UCpBnluzJ0d9gtAhCdksKjgdX/M25cSU2/He7GGF7btdeIE7APGyuSVZHsavbz/kzqPm/pTD9NKepBtNBXZuw8PsXdcw1/QLZ9jJih7qX3Fdv+nnwtuuECCslqARULRdnM9LcmXfR52xaujZIelloZ0UDI/nbw0OoQwWrhDLjzxBGxHMOGL74j5DyUqWt/3PUpL2e3k+2xxmUMnS9aJdEJ6LMfksi+JEiQikrb//9HG529Ly/abk8e50goh4wn3K0jdOkEfA/Mc5zDVGfoPOkMD/eWVuHokcGS9c3yDilQCsTlS2kEiqHp5a4+WRMuqCW/RzSKFF8qpZ+lUl/sgfRIsQ0ySfoQ9VxbFc3KrPklT8rmMzbY9omW4UFl9iASz2MLxFS7nnW1rVERbqKy5qnKEPq+e1mUfKxoL1fGJ2dv+BZ8Twp67UEWG1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amVtMnpBWG9nMzBnYUJXZmdDZ3pBbE9ZQVI0S2pOdmovVU50VnRvWVFVOWRK?=
 =?utf-8?B?NzQxU0Z4TXdMNmNPKzJ6eWRZZXBtaXlVZmFCbVJ6a3I5Ynd2a3BlbHRDQnFZ?=
 =?utf-8?B?VTJIMUlSYlhiT2VVTTVnOE9ZcWRRNDNyR0YyODRDNkVNVExYdXcyUll6WUs2?=
 =?utf-8?B?d3Y5TU1KUGNxOE9Jd2x6U05xMWxJM0cwYTR1SXpoSzJ0cDNRcitHTFF2MnZW?=
 =?utf-8?B?dEZrekJOaytYV2REcUVDM3lrTXVHNUFtNUhVOTVSK0F5MjkySXIrNlMzWmI0?=
 =?utf-8?B?cWsxMTlRaGh2OUQ1Tk9kb216aGtUV1JyRlN6cW1sRE5LMmROOWxYTURsWmgr?=
 =?utf-8?B?UkR3NDFCMUYzZzhnaVYxd0h6ZFh3UVM3S2Z5OS90RHJRMjg5aDJaWWFVeTZ3?=
 =?utf-8?B?ZDIvaXRJU3dvZkorMzBJbXpLOWtvaGVjaTZOaDZoQjBVamdjNUhrQ1ZNcnNo?=
 =?utf-8?B?SUhzU0FHQU9MVGovUkd0MXBXMElDMHRiNEpMQWRJNUtERW9RNjNGVU02QzFh?=
 =?utf-8?B?RUxtNjFFL1QvczVhRTgxZXVsQVlBM2F2YThaNUthVzhhRm9KdnRrakFjbkYz?=
 =?utf-8?B?MnIyV2hEcC9WSCtwNytyc29UaUovemtXYm9TbkNQbWJTSElWamhpdDBQNUpG?=
 =?utf-8?B?TUsvWHlCVjltSmJoeVFjYVhibVZiZGVEbHMyaHBYWWxFRXRpK3hhcTJsVjVP?=
 =?utf-8?B?bk5MZ3JuRnZCNWpHYUpZQ0hsMTk2TEFIeXJaUUxLeGhNb3dvZTlPUmtGbmdT?=
 =?utf-8?B?ckJhRkJwenpTcFUwMWJmZFR0bnk0RUNNTzliMzU1d05xcDE1MC9GMGlDd3Fi?=
 =?utf-8?B?UlhpUldIams4OFU3alFPLzYvb3d3TWlBR0R5Wm92UlJlUWtuYUc4cEw4anE3?=
 =?utf-8?B?L2xKWXZ1eEdYZzJKTlBabHI0WU14SndVWkY5T1N3SVo5RnlNeDRvd1R1bEMx?=
 =?utf-8?B?RWtLNlBXeUQwaEJ2ZW1YdzlKTmZZMGw1NEcxUHNhMFY3OVJLak90eDZhZnRr?=
 =?utf-8?B?N0xTTDhxZFB4VVA1MXBKc3B5b0xvZEdISWx0YzZ2WTRZYzZueFk3bmRUQ3Jj?=
 =?utf-8?B?ZHRTQ2RKYk1Ua0ZrUEJyK3QrSDJpMjZ6Lzd0TTJWN2V6YS9ObUZPaTdGNzBv?=
 =?utf-8?B?YWFYU2dVZExiYnV3aUpvNWZsUFV0WjR4aDlSL3FPV1JlUXZGTm1zY2xLcUx1?=
 =?utf-8?B?cFBFWW5LVjU4MDIwMjFWZVJXcGNGUnk1U3VhckxzNnZkeE54NmlLN3J3L3NX?=
 =?utf-8?B?Q2FXVjI1dDlFZ2hNZlFDVm81d09WdGs1UHlvZFc2S29nYlE3VW81Z204cXhk?=
 =?utf-8?B?UHlVMjVuSGpjZUZGRGR6UzRJSVV4dmo4Mk5RT2JqMDB0bHRBeGwxaEMyRDVk?=
 =?utf-8?B?NnZxejdMNnNyNHNjTHBYeW9wdGZXY0UyMTJ4QXFKN3hMSlM4QTRiRGhDZ2JV?=
 =?utf-8?B?VGxKZ0NsM1VEZzI0a1FoNkJmMC9MQkZxbk90WmNwSUdZUUh5RjdETXBEMjFr?=
 =?utf-8?B?M0E1Sk1Bb254UVViMncxU3VZWDQvWjRkNzg3SXMvS3hBZEZNNi9OSm82Skl1?=
 =?utf-8?B?ZEFRb1pMUWVhSmRBL3VPUkFaYnM2K0Rxb0grV0txRTNpWlhKdEh3NlMzZ1A3?=
 =?utf-8?B?MmtOZFQwUFk3UGp5SGtGbTUyb0FGQnRWcjhmZ01tNmZOVzNqMnFVc3pOT1dn?=
 =?utf-8?B?WVdBdEFpbGo0ZmNzN21tVVpidVQyOExiN3c4U1JhVDFGVDc5cUZQTXIrSzA4?=
 =?utf-8?B?QjU5blFNVWJidmY4d1MwZWxtaTBONzVkSC82NEJ5S1NsN1I1aVo2c1YrQTFH?=
 =?utf-8?B?Sk9LUHR1NzN2N21nNTE0ZnhuU0JlSFNLVEpPRjZvcmxPbHhpRjRMb2hNcHBO?=
 =?utf-8?B?VUJmdjNNM1ZmekdXbFdZaHQyNGlrMmpaNStMSTNUWThjUHo4dFdTUlU1VEtG?=
 =?utf-8?B?TjFqOVhCZ3cxVGlxVEt1SndQS3ZFS21CQU50WVBtY2kwVkFsZUNlaXp0citE?=
 =?utf-8?B?bmRsenpvdDZFNHNMOG1jTkNTMDZSb2Ziby9XZ2oycEFIQURlZ05QUGpxTThJ?=
 =?utf-8?B?Ry8xMk9TVTFjSCttMzI3UzRuQ2xDNUc2TC9Vckk0bUZyL2lDYUtaVmZkVG1I?=
 =?utf-8?B?YlplN01DbmxQRWppdGo5WXdQRERXazRNZFk1ZEdwS3pES0VwcXlvSlBMQ0J4?=
 =?utf-8?B?Vk5DcDVYZzZpQUQ4dFN4WG9naWVmbkw4K1hxdVJlbVRST1EzOEVoaEUxLzg0?=
 =?utf-8?B?MHZOWW5EbFRjOGl2REViZU0wWW9DTFVCQlJkeUNuQlFlbEk2ZEZrcHdYbFhv?=
 =?utf-8?B?RWVvYXM2T2VBRUswRGFzV2ZTRk0vd3dVMmJLdUdDTytYTXNaRStjalVhYSt5?=
 =?utf-8?Q?LQXyzzs7Ne/K1oLg=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ba88f8a-e283-4376-38b5-08decbb2264a
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 14:18:34.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mEz0nX9ddHqderuO7ycAn6ap0NpmwA7kNqwTwOYe71yF6KYDkbuK2jurh63uFpXyVhxczM8bu5zbG/KYSATaKTMPKeA1memXlpMlqloztxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1132

On 2026-05-19 09:57, Tony Rodriguez wrote:
> This patch restructures the thread‑stack sizing logic into a single
> if / elif / else chain and introduces an explicit 32KB kernel stack
> for SPARC64. The previous implementation relied on nested conditionals
> and PAGE_SHIFT‑dependent behavior, which produced 8KB or 16KB stacks
> depending on configuration. SPARC64 requires a larger,
> architecture‑specific stack due to its trapframe size, register‑window
> behavior, and deeper call paths.
> 
> A reproducible failure case occurs when usbcore is enabled: USB hub
> enumeration (usb_new_device(), hub_port_connect(), PM/QoS helpers)
> allocates large on‑stack structures and recurses through several
> layers of device‑model code. Combined with SPARC64’s trapframe and
> register‑window overhead, this reliably exhausts a 16KB stack and
> results in early‑boot panics.  A 32KB stack eliminates these failures.
> 
> The new logic is:
>     SPARC64:
>         THREAD_SIZE = 4 * PAGE_SIZE (32KB)
>         THREAD_SHIFT = PAGE_SHIFT + 2 (log₂(32KB))
>         THREAD_SIZE_ORDER = 2 (4 contiguous pages)

Yes

>     Non‑SPARC64 with PAGE_SHIFT == 13:
>         Retains the existing 16KB stack behavior
>     Fallback:
>         Retains the existing 8KB stack behavior

No, not to my understanding, see comments below.

> 
> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
> ---
>  arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
> index c8a73dff27f8..6b12a2b66385 100644
> --- a/arch/sparc/include/asm/thread_info_64.h
> +++ b/arch/sparc/include/asm/thread_info_64.h
> @@ -99,13 +99,20 @@ struct thread_info {
>  #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
>  #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
> 
> -#if PAGE_SHIFT == 13
> -#define THREAD_SIZE (2*PAGE_SIZE)
> -#define THREAD_SHIFT (PAGE_SHIFT + 1)
> -#else /* PAGE_SHIFT == 13 */
> -#define THREAD_SIZE PAGE_SIZE
> -#define THREAD_SHIFT PAGE_SHIFT
> -#endif /* PAGE_SHIFT == 13 */
> +/* thread information allocation */
> +#ifdef CONFIG_SPARC64
> +	#define THREAD_SIZE (4 * PAGE_SIZE)
> +	#define THREAD_SHIFT (PAGE_SHIFT + 2)
> +	#define THREAD_SIZE_ORDER 2

As far as I can see, given that this header is included by

#if defined(__sparc__) && defined(__arch64__)
#include <asm/thread_info_64.h>
#else
#include <asm/thread_info_32.h>
#endif

the code above is the only code that will ever be compiled, while leaving...

> +#elif PAGE_SHIFT == 13
> +	#define THREAD_SIZE (2 * PAGE_SIZE)
> +	#define THREAD_SHIFT (PAGE_SHIFT + 1)
> +	#define THREAD_SIZE_ORDER 1
> +#else
> +	#define THREAD_SIZE PAGE_SIZE
> +	#define THREAD_SHIFT PAGE_SHIFT
> +	#define THREAD_SIZE_ORDER 0
> +#endif

...this code dead, where the else branch code already was dead (but then
in two separate else braches).

I'd rather see the else branch here and the else branch below cleaned up
by a separate patch with a fixup tag for commit 15b9350a177b ("sparc64:
Only support 4MB huge pages and 8KB base pages.") that as far as I can
see should have removed the else branch. The else branches was to use
only one page when the page size was _larger_ than 8 KiB when that was
an option.

> 
>  /*
>   * macros/functions for gaining access to the thread information structure
> @@ -127,13 +134,6 @@ register struct thread_info *current_thread_info_reg asm("g6");
>  extern struct thread_info *current_thread_info(void);
>  #endif
> 
> -/* thread information allocation */
> -#if PAGE_SHIFT == 13
> -#define THREAD_SIZE_ORDER	1
> -#else /* PAGE_SHIFT == 13 */
> -#define THREAD_SIZE_ORDER	0
> -#endif /* PAGE_SHIFT == 13 */
> -
>  #define __thread_flag_byte_ptr(ti)	\
>  	((unsigned char *)(&((ti)->flags)))
>  #define __cur_thread_flag_byte_ptr	__thread_flag_byte_ptr(current_thread_info())
> --
> 2.53.0
> 

Apart from the above I agree with David Laight that more investigation
of the situation that leads to this problem would be good. Granted,
sparc and sparc64 in particular is a bit special with its stack frames,
but among other arches it seems to be uncommon with 32 KiB of thread
stack unless KASAN is enabled.

Cheers,
Andreas

