Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020085.outbound.protection.outlook.com [52.101.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0682831E84A;
	Mon, 15 Jun 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510503; cv=fail; b=Wzk15UOLjf2cg7GsvhJxrWMytav2ZQCHstOJetBzKv7L1PbWul/gmS+LzeFDC30tYMvG2ZOz0+RWLv+8IAdnsr5xWpRR1QAkpemhCVFcJQeCZMbck5I2rZPLjIwNIxvGTIdwl+YVKy9aj6TFwJnsAHkEKSmzJAq0Ls/JdtUQ6uM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510503; c=relaxed/simple;
	bh=1xAnwZS7/0YrE8ChSoj64116LZqYRvI37gZuPrI4zjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mj+0Ht+t8VVRIjC9Dzh82drPAMnGjyqTkSzzyVpMN7pTPnOfb7Eu1qfAtvsBFZa+e6plgkrdpy2ZzVp6KsG7o7q4vNQey+cF0yjmx1BAkta/IkFSFGpetVVw5qXspBs8y94ssQe86JRKxFAYVC8d+jcmJ9TDFribQADuBAZpdJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=WGiPIExX; arc=fail smtp.client-ip=52.101.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="WGiPIExX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkWo2wy1H7ehHF5xImKcDEbKn2wu6Ek/PxspuIp4XWTz8cqyIRs19DOgSazts3UP6ItXGwzxBLfwDqRLjTgAtu+7lvdVId3DqYw8HlKWB4nnfMW/ARrZ8z+bX3+a371qQoW3zI0yY6KXbHBi/NTtfpkws3Tz1dLdJ+zNpKEb6ha7v5IpJnsl5dr4D1XBjYdcLQnRuhChGD0IInm0aNBu75mrqhDwGWyXqqN3OsIv88IGxLTpvE7FNFZkoKi9wrzB56klaQc7HEbOxphU7NICgkStDdHbX/tp1gXvW2KYi2tkRH2NFZKc5sYESXuDVlShw3Z1AXnSnVnCDe4g6b53Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIQvrxY2ceOA2SxPyd82RvIdsB/rDZO415gEpsUc7LI=;
 b=LP22tfbEOv7jdv4lofZ4tYLEruheyn3RjpVsKlw3RCPGHxZjvo2FRwhDGcfvA2c6dJvMuncnpNmWOfcBPibJuwXp59XQ+fhPyuKOe8dQC25ZPWY1WuBxa80CClRv1yHClcpQyAbJUbw8cAT8fiF+rFi2fYCrjgUznlsK08/kf1dPfCIH+yKTewvo1Q5wzcV6sUnwN+9hDrX+6/PtQQx+Bes0eDb1dxstLtWbCKNtEWFZRfDLbOobB0XQqIarLOv6brMA1C2trW92BpNl4fMaCdstTWvuuPuei3/5SIaEb2Ci4xY7/YhrBhztFMMAoxyHOZTs8jTus+N6EappGjK5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIQvrxY2ceOA2SxPyd82RvIdsB/rDZO415gEpsUc7LI=;
 b=WGiPIExXyeqBbXLCC1JGvT4lmzwPDiQlXSyjaiZgiatTs7mtNSeXPjsgypaRCJtzkgPPcR0lkymR6fUkml6muSW3cQHbPFlt7L7C1tSdSdooeVQc0GC58Sw+P+YK+RM7DQ14GmbTley1cWvCaAU2fmlpYv6E0sSq1uilmrheWa5ZXk0zWxR1hUwioVOE2INJA/ZvsnCjsN63+/yvfEy1hzpv565h1XjlhBaBEVsO9oP6mf+WBVpRHYQaWbtXjYGIgThOFvupIcLJV8qTAhczcJKx5eSsGUB/kT4O6mr9tq9MMhpFi1IAYn6C5/LaA4EIzqClaCtA5c+EBmnBZZevBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVYP280MB2063.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:365::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:01:38 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:01:38 +0000
Message-ID: <2a45e280-104a-435c-891d-2c1e0e8e9c1c@gaisler.com>
Date: Mon, 15 Jun 2026 10:01:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sparc: led: avoid trimming a newline from empty writes
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c968c25b-7174-4b27-985a-9428a4ad429c@gaisler.com>
 <20260615055850.66363-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260615055850.66363-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC3D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2e8) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVYP280MB2063:EE_
