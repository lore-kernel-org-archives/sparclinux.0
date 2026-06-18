Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020081.outbound.protection.outlook.com [52.101.75.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D421F30BB;
	Thu, 18 Jun 2026 05:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781761992; cv=fail; b=OoAt+Ku8e28QhBQgTHhRLO24E9TMVNQcs7D4Hd/YzNAxLv1PZ+CReASIq4YkeceLq9ysEUGZS70HbLsrqm0rhjJvFLyAZqvHGdB5clOZlJ04AD1aTYN5EMiW1q4haCfLGaKptBmM+Sm7dsz7etzSENSuZuM9aNVqsUwNRNC8csg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781761992; c=relaxed/simple;
	bh=YRgYwQFF/+TmaTB5QUEw4ckivpDhzWDdkqQ5Ic+SUXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FVtVpGmEc42gLiTt6ONVYWe27Z7uJlHDf0sxZHvU1EdM1U9A9QLrNpwPPIt31d/POVY+8hY76/75ia2jtq71uL8DWFhtzEi4Ga6PCqGVdQ5ZiqP/i3hmMxLTFWjBVtN05BtDOlbOi1lc5OW+XPgGVuTgOssutcugmcIh6au4YD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=VgLyQyQi; arc=fail smtp.client-ip=52.101.75.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="VgLyQyQi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uva+FmGUkGSnEeZTvKIn/QjZBnCnpcWiMSOVkqpJ7ODiFnKONAD+J4ieqnSw+NXjOd9TyezdYk98JZnxr+eR5SVF9XrOsEhneU5xE6ZtIFDsrW2DH00LWgQ3Kn2IwQLgg6a0gO3VzCdzdVE1RNn1Xpa/iZJVp5QeTrqoiojMn+arzxu1CJy6/sMkgdj7tS+KfuWmLTAF9yKzxBMHSwJJW830HCi5bVmcoggmmHpr3tVN0ibHBDXgtBVoSo55yiNgnAs/uHLfd0WRdEeyoU5wyGqK+H33zuweDb4Pe6WliUwwts55fXGIg+wCtDT0rBm1hXZ9DKkGe9jJ9O6k2cFoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lnBDNH/xxIRicVJO2jx3URmKg1AbvQFoMohQvwQrVYo=;
 b=kcQ7mWTFVd1ziHzuHK/qAeqqFayHM3+4OAFMZWiFKLsCBLf59EcUUuQEb8U3qH5pp36eclTijpiYo6e4eT7vXvoAekWNrfJAmqVDYyaSNp110HDQ5m9GvXoqh1McSLzMwX+deF3JF+rrGWYkeVyjTVichh7Zk3pukTRhR4hH0Pdew4ELGiKjYXoZOckPEMQ2+gqLfnmooTTZb6NVNGk9oZgz1AGMy+hEdsvJbRFRyYeuEFuEG+SKQN3NvgczuGH5IDsQViy2h4+t3uyEhozZD7MGORGVyfj6drEfmUrVLfHhMWwUc+9NQRfJM+MvzzPMZGZVur1QeKsTOpmI5zUOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnBDNH/xxIRicVJO2jx3URmKg1AbvQFoMohQvwQrVYo=;
 b=VgLyQyQiQ011rb5Qt9x41VAwWFt+AM3oHtamOfHjsrRYphRtQZ0Dj8CD9yYxwJSVWlNUff19aN3RdHhwtwMEO+p6xuJo74UwKWuWi+TwriZup+7sHYDzKh8f2+39z9Y7mltS8K6JKT3pcAxrYd//3YhBNl6hjHD4pa1CHtGluPfKhqkNlfCMbQaKPVrGgGzkcrP4FUGf16q9DwhLPcJjrpsT3ItRCWGUUmJcOJWA1dhj0GZcjKARir+sfRhQp+jWQJG5laJ3SCPOmoTI/R9LUUpXKBR5DI0wUYr/VN7Mao1cUidxDMAm8SVk3e5cVGHd1NHD+CHYGX/7NwZDiCLSCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVZP280MB1657.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:234::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.14; Thu, 18 Jun
 2026 05:53:03 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 05:53:03 +0000
Message-ID: <d634e2f2-daf0-4328-bf16-7f5bff6fe851@gaisler.com>
Date: Thu, 18 Jun 2026 07:53:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
To: David Laight <david.laight.linux@gmail.com>,
 Andreas Larsson <andreas.larsson@gaisler.com>
Cc: Tony Rodriguez <unixpro1970@gmail.com>, davem@davemloft.net,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, thuth@redhat.com,
 regressions@lists.linux.dev, glaubitz@physik.fu-berlin.de
References: <20260519075809.8993-1-unixpro1970@gmail.com>
 <20260519075809.8993-2-unixpro1970@gmail.com>
 <03111ac5-0055-425f-a7f2-54d4f2bb4988@gaisler.com>
 <20260616205851.428ca70c@pumpkin>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260616205851.428ca70c@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVZP280MB1657:EE_
X-MS-Office365-Filtering-Correlation-Id: c58da915-7d3a-4420-6ec0-08deccfddc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eICLzA+DxrkUJ20y4t/IJZ5uQ1Bo87WHhiGlrYVxCNl2zZZsw7egleDMyuc3ZYAslCCFQkkkEyJZ0XcEZYWXXmFaHPLS36MB1Yc8oNOKNZxMGbw4E6YEFv3j7p1ibFhwKbilpXkVx1Bqh+S+J+vG9G9E5wRkqVUmwIBvvio6aUgdQuWAgf3uIq82Nd+1aGdv3b8aOkRJ+4XXASWvxWSVUNaXfaAD+2BlQHT/K3aDQrnOGCHtnOe1l79bA8S4PMSate8zMYFllvdJeD/ffS1L1sfM73GQ3a7J4wD6y50lS79Jm7htIPh5mgeptkPFVhN3kWFaCoFRYM7ZwFP8HonpgO6IaLPuvOkh+dq4GBzCGRh5y2o13dzgtk60TPBB46sc52zG+4mwsAXvckM03DUg3PCFYCEEVXlO5ZtaUDpQruQfJB6rX0RDEAcs9AUazayWtTuArpjtxWImo+/DffwhrHwpuIlPAIQR0ZvptqVRjVD4ibPp46x/J6PcL0d1U6kbJoYznWreHy7pyRPOSDbRA54MW5rTgeaGEwnFt8cMII2fjUqkNzpDBNgx8yGWlHzcFav2v3yDwcA33t5JeoA6DwbkqtahEk2oxPjTXNpJE3zJNazkW/85PigklLlPUC8uNRDzvstBQp+MjFBSjSfWC0C5HoGqtgEDiMS9EIPH3pLA55dwuz+G20ZHdS7h/WrN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUdrN3NJYW9ITWdsQnBXaVRwWFJud0YrOWt0Sk9jM21nclIrTXU3aFBQNG9h?=
 =?utf-8?B?WmRGNUswOU94dGlOZmxyaEdqY0thS21GUElrMGFpV3kvbkNLUkpXSjZMRklI?=
 =?utf-8?B?MEZ6b1VGcCtld1R3MDhLUEUwcFozVDJRMzY5RVkyVlRiQi9pQTArWGZNa0VE?=
 =?utf-8?B?dTB4VE50R1BQem5mWWo1bk9tcHNSYVlmcm1zeUNmQm1KdkJXaTF1WEVLZFp6?=
 =?utf-8?B?WVBUQm9RL1E1bG0reHlDYlJlVEZLTGFpL1FhL0haRnptdDlrUHQ5d2FHbWha?=
 =?utf-8?B?NXcrMzNvd0wwYUpndG94MzZNYnBPVVFBMWJ3V0xlTEplOEMxL2wrbHFMVlFR?=
 =?utf-8?B?ZElMYWpWazBQUnFWSHV1dUpiNWdHSUZBM2FMU1JrdGVmTHYvelVpWG9XZG5v?=
 =?utf-8?B?dGkvQnJLcjdSd3JxcTR4MU4wdEhvc2RmdXVvSUgyakNjNEM2b1JCaGdqTFlP?=
 =?utf-8?B?OGhsMVNzQ3BiRnZHSDArV0RVVTFWRkdpeXJKckJCNFYwYUJhVXo3cWMvNmho?=
 =?utf-8?B?QjB2TDZlNTRBdTlCN1lWYk80NTMxUHliaWNPVnBWVE5iamZaeVh1ZE44SE1r?=
 =?utf-8?B?NjZMWFU3NjhWQUgyU0tKdGRkcWRjdjVZYnJwUVhLcEFHZ0g3Q3BucHIrYmJw?=
 =?utf-8?B?NEQyTDR4UUVRbEpaVGM2WWZ0aEdQWHBuemFtUXVrZ3NLZTl6NzJQN0NBa2E1?=
 =?utf-8?B?UXNJc0NETGloU3lBazRWL01uN0k2Z1VjNCtQWXNIOGVnck1UMW1vVzhHaEVT?=
 =?utf-8?B?WnY4ZHh1SE0zV3VUaDAyU3lrWTVGZFRxNEswdjMxS2RYN1Z1b29rSGt2a2kz?=
 =?utf-8?B?M1VNbmhDUHZYcWtIaXkrWkRucXY4Z1UyWmtNMHB3M1V1b0lXNkJVQWtDUWpP?=
 =?utf-8?B?QUFtcHVkZ0wvQVVmWHdjdVQ5cGJWNUFBMGd4UEo1SkJscVVLaU1GZmM3VTFS?=
 =?utf-8?B?dUd2ajFUY0NDL3VwMG1MWXcwQmJGUnNaQXQwSm9vaTI0QjUxUjFHblVKaUh3?=
 =?utf-8?B?cjdDUlFiVUgyUHBJL1l5eTBxcWRlbFo1KzhMUzBBNXhmNU83MlFYeEpEcW9D?=
 =?utf-8?B?bnpOaE8vTGtCYW5PSzh3R0tCaHRsNkF5NUdDbGZLSXMrUHN4M0dsUm5hL3p0?=
 =?utf-8?B?eDJGMml0U0RkU0RkNzBQeVhmOUdkbzBERm5zVUFLdHR0Q0dEZHVvbmFjMU1J?=
 =?utf-8?B?NDlMK2RyaUR1TWU2UW1KSy80TS9sSVpUVDNPOWV2RnAyRUM5TFQ3SFFWMzdJ?=
 =?utf-8?B?MWszUllZS0V2MlRsOVBNd2NJbHE1K2ExWnhaTlRwVmlkM3ROeVBMWUFjVEhW?=
 =?utf-8?B?UzVWRFFzbHphclIyaVlBU1o5RzJ2eUVlQXZHQ3Y0VTFDd0E2bVVRMG1EQW5s?=
 =?utf-8?B?ZTlQV0pQL2psWFordHdDaTBFeVIyVFhUQ0hhalYzbVdYQ05tNGhZNXpLOEZv?=
 =?utf-8?B?T25iaStodkl0YUlDYnduNWtQcUQ3bWlnUFEvbW5tdUNWTTVtYVZET244c3Fa?=
 =?utf-8?B?T3BCZTZmZ2k4SkdhVTI1RkRlZjJvdFBRNngxajBIZ1E2L0R2dmNOWWludEdK?=
 =?utf-8?B?YllLRlFWQlduVHY5dW5pSTh6RHJGL3BMRE5zcGd2Q0RTcXVGOUVRQXhaMzBX?=
 =?utf-8?B?cm1xeG0ra0ZadDRJdnBlZjIvbWlqOEUzaUxZUWN1dWxJQVZJNHc1OG40RWR0?=
 =?utf-8?B?UDRUenJsMmRWWXRXMTZMdi9Ld21paXBHOXJYcXUyM2p6RkZ4RWkrREZ3cVZF?=
 =?utf-8?B?c2s1b2VKNTQ3dzhaMjBpeURmNXd1OFlrVHJFcW5xWDVFSGxRZ0w0RGdhMWNr?=
 =?utf-8?B?bHF1ZGxlV3YyUlhsbGp4ZUFRd2ZDNkozVnkzbkZsOGdqZEtpYkY0OTNRZjcw?=
 =?utf-8?B?d0JaN1RHRExnRzNTL3ZtYXRqdUJPazl2aDF2MHVzT01YT2tlRnU0Q0J6SW5z?=
 =?utf-8?B?djlQVUtTd2ZEbDA3Q3B5a0RBSnM3OUNHQUdWWVBOWVk0ZHVnYnlaZ2dlc09z?=
 =?utf-8?B?c1MrMkNEQnpzRkFMOUd3OTlBR1JSV01NZ0xYR0tJNjZGVnZVYTFFL0ZJKzM4?=
 =?utf-8?B?TXhJOUlRUkJqSDdYakdxcFJBM1IyMkx4ZVZSRXFoSS9vcEpxM29pNmNKQ0Vx?=
 =?utf-8?B?YnRwRWd5WHVzN0pjTHhtNE9iNnhMNk1BMlVKUGh4WjlFTW1ncWlXOHhyZzRI?=
 =?utf-8?B?Y3doTTBNUFpuZU5RZWlGclUxeEhVZU1VdHNRWnFNYVplWHlLR2pMaHRhZFNW?=
 =?utf-8?B?R05yNVBsYjk1WjExZDBZU3dqdG5EUm9HeXVZSkt3NTVCT3RkQ1c2NkxVQzVX?=
 =?utf-8?B?NWhmQzNsZTdlaUhmSlhmVGR4YVNnbDFhV29CSTdPZXZXL2JtWEp6cVIyOGVz?=
 =?utf-8?Q?iuWFl5xQt4GGYmoE=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c58da915-7d3a-4420-6ec0-08deccfddc80
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:53:03.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6Y9EDbyHIzTKCxBVADW6/Kn+X6DiAjVHsSVzAv2ZSgChYXpwXyVluiddmfAHrga4qMRH3s6AoH/3xNh5yd4LGQcvuYctLXiWVL+jRtO8VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1657

On 2026-06-16 21:58, David Laight wrote:
> On Tue, 16 Jun 2026 16:18:33 +0200
> Andreas Larsson <andreas.larsson@gaisler.com> wrote:
> 
>> On 2026-05-19 09:57, Tony Rodriguez wrote:
>>> This patch restructures the thread‑stack sizing logic into a single
>>> if / elif / else chain and introduces an explicit 32KB kernel stack
>>> for SPARC64. The previous implementation relied on nested conditionals
>>> and PAGE_SHIFT‑dependent behavior, which produced 8KB or 16KB stacks
>>> depending on configuration. SPARC64 requires a larger,
>>> architecture‑specific stack due to its trapframe size, register‑window
>>> behavior, and deeper call paths.
>>>
>>> A reproducible failure case occurs when usbcore is enabled: USB hub
>>> enumeration (usb_new_device(), hub_port_connect(), PM/QoS helpers)
>>> allocates large on‑stack structures and recurses through several
>>> layers of device‑model code. Combined with SPARC64’s trapframe and
>>> register‑window overhead, this reliably exhausts a 16KB stack and
>>> results in early‑boot panics.  A 32KB stack eliminates these failures.
>>>
>>> The new logic is:
>>>     SPARC64:
>>>         THREAD_SIZE = 4 * PAGE_SIZE (32KB)
>>>         THREAD_SHIFT = PAGE_SHIFT + 2 (log₂(32KB))
>>>         THREAD_SIZE_ORDER = 2 (4 contiguous pages)  
>>
>> Yes
>>
>>>     Non‑SPARC64 with PAGE_SHIFT == 13:
>>>         Retains the existing 16KB stack behavior
>>>     Fallback:
>>>         Retains the existing 8KB stack behavior  
>>
>> No, not to my understanding, see comments below.
>>
>>>
>>> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
>>> ---
>>>  arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
>>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
>>> index c8a73dff27f8..6b12a2b66385 100644
>>> --- a/arch/sparc/include/asm/thread_info_64.h
>>> +++ b/arch/sparc/include/asm/thread_info_64.h
>>> @@ -99,13 +99,20 @@ struct thread_info {
>>>  #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
>>>  #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
>>>
>>> -#if PAGE_SHIFT == 13
>>> -#define THREAD_SIZE (2*PAGE_SIZE)
>>> -#define THREAD_SHIFT (PAGE_SHIFT + 1)
>>> -#else /* PAGE_SHIFT == 13 */
>>> -#define THREAD_SIZE PAGE_SIZE
>>> -#define THREAD_SHIFT PAGE_SHIFT
>>> -#endif /* PAGE_SHIFT == 13 */
>>> +/* thread information allocation */
>>> +#ifdef CONFIG_SPARC64
>>> +	#define THREAD_SIZE (4 * PAGE_SIZE)
>>> +	#define THREAD_SHIFT (PAGE_SHIFT + 2)
>>> +	#define THREAD_SIZE_ORDER 2  
>>
>> As far as I can see, given that this header is included by
>>
>> #if defined(__sparc__) && defined(__arch64__)
>> #include <asm/thread_info_64.h>
>> #else
>> #include <asm/thread_info_32.h>
>> #endif
>>
>> the code above is the only code that will ever be compiled, while leaving...
>>
>>> +#elif PAGE_SHIFT == 13
>>> +	#define THREAD_SIZE (2 * PAGE_SIZE)
>>> +	#define THREAD_SHIFT (PAGE_SHIFT + 1)
>>> +	#define THREAD_SIZE_ORDER 1
>>> +#else
>>> +	#define THREAD_SIZE PAGE_SIZE
>>> +	#define THREAD_SHIFT PAGE_SHIFT
>>> +	#define THREAD_SIZE_ORDER 0
>>> +#endif  
>>
>> ...this code dead, where the else branch code already was dead (but then
>> in two separate else braches).
>>
>> I'd rather see the else branch here and the else branch below cleaned up
>> by a separate patch with a fixup tag for commit 15b9350a177b ("sparc64:
>> Only support 4MB huge pages and 8KB base pages.") that as far as I can
>> see should have removed the else branch. The else branches was to use
>> only one page when the page size was _larger_ than 8 KiB when that was
>> an option.
> 
> That whole logic is impenetrable.
> Why not set the 'desired thread size' in kB, then work out how many
> pages that ends up being based on the page size, and finally get the actual
> stack size.
> I'm not sure, but with vmalloc()ed stacks and 8k pages can't you have 24kB?

No, the next step up is 32 KiB as the stack allocation is sized by
THREAD_SIZE_ORDER.

Cheers,
Andreas

