Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020102.outbound.protection.outlook.com [52.101.75.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20904DA540;
	Fri, 25 Sep 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351907; cv=fail; b=GcLgPOeRjZtjrW0P2vsRlTraYN4+ZRym4PzfGYLbqCenM7mQmH4JaVe5il8zUz9R5GWo0HDcy3RybfsQDVydIJPwBnrlpzk1rv4wZ1zXjlFmdMCaWKTpJerSWBAvRdhpszV/+0tDxTA9no4WU0qptnZjaKxAtjKmXUaZTrxyjMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351907; c=relaxed/simple;
	bh=PpzFF6C9QGjFjP+tLOErDZKxZM1RcrzDwCiSVM6s1ac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V2OC0t3KDamC+lUGLniCgVR5W4Fb30n2tAKkO0nUZfFaGt4q5HIhC0swqlOXORxnyIY2v0UuUAVCPvSurm8E6aee36ueG+TtIhovwvec72K7oEXgPTYv4W5LGsAApr1XfbQqsS3CjZEM4Y3GsIeGVkQz0Btfv8F5+Tc3MELOzZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=cTwCQruE; arc=fail smtp.client-ip=52.101.75.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="cTwCQruE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yt/A1Cp6iXRVDTdxpl848hp+gNZA+WcB/nINTE5dsOb9aQwaMF8hsFIA73/R+fcTvf3zzFXAlvPlZCe4n8NRgaphhBstbLLsDgHxIuLIakMzxEW3T+VQ2dKyOPQNEpRY9CIUhV2/8T32Ffvy0Ayi2owj2DicWd8qd87Hf4Hiiw30qWsxi6ldIP9ps+pZza9g0bam5oPOkm7eJoOj8xD+508epudntO8/STmjjdfm7NoP0bh0piGdxfXAGprM4T5jUkbxJnKauN341j2gg7Y3EqoGfyJ53RJAx0Kwnih6r3gP8Gry4K7EFrfuOfq3hZHZ924acjvT5nWFWZgFHEoXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRAhKEBrdaupu8JRwUErMHDDwG1AOFdrTaYKLmNZZ6o=;
 b=cg6nUmzKURiHKnYvn2Z8lSXEAUebIdDgGDQ//nAzFhHyjS9hi2/s851KivMMUnZJYYzWTYS8Vy8MyipE/25Q4JUw3Z1F3urD33QbldhY83fXB6piSngKlOwI9idyAmby+D31m1VqRO1nJcNyVVZYb30Ix/4CN7Rlh/dN2uOWa3xd968D3Q8OuQ1YAiLnxmBHqk+YupLyw3HqTS4P5k+Ld2mOhdjE9JdXbISDVB4t8UWs+REBZrs9KfB7gvFwCJiNsb9kJDGkJWJHLPXBjl0VN62bdavCNCfSVhAEKECF2QW3EWyVDlswXdsOI9VesqpgybNiORI+GbRn4e6CkwgxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRAhKEBrdaupu8JRwUErMHDDwG1AOFdrTaYKLmNZZ6o=;
 b=cTwCQruE6xc3XMjwryI3fK5hLNH5RlxpjBEkIlxW5tLYHDxMqSzoENty63GgGgs7WjRirXkOgPc5YWvZwB51TPuaUvrHa4L//BsnUsPSR3jpnS5S9m+vD77t4I9roOThmzxdJmnOv+mi5aN+PhXaOS++7epIC9AqkHzf5O9TxhmoTeBBXiCqbJ+rgnb8am9PdFbv4MedaTEwS565ZiVR2wo2GHK6bosqkDkCxyGZkPwlW530aru3f6JJ1GfUXpPayatsW7FrfdKsk1M80cv5nKEO9YWOf0EPxcKLntXXI+dje295ISPpzTWrxIPi2ipHT3nI8M7L3M4tR1ykiy+4YQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by MM0P280MB2230.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:23::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:58:14 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 15:58:13 +0000
Message-ID: <01904ae2-ed8e-487e-80f7-540b4d06b55d@gaisler.com>
Date: Fri, 25 Sep 2026 17:58:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] sparc32: move early memory setup to setup_arch
To: Magnus Lindholm <linmag7@gmail.com>, sparclinux@vger.kernel.org
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, sam@ravnborg.org,
 glaubitz@physik.fu-berlin.de
