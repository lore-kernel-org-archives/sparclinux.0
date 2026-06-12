Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020110.outbound.protection.outlook.com [52.101.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74008305673
	for <sparclinux@vger.kernel.org>; Fri, 12 Jun 2026 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256092; cv=fail; b=Rie8ci5RHBHCLaXsxHYWdWEw/aiukYQaZg5iTyzWAV36nw17AXExeKOXADNjEMQdwrY3Hfd5EeGnxd6m8hBxyKNhBs3ZXh/QbaMV+S2X8mTqilFgpMjuGM1ZKuMsAPXHGfCGcVuXfLzPw10jP8T0HXRplpPN7xZiKk+xyFTbBS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256092; c=relaxed/simple;
	bh=HlZs1aHxdxjpx+07gEFnURsN9NWmv40HxQ55aw5XpNg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bqv/UhMOmjvUWTr8kec5Jpyr2CIe+JAwkGDDhCyJd7LalrPhEI7SAcBqJxoiJWp7Pg01wvWXaPK9ROtlTXFBbvHgr2yr/9NjsqdFvLxZ3npLEYXkB7MOZDq5V6WeGm7Ju/HSMzT4d/4unTKKhxPT60teefUvYKlDmNoQi8fYkfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=gsKuhiyP; arc=fail smtp.client-ip=52.101.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="gsKuhiyP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdl9R3mUQFVq6EK2JMXCbvWWh/ZJHdTRQJS2/jqqyF95lqPlE4lvbJlkanfjGUT0A/MQ3bkeHvZX5s1cVh0/Beoka1+mQxxMO+oHuPAOKeOfWp2VbnPsKjqCFlSCczsm+otSFDwOeSjMXSnxBzJGUG2/ZPlYBCsRztNE8HNuf3rPK6WRByW5Cy9ap4MYAlFI/FYCRRSjduhwB1UmQ3dgZJfVUm7XsfOFD3v7d6SRUyngHxB17eX2OabkxZntYIVrAwbdoQ1I2jMbDe4CmSAl3MkGHf9yaFv7uWCMxNJEv7dKJkdecZ3NPkvT8mRK0lvHax5m96gDOwjY5mD18qCNYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCHyW2SIHTHgctvQwYjgcxGReUxZT1h+VHoC6OOmhss=;
 b=D1wqCJxjFieP5h/yhutRzYCWzqtROEIEZzBhWOgzsG5GPUdVusByfWdZ0ru5vL+VHb5GRN34WVRBT89I8pGFExbJ4DmyQ6TVbWHjyriY77hvhvJBG3jSuSiiyWPKHpV5u1VcuKd22rY/saQKFtjdmqTZIY99yFH/FRfWNBkKf9bDLIHZbVElu5ucb6b4FGpYn/zvrL0U5hL0CEa68YfcGzvpXCPX5RtJ+LkDjNEx1sjn3+zvazsmujO/desquIahc4CMU6v5qTfVVb0acV6aRLuqKTjXHO2qv0ejIeJnUUMGVOI2vc0MfuwEjrXRwysQIYCikQ9kTIbidz507AAStA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCHyW2SIHTHgctvQwYjgcxGReUxZT1h+VHoC6OOmhss=;
 b=gsKuhiyPwNnBcCkAskgPwauaKxvrUoWJ10AFHJ4ozEgtAqenGwsAvNsmaqecCXB2wI1V4jfBCf5q8mpiKUNX3pUSVy9wZXCXzVU0M1kibzsrNSjujS6hAqRoY1xFWQqYHC7tjYm22PWNMFbgcWp/eer39XYgsu+B3eVSR+Kzy7PrlO6QRX/kfSE0uu2W7qmR7TKn834TAlTury6Nm32a7+5F7FnPBQls23b6MNLYOMBvp4/qrjdXEw61qeZYJ96Ackuf/zFGlABuH+RS6fr7JfxoREltm8VD0+0Q6xzwk8j9NyDQbi6WgdjY9Er1Jzkee08nOCoE+Ajj1qxmRHvKtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVZP280MB1985.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:233::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:21:25 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:21:25 +0000
Message-ID: <e84d7753-fb02-42c9-b4d9-8a7bce96a489@gaisler.com>
Date: Fri, 12 Jun 2026 11:21:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 1/1] sparc: add _mcount() prototype
To: Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org,
 davem@davemloft.net
