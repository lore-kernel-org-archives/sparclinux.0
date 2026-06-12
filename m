Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022141.outbound.protection.outlook.com [52.101.77.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ADE380FF0
	for <sparclinux@vger.kernel.org>; Fri, 12 Jun 2026 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255589; cv=fail; b=clP7CB4gQXk0NTcwbdbT/ABb0bCoX+G0jOPF3TOplt4PId/YAW74mNWhrM4l0qnVWSiFD+Viurt0crjPEtK78BICtS9p4jKQWKRY6EqxSG3QadvHHAxqyxZWJGjF7MAiOKmUIElViiJV+tmRc6v33XZndiRVd7cfO1PWl8Qh/qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255589; c=relaxed/simple;
	bh=Z3bQ7/qDDL/BY2rU+4FTONPXa71JIvdKrq/sZ3/4nrk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lJD8AEpG9++uRQ8Sk6l+cDBKt7BJvbCM6hODnZlv5ohgw6uHETAvJ0R6bch30AwvRWD36vTAw5D/fmwHzjoxtTkSRSK2aqeM6qkS/qd4HobIyuPb8GH49fnVqexycvuB53QbZc5ndfBM7V28QlZ8+dhhwMCWVcrKx85oUixo/Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=YFwHIQRN; arc=fail smtp.client-ip=52.101.77.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="YFwHIQRN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sz9yrb8ckL4S8wwuTiKL1cxxMUpniSx0O6FNvcAnBjra2TzFUJ/3cDk6Bqi+xkPazHefgyWm88krVXDXIHDMNtr57JQrAawTu6vHXns+a58Cmm0ecY4jBXi1Bl3CPmE/khLNdRImT4prtxwP2DPukz18vWazhcdtJklgy0mquhFaXui5/echHDwU0biixBS/zAEG/wL1BzL0v/AzbQHCEhhG3RaaU0FjFYbS6lX7M34vmDACBBsjd/BLFnDuaOQthGs7FCsuQ59zrxvyEJNntuf2Ib4wdZppA5bjMVwKbOqpfkLMG9cFytByzhleiYGWZnTWmHaocvZA1Kzb5/OFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCEVU6+iyadwm+IeJ0vGyc3PGAqfi1U9Ql1RDjAPU0E=;
 b=cQLVstXpqbX1jw/fPNgFy3Js5fXxZfWDWsKkkK7jDSEG2NZompGt1Nn17jBvLC6IqdMQYow/+NNp80iDvJynhzG2L5zTJDU+fDlPPt9bAaXBV34R64LvHmiNIrJC/Bk0yQyANRpEWZIQFoYUKr0E52YFKYTMNEOyezFZ6ePWRdCFi4+BBU7JbCzEF+bqm6L7MRWuCxC9rbuP9uHRBX0Br2bbhntHi7THEca2m2PKC6+RHa9f17Dy3qbqKa5ehYNay8hD7KtAzSf1+ZrLxjSOSCkUB0P0D5l/n61U5GggB9QD0DPColdRUMUHMfo1LQcyAdTbTySxU3QfQTh8iX9/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCEVU6+iyadwm+IeJ0vGyc3PGAqfi1U9Ql1RDjAPU0E=;
 b=YFwHIQRNOlBfXBsWIRQEy9JvQVP2gNwjqGkb0wpQACj28+wRna+Pg0TChOJbi0T4GMP2Df8uiwoCYL05VzBWKxzWmpfDkZaH0H7de3/4um+9sbt96JL8oNbfmVmd8SoIt7xx0yKwqLrpDyDwtIqviVzbeGIKYCDVziM1Aqc7iXBiXIrgnH/7pekfSDDbR2e0epxAgPH56Lx0xaComWiGwXVEN1RPN3Np50jQcryS4O6Hd1IbQfVX4d76wmKJBP1D83QHYCnOEtoEC6us8mReRG2+LpEluwdvU9YO87hAoTmSXY/dKL2js8B4xa6sOCq7WUd1+ffSoJl16W5VmIeX8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GV3P280MB0759.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:13:00 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:13:00 +0000
Message-ID: <fef05556-b2ec-4e6d-bb74-51c0a5b9e4df@gaisler.com>
Date: Fri, 12 Jun 2026 11:12:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: remove unused SERIAL_CONSOLE config option
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
References: <20260505000913.25576-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260505000913.25576-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F691.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::13a) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GV3P280MB0759:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef3910c-860b-4f95-7f57-08dec862cd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	w60RnmQ5r0dI+3QVU6/L4Gy3Sl2JjcLIrtntE4fWtjDGKNW0vGwHZA0aii859l8P1HlafoFzuSRqo5KSn3qf+ZHBOuFhBhhgJutsp71cDSVVsHz25b1zHcBsvpl17nH4NZYImwn4jeTAcCtpaicVN9gtRIDdjFsELgva2ddPtva6xua8aCpTnkY5dsuIWUWomvUv0oI44doBpYEzTmeBrZp2+C9OnnWhsFn2JM+gjcTB0pob1DatVvYf10iB/FHzIsayGT7Tnd4l6zz6OfCz1ljEMukvI/s3D6xZC1yKr9kJKPVx6b5Hwx1cZOhEywiLaKMpV/XfZeHsmENwe9iRkmh+H0yJwPVmvRdPSKVC8dUkm+BSSPFteHJcIb3OToi6t5UV4axKme7SypalsVWt/x6vOHmvl34U1+dQoNoJFBbtMvt2WT22bYO1l3NKuQfjYLwZmekaQfKDBaVy2PmoSBTv1BIJc4px70tRku23HbsrKdxo6WvnxT0tfGec8vp9BHbJ2KStK/G+YxN8Wr89/cfM9+cCG3z+NgOYggqrL5AISfgkWdajpTFo14Rt5GGM374mOs57bT8bs+YPKJEtGbxsp84M5YUxuUR6OL4aCjuvlILvvyn9w91R8kraXkSucSb9XjGWfyum0H/IO1I9gnxWamyrcqsNoVhCKAzhgl3rpXYEoAbmOLWVkOu7wpYX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFRGTGs0MUU3a2pKbVQ4aDlNK0x6NHpCRjVmam82ZFhtc09LUkgzck9hVGdS?=
 =?utf-8?B?MEh2cHJ4TXB2d3I5UDlqaDl1NGc0N3p0dEZaTGdNL2w0UklqSjByNEdvRHJ4?=
 =?utf-8?B?aG9yVVgxbURFa2lvS2NRRmY2RHRRNVM3aVRpYllOZDY1dW1aT0xDVjRBOTVC?=
 =?utf-8?B?YVFxTUMweHQ2aEYwUGttY2JwMWoxSHJmNVZWeDViYWRJd1lHWDhFaXM1VUQz?=
 =?utf-8?B?SVZiY3F1V0hkaEpLWXhOcCszOWRFaUZzaVo5cFpXZVdxMFpreE1CUjJmaTZp?=
 =?utf-8?B?Q2NMY1lJYnZwUDVqL2tYUXpIang2SzZJTXVwdXpoMmVhVUwwYnRZSWxOcWpp?=
 =?utf-8?B?bTNOdDdFZjF6OTlOK3ZGUTR1alVHdHRPMXdCa3g0VXFjWlF4bkUrRkkxcmN3?=
 =?utf-8?B?a05scEhYczFBTTc4My8vOHd6Wm93Q0NrYTlQNktpNGltb1JYSVVUOTlnQm96?=
 =?utf-8?B?QkY4VHNobFdCZGJnWFpXbWNySFcvc01aMk1HckVCdysrUzlEeXQ0MHoxUms2?=
 =?utf-8?B?S3BGdmhaTmNOZ3dBUWEzTWdzc1ZtSDM4ZXBabzFLN3V2MTRIdVdBcXR2ODZU?=
 =?utf-8?B?N3dXS05xTjBDVW5FNXRYSm9yNnROOEhiem1YdVA2RExDTWtHZk9lejAzbFR6?=
 =?utf-8?B?UDQwNjNDVXdhMkxtRm5kelZibllvZjdlb2R5S1JNN2lvSUtlN2wvLzlFQURH?=
 =?utf-8?B?eXpreThBbUhrNUQ4cWhvb2FhRG8wVkdlY0tDQUV2UEdoUDdnTlBOMTY4aWxC?=
 =?utf-8?B?L3dEVm5vbGZ5dnJZYmFlTHJkbDZTUlVUK0x4OHR0MVVWQ0NtcUpsTXFsTnlQ?=
 =?utf-8?B?aURmandNYVAzOTYxeTVuaHZBUTdlYjJRODlKRTZVYXZxZW1QbEVPUzRHWE81?=
 =?utf-8?B?UEhUcVhIVnM2UURTZktncFQ0b0VSMnJYTVVJbTM5TitTdGd1VjdMMkt2U1RG?=
 =?utf-8?B?bmdha2NDYmVQYW04akJSRlF3RnNuVWxwUHA0RjgzZk9QcFFCUTRrVk9lbkll?=
 =?utf-8?B?Q2tzSElmRVh6alJjZVdFZjcvUmpUTXhDNGhGaUg3eWFnS0NWRURlWHFvaHNk?=
 =?utf-8?B?c05RekttZmxrcktIMlNlRlhtbEl4b3k0OWcvUmxPdnAxMGJqaVlJWU1vb3Nx?=
 =?utf-8?B?bHFMazMwYlFOSnhFM2x0QnVhSDhpbHd0dEp4MERxS2dmOTdWWmtnbGVFSVB3?=
 =?utf-8?B?THlIMi9lS3N3Ky9lS3BYenBGNHFybjFYdHJIR2VlY0xHTXlxaGxtWHNYaVNy?=
 =?utf-8?B?T1FaV2lUd3JwejlLUnZsZk1tQUUvbTlPQmxUa2VQc0xNL0ZQQXl4Ylc2b0RD?=
 =?utf-8?B?SHFSS3QrVWx3elkrR0JtRUVCSFpteEFwNVpkVHBrdlNDcTNKbEliMG9VWFJz?=
 =?utf-8?B?K1NUQ0s4bFNPM0pOWUZXTUZvMWJrd3Z3b1E0UElzNmVCelcvVG1hOFMzeXJa?=
 =?utf-8?B?dFpnWUJzNEtDQ0ExYlRvcWJoTHo2VTNrVnZxMEdmZVhENThRRXFQSSs1S3dZ?=
 =?utf-8?B?S2s4VzJ5azFxUThLdUtGSHhQcjBwbTJtUk01MlMwNmQ0WmcyVG4vcXZvQStX?=
 =?utf-8?B?dk16blRZUWFDT1BPYVhqVk5JNHB6Y0ZsRVpBZ2lqK0pHdTAzYSsxZkRvQldH?=
 =?utf-8?B?V21sdWhoUm9sdmhPR1FkS3k5OUZ4MVJ0blpaSGVqSGZWaHhESDRKcW0xUzds?=
 =?utf-8?B?UHpDRm9PMEp0Mlc3bEluTFNNRG12RUtNWnFUcjRCT1kyUWNtRDhxcy9Pa29B?=
 =?utf-8?B?QXZuYmh4SS8yMVpleVFCWis5NHJBZ3ZTeTA0ZkZsQkowQnk3a0g4ZVp2YlpB?=
 =?utf-8?B?WGJ3Sm4xYzhqQ3dOMVNVdzZXY3dqNSt0TkpyNXl0T3RQV2ZoMnRtZHl5dndo?=
 =?utf-8?B?MWp1WE1oV1ptcEtLTG54enZwc3RUenN3N1hJbjMzSmdDQmZRSTlOUCtjSXJP?=
 =?utf-8?B?cXVPMVNDQUl1YTc5cit4WUNOYlNjQTRUSmt0REl3bkpmenR1WWNHTHBrSERN?=
 =?utf-8?B?b0h6aHJlSDMrSis5VXNlQ21SVWRaY1BqdTlOZnd3Q3JIdnd4YXFaN2V6RnZT?=
 =?utf-8?B?WXE2M2hTSktiSTlTVmpNc1RsVWpWb1BLeVJBeFd4dmxDYkhZb2FWL1BjK3hX?=
 =?utf-8?B?ZWJENFVUY0RPTU9CVVlYdE54Y2hRcHhUb2srVUpYeVZQK1pLTVhrKzJaRXBu?=
 =?utf-8?B?OUlDVlhoZGhBVUZGZElVT3lHRkorQ1BjL1M5ajB4Z0JqYTlwdDgvWWovcGRE?=
 =?utf-8?B?dnhFaUhwUVdIUVRsN3hjMGpSajQvSjJ1eERERitmK0pNTENJdldEWHBvTVhh?=
 =?utf-8?B?am4vbXRwRk56ZFVnUThwZUs5c2tWVk1jbnpwaGZwNDk0dSszY0FZQkJYR2NM?=
 =?utf-8?Q?84qW7NhKCAd7qGSY=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef3910c-860b-4f95-7f57-08dec862cd11
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:13:00.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iuZrPk+1Ac67UABKRThs9kl5zeeTrteDfZZ/mkXsYUvgXCQu0w0mNH1Gxeqyji77X4KtuzwbzoF2bYOyIskn6E1wcefTJQE/S+861I+tOUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0759