References: <20260901214611.60560-1-linmag7@gmail.com>
 <20260901214611.60560-6-linmag7@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260901214611.60560-6-linmag7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC09.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::277) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|MM0P280MB2230:EE_
X-MS-Office365-Filtering-Correlation-Id: f14cfb1c-5140-49d1-b67f-08df1b1dce39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|6133799003|22082099003|18002099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	nI7ZmHyBlq4iOoeo1NUyDrFPjAA36tImS3A6Ut8j3kO5Y3cZqPPN7MEgEK9CeULcQcWfH3h8Q3aCdoMSA0IUlJVvy2Fqfn8IYnoaZ/nmcapjfCv94vTWnTiMkmjYiMyNDtrCWeyEVptv7+0Shxuxg000I++aF24Vn4tv86h6QXMgscYImrLL4tEPPFQaLqWmG4rJW1UTzt/yq/JSN1cUbxQZklwPylWW6aF0XIhydoIIqMUXHFhvL08xRGvPu1o/Y1qssHGIAkfKHEuZq7rn9CusxImjBDkHvTg4ga042vx9zmftevSBysTQMuaJ9t8fuU/t4mcboFPryki6I2Ck9OnMusTW9xvKX55aqg6rpKtbUz8T6TDph6iLt3pAL6sIaW0kY4T0X4i/aHptmAu/jvEGeY879UAVNhy5VJVBZq6nGu+PR3LAfNK/chY7U8vRvXCRZJcU8qDcKYWDhEHZmJOxzvIkS0uGChXYpfbXWx2r8afpu8Ns8hsCZXpaEX4ZI8JWiygBn96LJp3fWeK7C305+knQNWQaD9dG66PyewqemI1MephN1l3TBJebPC4wh6GlQJnrQPFZebIMftgT9i9VXK/rmuyfqQLgFc+q6LxT7eNktgFyNMueBdZ1iT0WXFMcACs5upbciOGyCACT1RZGnhE153XV/HO4WrXkTP8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENtRXFvdGVxZmVnM1p2VGdXREpjajBCREhFR0pnWWpPL3U2S256RjAzSUd4?=
 =?utf-8?B?d2pEWlh4NWV3NmhKaVlGQ0lBZEtIT3drR1J3c0lVZU9BOFV1b2hHcHZ6Wmoz?=
 =?utf-8?B?RHlScFJ4WmRFVk5oTDlQOUpmalBvMFRLc2hHZ3lCa0E0YXZMR1F5UVZ5UVd6?=
 =?utf-8?B?U1E4cWIvYUs4N2ZCUWRFWHNmL3Q3dlUzbVh6TFVkTkFVci83UHkxKzM3Z3Za?=
 =?utf-8?B?Mk5lUXk5SzdsbG5hUkhIb2ZkT2pjTklYL0RXY2NpWlFhOTc4aE84SnZFV2Rn?=
 =?utf-8?B?eXdoTVdXVC9sUkE3YkNiY25vTlRISmdJZU1JbHpFOTM1YXF6aGFCc1FYRGs5?=
 =?utf-8?B?MUdLQVhXdlJmM0NONlUwb05WSWU2ODdsMnVFTTZ3ZWJWWHB0YXg5U1RYL3Y0?=
 =?utf-8?B?MXE4RTZDSUlRcFA3NkIyNWlpRlJHYjIra21LS1hGMHdFTjJOZ2pyUGU1U2tk?=
 =?utf-8?B?dk1vb2F2ZTBlVm1jRjJPNUFDVEFyUldYOTRtTjEvUzh2MjgxVEpPUWw5bTJY?=
 =?utf-8?B?TGtmQm4ybVd4TXEwSlNlZGNNbUZPbFJlRTN0dVJHQWU3bkljWjFjbTNUbUE5?=
 =?utf-8?B?Z0hFRSsybVdFZFd2TzUySVFWZUxtTFFvcXBzaUJ6TGRKQU9tSkNFNDZSeGJY?=
 =?utf-8?B?SFcrQjlyWllzN1JLREhPdlhNcWVKTm9namF2VWEyTFZaNW15M0RCY2VwcXVX?=
 =?utf-8?B?MnRtUjRLNTZiZU1QcTJIVHNMSFdOcXRUdzU1TlNleFJROFA5SjdJRzFOZXJn?=
 =?utf-8?B?TS9OZFNGWkhBMEtsbXZtU1lYRHZucjR2VWQ0S1I0TkpvcmFhTTVtUnZmc0tZ?=
 =?utf-8?B?SkM4OTJOOHY0eGRpdGs2S0JMaDdRQjJFQWcvb0F1YkFBVTBrNnNiRmRnSnpX?=
 =?utf-8?B?eS9RTnJGUFVmaGhxcWdIMlFIalplWG9LYlFVa1A2VDJNRWNQVVRHNEhZVFJV?=
 =?utf-8?B?VUZRc21wVk9jRm5HZUZ6QWtrZ0s1c3JReGNtVGVtalJpUzB0ekRWVnhKY2Mx?=
 =?utf-8?B?YklLMnZqRUFMNzVlUDBaUnhKVUFibnNPTFY4ZFNLUFhWeVFqYXBVVTY2ZlNt?=
 =?utf-8?B?TkNNazNFMXBNS0JrNSt6VzJJeTI2eTQvd25UVWZRdWZsRnBYNmRsdStoMkVy?=
 =?utf-8?B?VW83dy9SWFhwM0pEcDBwYUk2V2NIcDUrOXl6bWhLTU5RTjA2OStSZld1a0gv?=
 =?utf-8?B?QkpQcEtkYlpkaDBxZG1uclRZSzFzUFlCTlFlUmJpa2xrRG9YcS9HMnMzV2cw?=
 =?utf-8?B?b01HZUxLY2lBYTBwYjdyaklqWXdZeVBBM3dUbWtmSlVHdmhEaGVVZ0YrV0ww?=
 =?utf-8?B?eC9NYTBZVzJnbFZsOU5lNlZ6cjJIRHErcFRwOG1HclhSNEMySXlXaHQyNzdU?=
 =?utf-8?B?bXJIeGd4Ums5bFdPTEZseDFSVlg5OEFsek1yTWkzejRqT3dKWWFMVFFrL3Bm?=
 =?utf-8?B?cGhUejlsRWhUV3dHTStiOTNIMGNOWmZEd0traVJscDF2RmQ0ZFVwTDdTTXZX?=
 =?utf-8?B?Zi9BTnIxQWduaGFCYkE4VEY2cTlodmJSbFZlS0g1aGloTXZveFZ5SWhiSDFY?=
 =?utf-8?B?aGg1K1hPckdZK0NvQ3lsS2hXYk5xaUU0R0JSRENueElYSnE5eWFwSGZnUTZE?=
 =?utf-8?B?bk5xcHBMSjFCQ3cwcmg0eUZFM3M4QncrdVpqK3lBY2NlcUxITVA5MDB5VWw2?=
 =?utf-8?B?NTREckxDSG41Rks1Zjd5dnJJZ29XYmF3MmxSa3BzenN4MkY0eTEwV3VSaTJV?=
 =?utf-8?B?LzJHYUVRZXZwSHNJdmZ4RVh0aWJsUVhjY1ZmTWJsU3Zkc0FJa2hTdWttRGhW?=
 =?utf-8?B?anRzMVI5ZzFqdmxEc2VjWGNvRUQxUE43U0xkWm1rS2RNVzBOZUZ4MFRxcGF6?=
 =?utf-8?B?ZkhpSXA3VEZLUlNQV0d1MENVRUdDRWpYZEdCVHV0ZENkRy9tVzc5SFVzRUgr?=
 =?utf-8?B?NGpmWDFRZXo5NTlzNUlhUnBuYmlXaTBUcnhOSjRUSFFBZS9QZzJiMy9VZkJ3?=
 =?utf-8?B?NnRPNVN2d0owRS9MNFViVXIycTI1ZUVyVE5Xd20vWlJ1bGdRQ1J3M2RHRDda?=
 =?utf-8?B?RkRwbk51OFFxR0xKYVo4bWpzQXl3L0orKzdmMzl0emZzM3dIS2UrdGxVN21W?=
 =?utf-8?B?TFdYRWhuOFoyTDVyM2pmVVp2eVRnSyt1aG5Bb1FudFVab2xjSldIMU5DdDZP?=
 =?utf-8?B?Zzl5SkhLaElFUkplcUdJd2lRMUdQa05Bbm1sZ0szaGFCbU5oa0VYN2M0OEpw?=
 =?utf-8?B?TnZNREVZSnFHUVBQWGNYVUVHK1ZvcjNkVUEzdnYyemQrd05FUFEzOTFQZ250?=
 =?utf-8?B?d2FCQ3o1VDBMNFdxQTV6STZGZmFyTTl0Wis5ZFZhSEZmSStpVjg1RDFsYzFy?=
 =?utf-8?Q?f+oAuX/PpsamyQRE=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f14cfb1c-5140-49d1-b67f-08df1b1dce39
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:58:13.9138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjyxN5YIcNZ1jz9Hxf0W139XVIeYr+54t5LtltJsSBkjRESly0+hvPIi5Sn9okvfH5Z/PA0C5yoQ/YlYZu8ARrJyIjHt6tm/WKBjufur3wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB2230