References: <20260523042535.C3A6B1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260523042535.C3A6B1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0039.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:26f::7) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVZP280MB1985:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f987c30-31f1-47e3-053e-08dec863f9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sab6xC11Gu06iI5R6hY61BgYd1GvBuTGrd7nWOhHtAkSwANDOXMJF2CCz923U57U2ucMU5nSMVKA7m+OGoL6m0bS72Pf/jxpap33OYwLk8XVG7E56+AefttooKpk6aBYaKnQbNQMi3rHhwIkN/QaAwGK/5T6v1DhR8bipSPI6G7Ub01QubllNiuBBbBr4407zADdU7tV5rnCaOptCuVsqXUQ2lgQ02oYewSTd0r410lz3krYbRYPkNkiwCW4XLto98vwEvZWIy4dEARrnGOpNzK5GCA11CwZf9UxARKR9dq5o7N0OZEWnhisbM9H5D40yAEnHHuNIShQqI16q1JuSke4yurxHLtU5XepWywRAq1ci1RHPZIlniMcckKmhG3qGSxyfs7vjcuGv5fF3D65T19J1wIMS+df6izGgr41kTQM5Bmi6TVTdGSdlp3+Wm6UA9CdkpQwm4i1QgbOtITtmIqofU4rMVwdXeUNJe9ahvuXN1YdoPEc4S8Yf4HNjra5hd05xcTcIvW6vy4vo11dA1L6rjo3oF8VHbxNXwplvacTJQuJNpJHyElfQbSkKEDRDs95SIjccrZz+CDHxI1mPHHySUCOAyTZ5rw62nJHqh3sUQuctaTQwo0b8TTxPkoC/9/tI2wpjPI3RD/npN1m1P0zV/MMHgFQBXoOx4VpjHFTxPNE1OSjpcGsxLWkI1rM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhnUE0yZnNnMmxLOU5rdEx1aTF6WEtuMTBxQmFoQzMzNk1KYUNkcFRweG41?=
 =?utf-8?B?dXlNOHVsa0gvcENIcjZGSG1EYXZrTnV5Sm5kNElibXU1QUhRcFJsNUJHZEU1?=
 =?utf-8?B?WUtTZDFjRVBhQmNWR2NMM1hGa2FEMWxyRGUwZWtRRUl5N2M5bTdVclpKZlJy?=
 =?utf-8?B?RndBbWtXaXc3cSswUXpFaWRrYkZzUWhOOXEreWJObnhtbUxtUVEwUEFSM3dE?=
 =?utf-8?B?ODR6ZlJnN2x5bTk2aXJicG5PUkFIY3p3SVNMVFRSQVROVVJrTkpUYUltc3lj?=
 =?utf-8?B?WGpZQXllbUtwMkFFUlpGSmxLOXlBNHB6Y0lJQTJ6ZFhoNUhqeWY2R0d6ZHJW?=
 =?utf-8?B?L2MzTEFzSGRuUG5ZSngzUEdWaUJWRXU2N0JidHB0NWM2dHErUXB0dkhBSHR3?=
 =?utf-8?B?UFA4c2d6cHhRYmFDRko0UEdMUzFGamlJZW54QXNPczc4a05TelZlVDFXYmR2?=
 =?utf-8?B?OXhMV25BcDdDV0FOTVNQVTFSSlRyVm5ySFI2NDZOdXpBbVM0TlI2WE1FM0tE?=
 =?utf-8?B?QWR5elVWNVFYb1hrREFaRjlaRHN2NHVEWmU3ckFRSlBXNGFIMWV4S0FlOEpH?=
 =?utf-8?B?c1N0MVVSSUlhalFlZUZXMUJTOEhXSUR1TmIrdWNSMzVPQ2U3anRkTndhTklt?=
 =?utf-8?B?UUx1U256Um1nb2tlNmphZVd4ZUw1bnM0MVpnWW1PK05jRjVKT2liaWN6R2dJ?=
 =?utf-8?B?NFg3M2JOMjh4NzdjczR1d0w0RHoyVDBtTm1odlZ0YjhxMWdrdk1BRTZ3aWZQ?=
 =?utf-8?B?bWhublZ0U3dMak0rdG5pODlMc2s0VE5SclRoanpnZ1dkcFF6ZzdRWFFPbUl5?=
 =?utf-8?B?bFNycnB0aHpiWlRnV08zKy9OSFdySEdIdlpWb3BYUVhBcktRY2VOK0hnVm9o?=
 =?utf-8?B?bHpxZk5CcEdHWnZnN2N1UXRuekNycVpQTWZIV1FIYWtPeTF0Q0h6TytmcHJ1?=
 =?utf-8?B?NUNTOUhyRCt3UDBzV1Y4TEdPUVkxZkxFMFp1R2NnQnJjK1Jiam9jbUJnRW5n?=
 =?utf-8?B?T2NxWm00L1VaVmhwMTA5b0hJT0dFc1ovN0pQU29XZnpEdy9hbVlnZnpZd3JQ?=
 =?utf-8?B?NEI2NDZRa1NBbnlxUmtRZ3ptdHpGbHo2VjdVUE53MUZlU0lkM0ZXQ3RHVXVD?=
 =?utf-8?B?Skd4TzFSOVBzSGM2bDFuNmFyTTk5L0dJU0VhbHh0dlJYV0JVSHg4dG5WWkMr?=
 =?utf-8?B?NXk0MytaRzdzL2wzOGlQeVJJRW5zendNei9NWUZsRjltWFRWN3ZCZ2xsMXA0?=
 =?utf-8?B?TEJ3cTJpNGZxVnFCbFdxaWtBWmpmTGlicStvSXMrSWdRSEM4VFloOGNNenVt?=
 =?utf-8?B?YjJMemQwcWMvNFBKd2hGNUphdmxnS2VraldUKzE3UUhVUU5oYVNrdUY1a0dF?=
 =?utf-8?B?a0NtY2tnZWRIcVRnSEJLMmYyNi90cHphTlBTcUhMb2NFMERZc1FZVG5EcFFO?=
 =?utf-8?B?Q0F2VjJ6OE84UWdYcXc2RUZMbEtTdGVCTUxUbWlFMVY3bDFzRi9hTGRBejUx?=
 =?utf-8?B?NkRzWE5MRlV1TDFDam15bW8zUUl5TEVIYmJyRVFZaVkzblRHV09uWGgySkdz?=
 =?utf-8?B?V2dLV0ZKVnJDVDZLRTIyaEVrM1hRV0Fva3hTRkE2dXZXZk1NTlVjTEhjeHcx?=
 =?utf-8?B?L1ZsK1E2T2E0Mzg0YlE4TFdEcHZxdTZDUVdEMjllYU83ZUFuUHhBOFVrUnFw?=
 =?utf-8?B?N0pEYVRjYVVzbDJmMDhPVll6MXNudDZaWjNyZGRUOSs2eXRDU1Y3UXVuZXZu?=
 =?utf-8?B?bSsyV0FZRGxPYUI4S3c1SitaQUNqWDFkbG01MDJGQlJSK01jdVdPMWc2c3lT?=
 =?utf-8?B?L2ZIYTM3OG1WZFM4UHlnQWd6UEJaQitzMkZ6ZGdrTVJua3Nadk9rb0R0VXVq?=
 =?utf-8?B?MER0RUZFTTRwMDVGUXluUmdaSThSQ2dsa1R2L2dNL1p5ejVQMWZVRy9UeFBp?=
 =?utf-8?B?MzNKbmcyQ0tIT1JmWHZXcGFESjloNHh2T2Y5WXBzYWFtdXZCeC91NzJ1eFZ3?=
 =?utf-8?B?ZFZ0NS9TUno0RzhmMUJrNXJ5YlJ2R3M2NW5FMTN1Q29aa3QvdDRqSjl4T2dT?=
 =?utf-8?B?SWwyOHhxb1kwZjhneGd1T0VUbVk1RzhxT29HT2w4d29Qb0t1dUNPMVkwRjhv?=
 =?utf-8?B?dEQ5dFEvZnJ2R0ExWHlYbnk3MUVVOG91WC83VzhjRitOaDRjcytXZGxmRjFq?=
 =?utf-8?B?UERVUjJYcVpreHRKZjZGR3Z2bzRYN2s1T1MyR0k4d3A2ZWV3RC84ZlRzRkZK?=
 =?utf-8?B?Q0hxaEJHdXY0dkNGYmpVMTFGRm1CWFdHOGQvdjY2OXhXdGEwcVQ0ZEcwZS96?=
 =?utf-8?B?dlZwU1YwOGhDMndxNzU3TUN1VTBZZFFCd2Eza0ZUQ1pNVHpjVFdhcHFUbUp3?=
 =?utf-8?Q?6cbqaDiGR+6qQZXQ=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f987c30-31f1-47e3-053e-08dec863f9e8
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:21:25.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW2UVi3s3KWtbJmw2+y1RRDjnbgmXT+lsbY/a+Qk6B6lV6hwH5uBj4e9/WfMt/6Zs762XeOlFbIrzDZJy3e3+iZ1zDTc9RxAE8Yl8lJAnxo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1985

On 2026-05-23 06:25, Andrew Morton wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: sparc: add _mcount() prototype
> Date: Fri May 22 09:20:26 PM PDT 2026
> 
> sparc64 defconfig told me
> 
> WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.
> Is "_mcount" prototyped in <asm/asm-prototypes.h>?
> 
> so I added it.
> 
> BTW, altering arch/sparc/include/asm/asm-prototypes.h then running `make'
> doesn't compile anything, so there's a missing dependency somewhere?
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/sparc/include/asm/asm-prototypes.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/sparc/include/asm/asm-prototypes.h~sparc-add-_mcount-prototype
> +++ a/arch/sparc/include/asm/asm-prototypes.h
> @@ -25,6 +25,7 @@ void *memcpy(void *dest, const void *src
>  void *memset(void *s, int c, size_t n);
>  typedef int TItype __attribute__((mode(TI)));
>  TItype __multi3(TItype a, TItype b);
> +void _mcount(void);
>  
>  s64 __ashldi3(s64, int);
>  s64 __lshrdi3(s64, int);
> _

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next, minus the BTW comment which is a
separate discussion.

Thanks,
Andreas

