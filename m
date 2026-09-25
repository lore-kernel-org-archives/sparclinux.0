Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022072.outbound.protection.outlook.com [52.101.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C739449C;
	Fri, 25 Sep 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351171; cv=fail; b=Zyd0ygt8FAVopzXeFvHiibzPO7ihItToRZ5Ks8yYvxkWwBzdYznH2XtzJBeNkTVnumsfaSEXtm176B9nBNdj0D37Fulfzjd5GQBW2c0OcMeTn4f8fgUmcMNGFUIDBhALRrKlPVHuDRvgiFC6TCOtxpQjMMbOElH/RPNXWK1JFac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351171; c=relaxed/simple;
	bh=4+Xe4LvNuDgHEbPhf6l/UlnMA8TNkwmktqVylzVtFJQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VzwEJYg9dyUTdHd9bJxmEDXgMku0oAjoJ2uZPX1wDlFkIZaWlVd5UIRw1lhqyIv0T12WIpv1T9cDFRAt9BrkzNr2QTZbAnHNZU9beWxEyGqtWmsN8mtL8q87y/mlfVTK5sMntucuAbYx8U040IM3kz0M2ikYZMJhF4IdDiCWtWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=TjVRGiAK; arc=fail smtp.client-ip=52.101.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="TjVRGiAK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZwN5KDNCZ5MEP+O/+nlMMgghD7sh0ywg+Z56ZphdGOXA6+xjcFI3HlrOhPgEBATtq+6sRaLdBy41IHBPKcjxnbcWI7sqTcnbsB1cqA7UgC7ipsuPEUTxbh2w/oLItmswHwQ4F2C1ylgx6Lfht5jPTlznxS3PCamWc6IQXurSgGeZpuBEKOt9gv7ZB1TGs45T4LWwPMr9guKUZ1WnTyOR+W4DizAnCTgx+IqZVeUtlQMhOZ8nbubTc+6SAojnFq3nQR5rItkHEIqHyOY2KS/HPLRnnC6mBEMv9wVCrAw6zCVQZTGHo2/p/4t2QZVjwDdvug0aZczpTWP6OOBuaKVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTBG9OkfXMmZeOfHo8/NqYrUgtD0BzDyIC/iCXWXvh0=;
 b=KhZPxBN9Ku0RdCqwfYR+ib7Pv131QphybKo4rQZP8CfQEaAVEyAVDklEFuybkPhyW0UiE62gPkVctv0aM8nR8S76o1Lz0ay5hFuDgYD392WploExbdUobNDbLd65uICbikbfycfTgRUkQw4epofZZbP7yEzKFHNUfsMEB1CkBhLpyHlNMgwrisS6Lg78skzKqOPjYSQML0mxVM1xCXYcUQyOu5XY3BbKeZh8ZJZTksRf0qBpduwMexofE8qIygo/obs4F0jYoB3R/7iI7mJ9RnSdoPhmucHJrQ3k6RX3G6qQfjDDLen4V/XLiGCnf3fMmbfG5UYI/0qKjB1i1CrZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTBG9OkfXMmZeOfHo8/NqYrUgtD0BzDyIC/iCXWXvh0=;
 b=TjVRGiAKlcbcHMvHzP4JhgDTxJ7SUXF8PuUi7gaW8IVsDUZMdSD58OhmwhdVEolzYKYbe+OfJZU6sGxGy6ASsx0xYosIgDI0WoJOw2Y8XGtNZFd0hEO6XoX4ucAxnPFxaoCwnOXb6W2b2B3/4tDJbbVhZxvbiF++JuE27TmfSXiXrmEL8/gVrqepNC1Tlt5oRczAYCne5srY7jHnlim4Arw3JpiMsU7tWep2DVYrz80LzxrXa1QKa38sMp2kNLAn2Q8V6r3iAPxBCKS73UyUudeQUBTuiAMpbD3z5E1lIHF7v/IROqLc8om/egBKGYXnOIlZugjzNEGuyMTDS7CidQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GV5P280MB2059.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:373::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 15:46:02 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 15:46:02 +0000
Message-ID: <4038ae1d-40ae-44bd-b914-ffb064a695dc@gaisler.com>
Date: Fri, 25 Sep 2026 17:46:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET
 mapping
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260816075141.3489194-1-linmag7@gmail.com>
 <20260816075141.3489194-3-linmag7@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260816075141.3489194-3-linmag7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBCA.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6aa) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GV5P280MB2059:EE_
