Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022119.outbound.protection.outlook.com [52.101.82.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFA3B19DE;
	Fri,  9 Oct 2026 14:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791556890; cv=fail; b=FoeqqhskfwfsnNup/BwZg3RZ21UIIhMwXIq05WvUHgHYAq+ZKIjiMSghHeHwlMaZT/tl2yLnz/lRJjOKy8MPy20PNFdkPwMSsRRDwZzudfxZU0IxAYXmOLfgimG06D153M25R12n9Pfv89hv9iA6wlKdHRZ3F2OehpkrakrkaZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791556890; c=relaxed/simple;
	bh=sM6NLErAFHQs9vzEob5KIaTpO1ZaT23X7CP9a1nWNnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XY4xs/FQot3/Cy4m0luvAd/xiSUdH/uyLi/Q4Q4+StiXH5A3Fot0r6Sdra72hurWJldaNXAQhYiW24lHZvDpqmeEPZbT4M6e56vpd8NSdstJBWjF3sT7nldgOH5j0DDPeO70xsC4Hdtq+qsxcbBN1geeqsEbX+hLA7Q+kTZYQTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=D49ZlhrM; arc=fail smtp.client-ip=52.101.82.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="D49ZlhrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=doHw8tZmAIK64O5bgzInVdoOmM2M0Gp9kJd6rikZ8hWPzVKsp90SQOdmhL3VaAq3CcTu/AYp+QjqWgowWn9JN8FOk1AEXAn4q0/qt9U+gkyyXp/fXWet51AFOvrN6tvrAK8wRHMF5KVGFRxsOBZKt59Gx4PD1pIuLZLVDt9Tf3zeoME91Egy5l+pkQZgfmExPmWUU0xUEzhqA0J6LIHm92+DEt1jA1KvkokgvggJT2JMugYmdD9kMGAmxzKwS5qt2pmVRdlXV79q7azx8flxmHOlzvzn5GWuzh2MK0QBdrvtFKoNXPpY7u6zAdSEwtbK+DwXhGKDHm41KK/iXiHMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqI0Y5Ugu7xewxRr0Ly+6EpsF62tKX80xwtgg8ujCwo=;
 b=DrcqSy6k23tlOXkhlFxhe+tuoubKDL05RRs7vos3dWgvEbjP9bjus2US1MBEc7UvdC84/aSBq2xqrH1H1lG3AxVGITYzivw75xt2dCdu9Cz907D6vZaICgLI9C54xx3YXnYzDjPWka8MIWRiX7FLxWuwxhuMmLJ7nA1KR1C+8U+JYfi9xRk4cExRIERFS3ZIokc56aBkVZdzS3hUX8nh+TQetQindn9AVEc8lqHVyXCPe0pil2TG4TYmKp6xpqtmlgfi61qxI+yVLd7j+VLo4dL6PS9RFYFHOvisQNcxEnJhGMi1wGX4+dogtAvz/RPWvySZVWs1234ofFayw4qF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqI0Y5Ugu7xewxRr0Ly+6EpsF62tKX80xwtgg8ujCwo=;
 b=D49ZlhrM02TffkZfFjNeJq7h2lWyWqD+yctqfIWA5oAwSxbfBgFdHKS53pqlZt0iXT1W7qx5GMEpqFZeMkTwk4AJRx78zZv4VXx7ErFqg+XK2frJiAR0JoQurIkygXKR4tWqxT7HHSy/L/0VL7LvFc2tANkT6Tew1EdFZuykEkd8cC0q7MY0dL+4ZS8IlFQoScBEWy/FM+prHDTKWPTGewc+NFJ6YLihGbGZkhEbiI1izpSf84oiBG2+IyL5Hwje8dU8L8d1hiMJteDzLwarkzYLiCw8EMhv94mROW0Mh6fsOQpcp3/pszPTe3Nw6TlvxVKdAETqJ1TNTckEj0GIKA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB1148.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:18f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 14:41:25 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 14:41:25 +0000
Message-ID: <eac21764-dbb1-441c-b42e-aacbd2ca0d67@gaisler.com>
Date: Fri, 9 Oct 2026 16:41:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sparc32: remove redundant memset in
 srmmu_nocache_init()
To: Sang-Heon Jeon <ekffu200098@gmail.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20260827145437.490605-1-ekffu200098@gmail.com>
 <20260827145437.490605-3-ekffu200098@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260827145437.490605-3-ekffu200098@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBC1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6a4) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB1148:EE_
