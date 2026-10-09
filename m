Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022074.outbound.protection.outlook.com [52.101.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E83D9DDB;
	Fri,  9 Oct 2026 14:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556820; cv=fail; b=GH4wM16ICmsbkGavkiCka4kfCdp5Zou82CDcCLZKavDhdGOL6PqP1WJLGE4oZqsZCdMx1JtWzouOYKR+dd1sdLAfgi8kMsSq9xy/zrokkt8chVisz7s9VZbZikTPhXPrbMBKbUTQHhAQbVW5DSCTTAdry+chrTPXWqpxHKVtWgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556820; c=relaxed/simple;
	bh=tPyNJG9cOgKuxDLjQLsDk5jbn80+MZLsf8s6XVOuUF8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lDeE0mDzuixElc2wNb+YoNGDOgjvgjSWizeCKpkr229G4W/J34l5qO8iLo9Ofov9tUjiufvg9mCWz82V/PheMuZ+SjAHlgEG4y02EKJYzn9LBTM2lCv495jaZIkfj+c/G4kqVGSas6SBuV2+1w7dOuy4o5k8tGPLxWTYC7j9PLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=T4c/FzAx; arc=fail smtp.client-ip=52.101.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="T4c/FzAx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CarlZ0vzhS9vWCQadFxbeZOHwNJS0LkPROLGVRhodGaO2nlo9vBaFBt8/NWtenNSqrIH7ynJX8BNE2c2MhDh4tyBvEySA3AfJBYrMAQOcIy2ZSypeims10pc3O5nIjKLjEt1aSHfpLKL9mV5NqoyocGmtevEhNNhuOUuJanUWk1bIDnSbcB2C2+JJvNhuW0x/3kcIUsngUQOBtbc9tqGEPsdI7ESIVVoWXbXFjwg/7p3RR/IXxiYjNiFBsTQa1uh5CHC2JaCdjhxxoI8UTQisoV8onwp7LVPra1B/B+yoV31ytmpptGJh/od2kdg7u+B8QQiX3STwgvtOgCPyfnfHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJv5AydvaU/IlXWrfc8poOhfcdgnTakSy6Z7vZU/d+0=;
 b=VH4Y5dofY3TNcQ/dmUwqIiTmtPV6sYiceBEgkCnfvUTB9bp54YWkfI4EphlYfs8UIQmu1yl8PoXrb/ohoagsPENJK/ZBj98eJqc/ZXa9hh8e5kfVrYwfKe2vvw8/755aEUi47iPMUG6A0L+sY1hkZukZNnKvJltoNrJ34FPiEJvIj1fm9e1li3nii38msu+lpGm3GpQC2R1RSGknWgwr/ZCv+U0mr2I5rV1pe8uxumAjnqZLBI369zaCZka0YtHXEj8KzAExHF3t5LmJCbavxyU3GamW+8HLuCHm3SFgvuOWKN79sO6o7KeYBmF/3T9Bn4MtK2lO5nKt6p4BeLO/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJv5AydvaU/IlXWrfc8poOhfcdgnTakSy6Z7vZU/d+0=;
 b=T4c/FzAxrPL0OfPM8RaRvd79vEqPOOeW59Z8JlO6GLkzUj7USwuXlmS8dV/u3boDNBZ1CFOCd+TY7ZH0Z7WiDDBG8pzapIsXWObyCX968b6ngg12aciGPpyWIfBq8Ktk2Z6p4VYX+pi91GcvPRxCmrELtVIwwF0ZBZwa82P/F7LPSmalfC/ACryLh+U5+evRhePDkoAJ+AkolReawv8vyngqx0zyxAOZbjQKrfjOT0odOfeKZYP96afur41hboqDKLmAowi8poe49xDGlDAy5Q49C71OWr8fYAljUxB+7AnUrVDTJ3+e3A24KhDPaypIK3wdT5SKM4krQAayhBY3xA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB1148.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:18f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:40:13 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 14:40:13 +0000
Message-ID: <d0524359-d497-4396-9fa6-aacc6ce4520f@gaisler.com>
Date: Fri, 9 Oct 2026 16:40:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] sparc32: remove redundant memset in arch_mm_preinit()
To: Sang-Heon Jeon <ekffu200098@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260827145437.490605-1-ekffu200098@gmail.com>
 <20260827145437.490605-2-ekffu200098@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260827145437.490605-2-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DDA2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6c9) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB1148:EE_