X-MS-Office365-Filtering-Correlation-Id: 3163acde-cce7-4e85-d7cc-08df1b1c1a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|4143699003|10067099003|56012099006|11063799006|5023799004|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nM0VztYvvAuUXriFsvwOqoMioGKPdD8D2ZQxYvwmVbRqEfWHqdlg74d06QV2SXYjUhPsitRJWXNkgXUB3jxOE/V5OHtK4SDuW5b0J3R5HndorjQxE0bVUr1tGzSITD+Itza8qcpuce9hyf4c1OWsBWbDVcv4PETm55+mJ6OJq+f4Jgk25q/dju/ucdMy5TggbiQ9yB3aTcj13+aehrEJCXrzQoBd28v7scogEIm6RopBiGB7NXqWH8l3yS9su7n3HPco969EvwUC7zcqusQO0rwZ4wooZk1hhTHlL4NFlv2jOhxkT3gyCxL4QPPdXaUGTdAwfHpaOUwz4meoVlEbGnflX07g4JYhaGdPyhPwA/7Jpf97jXyp4+5iOS98FXELcGPCQK99WvrgNMOSavMyWNT6XsSl9vjyfUrT3fOhH185TmzAyCjcNHGxWXxqTUx5TlrmkMpQtanK1dKoEv7fAPa/yTDQ+wjDIJZuj+wZWg6TOoEfNhpwRKG2dQwnodBBImkyr8zbQ1VXjSd3DBHs6/4Wo78PWBjsNZrEJEdO9KC3bqdffXcZhr9eLgsP1CSKhg3zxiLZagWasqnn2AK5/Moe9uoGMrO6mhK/GGE3/8wuVRWiaH/m1yqZXc1N7MF2vDtPlJr/h63BMBIxEIZZTQYYa0pcP7+a9eg+VQo54Go=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXp6SEpuZEdpVzhndVp6dm1sRW1RY2dVYnpBK1hDa2dDaHpVUTBjS3V5U0hs?=
 =?utf-8?B?VExxTnFNRnFtMEVUWkE3SzFWY2Y1ZTBQc3ZXNGxFcG94ckM0TmNYQ1BnMjRP?=
 =?utf-8?B?QXdSSVg1RzZySFFHdDFpODRZNEM5MDFkUS9GN1VEOUJMeUVSeHRpaTRrT3Y3?=
 =?utf-8?B?bXpocG1jaVBRZHo2eVM1S2NDVW82OWRXaW9EZHUwdDFDQXg2ZjE2UFB0b3Bh?=
 =?utf-8?B?bW5XdzBweHAwR0FMbEt1c3lXNDNRZzZZUVpnb051OWl4ckVpU052TFN6cHVP?=
 =?utf-8?B?TkJhSFlPaWNWR2puRkw3K1pPaDJGR2hkclF4aWo5U21mT2JqY21ETy9pSVU0?=
 =?utf-8?B?WVNFUnlYbVVmRU9KSk1TK0dSdEk0QUU4bHRscVFxbFhBamY2TEdaUnF6MDBZ?=
 =?utf-8?B?Q3d1a0o3REpoU1BIUEs4UGN4cFpEZ3hTQkg3d1NBemVZK2MwYUplQnFCUmFu?=
 =?utf-8?B?N2hFNk1tRFRjdnhuSVh3dzJBb1I2VlkzY0FjckJtWGtOZFI2dytCT0ZzRzZW?=
 =?utf-8?B?MmY2Q25rOElGLzZhRHN0dlhVRko2Qk94MWY0MksvdWVkZUZidklIdERoUXIr?=
 =?utf-8?B?SWdEallaeUk0THdOZkgrRDBHbGJlNzVab0huSjFYaU1vakJ1aEllMnhxSllh?=
 =?utf-8?B?aVczdEY3TmRHc2V1WUVuNDA1dUZHOUxXVGdtaC9pK3Z4NmQxc2pNNE5Hdngz?=
 =?utf-8?B?WHNJVTJLSHhsOXRINUYwSzQ4UTRRWnZqRlc2emhGYlNrSFVmM0JrOEM2L05E?=
 =?utf-8?B?dWkwYmhhMzB0OU5GelUxSzhxeXd6NWoyR3B1LzNmVWo2TnBlQVBqQVpxZnhM?=
 =?utf-8?B?eTIwYnhQVlRlQU01WW5aZWRJVXprTFZ3Zm5rTitDcVZJTEZNb0VHWWpSaThE?=
 =?utf-8?B?SjZTTVpGOXBrV1ZUeUxVdDFsWmhrZVFFM1k3ZlBnZVluT3JkZ3Bhc00vNUg2?=
 =?utf-8?B?a2FpYVR0eDFoOW9mNXhNblJjd29VS2w4eTQ3Q01KUmx3VlBoaFdvUUpHb0tN?=
 =?utf-8?B?amxQOHlZd0dUcDZoTUkzbUZXcWZha3FHNDViR1ZuY21id3p0ZGhWUUY5dmNi?=
 =?utf-8?B?WEZmSGg1THcvcVl3dlVmeHVxT3N1bnFWK3phUlFkRzIrYlM3aEpTM1FqNkxh?=
 =?utf-8?B?OXo5M0k2a2krM0FYeU9waXZCQjJRbGtOc1FWZHZYTjFCbXo0UzNIcndhTFdl?=
 =?utf-8?B?ZFpNQzZibkxqN3hZNHllekVtRXhocElHZ0QxeVdXS1pWSE04U1dqbjIwYzlV?=
 =?utf-8?B?QjkvOTN1QTd3NHkxMVRaMXZ4NXl5TTRFTjBmb0NIUVlnajhtNWRuSmNtblV0?=
 =?utf-8?B?NzlydjRWY1kwcG5VSHZXcFZJY1U1ai9iUmZsUVZxcEQwcFJJYUJmZ1N4MElj?=
 =?utf-8?B?K0JBOGJvVmJpQVFmTVgwa2ZyL0VKT3R3eC91UTZiMmdSa0VhcHRvNk9TdVZF?=
 =?utf-8?B?ditkbUtZbHFmanJ4bnRFeHpkclh1T2ZLZ2FFOUQ5alQzeEFJb1pwbEppTlg3?=
 =?utf-8?B?c3MwalJDNmlUNFdoNTI4SDYwQTdneGMyRFE1QS90Vk1EL25NeFNPOXFvQ09N?=
 =?utf-8?B?QVIzK3VvblFvSlJlQnIxL0xIZVExOUdITXR5dzJxcWRzMElzZXVQaVByMFAx?=
 =?utf-8?B?Z1pJOHhYOU8wendXNXE0OVNBM01NR3JQWitCMjRLVnpzVmV0dnFsMnVjOFI5?=
 =?utf-8?B?KzdwUGlMTGY5SFBydTNVLytmVjk2VUdXMFBNZHFHTWpoTTMxT1VkcG81UG9D?=
 =?utf-8?B?Z1dJbU1GeGtJZE5HcHBHaDFVR1BZbFA4UUlxS1VqZDNhUTZ2N1kwNWpQUFRh?=
 =?utf-8?B?SmlYSTVGY3YyUHVZWjJFbWlKVXArMTZXVlVUcG9qSGlqWkRCcmkzRk02SXpK?=
 =?utf-8?B?djQxTmp1ZHhsQ29jMG1oUzFtUytnMDNvMnZnSDN1T0dkSDRIaDdSY0luS1JX?=
 =?utf-8?B?QXEyc29BSEVSRVdYeE01amtCamVkNGxWYVJjdzZUcitHTUV2dUpUTGdyVVJz?=
 =?utf-8?B?a0RwZWtxbytybG5KREJMdE92L08vY0ovclU5YlV4S2R5aHJqbFMwVE9OSllS?=
 =?utf-8?B?Q1hvY0JUay9UcmVwSTUxNUNRaWlSblZWT3ZSamg0ZEUxb0ZpWlhZTHVBbEU4?=
 =?utf-8?B?MzhCZWppOXVVSXpUMmx6OWlCMEZyNmxCNzFXZjRDcnplUUU2Z0JiZWdBcVZ1?=
 =?utf-8?B?NmRDQ21PVkpTWXRaVFYvbWJnd0VCVGNvSUMvOFZic3g3QlMvSnhPS2w5ejdK?=
 =?utf-8?B?V25hcUJUUzhUbXg0NDVpaE9QMExScHFoRkpJTUhYTVVJMmZyUFNGT0JBVlA0?=
 =?utf-8?B?TE1YL2ZiM29IWkhQQ3JRMWxLT3gvZExBQnpOZnJYb1phQmxxa3VORnVOcGtR?=
 =?utf-8?Q?fIFhFfyJCYMuEl0Q=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3163acde-cce7-4e85-d7cc-08df1b1c1a1f
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:46:02.3200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLolWVAsv2U+fLRO+29v3Mj1nV0/pAR30ZCXOy+cwIz9ykewLlg3+ORXXbOljnWPGdkWnjYNKABX7heT/dyHgeJg1q5MAFU0dKUBLgclBLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2059

