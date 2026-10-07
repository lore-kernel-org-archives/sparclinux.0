Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022128.outbound.protection.outlook.com [52.101.77.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600704A99C6;
	Wed,  7 Oct 2026 09:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364299; cv=fail; b=ZxV/XH7H/jH1HVS9y3R3MULVGh0dHI0tbHBpL1STAQowQN7lG6N6geCOXnHjXGcldhUjZe22EvXH6pcXNiNu+ovQuSLjHUVr02kwG7e8SySEpOUrcsXcqYp9pOw0v1NCdu3YYKvh+u/m0wR64D0IyOgFPCQVpZKwv9uCLz+QxDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364299; c=relaxed/simple;
	bh=oOLx6G7r2XQjT1l7zffJZu05OCmdX4H/+aoA8O5vAhM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+wgfyZxcUAJV8UAFzmSAojiB2BpliHSCk5AwcreHLBOWNw5n684tiYCNNAElkOuya+o3d+YG/yuj2c2c5xEo1R9HWRvpDDPzhRGKBJk+8FGVpfqHHgb7SOM6JaiUvfkBzzQcrUcood5m++L9H2+pCiqQ34hke4e0ZnJHT+BWzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=eOBrZA9r; arc=fail smtp.client-ip=52.101.77.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="eOBrZA9r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fk4hXr/QyLNAwO0L9s7ruce4+6Uv69vYG9uCUMQOLgo03Uk85OOSv6Yb/ecsJlUfWYvVbUJIXQtG+UmqHpDy16e54ldSv9+enSkExn24Z7S5NvHd77G5xlFiinFaehRgbJmOCUSS/2Nxz+nMUMVJDfr4Gj6++t+Udy7K9FsPDAf5/hojV2SFjDuPHLKcy6b+bULPYwi4Xvw/CW/SyUQw6kqjziwojhNKVrWk26+bNfFyJsFKmq4hH/MGoMReOiyQMXhAI0eULee4czkqQE15/Jex2mIKPGbMXSKwAYvZCLXqZEJcCoYSWTVXnZhyaCMxMMPOZ4xeU/+iZoLPAZ+hKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoKoTgxlwkJFi7CbjuD+Un8M+9clTwxxmUVyoW3lxSY=;
 b=sPJ1HznR50WnjBtw5s7dJ7TWbH7mpjd7nRdnbLneui6qEyhVkNXosO+OikZ37dESbBqUjgPFqOvdcdUNtLPNALoWwK7QPIwQcYAaSY+e7//u4Lh5sBY2lzjnQy1+22GWNNkfDJmq2LcNdmbZKRaauJq/1yeGWG7b3tjKFzH2ULfSZc76T4CmOz4OgVFyjNCm1wNesQqSLs+sBw+H1eDqvfk37ELKbnpMLPLOtQKAOtaI5zoVxn9gHX5FC0XeCUm3L8obJZMgWGrQYJIP3lEsDYbhlvSdX99d+PG5nmsRQBYmnPwqTWqiE4Ktn4Sny8W23UtVkZW0j7vCh43Fj/Y+3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoKoTgxlwkJFi7CbjuD+Un8M+9clTwxxmUVyoW3lxSY=;
 b=eOBrZA9rEN9h/l2bLQrDSOO3Shw4Yh2wcUMxsbjTC7k0Wnt3r80Zd8x5r87AJ+zWWnlg2MXDaAz2hIfM8jP9tyOrz8QbP+14FAZnXvPIKEbIrqh4w5Utx2j0R9KJa6wjf10YrnO1fcR5UqecDV3XW5Fcf8kMCFYTHFvPxQw5uGssl+NC0qtH7CU+F0wVoe/yCv6l32g+3xf28UlrxIR81xsLwbPXX6POrs5Bh1S8T2naLsCx1XC3MWNAZcBKlkqaQAQKBsUfAe8bgdmDrpPFvh3MImMObndZ2dgTXwbVwxuITyEtV2R39/WyPQXErKMSB5Ws8uu5vQP9Mz68aJuLSw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB1719.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:1e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 09:08:44 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 09:08:44 +0000
Message-ID: <051531af-e41a-4d4b-a1cf-07bf69c4037c@gaisler.com>
Date: Wed, 7 Oct 2026 11:08:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] sparc64: remove dead THREAD_SIZE branches for
 non-8K pages
