Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022098.outbound.protection.outlook.com [52.101.77.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773403A83AC;
	Wed,  7 Oct 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791357726; cv=fail; b=AOEsvI/ax+7X1BnHRZLz3kZfIAIkMiZieTLPfia0tgWGsgJw6TrlADhGyGzTAl3nA5oiZuCc5IbZuNWwOMhC8qainpvVbu02Jf0bPLyYzC1DhJ1gmPE5vJIJq1Mx2uy7a/Jl8BB0EH4t9YvBBrZ24NTRCIHh6C62MwnXXzA+9gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791357726; c=relaxed/simple;
	bh=r59+1zKalYg7ArxltEYKkQdT5VANfTOw4QpI4scKZFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TX9St6JLAdgvUknIQnl8KhHBhP6bW5z2hKOGSxP6yefELQoC2A+uK3tmt1vggTIj6m3+rEroCxH2AE92pApAWl8ANptkyvwCteM/Yi00sY6K70AwT4b7uXv/H5JZP5cQwm8c8sdBaA52Xuo6lxArdAel1jkkhiBf7cBOeeIGMcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=T8Hj1Ing; arc=fail smtp.client-ip=52.101.77.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="T8Hj1Ing"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cCu/y25tdAfQWgmwfseORqhoMhimryDdBMVR8IwdOxPAQtNm11mMNbFknBQVoJIT6k/PwdLNp/Ar0VoEmixWd9qUkxsO+QSC4saZXJWCz8qUJsqKIhHhs47GBcnDaYA7ma1irNfQCNmr3AluikhM/ey7INU4bW0w6EbrkAMkWK44D0BAa3A9HSl7etKFvoLQK81Gncq3QDg1cdFYG0y9f/cpN6Ii16LSvTPgGHMstEZA0c/nCJQnVOxHWBM6naickZSoz8I+lyhVD0oq+qPQKmNZBBXY9jQxtaiHkR6ruv/1oDaoudrdYtnG58YnWdmXMn7ZWbnmJsDqYoslPIQrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O5rFoi8NbDmLVHpcbE+r8Dl4OQxbrBO0hR87031DG4=;
 b=eAWwV3m51DXAp0FvToduKyZtlVXKAzDZnx9/XyVt+vLFL/x/a1j+6Vlh/y9PRzFex3O5LdW0ViHE9xtz0g553C/uorrfCw3QM4jPNWVtTNayXeOIB15I+5Od04mPlHhgcfR147w4q1gw3ZjUeB3fFuz0XFCzix0tk/5wPIPQz3oeV9wKiJ2ntyyDnY7acqCu+w+QrRv0MCvrvF2dJ1B4auxm1LxI4/d7aPt4RduHM6IdJeZnERUqY5Kk1kV7xjIFlQ269+fuHzfWk5FGPXqpXo63suz6tRnYnaRdKLeUg4Hbs0DDh8MrXTy86dSPuCWVRpFB0XHNPvvDj3N8DdA8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O5rFoi8NbDmLVHpcbE+r8Dl4OQxbrBO0hR87031DG4=;
 b=T8Hj1IngqKxxVgy5VlQ0GsSUW5PPKtAbH7XMya/MT5WtITPWBx1URsA6c2w1KtdAPPA83E6a4hqEjkuBKe8ekzbPufwI313wFkglVz4lJs3amHByLske47VGaHjPcouB6PoneVCP5dRm4JcxTzwc2mYmnM+w0ShXdNtYUO5ZCt0JaLiKsgLBeaHfT3MRDczv+SwXkW1pC4xBTUG0/RDd2mtzBs//ED0YLbN8ritHC5OZBL+FxnjbiaA4bLUbPWyqY5E/y3zMDD7BiQlKpuUcpD7l6xEAmHRfFdVToV5TRCxm6Wd7vVku7rLaDAJfCdWZfT2CRKvHRHQrWTlIu8md6A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV3P280MB880294.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:504::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 07:21:58 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 07:21:58 +0000
Message-ID: <62771b7c-c9a4-4fa0-83d8-4b39e36472e8@gaisler.com>
Date: Wed, 7 Oct 2026 09:21:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sparc64: restore %asi in user_rtt_fill_fixup_common
To: Stian Halseth <stian@itx.no>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 glaubitz@physik.fu-berlin.de
References: <20260828123707.1852437-1-stian@itx.no>
 <20260828123707.1852437-2-stian@itx.no>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260828123707.1852437-2-stian@itx.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0309.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:85::9) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV3P280MB880294:EE_
