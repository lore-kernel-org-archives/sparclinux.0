Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020125.outbound.protection.outlook.com [52.101.75.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12736195A;
	Fri, 16 Oct 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160816; cv=fail; b=pfNp9rg8uJ1cufbeK3CIQLjCCmwDnDwcAhHb/K4HcFNOdmVYK/GerubD8PTdu+6W6om/x/MzYvPvnjsaLv94bee3cyz7b8g2stw3vdorvT7bdTlB/k68gf2H6SDEgmq51V0OW+gzfpSKVbHNU5w1p9f7D4gjQGiP5Oy367NIiSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160816; c=relaxed/simple;
	bh=08pGKostOv2Wa2W85pEqvqzr8J+xtwEpN0wz642wziQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0V4vXN7vjHzwWPkvuWJtO7dmB5SimFer5+YxkI60JV1hz191bpFKNKUrwd1LxP4JV6H5eLQVtrTFErimTPgB8r06AF0MCtElZ4pNU7zGmest6l/VwPeNdvIiFiusXBV+VZUxPMI4HvpbmcDrPAfI5AX0EaaW9p9LJ7hXUD016o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=FEnlfJTo; arc=fail smtp.client-ip=52.101.75.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="FEnlfJTo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIz210Vbs7X80j5UrhVwabv4A5+OFfy+FCZJD01pYrVoRFHOzmLlUrhLTonU3jEXlgvNimYrJ4uEcRw4nZZzM0XPpaW4zXoR7hKmssiK0Sy1pYxDvQsIbXhG236YNrC+GJR3lMYELUIzVFRnmS94Pj7K2Z6/rlD4iW+vqCC7WOeTG3ycSJ82jv44X6y7U+KONpKROnY96NaAM21BHLWv2stSWDutxr9SDMBLSBCbcKOAo9vlIYCywTwuIliAOJssdvAHrHGgfM4JMmQnIl6Do3jFukzmIkChwWwGgW+wUTTjmPn6GdRXC6itetqgk+ZHupBesKJt7ESo5UoRHDkqQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAH4dw8Mlvh8tmHbUqvFiJI2VMPHAuGgCPG9vddRVEM=;
 b=yF5MbCB5txSWsxwdpy3rstGLqomeVyQCbnK1q9nYcSqWPwSnTgNIk6fF18QmTMtE+5IvN093k2whB6ToYuyN9X90On2JiRqUMnwBmNg6ZuU3nLvUZiTuzduJfXol84RUMzCiGnE/eCdPFVsL5cFh1jcGX0xESOYrhQ1RCktZC4SbHXzFX790AvN0zsX+7BpCc/t21xIZxMgRs1WEPngZXExzjOAvFgd2HkPKAZD4hnOxLxgkQQDo2Vz/oSh6h7LN6e8NTaxsO9472OwLq2p01X3OfYJtzHdmcxS6YsuAYHFCOYJn/vRY96rv9vccOIhGpl9PflWFRywLu2H4W7hD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAH4dw8Mlvh8tmHbUqvFiJI2VMPHAuGgCPG9vddRVEM=;
 b=FEnlfJTo8tpXomz54tq3D5JGYEnJ6+/DyL75rSNluL/6QzJd9Bu+0eskSVYDZde7vgyOWAoWIxjYnJJ+yZgkjJRNf/8KWC6AcGGeZyM1+d9sFyx0gTLJqFvQ8j4NF2PnxFz7UJ6AQwUCUS+GD06pVA9VhvFhaTa5bAItmtIbLewsSVMc/7JInQXJBn9BELcGaFoO4lf22CBVpm6wUtcKgRPcDnoflZCPC4mljjFp8Co3phSurBlqZf12o+rlEPGEZf4mJWBJAHjGUs4PYvybu8NowQ3h/HiIfgJxz79fT+nkPx4R5IsRrrSoTx8vpW7rM5ZzDKhapPq4SZBAOC4xsg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB0666.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:41::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 14:26:47 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 16 Oct 2026
 14:26:47 +0000
Message-ID: <908fd2b4-8bf5-45a9-89cb-86407086b61b@gaisler.com>
Date: Fri, 16 Oct 2026 16:26:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc32: Avoid NULL pointer dereference in fault handler
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
 linux-kernel@vger.kernel.org
References: <20261014133229.7841-1-ludwig.rydberg@gaisler.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261014133229.7841-1-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::11) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB0666:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d25cd2-fb72-4e73-7e06-08df2b9182dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	FP+3lSRSFC2tEjxsP+SEBil5GiROD7Dl8/yiyITOsJesSJ20Xo6ZMkYG0WzNCtkJBq44OgJPp5GvPmZ3NWmW8LgbAOtTw6AWScl5TL4roh32DHiAdknHcsJfG2ID7RslB0MIWLm8fZr8HvTkAtTfZut70bXz6JXRI082751b6fMTPllG9+QNmO9Uj59k7kczlTqSukSXN8ipMNd1qBJuKKYeTU8Qa0sOw5wElWZA8izCTXP7t6c+zi1iFTj/7/236eu96jvrGxhqEULh8mBa+jgnyyx34gD86SsD711laK/AXO1G5joHGPveuQUl3UFgk0VA0BocBMhwTENwglzIbirb7XuAEmcRYvF2nGrphWrxw0qCzrAHkbx9fZhJMjS1WemP7noX6C81LzxfiheTjFg9UlgC/IU718Q/ytfney1Dra/DUSFU5tnTRyARk6rYZlNY+VSEp3bcQ0SJCMWbgsbboMgFtwNJzQ4xQ7IP5/gwD4/+hSAhR1lir8znXZO4vZzxUKVobubKkS6vIo3oAsXJCKWIUsvo4ZzZiQGaNEk8QJgDlzWy5as/8ZOm29Owt/JG9up8YNNnXCUDcPMz2pLbrFkmYuDncelnzHtggKexvDZzy9usIFc2RnQjVNq17Bk4IlXZE3MsepoFWA9Q2WCLDUHsVFY2jGpAzXMu9sI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czBtNWtpSTNZREZmVzBZVWZPMjZ5UXhoaTN2T3FLVks5M1BTNUVlcCtoWEYw?=
 =?utf-8?B?RHd1L1lKVmROMGhvUnRHeHUwZ25QRlBiOW9yNXl1RUVxV0lud0xFUElBQkhV?=
 =?utf-8?B?TEJiRTZKZnhsWFE3elcvODRYb0ZMYTRJU2xRcktsQm8vVFRDeUU2dS9oWEd5?=
 =?utf-8?B?MEZSK1dBdDBBOEh3VjIwSE41M25JZUZZK2ZIQ0ljTXRPQ0dHMXh1QlpxMzcy?=
 =?utf-8?B?aDVVWnJVYituRDFHcWRKWHZuMDNtTVNPTGVFbHhWU3grL0FkNGJOZmwyRHFt?=
 =?utf-8?B?ZkhnODJZSDQrTFloWUpIU0FLZkRDVHBXK3p2cWYwaEllYzFabUdtK1J6K3BQ?=
 =?utf-8?B?S0dJdjVpalNnZmQyWEV4WTBBemxjQ01TZ0tKdHI0clUzNkpZcXZ1ajU5Mmxq?=
 =?utf-8?B?VklYcHlTZ0RIQWI2UStjODdsN2QzUjdPOU5pblBXbm81eW54YTlhWno2QzZ0?=
 =?utf-8?B?bndialRDRGNpbG8waXpKTXk0cTM3UldnUGd6STNiT1praFZ5RUZLS3JtQzlC?=
 =?utf-8?B?N1BrbTNpcERnbnlKQW1DM0JiUERIcjFiNjFuL3FvMWNWTXRSVG9nN2xMc2Nt?=
 =?utf-8?B?YWVwTFZObUdxWHpqWWEvVTZBT1V0VThVSk1weXlGcjBVN3lodFRDYXJSSUxG?=
 =?utf-8?B?dFhOTzREYnpSdWF6a0RyNE9rRFZvM2s3Wmh0UERJcW5YOC9FSThkYXlnS1BR?=
 =?utf-8?B?Y1lDVG43MmdLMDlXUDdlUnlJVlNWNjFFSHdMZldUMkZaeGZUSWZ6bXNtQUt5?=
 =?utf-8?B?eHF0dzdjWmNQMmVWSmErWFMyWEwyaVQvaFNMZ3dZc1JFMXBvdGhvbVNqQzBV?=
 =?utf-8?B?NnNpZEpjcTJpRVpVTW1zTzUrc0piUnAwQjJKWFhnR2pWWUh3c0Q0NWMyOWpj?=
 =?utf-8?B?UW81RWlhanRtS214V2FzTmlOYjQ3MmYraVMvN1hpaXF6a0h1bHkvUWtkVWE2?=
 =?utf-8?B?VWp5RE43M0NNU3NiaHBvRDlhVkNaekdkV1o5cjdwZm9OY1JBdnFQKysyYUwz?=
 =?utf-8?B?eHlCZEo1ekRlbXRjL2lhTUYyNWxBNmhwVUJ6TTdXdjVBdlpqUXdBNlNPZ0ww?=
 =?utf-8?B?Y0E1NjZUbkFKRVJCMFpNeEVzMENxVkZWRXRjMlhlS0huMUR4RTlIMFFycjYx?=
 =?utf-8?B?eDE1Lzh4ZUp5NFBKQWgyaDB2K3RXVFJoNVBta2draklwdVVnamJoblNJRGp2?=
 =?utf-8?B?YWFsNTU3dVVTMFZBRTBvTEo0QThYZnFiSldSUUpESzFoWWdiNklNMWtLM0xW?=
 =?utf-8?B?NlV1cjRBeHlLTnFlUFFsQXBGcStCcS9abXlMVHk4VjFFdW1aVDBnNXIrc1h1?=
 =?utf-8?B?dTJtSStsL1JIMXZlZDRHZysxYjl6dHNWZWRVTEVpS01Lc0RLMXNob1p1dXBL?=
 =?utf-8?B?QW9nUGJYS2pKZEFhOEdmZTMyN2c2Z0tQZzhNZFlOb1Z0YlRCcDc2R29wZEs1?=
 =?utf-8?B?RGJYdG5OQ3VUL2s2TFZmUFRuRTJMUXZaZ0laK3JMeVpWNGxPVFBQdHZLc3R2?=
 =?utf-8?B?Sm9UVkZMdHlpVXphL2FMQkd5d3pQUExCcVQ5azFLQTRPZmFQSUlUWXBxQlZy?=
 =?utf-8?B?UlNycHlUWG9YUzhFOW1DTWVpRmJNK1ppa0xQRi9ucExhTzREVFNwYUM5WUxF?=
 =?utf-8?B?YWNobm5LOHl6aVQwaCtmclJQNzRpMVZWamY4Zk05d0Y3eDNMZS8zZS9pUnU2?=
 =?utf-8?B?bkxMUVVSSnhZRmhQcnBTenlPSkFSS2k1QmlLY2M3TVkvZTlZb2JLb1pxUnJY?=
 =?utf-8?B?SEhnK3hOWDZLWXdScEpXbGxlNzl2ZkZsdzg1SXg2RW5DM3ZJdEVsZDNXdEJa?=
 =?utf-8?B?NTQyOEMwV1NLQllRd1dVZWpDcFIxdUorbmlXVXR3RC9HQ0dPV0IwWUhNMEZm?=
 =?utf-8?B?S2ZBVzZocWdVSEFzM21rMW8vT3Y4QjJYUnlRL2NWWllKVHJCUHJWYXB5YkIx?=
 =?utf-8?B?Uy9DMkI0dWlUdGtDaEZla05KR1ovcG50RXNxMTM4cXJuOGlBLyt2bUxSa0xi?=
 =?utf-8?B?QVpNZGdpdEVrcWhJY1JMVE5qTndsbElheVIrbUNtNnRIdmh6TjdaN2hDb2xQ?=
 =?utf-8?B?dXZTQ0xPbC8vMFBncmRKZWdsaVBlQ3JqcjJpVUF0clRRWXlmZHJPSGhvSCtC?=
 =?utf-8?B?akxyT29CMUUwZXVveGRLMExEZ0JHOUVOcGx6aEJSaVI2VjVxbFR6TUhOZExn?=
 =?utf-8?B?N2E2U1p6TmxyVDFCbFFXWGtYa2tzQ1JEclhiL1lMMERsYmRSS0Y2cjVKV1R4?=
 =?utf-8?B?QTNJMDlTM0FtbEVZd2lrcEhyOXNTSmt5OGJrMnFDNTZEdm9mYmhuOEcyM0JC?=
 =?utf-8?B?VXlHZE5HVTAwVlRJYXAxem5YQW9hTXQ1SDlCVnlrL1Q1VksxY3labG1Rd3cv?=
 =?utf-8?Q?nL4rakmQopkyarKI=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d25cd2-fb72-4e73-7e06-08df2b9182dd
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:26:47.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8yBFeRx5gpv+wgf3jztVb293MsDSBY6ydqrBDyZPtvK8E+qURcdRO0LVK1xqJt3jgfC3Um7CGMMrT3btC5Q1gRpQENkcu/A6zy4e7NKAwo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB0666

