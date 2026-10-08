Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020111.outbound.protection.outlook.com [52.101.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CC23D3CE3;
	Thu,  8 Oct 2026 08:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449233; cv=fail; b=mCuY8d+18VF3RxyPH0zLVcSIngdBCWfU/KuPaaGF96poRIXrnE7jMyB4QSIposTSCUe4X6awhxSgcabeIB8K1wAHTenJP6a57nuZbTWsgveP3NZ5GfBkhZScrvIN3DFkOQ5mcqOCjO/iOcNLW2GoLw14OiT8LPv63wYFScJhCZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449233; c=relaxed/simple;
	bh=09j/SUWqt/Ymo1RPdatO0/cV7AwbkdYDaL6z4n7qWR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QR7YQo8pj2bC8db883XW4G1r1Dp7FDPxXe4auT45mTgfgp854yNAMyrU6MAYXmwFbvtK7C4+YCGuSvwNBiFP8lB0doDodz59waEfZqWnFs5ML3GvcbV0F+320oy2Aevma34WQ/KGFTB1DRH0fr/ZtoxsE3LBxu9q21dBTSBm5QQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=uK5pJLHW; arc=fail smtp.client-ip=52.101.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="uK5pJLHW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGdK4jquMTl6MbGRypwqpxQqKml1mAAlvel6KbZr88T8qKAMCG3uoknKdoQidPG2zSyGCvmwDqk9tEYtebuS6hdrZ7O+Fz902Tq1RJ1w+Ic1aI5yUrjrDvS6Q323pIeea4wGh6Qvzcege7vIPQ18L3ONNGnNeGpNhMLOb9aiYv+rUR/1tPyFT2u+XgK3NPk3DN4evW65HE5QUonqGYLB0LqwdGw1oZGh2jO6CAoctJ2cgckz9FfXr7ETUYYu+CHKrkUGAxfy3c+DQ9X7L6l/FPpP5kmyEsxcFG5f2qJ9RqqS60kQTdTuMog+Fa4IHCM8cqUIOy64lZxm+KPb3LXPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lS5sC5gYfMP9m/TTRoeZC50eHiT7fxkIBClQfPB6WFs=;
 b=nBEV97MjwiejMIuTDg47UNyz3TD2pqGZnjof9X/6qGjtVjxqXZcKEwfKqG60WeQYjoBN4+pPrpYGQt942DRgdiLVDZqz4GHa5S8j/Ch8cuiLtUkJ6H9rC+f4lXoHD/SsxA/J142DbhNrDyOGzlA/vP+HS55Sk7eO/OKG3KRDylW2QxqY5F/h5pc94fs+0wIzSyGFFK9jIdznzVUeyzOVctlHqx7XqRNJhFgfUaJcby/gIZAM4efMwRDGoTYeJASztuuUyMSEuvLKAQ+/FM6C04LFdEAccsMybvmADdmGpEEco5MWQGPTw28GV27CGJMRjxmBAmMTSD6sbKxqbhtHPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lS5sC5gYfMP9m/TTRoeZC50eHiT7fxkIBClQfPB6WFs=;
 b=uK5pJLHW9BTpynHBwzcyO+65zxPulv+JnafQDOOsvX9zHl0qj4S+vPdpBPmGZbMDfmjuyY2SemzsaV0zK6QSMWtVdR2O71OtYdIQTiO66mmHVyuso0r8vxjB0M5euvyEnUsa9O3NvfcTMr/GJgt5Zc6ynSmrpNs5xpfBKC9r4N7KjfC2OVFtx2zt7AYUHEORCevlDsgGmv74zFBjaHCdBvODEsjxbLYuZL1vD6xawGx5kYnZ0AsFIN9bLuAFOVLwBwXq7f3KM8+a6D2rBXRE5nuQHqNsqVQDbN/TIHHTMd++1FumXy/bxL05KN22vHYdOjU2nOIXNXF5RReaPU0x7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB0631.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:14::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 08:47:00 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 08:47:00 +0000
Message-ID: <96053042-bc15-407f-872b-ad99a979eeb4@gaisler.com>
Date: Thu, 8 Oct 2026 10:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] sparc32: replace sp_banks with memblock
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007174128.959307-1-linmag7@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261007174128.959307-1-linmag7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0006.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:30::7) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB0631:EE_
X-MS-Office365-Filtering-Correlation-Id: 926857b6-09c1-4447-80ac-08df2518b777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	t3qw2B/DPrKw6z/QNLIMrv8FMmOs6vZ9niqzwRvExFUAA00JTLci1WsxgYCvAw+0/aErMbURhgMG9S8/6Ya2VV6yvIASWavc8jF86idJM95uggWNHGUCp3JRHDFTGFws9JJ8yVC6oyYDxpfOb+L99Q7y2V1TmGkSByP7jtac1tdxumEysT8G09WxHAjSdgKRQKjZ32ZE2wRbgQDn0Nk/V6pJV62ggrx36aDsiWPJnBO2sjR85z22GHHWLYoF/arPOkY8YeCIGx8qS11S9d2nFdttRRXOTzIxWBnbiv9vzN90WPJ0NSEe/AVSYtjKaOBeZwCQZbnDwgyBDLQ88bzC+cjbv3z6dvnY2IgJzCSURdu+t9uu8xDTaS7cGNlFnDg6MqwNIAx/k5tAX2GGhLxMXeg2t19xD8Ri7AOkgUtxT94DsCeosYp0ifef2HhbbGn5cbSCZkBsGO1hG8hEM7sh1jU5PMjbMpKJxO3/HqtWg5xB5cz2nchFSWqtyKPGMbmE5ukvZqTz3FhxkTACtmfnb85Ke6W+hglyBDfH6Sjw+Jm8jEAPepYjwkM9HupgupyUA0VFWCYhBTgSC2oeh6NSkTLD/T7pYDtwHj/ES+fc984nXvbEx2XJI9gdWHIy3qa6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVhNMStIc2JnOTR5dk8wMFRQeGpFTVRJOG9kL3gzd1pnYzR5OUNBTzdaenZ2?=
 =?utf-8?B?c0YvMW5OOG1PNUpBckNRbXptYlRTMHJMOVZ6bVQydlNRNWJQMTRqU28vNllB?=
 =?utf-8?B?WStwTk1va3V5MWtSZ0Z0dFZCZ3NRMk9rUDhYOTJwM1QxMmR2VmxSWVRFQ2tR?=
 =?utf-8?B?Tm1EM00xV1d4ekJsRk14TWlFK1VORmQ4Nzc2cXhza2tnejJZY3dyZ3FEUDg0?=
 =?utf-8?B?RU1iSllVeHd2QW9iUzZ1RjV6S2hiY1BLVlRhUTBNVlIxWkZRb2lYY25mbnR6?=
 =?utf-8?B?Vkp2di9TUGJMMTF5NHNEMTg5ZFdCYlp2MnQwTytxb1I3b1hraGhmTHRLZ0or?=
 =?utf-8?B?cHN1V2M5N1ZLNzA3d2QvclhuRmJVVVdUeTBjUHQzTGt4aFdXOTNNQlBkZjhM?=
 =?utf-8?B?Ym5tYmdHbjEyRXh4ejF2cE5BMUREdDhuQ01UR3kvYjg1ck9rQ3pDL24wTnVF?=
 =?utf-8?B?aTlVdGFpb1pCdGJWa0RHZU93c29QdGRRSnE3Z3lFdjh3Tm13Z2tlOTlENWRh?=
 =?utf-8?B?UC9wbzJrUEpxV1FSOWs1UmtYOEdUY3FycndMUExVd09VT2pucFJ5K2xOUDdH?=
 =?utf-8?B?cmwzV3piYXlkaTJ1ZENhcytMbEhpNXo1NzlwNHFFV0pQckoxNGlwUjJnaWRS?=
 =?utf-8?B?aldPUERkVWhBUXZWMWJsbUpvaDczcVFXckFLcllZSjgrQU5GYThab0R4N0Rl?=
 =?utf-8?B?TnRLZzMySnhlWXZMcXJuK2o3SUVEeStyaUhSekpsbjVPWGR4aVZ2RHdPbXFq?=
 =?utf-8?B?MG5EZFBSK1BTMG9GeTg4R2F2VWc5bDVSTzY4UnE3M3FuRXllbUw4RU93Mzdm?=
 =?utf-8?B?NW1OeDk3TTJoZVRDNktkR3lNclVLaGRrUExjNW9YU3ZDS0orRVoyeXFKaUJL?=
 =?utf-8?B?Y3cyaWtXWFVHUW1ZT3VPUk1RS3FGWEtDSmg0dU1rODNjd1UvTHJTMW9hRlMr?=
 =?utf-8?B?akY4VFBsWjFIWTZMaFNVTmF4elgwaUZYenAzYTVPcllvbDFtTks1Vjd2YjE2?=
 =?utf-8?B?elpHSnpUV0hCRExSV01lb2UyR2RLU1htL0g0cnRxVGU0R01GVHdEVUx3Z2d6?=
 =?utf-8?B?ZXpzZUdtM3MvdnhBNi9Ram1BWTFaS1BsSFBLazBuZzYxdjVEUTFnSFRJcTFh?=
 =?utf-8?B?VXBLM1FXSU92L0dTY2JCK0hBdEVaMlVVMkl3MGVwam9YdUNsVE9uZ2psRkli?=
 =?utf-8?B?NUpzWkR2djI1VFZZdTlHdVRsVHpDOUtQOHZpb0xNbDg4ek5ZdHV2c20yYWJO?=
 =?utf-8?B?QWVENDd0cU5HTDVsczBFUWNZSW9pOS93Z1ZNb0oxaURPNjJ0a0xKdkw0azhS?=
 =?utf-8?B?elo5ejNibmMzSWZFSnlEWjFjZzRKN01ud2lZNXplektOZVQ1NUVVbkltVjly?=
 =?utf-8?B?dUZLVlZldllxL04zcEd0TndrZjQrOWJ5VW5tRGpsb21wSWFDOUtNVEJVQnpF?=
 =?utf-8?B?Z1UwMVV1bGZEazNxbzIyOWowOWpHWmhUSmZzR1NwUzJkeC9kTTFOQTVhcnIx?=
 =?utf-8?B?U3owdUs3ZnV3emJ3Z2VSTmt0WU9mYzFTUWRBdXZQMXd0MjBFbkxRcW1LakhY?=
 =?utf-8?B?QnNJNzVSZEZ4YjRtd1NlU2pFdE5LQ1QzS0xxRndQcHVBa1hWUE1rd1JTUlkw?=
 =?utf-8?B?ZzFUWGFxUXpXYkJYK212Wll2UC9HNmJmdnRPTUJXcW9mejhxRytMcGx1WlBB?=
 =?utf-8?B?VlVUNWxBeUVhR2RCd3lteE1Wd2tydDlIRXlhTldsaCs4V09rVnFsTTQzbWw4?=
 =?utf-8?B?YlY5N2RINTk3UE5DcmFJUk9HNyt3MGprSGdpNWRYMTNjZytzZ0dRSUtNM1Ez?=
 =?utf-8?B?bkJmNWtGNnFDY1pzYU9ockI0YlVlUGlCdWVPSXovWWJSb2Y3UUtNaVJTYlFW?=
 =?utf-8?B?ZjBCY04rSktQb3NYRVpZWHhJTFp4TEtLN0JYQTFYYytkZ2tidVVMSkxpWWdj?=
 =?utf-8?B?bHhrdEU1TkNicFRKNzdpb1daU29mbzJ1SlBnY29ObXU1YzA1enhZNldPT0o3?=
 =?utf-8?B?Z2xxR25MZGxFcHl4cTVYRDQyVU1JMGdUQzIxTHdFM1JacjJpdDJlMGRoejN3?=
 =?utf-8?B?bG02S0hsU0VhUGVjV25QeGNtRjlGQ0xzTVRtS2djZ2pwSVRZUURDS2dNbEln?=
 =?utf-8?B?YkxFdElVbkgrcHdhRTlCdXJ1SGNrajJacUpYSmk0WHErWE0wSWcrT2xiQmlp?=
 =?utf-8?B?N1N6WUxYa01ncWpDb2doU0VJeHp4UmxWbFVpangxUi9iOHJvYzFrdFhTYzV0?=
 =?utf-8?B?SXh0YVA5QnJQdTljSkRCdkFNOFE1RDlvSVYvdXM0a3hpaDVuM2pOd3hjck9C?=
 =?utf-8?B?VXBFcnN1MlpLZVFjQ2hWV1gvV2VzYk5ZbEMrWlJyTWZkQlB5bS9Mbi83ajlq?=
 =?utf-8?Q?mYXW18fMprNkugZI=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 926857b6-09c1-4447-80ac-08df2518b777
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 08:46:59.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PD98MN7Ojg52A92PRrYHdU04fshTfKiFN9rKIw1M6y+QcggnChn+o7sd51beHzzFp28t8xTGT0ItX9+Cqob+3NdEQVaTv0uTdZLvclC354=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB0631