X-MS-Office365-Filtering-Correlation-Id: 06556cc8-0818-4e7a-758e-08df2443ac2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|10067099003|4143699003|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info:
	lKuvjrfmS5yn0B/CReZhWXecoWz2zTbJ8opupTjyjkF4YvQYQFeP0UQ8Jqt+GhoHYDSZfqx2hHl6BSoQ0TTVnhUJOlQqmfwA+X/BJAQk7KzCEuqauA3jJ0yZmofeqIOly0MM0kxLmDuz9uRZ1wgXcUQvgxMqVeFOMOtqMK9kI6ENeT2yuWOoebfOmoQsfm7saKDEZowkLxNPvqeK6xgQDFdsrzjlObtmTMCJMpPI1utxIRzTj96dqyh+tsJVzlMVerhcEangt/1lr6WTeS18zv7UEs/8vG8bkA8Kue5Nvg0x93gIa6Ul8z8Vf1mPctUTiMsFGm0oe8ZQBF88y1oR2up7NomJWT562MRAmGFeuTp4NcUA587hTY5GkkfcG+17AHwINt0F9/V3BusXNsdEYP30b5b5dTC7HlrVyu6L1K+aELNj+Okqj4FYbL80isIm9zjbJBsMdkskYZSVGWVGCt1G5NjArlphHRbvrYub21ou+9Axj4sAG3siW0kQp9QAm/+9DqQ/j4qpDdvZolYcYLsBzUHkct8T8y20s8rWXSfbEfcr8UhZCsAZWyGylAlGEqj53Z/zNOY0ymwMzw43aw8F4V85H1tedmUmU7H0Kt2S2ykKmf8CgZyvAapU+hGXI9rxJF+aZHkrPx69m3a23jWix65/6tNfB1trSxwTb3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NStvbkZabzB4dTRHS2p0N0RkVkdLWkJ3SHZUTzBVaEVvQ0VpK0xVWUlLWE1X?=
 =?utf-8?B?L25lMDV4OTk5Qm80T1RMbDl6WUF1MFgrVGluNmFPWWRuMTJZb3o3dXFPa1l2?=
 =?utf-8?B?QnhnQUR1L1MxZ2pSUk1hTDVJYkU5cVpWVk9IcGJqR3htZFZRVXU2VGpXWXAx?=
 =?utf-8?B?OTJsd0FsQ3dWanN3dTZ1VVVpWmpkTGZIRWhRb2F0WTNvSmFTUklDS0V2V2hp?=
 =?utf-8?B?SVFxT0ZjVXluYWQ4ZFRPOVRkeHFxWGhBdUE3bHJQREczck9RL25VY2dOeTRL?=
 =?utf-8?B?Uld3WlNwZGpGcGNPckJna0xEVTRucjJ5T3dldkhoWVE5WVRtajNxc1RxbTNi?=
 =?utf-8?B?dGt6cXhSc3N4cCthUk1BdFFCNFhqNVY3QklDYk9BWUdkYTRYWDQ0M2tmNk9n?=
 =?utf-8?B?MWdnd3RlNzR1VTU4c3ZUa1drdlZqTnpPcHo5SU1VSEY4eldveTM1WDUweFhh?=
 =?utf-8?B?VU8vQ0RQWUZaSXJYc1BWK2VWWVBaTzhQakpXM0FKYnhaMks4MkNFTkh6MmNo?=
 =?utf-8?B?NjhrQWltZWdOakZOUlZ5ekhkWXJtS1RhNG9VTzdvcWdpUkptVzFSeTFSNkc3?=
 =?utf-8?B?VmVwTjlDQXdaY1dabGMxT0p1KzVvNUlZZytWYWY0OC9wdmc4eHlpbzBRay9M?=
 =?utf-8?B?aEdFK2IvSEJVQXdONWFqRXUwVldoeTE5cTdyR1h3ak96Q0lGWXBYTEdwbDhP?=
 =?utf-8?B?VHEyY2s3RDNvRWVXK2VVcWpjTnJLU0dNRFlubm9MMFRPUngzZGNGTStVMlRi?=
 =?utf-8?B?ZnUzMEQ3VFBnbTN3YmRjUFFJb21QMWJNNTZndUNKM2lKSGhnTEU2UXd6aExq?=
 =?utf-8?B?VkdrRWpNSWo1UFpyWDk3dWcveWNMdnJ1Q2dHellZbURoVTkwMHVHcjVYY1dr?=
 =?utf-8?B?NU55OUVyVzl6TzFMY0o0blV0KzdDYWZ4R0wzdFp1cjNyUE1FM29CSnVNeUpq?=
 =?utf-8?B?Y0gzNktDdVFTTUNSaWNYekowczVIYWNpQkNQTWZDRVJyK3NSMDN0azNJdW1E?=
 =?utf-8?B?TUk1MmsyU3IzY09KZUN4MjNRZWsrU3NtTkhxZFBGVWtHNXpmeHdmOWpSQkc2?=
 =?utf-8?B?eHR1TlVoVmxheFQ2NlVFelU2UThrQ2VCOUk2bDk1SUU2SVNKUWhGQVRKTmNW?=
 =?utf-8?B?VXArKzRYOUx0ck8wcnpXKzJ2RnZCaENVZ1JlS2Y3Wll6WmV0em1yUmNrbXpQ?=
 =?utf-8?B?VEc4N2k1TjZCelZhV1cxODZHKzFDSmE1ZVAyS3Q0Z254NHhFR1lVNEM1ejFT?=
 =?utf-8?B?NDUrcFNadWZkZG5PejA3SU9JNlNPUW9EMm9Gb3QyTmFnQUoyMzJSQkdSdEMw?=
 =?utf-8?B?VVp3a3hsSzFCKy9iVFRJUS9qYVlscmRvSU1STDE4VmtWREIrT3NHWlRDSldU?=
 =?utf-8?B?cUo4b3dua3pwZVc1ejZZV0NZUTJScWYrZlRQdVIrVHlwcnBsYm5yaUpWUHJR?=
 =?utf-8?B?MkVvSmF3bEYwZkZjakpNWVI2RmRGajNDYkZiZEZ6TytCYmZORStWQTMvRjls?=
 =?utf-8?B?Z2VNdExRa1dMS0h3SzBZMkRid2ZtSERML3FKOWtNenRJMi9qZERhZys3QWVO?=
 =?utf-8?B?S2hsbUltQVhpeWZTanpDZlZ1L2tDVEJMaDVhZzVrWnc4MS95bmpCZVMzWlo1?=
 =?utf-8?B?L1JIRjdCS3N0RkJoYWI4TGhrdVhLQ1V2L2hNMFovRjdqbktWWWJUb0pnL0Ri?=
 =?utf-8?B?UTRpN1dlOUhVK010Y1psSVBnNUVEMFV5T0FrQW96OEsvdzhaSnQyZVZwQkZT?=
 =?utf-8?B?T1gxK1A3NFBFTE41bXYyR3J6bTVhVE55VFowQ3FrT1g4ckp3WVdZWExjTUp0?=
 =?utf-8?B?cVBGRUo2dnFkQW9Nc2JPMk5MM21odE9oUXZoWUU4NkJWVVZYbVJxaGg4RFRo?=
 =?utf-8?B?eTRNamIvbjV6QjdIOWpDb0FJODJkZTZ0cU5HeFlDZTN4cElvQVYzWmhWZHdy?=
 =?utf-8?B?cHdVek1BVXlVcTlva1BnTmxjUlJoYU5JSnUvSm1ISkRNQkZNOU9XeHVQTVV4?=
 =?utf-8?B?SVVVaXB2WVBJcUhNU3d3OURLSkl1eURYcEtVUjgyUUMrbWErajBlZGozTUo0?=
 =?utf-8?B?S0Q4aWhJYXJnNlU3QnZUQlFCNTRNQjdIT0huOG5VVy92bFAwa0JCUG8yL21H?=
 =?utf-8?B?L0ZTUE5aNkExczdremNNbkNhcE9ULzI0Rlkza0ovb2tQNHJJb2F6M2pYY2F4?=
 =?utf-8?B?M25UVHczWkNaU01DVXRLOGh5MkVyNEpjZDZYZm9OU3pVZ0NPMlk2SzkxZ1Jy?=
 =?utf-8?B?WDltYktZQjJVRjZTcTBudThVYk42VnBzcFF2Qnp0VUZkUDNlVnFKUU5GSGR5?=
 =?utf-8?B?STN2NkMyZzJ4ejd6RmZlMVlmZGc5NUlNK0hqR2tEOWxsOEd2S2ZROVJ6RlFB?=
 =?utf-8?Q?q32HsHv5adphuG4o=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06556cc8-0818-4e7a-758e-08df2443ac2b
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:21:58.0842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRvL5IrOVfDgli1skBmDzgO4jdUvlArZW5cOS2XuK9agB8/wFxO4D4tmcJ81wr4FrJ45QeTGnUuXyXSR9vcQiAxfkrQBSBi6Eo1gUX2Jes8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB880294