X-MS-Office365-Filtering-Correlation-Id: 916bc158-0aef-47b4-fcf1-08decab453f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	r34s1YbfepF2t+Ox0IFtDkwTn/X8caFNGCWLinrxhGVoDU4V0WTpr4Q8X0LvZYnFcCuO424Ye/qDDryYsDcvat/9Ljggd1P/cj9epH2jItwWE1mPTIAI8wdflfhmlp8LDr4dizyGOV4hxR6GyTVq+GeUBHWYUpYRE46AKct6snNqctmJLgS/0+eNcJSNJ/DFfwi6GufM+1fliIS+nF69dWZITS1rN/nTp+5gtMWiYREjdMBtx6EGwCCQuLoXXbNTD1oAnRwQgbvep5YhnUfejtcj0uyIb7OusctEexHAQza86+3XSUFh6EZcCbi9zGyN85brEhEH5mHs+bTJ3gRWPCR65JMgBX6vcGACW4geF4kOVSxxRy2YlqpJRe/rfkWW8DkDZxrpE4mgbPZbwO1YwdZnVblIMReUqUsvO8Fu/16xQMXN6lSCpfrIl9LuZTLvmCA8e+n1eXga9pjnprTDMM5eKT/L8zppY2RykyE73x9sPFt6wjUcRr92CNU8XOu80ESOiRH+4R2dMuGvxnBEujpnM4VDPAksBEmQ8mXfn8jU3y8f8hZetkL/pKMcG6C29yTJ7/hEZZy7tzopMO5XOpIGfVBMOmqgcxD1EQidQMc8zW5jRDgnCJmIS7R+W9+n8zE3VHVRcWSAsRhfNLtk3M+ho4oHD9CY6cB4z67y3SkmPlUp0/AIQUQJb2GhPwko
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHM0c01VVUdLSHpVV3hRdGhJNXc5a2xWc1FoK3BQQURtZmEyaWkvWjRIc2Q4?=
 =?utf-8?B?N2VzN2hNa251TDdYd3cvcEk2ckJXR1dKbk5tYXVla1YrdHBCZkdYR2VKRXJ4?=
 =?utf-8?B?QWZGMm1XeEZ0ZFZhU3V2SU5nMWZFdGJlYURXdUhRc0E2Y0hyVmp0V09MaUU2?=
 =?utf-8?B?UXBvLzF0ckx0L1Y0ekdxWVRBNnpEd2pGL0xpQXZXVTRoRStZN3l4SjVwTDNX?=
 =?utf-8?B?am1WK1dJeHlMTER4bXp6NmNFUE5Wd1hZQURWc1hVUzk3NnBwU2RjOEpKUW9q?=
 =?utf-8?B?THorc3ZpS1ZGbWpCdmJQOENyRldEVytBRFNiN0pFSVpnL1R6aUJ4NnFhcU5u?=
 =?utf-8?B?VnFPY3lCNXlkbTl6VHJXMjBZb1JId3B1M0JBM3pJeVNhNkVMdE9Iak1GYnRN?=
 =?utf-8?B?eElLSDZtUEtMOE5IV2laL1JISGk0TDllRXBHRmFiMTFnNVZyVk9uVmRLWkZl?=
 =?utf-8?B?TEJNVXhNaTcxSGRtSDFEQ3dvcHpwZGFCOFBsUDVhVHAwZG1GRWJwVDFjSU1W?=
 =?utf-8?B?eUMyYTJ1YjlMRGs3TXJPSW9iRnU0TURoZ1FnUFVkZG5GZkNrQituOWN1QjdS?=
 =?utf-8?B?WHRDVCtya1VXcTZtUGhpTFlGVWw2MkdHemE2azArL0hYTkFVV2tlUldBRldy?=
 =?utf-8?B?enNSY0dQNWM3YnovcDlVUklOUVpubGNTcmt4U0RFaWZHclFWa0FTd1E1bHFs?=
 =?utf-8?B?eGpKek9XbGVMaC95ZC9iY2FQemVyQjF0a21aZ1MrdnRjMDcyNU5DQllCWi9s?=
 =?utf-8?B?ZUNMclVaTHNXQUlpVVUrUXBVL1lQN0UrNTd2NXN3ZGpoSlpxb1lnREY2c1V0?=
 =?utf-8?B?cERuUWtPdG9NYjRLbUhWYy9mYmpSY1Z4UHB5NkxjcTExWWtYSXlHVEFPdEZx?=
 =?utf-8?B?SDltWis3WVMwanZzZVBYcXFRZnpsempjT1dNY1dMWndFSjJINitDTkY1YVg0?=
 =?utf-8?B?SDhGN0Q5My9TSmNMa3B0VUcyYWc0WG8rK0hhQW5tVngxSmdJcm9PaldmUnRH?=
 =?utf-8?B?ZC9NVVlmRitFVXBmWnBnNU9hYjZkTnBNMEpaZ2Q5c243RFE1cHFrckZuaUZ5?=
 =?utf-8?B?ekt4TjR6cG1JNEhkZWNTMDlZcnBPTjJIZVc2bUZsZmd5VkIzakhkZ3gzY3hj?=
 =?utf-8?B?RDUyaHBaWWZOcU4zYzkrQXIwVUdKeVd3N1A3VmNWUVc4UHhlekZvdHYrbmZX?=
 =?utf-8?B?VkNDbldhektUN29pZGFkU3ZQSzdlek15Szd2VllOU1p3V2RMelVwS3pCNFpK?=
 =?utf-8?B?YS9NdFA0OTZ6UlloNlpkWkU3dVp1eG1vV3hVSDdXTlBtbTBIZHQrakVNcjNO?=
 =?utf-8?B?R2ZHU1pCbHA4a2oydXVNOGlyMzVORUdETkROUmdmdGNjcWZaUWZOdU1BTlQv?=
 =?utf-8?B?TDRFNDdvTkY0WXROOGtmY3pJUjQ0d3VRMml6OGpQL2p4elh3T3hPRXJWWk1t?=
 =?utf-8?B?bEhTd0hrSXp5RlhUY0xFK1JMbzQyT3Q3R24rbXM0VC9pd3VMdko5REM2WWJi?=
 =?utf-8?B?T3EzSkF5VlhQZ2FSYnNXZVZRV0h5cVdNVk1tVjZIQWZkVEgyem9NaW9VOEc4?=
 =?utf-8?B?OXA2V1BVLzBwc09DSzYrd29Ub1BsV0R1bGVaWDhTK2U1YnZUMmpKcGFSbGVv?=
 =?utf-8?B?OGxteDE4emxqZ1RObENyQ296bkRlcFlXc0JYb2dCSVowVE9TR2JYc1EydzUw?=
 =?utf-8?B?akNyR0hmbE5uRGRoalVNUmc5K256WFlVWS8wa0RxYk1Lb2F2LzBQa25EZi9X?=
 =?utf-8?B?RDNQMVlJTE5Rdm54S3lTS1YyK24zWEVLTjJIZlJ0cWVlNjRzMEdRNzZ1NllZ?=
 =?utf-8?B?T1FiTTdwLzBWK3ZZM2wxUTdma2krRjBrM1BRU04wUFlLd2RSZjJXZ2lQV2hx?=
 =?utf-8?B?SkQ3ekJNQnVSNjRtc3lYeVFWOVI1ME1MZ2RmcTJBazVVckh1VGh3Q3RNeUIy?=
 =?utf-8?B?YnNxQWl2MDI1N0tpbWtQbGNaTE1mNmR3eTJtRU5pSlp4YWxhaWUvM21VK3dt?=
 =?utf-8?B?Sm9HcDhQR0U1QzFTcDZ1bHd3MHpOOTBTa2FiTWowNllMZDJYMHN6bEFUVTZ6?=
 =?utf-8?B?S3BaaWpiQzFzdnkzaHM4YWtRQ0I3VzQxZjRNV1dXbCtFTmNKOUg2RW1WZm50?=
 =?utf-8?B?Q05wV0pWQVp0c2JhYjVIMk9NUmdRaTNscFBzalAyYkZZamJtOUUzOUN4QTVv?=
 =?utf-8?B?L1VPYXllRG85bEZ0ZXpXOWVpY2d2S3J3bVZEOFAwSG1Hc0s5cEV1R01uNllK?=
 =?utf-8?B?K1BRbVRYOVVXelFWZjZmTFlHQTgrWVYwWXhSZ2RIbTRXamhJUDhIREM2UUNM?=
 =?utf-8?B?VU5wTnZqYVRyb1p0SktYL3F1aGUwZkFqOWhXbnFncGg0MFFpWHBTQ2I3WkZ3?=
 =?utf-8?Q?ofjMjyiwMF9CbKAs=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916bc158-0aef-47b4-fcf1-08decab453f0
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:01:38.6645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OwSJdPKNlJpAkUfaRvhS6c7tLYXu1RssYrtrD66LPWCeQhGUfm3p/C++tItF54gui+7ULt9kuilt6zoQ7bJ3wFScPsSXeHwKkSZD3ePuxZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB2063