To: Stian Halseth <stian@itx.no>, davem@davemloft.net,
 sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
 glaubitz@physik.fu-berlin.de, thuth@redhat.com, regressions@lists.linux.dev,
 nroach44@nroach44.id.au, kaloz@kernel.org, unixpro1970@gmail.com
References: <20260927204912.3667-1-kaloz@kernel.org>
 <20260927212913.3237082-1-stian@itx.no>
 <20260927212913.3237082-2-stian@itx.no>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260927212913.3237082-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0032.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::12) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB1719:EE_
X-MS-Office365-Filtering-Correlation-Id: a78e616b-47bb-415d-2243-08df24529646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|23010399003|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	jDajaRKBwQmG1VU7xI/muyLC0XIqbeUzELyUuYeKZzxFnHx87qCggIx73ysZVgm1PPrxMpxyO2ruvDNLyJh0eCDejXE4W/Id+jUWKmfAxHX9qet1/VsXa5fvf6CCOcynv7vwOe272K8NVuKTIDKt66lZ92rJRV+aqYTmk3zVWEvDyGhBWqLbuuMUhXXv6U5o3nrxnvuViQhuij/rZQ9Fmk5c9lDCYv0QOhbT2hX6pCKgC5YxBQrsKslQeMVNr3Cy1TBrTo+UrStRtk+RM7b426ZOZvMeucBMP24Y5N3Hn0DpmASD7qqNuiBV16MBjaWfBpt4JTs24biLHXFy5ZT+bP3p8/4D5qugFiFqiVLmQsGSn2Xs0POsseBHMz70Fm/GxIgqvhnPs2iGyuHoZescORWj9kDHHx6PYBtLAKw+q4fTsCQqE428BzCugMhfvpwRwycbjk9FZPq5Ims8MSfgJHy1jo55rtZZxciIyGojuOIB+h61aIeTSQ7x6CjppHF97N2z4kbuCffVIxTUZwKkq1Xg3kSi6uUXulh1Tvtn9J+G5FgWc13z1nlCqKSGApdIC2ZNJejv/sCUi5CEwfOpcfpyPYdmb5/3fdfAHSg2M6+QF3Q2rotyHzj2JScf60kn7L4hLQALYMxR52bFu2Tlp8qJ4YZNDAULvFM1WWKuf68=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVuVHU4TFVvbDZVTm8yM3M3bG1jeVg5L3ZLT0V1RmVPQWpMLzFmeW9LcUg1?=
 =?utf-8?B?VVdhdVdHZkM4ZzdNTGx0TWZub09XV1dUQTgyamNWWmpRTmEva25NZjk2OGVk?=
 =?utf-8?B?dCtiT1IxbTUyeWRvK1g5djVhSlJsMnByb0RnWURBZEpENXVwTFlGQ0x6QjBL?=
 =?utf-8?B?b1R0ZjhrYUpiUEdZaFVzeks5dU5zbktjYkhpa2RoaXZNKytRUEVOY2VMRTl5?=
 =?utf-8?B?WlZFQ1BGdnl1eWxXcmlJREo3UmlVYTQzQWpSd3BoUWhrM3AyQWRxUmdWS29N?=
 =?utf-8?B?amErRjFQdFJ4VTFtdmpoNnFRbG5iM3V4cXhwL3RlR3JGNXJsdXlaWE1JUHFq?=
 =?utf-8?B?UWI4a0ZrejJlYks1cjhBMjc5OWZWR0QvZEZUMzJmeFZrdjBVcFZHemhXd1A5?=
 =?utf-8?B?MnlCV3p5R1hscE5ZeFVqMzVKM0lFVUt1MVdKZ01VUXZSN1l3QVJTc1IxdC9V?=
 =?utf-8?B?SW9oYlo3YXZIa2tFNjVhNWc3VS9oUHJ1QzdHL2tIWnM2WWswckhlRjQ3UFMy?=
 =?utf-8?B?dXRmZlgxOEpua053ZnNKUThUTm9RTUdjd3dmY2NHQWt3bVM3ZFBUeWd1a0t6?=
 =?utf-8?B?cUpRNGlIbW82VEVzeXhVcGdPRkx6UUM2T3o3WkJkenpzWitjb2N4ZEp1ZGM2?=
 =?utf-8?B?ditaS0YzZ1VwdzNpQjQwakREckNXMGNRSXRRV3drMHN5cmRvYjdhMWMzeHVm?=
 =?utf-8?B?MHBuSldGT3B3THBSODVsS3hLR0tjeC9Zc3lwZWtXZzVEVEJ6VUU5SkZsejky?=
 =?utf-8?B?d2VqNG1OWFR6Mlo5TkgrVW5KVUlMbXJ0WVdrR3BLMnFVaWV4Q0JpbktHSU1D?=
 =?utf-8?B?NmJ4OFZNRHprZXZnVGcwdHpMS0cyV0JKYnVxMHpvaUpONTRqWjlRcW5pekpG?=
 =?utf-8?B?aERjTUROKzJTa2NnSzBhQzlsb0Z3eUo0djhBNHdYNTA5aHExSEZJOUJOMHBr?=
 =?utf-8?B?M3U1TytXVWM2dXAwYnJsQy9LQjNobDZ2VGxmVDNFWE83bVNVREROd0tlN2Nh?=
 =?utf-8?B?RzBpMUU4OU1xZjg0ZlJVU1diNFd6dEVodXdjLy95WjFnMkVFTCtOQjNpVFVK?=
 =?utf-8?B?QmpXR2YvcDBTNlhOM1ZVczBGeEtRRjMwZGFnS3gza1lLQ05XancrZUxhd3hW?=
 =?utf-8?B?T2JWUFFkSjJwc0MyTUJOMkdvbGxJZERmK3h1U0xEbGY5aTA0VUkrYmdpV0xF?=
 =?utf-8?B?TFVIbURHZGdlc2d2S2srcDNZZDBkWGwzSFlHLzhXdjhvZGlpL3FoQm5FbUFJ?=
 =?utf-8?B?bmF2bFhBSFhGcm5qZ3ZDb0sxNHdzdUl4b0hmUVZGZDdtOW5keHA2SWwrOEF1?=
 =?utf-8?B?SXRzTmlkNXphR2UwaWtXNS9yNGkzM1B1N3NOQUxWTGZEdEJPSStYQ1JQOUli?=
 =?utf-8?B?ODR4amZ2YlpiSTM2SWZmeU0yYzY0aGFNc0w4ZDNFemg5ckxkRStmUmY5RnBK?=
 =?utf-8?B?WFhVdmNuMVE1eU9DNi9wSmxSNEZabnR6ejhXLytYcUJ1VVVIalNRemhCbG8v?=
 =?utf-8?B?dVFPZkdFNWNZYjQ3OGxRbG5aYlJFZ3JWY3czUWdWVXZnYWpJdW5OSkppdFAz?=
 =?utf-8?B?d28rSWZTcnBqT1A0YlpKQVE3UUFmTTIyOXppNjN2R1VvU2FQaFVlNmtpREpz?=
 =?utf-8?B?YnZqUHhIZkJudkNXWmROSVNWN3dubGZwVk9jMlpTSmx5NkRLT094dk8rV0dJ?=
 =?utf-8?B?clV5RkVyQ0VyaGg0MUlWeWJTVHZyOGxVNWI3RmZZNXVHTng1WjBSK1M3UmR2?=
 =?utf-8?B?a05Tdm9LNVdySkJQMmROdm5Cd0k2WU9mTHhiOU55V1JWOG5FdnNqQTBJY0Na?=
 =?utf-8?B?Q29OeWtDd0FvQWdTMS9ESHdvTm84QW52bFVkREtYUFYvSmphVWYzVTFOWnox?=
 =?utf-8?B?VHdRRTd1N0liYVVJVHpnODRmRXpDeDFtd3JUNktkc1lvay95amQ0eHI5UXB6?=
 =?utf-8?B?WDBteWUrbWlYVXFDcmpmNURLNDdRc0lXSWQ5RFBicTBBbGpnanpnbi9vMzgw?=
 =?utf-8?B?cFV1RkhoaGFscGdvRTJ2dHhqY3ZjMkl1WFBPVEFYQzExVWlZL21hQXF3NStX?=
 =?utf-8?B?alo2VXN5aXIwTGZIOXhUVjFXMHpxamJ4V3ZUR2NBY1pLOXkwbUJFU0ZIVHNB?=
 =?utf-8?B?ZDhkN2toQm1Dbnl0aGtXbmFCZU1QQWRZNlg2eUNhOWVQZVRidmFrRytCNk5D?=
 =?utf-8?B?Y1Avc2g1MXpFV0Ura2VQZUExbkZYc2x0TEU4UFFGZTMweUQ1NldvRDhnZlQv?=
 =?utf-8?B?Qm1idENrRG10ekZjVWlQNlRacnh3RlgyNnhkTU5Lc21kT2VSQVh6MXVHZnVJ?=
 =?utf-8?B?aW5SU214TEhaejExK1NmckZPS1NUdjZQWTNrSnZuWnJkbE5oZURGMm5qWkZ5?=
 =?utf-8?Q?CHR+1B1oSMglVtRg=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78e616b-47bb-415d-2243-08df24529646
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 09:08:43.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dOMH3RphjgkB9XuZW58dr09AZYmtcbaHGd+KNgbli/fXKmieYHGFjHHWOGRyHRzhUHF1dICZSu2JYsSI4XeEzjhXKJWMpqRtQlVk4nZP5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB1719