On 2026-08-16 09:50, Magnus Lindholm wrote:
> setup_arch() computes phys_base as the base of the lowest sp_banks[]
> entry, that is, where RAM starts, and assumes the kernel image was loaded
> there. That holds for the traditional boot path, where SILO places the
> image at physical 0x4000 and PAGE_OFFSET is mapped to physical 0.
> 
> It stops holding once the image no longer fits there. SILO loads a kernel
> between physical 0x4000 and its own text at 0x280000, a window of 2605056
> bytes; a current sparc32 kernel is roughly twice that. The loader must
> then place the image elsewhere in physical memory and map PAGE_OFFSET to
> it, at which point phys_base describes where RAM begins rather than what
> PAGE_OFFSET maps to, and the two disagree.
> 
> phys_base is the offset __pa() and __va() are defined in terms of, so once
> it is wrong every early translation is wrong by the difference, including
> the physical addresses written into page table descriptors. The
> tablewalker then follows pointers into pages that hold nothing while the
> same tables read back correctly through the nocache view. The failure
> surfaces as a hang right after the context table pointer is installed and
> the TLB flushed, with nothing on the console to explain it, since the PROM
> mappings the early console depends on have become just as unreachable.
> 
> Ask the MMU what PAGE_OFFSET actually translates to and adopt that.
> __get_phys() already implements this probe for sun4m and sun4d and returns
> zero elsewhere, so no new low level MMU access is introduced and machines
> without an SRMMU are unaffected.
> 
> Memory below the kernel cannot be reached through the linear map, which
> runs upward from PAGE_OFFSET, so drop the banks that fall below it rather
> than leave entries that __va() would translate to below PAGE_OFFSET.
> 
> With this a 6MB kernel loaded at physical 0x03000000 boots on sun4m: the
> context table lands at its true physical address,
> srmmu_inherit_prom_mappings() preserves the PROM console mappings, and
> srmmu.c needs no change at all, since map_kernel() already handles a
> non-zero phys_base via do_large_mapping().
> 
> The cost is the RAM below the load address the loader chose. SILO's
> memory_find() picks 48MB on machines with 64MB or more.
> 
> Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> ---
>  arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 1b0db16cd37b..34e8f7c87685 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -254,6 +254,30 @@ static __init void leon_patch(void)
>  
>  struct tt_entry *sparc_ttable;
>  
> +/* Drop RAM below the kernel; the linear map runs upward from phys_base
> + * and cannot reach it.
> + */
> +static void __init trim_sp_banks_below(unsigned long base)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
> +		unsigned long start = sp_banks[i].base_addr;
> +		unsigned long end = start + sp_banks[i].num_bytes;
> +
> +		if (end <= base)
> +			continue;		/* wholly below - drop it */
> +		if (start < base)
> +			start = base;		/* straddles - trim the front */
> +
> +		sp_banks[j].base_addr = start;
> +		sp_banks[j].num_bytes = end - start;
> +		j++;
> +	}
> +	sp_banks[j].base_addr = 0;
> +	sp_banks[j].num_bytes = 0;
> +}
> +
>  /* Called from head_32.S - before we have setup anything
>   * in the kernel. Be very careful with what you do here.
>   */
> @@ -332,6 +356,22 @@ void __init setup_arch(char **cmdline_p)
>  		if (highest_paddr < top)
>  			highest_paddr = top;
>  	}
> +
> +	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
> +	{
> +		unsigned long real_base = __get_phys(PAGE_OFFSET);
> +
> +		prom_printf("phys_base: RAM starts 0x%lx, kernel is at 0x%lx\n",
> +			    phys_base, real_base);


This must not print bogus information on LEON systems. 

It is a pity that leon_swprobe() is not ready for use at this point or
it could have been used in __get_phys(). It could be changed in the
future to not do the strict checks that now depends on variables
initialized later with, the here calculated, phys_base as input. For
now, please refrain from printing the above on systems not supported
by __get_phys(), or move it or parts of it back under the if below.

Nit: I think it should be "...RAM starts at 0x%lx..."

Apart from that, this patch, as well as the rest of the series looks
good!

> +
> +		if (real_base && real_base != phys_base) {
> +			phys_base = real_base;
> +			trim_sp_banks_below(phys_base);
> +			prom_printf("phys_base: adopted 0x%lx, RAM below it dropped\n",
> +				    phys_base);
> +		}
> +	}
> +
>  	pfn_base = phys_base >> PAGE_SHIFT;
>  
>  	if (!root_flags)


Thanks,
Andreas