On 2026-09-01 23:45, Magnus Lindholm wrote:
> Move the early memory configuration out of SRMMU paging setup and next to
> the rest of setup_arch(). Derive the PFN limits from memblock, reserve the
> kernel and initrd there, and retain mem= support with
> memblock_enforce_memory_limit().
> 
> Use for_each_mem_pfn_range() to find the lowmem boundary and replace
> last_valid_pfn with the standard max_low_pfn variable. Set the standard
> max_pfn variable to the end of physical memory and use it as the highmem
> zone limit. This tightens LEON's _pfn_valid() upper bound from all RAM to
> the lowmem limit, with no functional change because LEON does not use
> highmem.

It is not at all true that LEON systems do not use highmem. Rather, they
can make heavy use of highmen. Continued further down.


> The removed bootmem code also printed a private HIGHMEM summary. Generic
> memory initialization already reports the highmem zone, so do not retain
> the duplicate message.
> 
> When PAGE_OFFSET maps a relocated kernel, remove memory below phys_base
> from memblock because it cannot be reached through the linear map. This
> replaces the equivalent trimming of sp_banks.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  arch/sparc/include/asm/highmem.h    |   3 -
>  arch/sparc/include/asm/leon.h       |   2 +-
>  arch/sparc/include/asm/pgtable_32.h |   3 +-
>  arch/sparc/include/asm/pgtsrmmu.h   |   1 -
>  arch/sparc/kernel/setup_32.c        | 112 ++++++++++++-----------
>  arch/sparc/mm/init_32.c             | 132 +---------------------------
>  arch/sparc/mm/leon_mm.c             |   1 +
>  arch/sparc/mm/srmmu.c               |   8 +-
>  8 files changed, 67 insertions(+), 195 deletions(-)
> 
> diff --git a/arch/sparc/include/asm/highmem.h b/arch/sparc/include/asm/highmem.h
> index c7b2e208328b..b1b915ac604d 100644
> --- a/arch/sparc/include/asm/highmem.h
> +++ b/arch/sparc/include/asm/highmem.h
> @@ -26,9 +26,6 @@
>  #include <asm/vaddrs.h>
>  #include <asm/pgtsrmmu.h>
>  
> -/* declarations for highmem.c */
> -extern unsigned long highstart_pfn, highend_pfn;
> -
>  #define kmap_prot __pgprot(SRMMU_ET_PTE | SRMMU_PRIV | SRMMU_CACHE)
>  extern pte_t *pkmap_page_table;
>  
> diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
> index 053a24b67aed..815131c77ed7 100644
> --- a/arch/sparc/include/asm/leon.h
> +++ b/arch/sparc/include/asm/leon.h
> @@ -251,7 +251,7 @@ extern int leon_ipi_irq;
>  
>  /* macros used in leon_mm.c */
>  #define PFN(x)           ((x) >> PAGE_SHIFT)
> -#define _pfn_valid(pfn)	 ((pfn < last_valid_pfn) && (pfn >= PFN(phys_base)))
> +#define _pfn_valid(pfn)	 ((pfn < max_low_pfn) && (pfn >= PFN(phys_base)))