X-MS-Office365-Filtering-Correlation-Id: e4261aff-b4de-4fc6-9e7a-08df261339fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vua1vCH0pn95sghi2s6WyxCUgCtbcIOOOlc/e4+DwvvEVFEjUTGDjercSHCzkSxzyAupDdnIC7uon0p36AUg/ptZkSrqmEAlacDA4ie02tAqgw+8SKEjhbFiQ4dyl57b56kA3OCdqsl5/SxxnhVRNrgtNerJu6PaLodq6eRrMVxUjCY30eJ/S6UhrtwVob6KoZ7vuC41uKkQC+pAawAdJkr7WiKVwM8JUepalg0cDcD5JIBld5b2zRKcMmt6Rqn6ZCRGG3HcZ0ljxywkeKY4FS22o8cXSZU6WGwUym4OlClL7E/itDfXVVG/RzT9fIo2HD4/HWxQ8TIi1zga/9+aZQkKzMjaz5p2mLEdaEm9M22crfBsIvavQXu7nkfPd/srE7bIAyyp9a07lf1E5exgl1vfiNq6VLDqKkWBNEGT9pLTHmmeCl/VyrDXSOaH/q5Mo9CFzsdLqXWBpva71hR8k+hmoqQ2GUJNwRNbo1+HtMjS3pmpAgKxYEY5twD4+eWQmz0aWqdApCVunXRvEGyW/PfUj8BK4YQSrZkilto68I8yHBUxyeLJW1kDiGKSgkczyn6VHfWmx/LUh3tZ2x8oEblcNpopp5BjM3TN5XI5y375FV0Hw2NbfCQnkzWpvJplw6CrrvuVBLwAbr3qB0V15/sdSq4lUIGr42aBFKlxQ5k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0psYkZ6ZWtQMHRKT3B0MkgxcDFqdmtpMGQvcnpoZkNKRE9GS01hWEhmNEFM?=
 =?utf-8?B?bytzYkhTSUZpV05yQ0Zlb2xmNmdidWt6emozQmRZUkNVZjBNK2hsNWxRbmVy?=
 =?utf-8?B?Tkk4NkdyOGhWM1dZbXI2ZEVmNW9aV3F0K0trZXpuMFlTbk1DYllSSjl2c2J1?=
 =?utf-8?B?QjJMN2JXVEUzcGpMOU5uTk0zWkU3aUxKTnY2VzlWbHBZRmpPMHBja1Z3Njkr?=
 =?utf-8?B?WHd6eXdZVVg5a0pyYmdzYWszd3gxdVNIbTVBU0hWeUNCbjA3YnlUVnZNWnJG?=
 =?utf-8?B?QzRxZmlhK0E1TU5QNSt0NVBpRzBoUjk3ZEZtMDFaNi9VYWxXdW5hNytDc3I0?=
 =?utf-8?B?V25tSnJsWkdjL24zdVlkZG90OVFla3BzY2VIZk1taTBhc2FCOW5ZTksrV3hM?=
 =?utf-8?B?dlJIN3hqNUdnUFJ4WFFxb0N3VjIwNW5FUG5nRlVPR01UbHNqVGo4c1BsQWxp?=
 =?utf-8?B?MlJxQjdmTDFQQTJNeUozT0JDYUsvZXhBVDZmVGdMUWRSaUsxa1pEQyt3VXNo?=
 =?utf-8?B?dlhkeWdRVjFpd3I4bGhIa0FTaGVOS2x4ZE51TFRrdWZlbUQxdHVKei9GTVpq?=
 =?utf-8?B?NC80ZUNjMnBPNVBkZnhWT2RWZUtRckpQS1pxWjdmYWNOUEpxTWtWQjJvU0ZZ?=
 =?utf-8?B?RS9MRnBuNXdUcU9NM3FNWDJweS9UOEY3QUZXNTlGbkVMUWUyVlZyTTlIT3lv?=
 =?utf-8?B?L3BZWHRIcmgydFJ1a0NmWjVFbjAzRlZxSlhsRytaaWNaVGlHdlVuSFJTR0hy?=
 =?utf-8?B?RWxqNDE2VHduTGFEMEVGR2J5ZTV5QWtXdGlYbk1BY2F1ZVVQcGpVcW9UbVVB?=
 =?utf-8?B?UkkyUHdzbmlPVjZiVm0vV3dxeWV1Y2Q0eHN5b0JhRlZuRVJXMTZ3WkJLLzJZ?=
 =?utf-8?B?T21XNlptQTk1RVAwbElMQWV3TW9UV3F1R0E5QldBbDVmZW5Bc1NVdVUrY1Ni?=
 =?utf-8?B?eEo4RWZUNDVFY0NTSzVWVzNSWTEzSzlHUmdJdjBvMGlQYW9KWUpSSFJrbG00?=
 =?utf-8?B?dWk1d1A2a2RGS2I4UmgzNkpIbThMVGVpUU52N0lmaFF5emw5VmFnZXJCUTV4?=
 =?utf-8?B?bXhwL05wVFdXTjNCN1V2K0pKcTM1TEUyalMyckVMMmd4dHoyRkNCc2pIbTRa?=
 =?utf-8?B?SzhwOTV6ZGtNN3pqSHhDanJBclE2WFhQV2QzN1JYeWJUSkFGMTNKLzEzVFBq?=
 =?utf-8?B?bU1iK2ZUN3BLWXJBdGtRSFdOYU9QY1V2R0VpY1dwdC9lMzZzeFh4VXVTNW1j?=
 =?utf-8?B?UWJIVmNiUHpFYUZqeHZxNDJSRGhseUxVYTlCcjRUS1dRZ3prWU4ySXdLWEJl?=
 =?utf-8?B?YVRNUG9YdmRncnBUWlRSdG1LdGx1NnlYVjliOEw0N0dsZzVzUHo0VExsRjhw?=
 =?utf-8?B?emdnQ2d3a3NyUmZmK1c2NG9UckpsdXdFTVp1UFhHeDZEdnVLNUJBN0I2RnNo?=
 =?utf-8?B?NjVucExMbjdqZ3F2MG1hVk1JVXB5Q2JZWmRtMWZzdmZKOW5XT1g1ZnZvbnJV?=
 =?utf-8?B?N3VMWmJGY2s5MmhBUTMrSEVWandxWUNObnkxVTJOc0JuT3dLQTJsRzNHUmdD?=
 =?utf-8?B?MitHTXpsbnlsaGFKamorMWZld01OaW51dDFQeXpUa1I2a2owbnN3VkpLRVpT?=
 =?utf-8?B?dFhjUkpJOFRWQlAxcGVhRVV0R2lrTFZINEFNTjZFTXAxaVpqU1dPZldDQjUz?=
 =?utf-8?B?VXo0aGpNcHY3YXpuWWpILzJlUnF4N09PZy9yWHNXR3I0TnBlcUErSjR4UEZ4?=
 =?utf-8?B?b2RwYk1Uc1E4amVPNWJuWHFmV2dJemtjZDVMYUx2ZW42TnA0OCtsY2YvZkJw?=
 =?utf-8?B?Rzdhd0VoakU3SEc0ZnlYQkpwd3I3LzJiVVlQSDBPSDZmNUxVZW0zNXNQb0Fp?=
 =?utf-8?B?OTdQa0hWY1Y1RlpTQ3Axak8yTVZzQ3dvYUJjbVl5QkZUNEVCalhyNFdBZ040?=
 =?utf-8?B?VkZ0dzNQYnVJaEZiQTJlNFhTbXFHVUVqQVYxdWl6THdhdmsvMTAvUSsrOThY?=
 =?utf-8?B?aFpMa25tdklMRFhUbC9pWllGNmtMTVNqZFdxVzNyM1ZDek8yeno0QUxYNS9N?=
 =?utf-8?B?RXdWSEJrUGRZYTE5RStiQS9WN0Q1ZnQ5VUFwWXptSjQrYkY2ZTZsWnErWm1i?=
 =?utf-8?B?TjZQQk9QYnV6Y2lheEk4MW5VemlWa0tkKytpTEhtcUJsMUNpdHdnK0FHU0Ra?=
 =?utf-8?B?SWlmQlhTZncwNEJIR2Zka25SZGZkdjJmUWdGcEl1bHRVUFhOZ1AycmFtT2lh?=
 =?utf-8?B?ejliblBzWkx0djhVTzJzNURXMlNXNUVGOTRObUVrSFhKYUdKRU8wZGZnK2Rn?=
 =?utf-8?B?dFdMNlZBcmI3SWpJYU9HaExQVHZlYVdvVE5VeDFFSnUxenRFSzZXNFFSb1Rh?=
 =?utf-8?Q?jF4vVbMrjKvzSa/g=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4261aff-b4de-4fc6-9e7a-08df261339fe
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:40:13.0080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/sxc9CySWagAPPAhbc+4g0VwBrmUp1JUITwyRp6rSY1PeqS7tMQhlDYhJgMKvBWku03qimEm9EfnuRc2bVa0uMf7WEo1A3G1ASINTO0+UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1148

On 2026-08-27 16:54, Sang-Heon Jeon wrote:
> memblock_alloc() returns zeroed memory, so the memset after the
> allocation is redundant.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  arch/sparc/mm/init_32.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index e0e66f91ceeb..b4f31d41d665 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -255,7 +255,6 @@ void __init arch_mm_preinit(void)
>  		prom_printf("mem_init: Cannot alloc valid_addr_bitmap.\n");
>  		prom_halt();
>  	}
> -	memset(sparc_valid_addr_bitmap, 0, i << 2);
>  
>  	taint_real_pages();
>  }

No need for this anymore as this code is gone on my for-next thanks to
commit 91c897e01883 ("sparc32: drop unused valid address bitmap").

Cheers,
Andreas