On 2026-06-15 07:58, Pengpeng Hou wrote:
> led_proc_write() duplicates up to LED_MAX_LENGTH bytes with
> memdup_user_nul() and then unconditionally inspects buf[count - 1] to
> strip a trailing newline. A zero-length write therefore reads one byte
> before the duplicated buffer.
> 
> The previous version rejected empty writes, but empty input already falls
> through to the existing default case and turns the LED off like any other
> unrecognized string. Preserve that behavior and only skip the newline
> trim when there is no input byte to inspect.
> 
> Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
> Suggested-by: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - Preserve the existing empty-write/default LED-off behavior instead of
>   returning -EINVAL, as suggested by Andreas.
> - Guard only the trailing-newline trim.
> 
>  arch/sparc/kernel/led.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
> index f4fb82b019bb..9b53ac1fe533 100644
> --- a/arch/sparc/kernel/led.c
> +++ b/arch/sparc/kernel/led.c
> @@ -78,7 +78,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
>  		return PTR_ERR(buf);
>  
>  	/* work around \n when echo'ing into proc */
> -	if (buf[count - 1] == '\n')
> +	if (count > 0 && buf[count - 1] == '\n')
>  		buf[count - 1] = '\0';
>  
>  	/* before we change anything we want to stop any running timers,

Picking this up to my for-next.

Thanks,
Andreas