On 2026-08-28 14:37, Stian Halseth wrote:
> A window fill that faults re-enters the kernel through
> user_rtt_fill_fixup_common(), which does not pass through etrap.  rtrap
> has already set %asi to ASI_AIUP for the fill, and etrap is what would
> normally re-establish ASI_AIUS from the TSTATE it synthesizes, so the
> kernel carries on with %asi = ASI_AIUP while the primary context has
> just been restored to the kernel's.
> 
> Every %asi-based user access made from there - put_user(), get_user()
> and everything built on them - then translates in the kernel context.
> User addresses below the VA hole fault forever, because nothing ever
> fills a context-zero translation for them, and the CPU is wedged in
> kernel mode: the task survives SIGKILL, sits in state R at 100% CPU,
> and takes the machine down once RCU stalls.  Addresses above the hole
> fail more quietly, silently aliasing the kernel linear mapping.
> 
> Restore the invariant before any user access is attempted.
> 
> Fixes: 7cafc0b8bf13 ("sparc64: Fix return from trap window fill crashes.")
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Link: https://github.com/sparclinux/issues/issues/87
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>  arch/sparc/kernel/urtt_fill.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 

Good catch!

> diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
> index e4cee7be5cd0..5acd27b18b1e 100644
> --- a/arch/sparc/kernel/urtt_fill.S
> +++ b/arch/sparc/kernel/urtt_fill.S
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <asm/asi.h>
>  #include <asm/thread_info.h>
>  #include <asm/trap_block.h>
>  #include <asm/spitfire.h>
> @@ -32,6 +33,20 @@ user_rtt_fill_fixup_common:
>  		sethi	%hi(KERNBASE), %g1
>  		flush	%g1
>  
> +		/* rtrap set %asi to ASI_AIUP for the window fill, and
> +		 * we re-enter the kernel here without passing through
> +		 * etrap, which would have re-established ASI_AIUS via
> +		 * the TSTATE it synthesizes.  The primary context was
> +		 * just restored to the kernel's above, 

Perhaps begin with the "Restore the kernel invariant" wording up here
and then continue with why it needs to be done (no strong opinion here).

> so a leftover
> +		 * ASI_AIUP makes every %asi-based user access (put_user,
> +		 * get_user) translate in the kernel context

The comment in the code itself should be from the point of view of why
the %asi update is being done, rather than having language as if the bug
was still in place. It could be as simple as "...so restore the kernel
invariant, as a leftover ASI_AIUP would make every..." or something like
that. I'll leave the exact language to you.

> : user
> +		 * addresses below the VA hole then fault forever
> +		 * (nothing ever fills a context-zero translation for
> +		 * them), and addresses above it silently alias the
> +		 * kernel linear mapping.  

I think it is enough that these details are in the commit message. These
are details about the bug that now is no more. The short version on why
%asi needs to be set to ASI_AIUP is enough in the code.

> Restore the kernel invariant.
> +		 */
> +		wr	%g0, ASI_AIUS, %asi
> +
>  		mov	%g4, %l4
>  		mov	%g5, %l5
>  		brnz,pn	%g3, 1f

Other than that, the series looks good to me.

Thanks,
Andreas