On 2026-09-27 23:29, Stian Halseth wrote:
> Commit 15b9350a177b ("sparc64: Only support 4MB huge pages and 8KB
> base pages.") made 8K the only base page size, so PAGE_SHIFT is
> always 13 here and the else branches have been dead since. Remove
> them.
> 
> Fixes: 15b9350a177b ("sparc64: Only support 4MB huge pages and 8KB base pages.")
> Suggested-by: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>  arch/sparc/include/asm/thread_info_64.h | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
> --- a/arch/sparc/include/asm/thread_info_64.h
> +++ b/arch/sparc/include/asm/thread_info_64.h
> @@ -99,13 +99,8 @@
>  #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
>  #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
>  
> -#if PAGE_SHIFT == 13
>  #define THREAD_SIZE (4*PAGE_SIZE)
>  #define THREAD_SHIFT (PAGE_SHIFT + 2)
> -#else /* PAGE_SHIFT == 13 */
> -#define THREAD_SIZE PAGE_SIZE
> -#define THREAD_SHIFT PAGE_SHIFT
> -#endif /* PAGE_SHIFT == 13 */
>  
>  /*
>   * macros/functions for gaining access to the thread information structure
> @@ -128,11 +123,7 @@
>  #endif
>  
>  /* thread information allocation */
> -#if PAGE_SHIFT == 13
>  #define THREAD_SIZE_ORDER	2
> -#else /* PAGE_SHIFT == 13 */
> -#define THREAD_SIZE_ORDER	0
> -#endif /* PAGE_SHIFT == 13 */
>  
>  #define __thread_flag_byte_ptr(ti)	\
>  	((unsigned char *)(&((ti)->flags)))
> --
> 2.53.0

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking these two up to my for-next.

Thanks,
Andreas
