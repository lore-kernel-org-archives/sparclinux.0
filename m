Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020089.outbound.protection.outlook.com [52.101.75.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B030566C;
	Fri, 12 Jun 2026 09:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781256534; cv=fail; b=dHw6I2FEXUJ/XcjxyBeiDE4BBWHUkVCUKhofUs4LjGIKmqVW/TCENH1u3MHrB4lkNwM6n7qvldolpHil5w72Z3mjTHZe0x6LGJ8GxsL9yJY80ibA5IF64TrXAsY91yFWgbTQV3Z0wE6Ehp0WVWZf3j9/aVQUkodhWx8QU2f6pno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781256534; c=relaxed/simple;
	bh=yMIwNrH3UZJwwdBXQyEnrjFIuWTK4cytR8lnQMTKz0E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FtDYST1V/Am+pJbyX4R6a35wmfrnh3MeiqCykqyAKLo3JLm4EMLEFS+ckvv0WxBHRDZhYLClWZAL70SXNL2VZNEAWrpFhTEpmwjIB88xGG1KxHWg4opktF26jh6gskEAj21mGkRLj6bxAbsdMNPXQ9pVKvMBMACxDEGw4/EW4vE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=AZbYGWZD; arc=fail smtp.client-ip=52.101.75.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="AZbYGWZD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRaOBEiiB0CNZDC5ZCDgfMEH29qBtA4xIrr9ksdGJQV7aT55hEKMA7nbbPjpUWv686nDpjjg6eVgbDZcdprb5Ab32lFLeFpVaWkNbY5Wp/Al+ymmAVjAN9KCpmCs1IUgEzM44756ULHqJPJKwBvBxeBcLjqeiRui/5ozShjOLRJj4vWb8iT8Pu2Hq752TNLKk3pEXMn+gJBRK175ROLVteFmd2J9fWzJQ0Jxy+Kt+AA0CphUQW9dMtLTvs1pqDNFLWSDD/bKGdtd4QYUWMv26ZQ/p1ahh/pUYYenB2kMtpArL3Gl00WMkdzGESszmgA2AZBzn49uaRmVKiNlOOzYfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Np95C0ByQP1u5ySmDscahxi+g8/69uUqPkln9mkFQQ=;
 b=TdwMgf3hy5g1eRi37ZRolByUgPe3ocWXPyDwJACh/juEReFjVyQVfsE5UHJlLTvnQUMwDIirlTkwbBKnxxJR1oo5/um1waW6zPSH0+8+1xisMBsPLXJp+o5xGMF8/f8FDnO8htoSOYeAUywbPTpyPAncZiGGJiIbTp2+IECPpcvEiBkqSd3879BjQaT080MXcqlDjDlw+zHF4uIfQ1WVSHnomrFmhttIRdYMADrW11eO4OIdh1M7UXfqxyh4phteJ5kt6UhwX0lZCFhCgIxTBryWhEUIJLxP6LDg3hZyBnn2LXQ5GeOMz4GSh4RPIA3SRb2ceRM48qs3BtTYFaTNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Np95C0ByQP1u5ySmDscahxi+g8/69uUqPkln9mkFQQ=;
 b=AZbYGWZDjkUauzK8Z22ounACtsR0W5wzn1KUmE8HoYiDOQAUMqNqWlhsm7pkiB3N0VNZMrCrZxUulmrI7j8bWatQghoKyiJBUGN9SUV/WwuRsV7pstgOh9MYC5ahFIZXCJ4ewpoifK4tId7htVeO62ATTONiQiB9rGvyvWgSy2a8G+H0t48S7zNvAECXxb3GIxFB7NV3R1NoFbYfLnfcirZMdazKyi/fxzTKbK3gtrtUIFZ7HERm9q0BAbgZXghDK2cOJwSbHyD6K/BPqWWwwahhFpXB4oew4j58PE8iqfIpwKlzl+zxBfvqS/BOkpd/0W0/BW3XlrA3Up3MFOhOcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVTP280MB2194.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:371::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:28:46 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:28:46 +0000
Message-ID: <9a48cc07-0ead-453b-99e6-ff1980e52381@gaisler.com>
Date: Fri, 12 Jun 2026 11:28:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Export mcount for Clang-built modules
To: Rosen Penev <rosenp@gmail.com>, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260508021119.1635054-1-rosenp@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260508021119.1635054-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F70B.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::38a) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVTP280MB2194:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e892dfb-9ae0-4390-81db-08dec86500d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	RkpS9NKW9mRMG8451o/WDNRnohpHvUeJMp1M9L/cTYf8Q9u0ZvRqw/r+CytexqBMm/G9N2dCe3HPvT2wrhxKEQlHKyd2OkVHAvgOL+y8ajBgCnU/l6Vci9VIW4Z57153JF6k71XpIhWRrhO68c8BW4c2LpHQMU+6j96gdPr9bKRcruXAUcJz9ulfsQm4zbfv2T+T87OLZ2Vi9TlUNtaf/pKzrt4Xl1/zZy94ffvZI0drezZ5QlJgWyF8cejYS46VmQK6lAVjhGudObZ5P+RW0/9lnu5iLLVZE117HFKFMl48muVkpX+DWlMQ+n4exHY37rjPOc0r++sE6nhMr3O3sQwACZSsUl3S6FkBsFen8QShdnQPcXkxJEcxINJkbbFp1BhltIr2Jdty3K7El0yTuEpVgX+D/177Nrx136x3ou5YRHLlD2E72jmRSDp8utJ/mEvlstJXFX8O/jCuj5VKhoZKw4fGvJrm5q3Yom87rCsddxJez0XaWK63o+/KhEMZ7e9bAtQ3xKLaTSPgSUcwI6rN1xCA7FlJWUZv22meXrkgs68U+pQ5HUTTi2Vi0xJDRUa0LoAcEJ7dVShN+7jNmeerrBfv5EYCbGRohocULYk0a8V1xYgAT/Ym67EnRcKLmILDdZITDuTeFa/QLMYptZJR27zq9xUrwLjcq6I4cDhmO0+RpZ0P0PZY3BMIBAIYz+S7bX+Oqkm1EAjaW+xZfg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(6133799003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TlZxRktpVDI0L3JaSDAydmVISlNTSlJxWHNRK09OWUgwRmdlcWMzeS8xYm9n?=
 =?utf-8?B?YUxudzJ3QW5yOUozRENLRlRhcHFtWC9xQ2p4anpWNCt6RXlWazBzdTlNd3Rw?=
 =?utf-8?B?bkQzYktsYzltTmp5NjN2U0Jnd0hCSlpRdTN5WE5UVjBrb2wzK1BFczNiaDVo?=
 =?utf-8?B?TUJZRm0yN3JqSGlmM29HS0xkVGdBYWl1bFpUSVg4YmI4WFQ3bGg5bG1ZeEU3?=
 =?utf-8?B?V0t4enYxSHdzbTBWN0t5T3ZGaFk3anhuNUh5Z2pya2ltZTNwd3VWMVU3OUdy?=
 =?utf-8?B?SG1qSVRYbTVOdWFRTm5PS0RsdFlzQUo2Q3FmbG1pa01jdnNMWDZZK01tMzFQ?=
 =?utf-8?B?elJoUjJtVERjZ3RNQjEyMHJXaE9kUWczajVYMnFqazRCbmVlSGxkcnphMi9q?=
 =?utf-8?B?eVdBajdTMFV0Y1FwdkQvdU1GMTArZCtKbnNyWmZMOUNBa1ZaT240bDNEdVFN?=
 =?utf-8?B?cjJoTE1TeWlIVDBjTjVMbUcrQkNFeWZQcTdlVEVuMmFacW4zTmNmMUhjNktU?=
 =?utf-8?B?TC9EcTM3UWduRURWMjBVWUdQcGp1b3FHQlZzTk5FTnFrUjRvR2VLOGxkUlpL?=
 =?utf-8?B?YldINVpOb1pjZjM2WGVsaWw2WWN2TldPWmk4NjByY2lWK2l2Q3JiVVdvZDk4?=
 =?utf-8?B?VnY4eFJkRG9CMVhTenVWbTBKL3BDeThUakRkbEJCcWRmOWpoYy92WG9yelNq?=
 =?utf-8?B?NnhJU0hRa2N6M0pPSE5xT2k0TkdaVU5xa3BjUmpLSzFOQllRbi9xdnRJdkR2?=
 =?utf-8?B?WVRpQnp5Sk1CeElYT1F1RUQ5VmgrSkk0YXRyRDh1SlAzN3hiSVBzanBLN2RW?=
 =?utf-8?B?QlBJMFJkanlVNGtod2VmNzhpQnV3WkNBN0src3hjZ1pRZ1A4OE1UVHBIVUNl?=
 =?utf-8?B?R3AxMEFsbnpZVDcyMTVpL1U1azI0aXR3bVM0WUlURkVyNjBsSlJtV0tkc3lh?=
 =?utf-8?B?Y2R0ZldtNjRETXhQWDFMUktBaFBQZ3JlS1dNbUc2a0ZrcDVoc2QrTml3WUM4?=
 =?utf-8?B?eXdqbVBnY1J0cFJTeXhkdXhkNEI5ZGo3dUZKbklmUGhoZFZpTGptSmc5Rktx?=
 =?utf-8?B?aHNuSWVydXJ2bjQ2Nm8rb3RXL0NZL3VRMWRFOWNoU3ZJakhZZWV0cUp6RGsr?=
 =?utf-8?B?WW9mNml3VVRUSGgwUlBtVmYrNGtPNFpYQkU3U00rcGQxYjBoSlFzcmVXOUZJ?=
 =?utf-8?B?a2Z4dG5qSDdJSldUMnZwQ3QyVlVwSUdwUzUvVHFxR3J2MndjSHpwU2lFNkVI?=
 =?utf-8?B?S3lJeWxZVWhxcGpaTUlWaUlNUUs2aSsrbHIxRml5cUFUU0J5eGJkYVVFSDJJ?=
 =?utf-8?B?TW5wMVdKdG1wZmU2Ynk5VGhZK2JieGVXOXF3NnorOEh0d1owbXNNbm5NZGtR?=
 =?utf-8?B?Q01YSzB6K3VRUytVQ21GcU1XaHV4K0hIWVVUZmFOZjVDazlWdzFSNzZHQ293?=
 =?utf-8?B?bnBnUTBEYTZSRXpYNDBKZHl3M2tuRUZWbnZRQmM3ekgyVjJGTkNxRWozQUxo?=
 =?utf-8?B?N3JoY0FXL29zTVRJem9PWXhmREM1YWFFWlBUQWRmNmxxWlV5YlJhVGp6Qkhz?=
 =?utf-8?B?QlppUW0zeXhPVm84UVlEWHVTdTlGWjR0ZHcybXNZU3JtZGN4dDMxTWlPcXZG?=
 =?utf-8?B?R3FkNDZuekxMSlRSdFZvZnhpbWN3K2E1Y3hxb2gwZ0hwSG51Y050RkRNTlZr?=
 =?utf-8?B?aEVGTGlrSWZNMEJ6S1VKNjJ4UDR1T3ora0dPODc5aVhFOGsyejVid3hoL1JM?=
 =?utf-8?B?N2lKSWNqMTcwazk0bmhvMWR4WXk1QkxPUW40c2p3MXNpNzJkZGI4ZWlGcGFF?=
 =?utf-8?B?bEF6TWwzZnpjNU5Ha0pRMGpEVHZVSWxNVjRPWG43SDBNeXU0VEE2UUNMNEll?=
 =?utf-8?B?SWd2WUdnaFFaZTUra2tYazlkZVkzYUhsL1pDTzY4VnpXWmdQZmVJMjBrM2tk?=
 =?utf-8?B?d1M0TmpGbzJBWFQyL3UvQ0NSV3dXVE9WTEthSkw3RnRISlNsMEpnWUxTS3dO?=
 =?utf-8?B?ZHJialh0WmtFNjFPbzJDMHh6SzZqdkQ2SjN2c3k2NkZONGZ2TGp6T3ZDLzdv?=
 =?utf-8?B?bzQyZC93LytVN1N3ZXlzWFRSYUtwV1plakVLd3VCY0xXY2QycmU1bzlzV1l2?=
 =?utf-8?B?NGZkdUpEWEZKZGw1YXJxWGNVTWh5RjRrczVtYVAwenFHRkJROERhQWZ0cUNo?=
 =?utf-8?B?NkxzNDltSVMyQUZUMldTaTcwNUk0Tng3dGpVUWpRcVRXQTlqaDhUOXRyY1dO?=
 =?utf-8?B?TFg1dVd5S0JHTFYyb2pDS0RoRnY1UXdpMkxIbmgzVVM1WjFXUzIrVXd1UGJk?=
 =?utf-8?B?RG1aZUZhZzNGMjU0UmFIM1BRMVJDbitwaTRxZ1U1SHZHTnJlMGFkdG1mKzdo?=
 =?utf-8?Q?N1EqYl/Zz0eSaRM8=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e892dfb-9ae0-4390-81db-08dec86500d7
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:28:46.5956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyvuAiIyXa1sfbAwKHee/0VYxNcImpWS9V3hJAwk90pswO5cxZWtS/ersM5bd/O87atf7+yfupd6m431aOZWpGllkZyQL8uw+eQqr1AOdDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVTP280MB2194

On 2026-05-08 04:11, Rosen Penev wrote:
> Clang emits calls to mcount for -pg on sparc64, while the
> existing ftrace support only exports the _mcount name. With
> FUNCTION_TRACER enabled, modules can therefore keep relocations
> against mcount and fail during modpost:
> 
>   ERROR: modpost: "mcount" [arch/sparc/kernel/chmc.ko] undefined!
> 
> _mcount and mcount are aliases in arch/sparc/lib/mcount.S. Export
> the plain mcount alias as well so Clang-built modules can resolve
> their profiling call target.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/sparc/lib/mcount.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
> index f7f7910eb41e..0309ba2c4712 100644
> --- a/arch/sparc/lib/mcount.S
> +++ b/arch/sparc/lib/mcount.S
> @@ -21,6 +21,7 @@
>  	EXPORT_SYMBOL(_mcount)
>  	.globl		mcount
>  	.type		mcount,#function
> +	EXPORT_SYMBOL(mcount)
>  _mcount:
>  mcount:
>  #ifdef CONFIG_FUNCTION_TRACER

Hi,

Please also add it to arch/sparc/include/asm/asm-prototypes.h, like in
https://lore.kernel.org/sparclinux/20260523042535.C3A6B1F000E9@smtp.kernel.org
to not get an added warning about mcount in modpost.

Thanks,
Andreas