On 2026-10-14 15:32, Ludwig Rydberg wrote:
> Add a null pointer check for the return value of
> search_exception_tables() to avoid dereferencing it if no entry is found.
> Without this check, the system will crash silently without providing
> any fault information to the user.
> 
> Fixes: b4edf06c8aaa ("sparc32: switch to generic extables")
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> ---
>  arch/sparc/mm/fault_32.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 86a831ebd8c8..4cfff3d36a99 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -232,15 +232,17 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
>  		const struct exception_table_entry *entry;
>  
>  		entry = search_exception_tables(regs->pc);
> +		if (entry) {
>  #ifdef DEBUG_EXCEPTIONS
> -		printk("Exception: PC<%08lx> faddr<%08lx>\n",
> -		       regs->pc, address);
> -		printk("EX_TABLE: insn<%08lx> fixup<%08x>\n",
> -			regs->pc, entry->fixup);
> +			printk("Exception: PC<%08lx> faddr<%08lx>\n",
> +			       regs->pc, address);
> +			printk("EX_TABLE: insn<%08lx> fixup<%08x>\n",
> +				regs->pc, entry->fixup);
>  #endif
> -		regs->pc = entry->fixup;
> -		regs->npc = regs->pc + 4;
> -		return;
> +			regs->pc = entry->fixup;
> +			regs->npc = regs->pc + 4;
> +			return;
> +		}
>  	}
>  
>  	unhandled_fault(address, tsk, regs);
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