X-MS-Office365-Filtering-Correlation-Id: 479615bd-73de-42a5-c094-08df26136529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DTcXiLcES5y/LpJ9hB3SEIdi75hKt0XBXIgEXx5/KF87uhQEt6fCgW6gM1mlb6LLTKLzwx4oP2lz8tmHoQGFG0iVHCZJL/JOgm3GcDHXT2RMDkDLR3ZhL2JlqcZKthOfIvNIU5fvYAk1O1Ss4vDOycGUufI7Tt/W8eZLOf74mdxDl7kDCioAcw1HNoZJp12gE7s2Cpeits/Kk8JqXh3MDbr/rboVCal1agtab1R79VxoedX2NBVpaTro7nQfXW07CxV8m4y1vc/6Ff5EO1OmPEZ916BRrikVzT4yX14grkR9H/c1i+k6M9QAz1SyvNHPLiCmMpsLYdZESQ/DrQlApz0NLQKWejhhU6sbizo9JSy8LiWEi4hF+bEAdXPRcT5fS9kMZL0zy+AfNWc0bT2jxc3GEeUU3NNrdEFqtLpIR43ovzBavpxgq7bRGjLqhkuRhWzP+7JPnPIl9W/nDqrVckmBdb5UblbRIn6oBied+MT1BECikG8sYCn5CdvDni6VGFhYWAHC22TqwkSwoZp059S3/cZwlkZXZC77Q651sx3TiT1s5P0JTxeHPBtGfXq8Ve8tfKZk8O+roCF9ctdPRESMXJ3nxpCTxxflrQ+rZh1qRxgPVTq9KXSmOoDkwCaR4iS1VtIvdVwhEPJppKZlIV//ZoAmWx5FBrlbAa5jqfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkJzbithclRaVG5SS0YzcTYyTiswKzRYbUViMmpyK2lFN2xBeC95THZBalV6?=
 =?utf-8?B?bkl1UVgrNW1DYTBtVE95M285aVVOVUdJMmQ2T09OZUVheEpCZWNMWTI5VWVu?=
 =?utf-8?B?OUtoeWY2bVgxRUoxN3BqdFRocVlvWUFuZmMrY2dMRW40T3BqWWtkZ3cxa2d2?=
 =?utf-8?B?L3NnbytiRXZEdUNJdjJuS2ZOTUc0STlrL3NKOXZsY2Q0MjN6ZTFwNi9kUGlh?=
 =?utf-8?B?NEFZK2ZkMVFYZ1VXMjBRYUhCakxtbkJvRG56RWg4RnRPUDVnMVJIQWNDQ0F5?=
 =?utf-8?B?T2k0OTlpRjRuU2ZIVy9YdG4yQ2FYY1NlRU1zN0liY2xNdzBTMkx4K3MzcHBZ?=
 =?utf-8?B?K1hjS0luTmJQQWNzN21JQk1YclhXZkk1bC8yMVVWU1NsUURFTzJvUnlucU9m?=
 =?utf-8?B?cjR3bE9vR2x3aTQ3ejBBY0F2Y2xpb1pOMGdkenkzVXl6VnlaSjIyTzNBVFRH?=
 =?utf-8?B?SUNxYTlPMzZDTjMxdUZKSnJza2lXMlJvZld5WTNNUkxFWlNRaGQ3b0FFNHo2?=
 =?utf-8?B?a0FmLzZhQVh5VDlIR3Q1UW5xM012bEF2Myt2UmhwU0h4aVhiWXJFNkF6Q2hp?=
 =?utf-8?B?VzNZaE12VjVvN3B0WHphQkd5VC9xQVg0bjFwUGUrTC8zTG1OZFcvWjRSR2JD?=
 =?utf-8?B?V2VmK1FoVlVKSWdpR2RPZGVCbzNZZDBhQzVSMW5QNE55UklQWWNCS29vcXEy?=
 =?utf-8?B?QWYwSlppYkVaSGZwM2d0bjhBcmwydWQyazlwMUxlbGhmRXBLcGcxbjJaOGhs?=
 =?utf-8?B?YVkzTk11d3NHNnY0TVVIczBjakJqQ2VhWVVtYTBObHJPUGR0b1FxdmRodHpI?=
 =?utf-8?B?cGEwemlZM0Q3VjhKOFdMeUlPYll6Ty9rWkt2YmxIZHI0QzZhSldtZHNocklK?=
 =?utf-8?B?KzN1S3FTTXlxNzRub214NlJGS2lwSEZlbzBpNlFwQmFFemZvTGc4QnBQY0w1?=
 =?utf-8?B?U0VkT2FLdDZTWkFocStGK3pTN1ZIdFU2d0JRbDRzcDY4Y2dOSENsQXUxWkpR?=
 =?utf-8?B?aEl3WElXNkx3Qm9Jdm03b2Q3NmN2SFRNOHBHaWVyVW9yYWp0SjlRUjNhaVlr?=
 =?utf-8?B?bmxMNlhxNTVhOEx3L3lIRDFVdHNRa3JYWHNpT0dEWWlUOWdvVFpKdFZKZXQ1?=
 =?utf-8?B?cW9zWTd1Qm1BRHowVVFPU2dwZ1E0UXh5TkM5MVNWNGZ5WkgxQk9idGV4dzNy?=
 =?utf-8?B?TytST2RybHRibFBjQ1JhMlVnb1d1bWt3TjNHN1V4Z1owNGZlSmxpaksyL3hG?=
 =?utf-8?B?cUpVZWpDQkl2RE1oV0poTm12NkpYbzhzUjhnOUJ5aXhVcE9TZGFSaUZlamRS?=
 =?utf-8?B?amFKdDJWY2ozei9uTHV6OStTNGhUNEhKbExoMVd3K3FTdTJDYnN5Ky82elln?=
 =?utf-8?B?WFJORjNRbnk3NWNxYm8yVXdWb3pUOEExMnRrRFkrTmZ1aWRITXUvK2VvY0ZM?=
 =?utf-8?B?OUFyN1FmUEpHZmhleHNUeGN1MTNWem41cXB0TkdvR29wc0FPMEQ4cVFEL1ZY?=
 =?utf-8?B?R3dFbDVQcDZ3YmdwQ0dxS3BBaHJQcU1rNHhVS0U4bTYxeWhXcWQvdEZiV0dp?=
 =?utf-8?B?bENjZ251NkM2aUtkMzZhWjBkUm5ZYzQ3aDJzK3NMSkJOMHI2NDg5RGdKcW5K?=
 =?utf-8?B?dmYrbnpHZFQ4WGg2STVoUUU2TVJvdloyazdUWlVORDhCWHFzUkg2ZTZwRHZi?=
 =?utf-8?B?S0lHRmJ3dzRDMzNYZ0VpN3RETExSaXlkaEQrT3MwaktRem42Qm0zemNHSTJG?=
 =?utf-8?B?VDd3RmFSOUtuNEFRQTIyT2I2WnJwUkJ2ekZBYnlCR1lBdTNTOGQ3b1FNUDd4?=
 =?utf-8?B?UjkrYWJmZk91WGlJNWc4U1FxVC9ycDduMVEwemFrV0lyRG9EeDhSTGdNTWpB?=
 =?utf-8?B?RHNoMmpENXpvMVg3Q04vbHkwa0oxNExJRy9GdUVEREhxWW13ZzJjS3VIZ3c0?=
 =?utf-8?B?dzNvY2JMM3ViaVVQREhNTFlLV2czMEdvRzVpZHV5WVpnU25zcTIxTERPR2Na?=
 =?utf-8?B?cXZITUFmOVFXdDN5c0xObEFISE9SUTJkdm8wOVBrTm54c0pVcjZ2OWt1RVc2?=
 =?utf-8?B?VGNtaFJxR0dzZ2xuSFU2WnMyNU5KM2pQT29CaFp2MHF6UllVajZjbXdQTmpN?=
 =?utf-8?B?RFpoUDYwUDYrMFFDeklkTDJIVmR6K0plYmlmc3RNSlFLZzZsMWpYMTA1ODZy?=
 =?utf-8?B?aHJyZWphTjBKK0F4dDNkdkVoWnBXc05acGk3VW1YbDVXV1lXT3JpVVpvNENt?=
 =?utf-8?B?NlN6amRIMVBBU0Z1WmpWUCt0akZrUmNWSmtzdGJWZnJYZFVtS1lOTzJWZ01D?=
 =?utf-8?B?SVRncDBNQzF5cDY5VzhiRlY4OFZHQi9xaGVEeE5RbnR6b05ZdDAwSUF1NVhN?=
 =?utf-8?Q?dM7R9Sh/3Mf7pVno=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 479615bd-73de-42a5-c094-08df26136529
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 14:41:25.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+266yBX4sYCXWuCaBiFzFE9PWSRVCrfERZ/VDKaXhbCCdAYv5Qw0sxhex4o61aGS7UnQ73uMOZXoN8sJ2xfW0nmPs9LPTABzZL1/M8i8Q4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1148

On 2026-08-27 16:54, Sang-Heon Jeon wrote:
> memblock_alloc_or_panic() returns zeroed memory, so the memset after
> the allocation is redundant.
> 
> No functional change.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  arch/sparc/mm/srmmu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 9a74902ad181..f9a92a07a255 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -279,7 +279,6 @@ static void __init srmmu_nocache_init(void)
>  
>  	srmmu_nocache_pool = memblock_alloc_or_panic(srmmu_nocache_size,
>  					    SRMMU_NOCACHE_ALIGN_MAX);
> -	memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
>  
>  	srmmu_nocache_bitmap =
>  		memblock_alloc_or_panic(BITS_TO_LONGS(bitmap_bits) * sizeof(long),

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