On 2026-05-05 02:09, Ethan Nelson-Moore wrote:
> There are no references to this option in SPARC or
> architecture-independent code. Remove it to simplify the configuration
> process.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  arch/sparc/Kconfig | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index a6b787efc2c4..fb53b21a8696 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -327,30 +327,6 @@ config SPARC_LED
>  	  by reading /proc/led and its blinking mode can be changed
>  	  via writes to /proc/led
>  
> -config SERIAL_CONSOLE
> -	bool
> -	depends on SPARC32
> -	default y
> -	help
> -	  If you say Y here, it will be possible to use a serial port as the
> -	  system console (the system console is the device which receives all
> -	  kernel messages and warnings and which allows logins in single user
> -	  mode). This could be useful if some terminal or printer is connected
> -	  to that serial port.
> -
> -	  Even if you say Y here, the currently visible virtual console
> -	  (/dev/tty0) will still be used as the system console by default, but
> -	  you can alter that using a kernel command line option such as
> -	  "console=ttyS1". (Try "man bootparam" or see the documentation of
> -	  your boot loader (silo) about how to pass options to the kernel at
> -	  boot time.)
> -
> -	  If you don't have a graphics card installed and you say Y here, the
> -	  kernel will automatically use the first serial line, /dev/ttyS0, as
> -	  system console.
> -
> -	  If unsure, say N.
> -
>  config SPARC_LEON
>  	bool "Sparc Leon processor family"
>  	depends on SPARC32

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