What is the reason for doing this change? When leon_swprobe() is called
max_pfn has already been set up. Is there a reason for not using that?


However, in the scope of the calls to leon_swprobe(), no parts of the
inherited MMU table's PTDs/PTEs are outside of lowmem. If there indeed
is some technical reason for needing to do this change I suggest that
you, in a separate patch before this one:

- Remove PFN() and replace the callers in leon_mm.c with the standard
  PFN_DOWN() instead, as also Sam lifted as "future work", and

- Move the _pfn_valid define to leon_mm.c, make it only check for lowmem
  pfns and rename it to _pfn_lowmem() or something like that.

>  #define _SRMMU_PTE_PMASK_LEON 0xffffffff
>  
>  /*
> diff --git a/arch/sparc/include/asm/pgtable_32.h b/arch/sparc/include/asm/pgtable_32.h
> index f89b1250661d..91a6032cf6a2 100644
> --- a/arch/sparc/include/asm/pgtable_32.h
> +++ b/arch/sparc/include/asm/pgtable_32.h
> @@ -37,8 +37,7 @@ struct vm_area_struct;
>  struct page;
>  
>  void load_mmu(void);
> -unsigned long calc_highpages(void);
> -unsigned long __init bootmem_init(unsigned long *pages_avail);
> +void __init find_ramdisk(unsigned long end_of_phys_memory);
>  
>  #define pte_ERROR(e)   __builtin_trap()
>  #define pmd_ERROR(e)   __builtin_trap()
> diff --git a/arch/sparc/include/asm/pgtsrmmu.h b/arch/sparc/include/asm/pgtsrmmu.h
> index a265822a475e..a2a6c8564c3e 100644
> --- a/arch/sparc/include/asm/pgtsrmmu.h
> +++ b/arch/sparc/include/asm/pgtsrmmu.h
> @@ -98,7 +98,6 @@
>  	 restore %g0, %g0, %g0;
>  
>  #ifndef __ASSEMBLER__
> -extern unsigned long last_valid_pfn;
>  
>  /* This makes sense. Honest it does - Anton */
>  /* XXX Yes but it's ugly as sin.  FIXME. -KMW */
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 795714959da6..6ad85538964d 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -23,6 +23,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/kdev_t.h>
>  #include <linux/major.h>
> +#include <linux/memblock.h>
>  #include <linux/string.h>
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
> @@ -254,28 +255,71 @@ static __init void leon_patch(void)
>  
>  struct tt_entry *sparc_ttable;
>  
> -/* Drop RAM below the kernel; the linear map runs upward from phys_base
> - * and cannot reach it.
> - */
> -static void __init trim_sp_banks_below(unsigned long base)
> +unsigned long phys_base;
> +EXPORT_SYMBOL(phys_base);
> +
> +unsigned long pfn_base;
> +EXPORT_SYMBOL(pfn_base);
> +
> +static unsigned long __init calc_max_low_pfn(void)
>  {
> -	int i, j = 0;
> +	unsigned long limit = pfn_base + PHYS_PFN(SRMMU_MAXMEM);
> +	unsigned long start_pfn, end_pfn;
> +	unsigned long last_pfn = 0;
> +	int i;
> +
> +	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
> +		if (start_pfn >= limit) {
> +			if (last_pfn < limit)
> +				limit = last_pfn;
> +			break;
> +		}
>  
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		unsigned long start = sp_banks[i].base_addr;
> -		unsigned long end = start + sp_banks[i].num_bytes;
> +		last_pfn = end_pfn;
> +	}
>  
> -		if (end <= base)
> -			continue;		/* wholly below - drop it */
> -		if (start < base)
> -			start = base;		/* straddles - trim the front */
> +	return limit;
> +}
>  
> -		sp_banks[j].base_addr = start;
> -		sp_banks[j].num_bytes = end - start;
> -		j++;
> +static void __init setup_memory(void)
> +{
> +	unsigned long ram_base = memblock_start_of_DRAM();
> +	unsigned long real_base = __get_phys(PAGE_OFFSET);
> +	unsigned long size;
> +
> +	memblock_set_bottom_up(true);
> +	memblock_allow_resize();
> +
> +	phys_base = ram_base;
> +	if (real_base && real_base != phys_base) {
> +		prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
> +			    (unsigned int)phys_base, (unsigned int)real_base);
> +		phys_base = real_base;
> +		memblock_remove(0, phys_base);
> +		prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
> +			    (unsigned int)phys_base);
>  	}
> -	sp_banks[j].base_addr = 0;
> -	sp_banks[j].num_bytes = 0;
> +
> +	if (cmdline_memory_size)
> +		memblock_enforce_memory_limit(cmdline_memory_size);
> +
> +	min_low_pfn = PFN_DOWN(memblock_start_of_DRAM());
> +	pfn_base = PHYS_PFN(phys_base);
> +	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
> +	max_low_pfn = max_pfn;
> +
> +	if (max_low_pfn > pfn_base + PHYS_PFN(SRMMU_MAXMEM))
> +		max_low_pfn = calc_max_low_pfn();
> +
> +	find_ramdisk(memblock_end_of_DRAM());
> +
> +	/* Reserve the kernel text/data/bss. */
> +	size = __pa(PAGE_ALIGN((unsigned long)&_end)) - phys_base;
> +	memblock_reserve(phys_base, size);
> +	memblock_add(phys_base, size);
> +
> +	/* Only allow low memory to be allocated by memblock. */
> +	memblock_set_current_limit(PFN_PHYS(max_low_pfn));
>  }
>  
>  /* Called from head_32.S - before we have setup anything
> @@ -306,9 +350,6 @@ void __init sparc32_start_kernel(struct linux_romvec *rp)
>  
>  void __init setup_arch(char **cmdline_p)
>  {
> -	int i;
> -	unsigned long highest_paddr;
> -
>  	sparc_ttable = &trapbase[0];
>  
>  	/* Initialize PROM console and command line. */
> @@ -343,36 +384,7 @@ void __init setup_arch(char **cmdline_p)
>  
>  	idprom_init();
>  	load_mmu();
> -
> -	phys_base = 0xffffffffUL;
> -	highest_paddr = 0UL;
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		unsigned long top;
> -
> -		if (sp_banks[i].base_addr < phys_base)
> -			phys_base = sp_banks[i].base_addr;
> -		top = sp_banks[i].base_addr +
> -			sp_banks[i].num_bytes;
> -		if (highest_paddr < top)
> -			highest_paddr = top;
> -	}
> -
> -	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
> -	{
> -		unsigned long real_base = __get_phys(PAGE_OFFSET);
> -
> -		if (real_base && real_base != phys_base) {
> -			prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
> -				    (unsigned int)phys_base,
> -				    (unsigned int)real_base);
> -			phys_base = real_base;
> -			trim_sp_banks_below(phys_base);
> -			prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
> -				    (unsigned int)phys_base);
> -		}
> -	}
> -
> -	pfn_base = phys_base >> PAGE_SHIFT;
> +	setup_memory();
>  
>  	if (!root_flags)
>  		root_mountflags &= ~MS_RDONLY;
> diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
> index 6880d9cb30a5..ac4462f1cf76 100644
> --- a/arch/sparc/mm/init_32.c
> +++ b/arch/sparc/mm/init_32.c
> @@ -35,66 +35,13 @@
>  
>  #include "mm_32.h"
>  
> -unsigned long phys_base;
> -EXPORT_SYMBOL(phys_base);
> -
> -unsigned long pfn_base;
> -EXPORT_SYMBOL(pfn_base);
> -
>  struct sparc_phys_banks sp_banks[SPARC_PHYS_BANKS+1];
>  
>  /* Initial ramdisk setup */
>  extern unsigned int sparc_ramdisk_image;
>  extern unsigned int sparc_ramdisk_size;
>  
> -unsigned long highstart_pfn, highend_pfn;
> -
> -unsigned long last_valid_pfn;
> -
> -unsigned long calc_highpages(void)
> -{
> -	int i;
> -	int nr = 0;
> -
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		unsigned long start_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
> -		unsigned long end_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
> -
> -		if (end_pfn <= max_low_pfn)
> -			continue;
> -
> -		if (start_pfn < max_low_pfn)
> -			start_pfn = max_low_pfn;
> -
> -		nr += end_pfn - start_pfn;
> -	}
> -
> -	return nr;
> -}
> -
> -static unsigned long calc_max_low_pfn(void)
> -{
> -	int i;
> -	unsigned long tmp = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
> -	unsigned long curr_pfn, last_pfn;
> -
> -	last_pfn = (sp_banks[0].base_addr + sp_banks[0].num_bytes) >> PAGE_SHIFT;
> -	for (i = 1; sp_banks[i].num_bytes != 0; i++) {
> -		curr_pfn = sp_banks[i].base_addr >> PAGE_SHIFT;
> -
> -		if (curr_pfn >= tmp) {
> -			if (last_pfn < tmp)
> -				tmp = last_pfn;
> -			break;
> -		}
> -
> -		last_pfn = (sp_banks[i].base_addr + sp_banks[i].num_bytes) >> PAGE_SHIFT;
> -	}
> -
> -	return tmp;
> -}
> -
> -static void __init find_ramdisk(unsigned long end_of_phys_memory)
> +void __init find_ramdisk(unsigned long end_of_phys_memory)
>  {
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	unsigned long size;
> @@ -124,83 +71,6 @@ static void __init find_ramdisk(unsigned long end_of_phys_memory)
>  #endif
>  }
>  
> -unsigned long __init bootmem_init(unsigned long *pages_avail)
> -{
> -	unsigned long start_pfn, bytes_avail, size;
> -	unsigned long end_of_phys_memory = 0;
> -	unsigned long high_pages = 0;
> -	int i;
> -
> -	memblock_set_bottom_up(true);
> -	memblock_allow_resize();
> -
> -	bytes_avail = 0UL;
> -	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> -		end_of_phys_memory = sp_banks[i].base_addr +
> -			sp_banks[i].num_bytes;
> -		bytes_avail += sp_banks[i].num_bytes;
> -		if (cmdline_memory_size) {
> -			if (bytes_avail > cmdline_memory_size) {
> -				unsigned long slack = bytes_avail - cmdline_memory_size;
> -
> -				bytes_avail -= slack;
> -				end_of_phys_memory -= slack;
> -
> -				sp_banks[i].num_bytes -= slack;
> -				if (sp_banks[i].num_bytes == 0) {
> -					sp_banks[i].base_addr = 0xdeadbeef;
> -				} else {
> -					memblock_add(sp_banks[i].base_addr,
> -						     sp_banks[i].num_bytes);
> -					sp_banks[i+1].num_bytes = 0;
> -					sp_banks[i+1].base_addr = 0xdeadbeef;
> -				}
> -				break;
> -			}
> -		}
> -		memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes);
> -	}
> -
> -	if (cmdline_memory_size)
> -		memblock_enforce_memory_limit(cmdline_memory_size);
> -
> -	/* Start with page aligned address of last symbol in kernel
> -	 * image.
> -	 */
> -	start_pfn  = (unsigned long)__pa(PAGE_ALIGN((unsigned long) &_end));
> -
> -	/* Now shift down to get the real physical page frame number. */
> -	start_pfn >>= PAGE_SHIFT;
> -
> -	max_pfn = end_of_phys_memory >> PAGE_SHIFT;
> -
> -	max_low_pfn = max_pfn;
> -	highstart_pfn = highend_pfn = max_pfn;
> -
> -	if (max_low_pfn > pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT)) {
> -		highstart_pfn = pfn_base + (SRMMU_MAXMEM >> PAGE_SHIFT);
> -		max_low_pfn = calc_max_low_pfn();
> -		high_pages = calc_highpages();
> -		printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
> -		    high_pages >> (20 - PAGE_SHIFT));
> -	}
> -
> -	find_ramdisk(end_of_phys_memory);
> -
> -	/* Reserve the kernel text/data/bss. */
> -	size = (start_pfn << PAGE_SHIFT) - phys_base;
> -	memblock_reserve(phys_base, size);
> -	memblock_add(phys_base, size);
> -
> -	size = memblock_phys_mem_size() - memblock_reserved_size();
> -	*pages_avail = (size >> PAGE_SHIFT) - high_pages;
> -
> -	/* Only allow low memory to be allocated via memblock allocation */
> -	memblock_set_current_limit(max_low_pfn << PAGE_SHIFT);
> -
> -	return max_pfn;
> -}
> -
>  /*
>   * paging_init() sets up the page tables: We call the MMU specific
>   * init routine based upon the Sun model type on the Sparc.
> diff --git a/arch/sparc/mm/leon_mm.c b/arch/sparc/mm/leon_mm.c
> index 1dc9b3d70eda..a43c5ffbbbe5 100644
> --- a/arch/sparc/mm/leon_mm.c
> +++ b/arch/sparc/mm/leon_mm.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/memblock.h>
>  #include <linux/mm.h>
>  #include <asm/asi.h>
>  #include <asm/leon.h>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index f094f6c105a2..e333d3eac451 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -59,8 +59,6 @@ int vac_line_size;
>  
>  extern struct resource sparc_iomap;
>  
> -extern unsigned long last_valid_pfn;
> -
>  static pgd_t *srmmu_swapper_pg_dir;
>  
>  const struct sparc32_cachetlb_ops *sparc32_cachetlb_ops;
> @@ -871,7 +869,7 @@ void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
>  {
>  	max_zone_pfns[ZONE_DMA] = max_low_pfn;
>  	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> -	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
> +	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
>  }
>  
>  void __init srmmu_paging_init(void)
> @@ -884,7 +882,6 @@ void __init srmmu_paging_init(void)
>  	pud_t *pud;
>  	pmd_t *pmd;
>  	pte_t *pte;
> -	unsigned long pages_avail;
>  
>  	init_mm.context = (unsigned long) NO_CONTEXT;
>  	sparc_iomap.start = SUN4M_IOBASE_VADDR;	/* 16MB of IOSPACE on all sun4m's. */
> @@ -910,9 +907,6 @@ void __init srmmu_paging_init(void)
>  		prom_halt();
>  	}
>  
> -	pages_avail = 0;
> -	last_valid_pfn = bootmem_init(&pages_avail);
> -
>  	srmmu_nocache_calcsize();
>  	srmmu_nocache_init();
>  	srmmu_inherit_prom_mappings(0xfe400000, (LINUX_OPPROM_ENDVM - PAGE_SIZE));

Thanks,
Andreas