On 2026-10-07 19:41, Magnus Lindholm wrote:
> Replace the sparc32-private sp_banks memory description with memblock.
> 
> The first two patches convert the SRMMU consumers that already run after
> bootmem_init() has populated memblock. The third patch moves memblock
> population to prom_meminit() and applies the mem= limit there. Patch 4
> removes an unused address bitmap before patch 5 moves the early memory
> setup into setup_32.c. Patch 6 removes the now-unused sp_banks array.
> 
> This work is based on an earlier eight-patch series by Sam Ravnborg.
> Patch 2 directly carries over Sam's memblock sizing conversion. The series
> has otherwise been substantially reorganized and reworked for the current
> kernel. It retains the sparc32 mem= command-line option by using
> memblock_enforce_memory_limit() and uses memblock's exclusive range-end
> semantics throughout.
> 
> The series applies on top of Andreas Larsson's for-next branch at
> 22a749706e3b (sparc64: decide the TSB huge-page window fixup before the
> bank switch), which includes the sparc32 relocation and Viking fixes.
> setup_memory() preserves the sun4m/sun4d PAGE_OFFSET probe and diagnostics
> from that branch, removing RAM below the mapped physical address using
> memblock instead of trimming sp_banks.
> 
> Link: https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t
> 
> The v1 series was boot tested on a Sun SPARCstation 20 with dual
> SuperSPARC-II CPUs (SM71).
> The v2 series was boot tested on a Sun SPARCstation 20 with dual
> ROSS HyperSPARC (RT626) CPUs.
> The v3 series was cross-compiled with the SPARCstation 20 and LEON
> configurations as well as boot tested on a Sun SPARCstation 20
> with dual ROSS HyperSPARC (RT626) CPUs.
> The v4 series was cross-compiled with the SPARCstation 20 SMP configuration
> and a sparc32_defconfig-derived LEON configuration, both with HIGHMEM
> enabled. Boot tested on a SPARCstation 20 SMP (ROSS).
> The v5 series was cross-compiled with the SPARCstation 20 SMP and LEON
> configurations, both with HIGHMEM enabled. Boot tested on a SPARCstation 20
> SMP (ROSS).
> 
> Changes in v5:
> - Rebase onto Andreas Larsson's for-next branch, resolving the patch 5
>   conflict and preserving the updated phys_base handling, including the
>   sun4m/sun4d probe restriction and diagnostics, from the relocation fixes.
> - Retain Sam's Reviewed-by tags on all six patches.
> 
> Changes in v4:
> - Use max_pfn in LEON's _pfn_valid() check, preserving the bounds of
>   last_valid_pfn instead of restricting the check to lowmem, as requested
>   by Andreas Larsson.
> - Correct the description: LEON systems can use highmem.
> - Carry Sam's Reviewed-by tag on patch 5; all six patches now retain his
>   review tags.
> - Rebase onto Linux 7.3-rc1 plus the three prerequisite patches; adjust
>   patch 6's context without changing its code changes.
> 
> Changes in v3:
> - Add Sam's Reviewed-by tag to patch 4.
> - Initialize max_pfn in patch 5 and use it as the highmem zone limit.
> - Use PHYS_PFN() instead of open-coded PAGE_SHIFT conversions in patch 5.
> - Remove the obsolete highstart_pfn and highend_pfn declarations.
> - Use the generic PFN limit declarations from linux/memblock.h.
> - Document removal of the duplicate private HIGHMEM summary.
> 
> Changes in v2:
> - Add Sam's Reviewed-by tags to patches 1-3 and 6. Patch 6 is the
>   unchanged source change from patch 5 in v1, renumbered by the new patch.
> - Drop the unused sparc_valid_addr_bitmap in a preparation patch.
> - Use for_each_mem_pfn_range() and the standard max_low_pfn variable in
>   the early memory setup. The change to LEON's PFN check made in v2 is
>   corrected in v4 to preserve its original bounds.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Link: https://lore.kernel.org/r/20260817153237.GA702187@ravnborg.org
> Link: https://lore.kernel.org/r/20260901214611.60560-1-linmag7@gmail.com
> 
> Magnus Lindholm (6):
>   sparc32: use memblock when mapping the kernel
>   sparc32: use memblock to find available system memory
>   sparc32: populate memblock from the PROM memory map
>   sparc32: drop unused valid address bitmap
>   sparc32: move early memory setup to setup_arch
>   sparc32: drop sp_banks
> 
>  arch/sparc/include/asm/highmem.h    |   3 -
>  arch/sparc/include/asm/leon.h       |   2 +-
>  arch/sparc/include/asm/page_32.h    |  16 ---
>  arch/sparc/include/asm/pgtable_32.h |   3 +-
>  arch/sparc/include/asm/pgtsrmmu.h   |   1 -
>  arch/sparc/kernel/setup_32.c        | 117 ++++++++++---------
>  arch/sparc/mm/init_32.c             | 167 +---------------------------
>  arch/sparc/mm/leon_mm.c             |   1 +
>  arch/sparc/mm/srmmu.c               |  69 ++++--------
>  arch/sparc/prom/memory.c            |  51 ++-------
>  10 files changed, 103 insertions(+), 327 deletions(-)
> 
> 
> base-commit: 22a749706e3b0f857d5169a61f2f86a160eb9abd

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

