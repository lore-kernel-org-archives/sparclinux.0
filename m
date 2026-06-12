Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022101.outbound.protection.outlook.com [52.101.82.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DDA36A375;
	Fri, 12 Jun 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255489; cv=fail; b=iZaxBkbPIhw6coTRtmViJYnycqBFzfICNN6nImmay6b9Y1j8tA0OoS98zJ2Yk0mKAeXbE2ky2xFJBNFd5K4gzEvkAsdz4nWRbvDTxtcwgvX1WY8PbqCFw4xkWgdbqCvJx7Rc+jecjj+f+ACSeiAHzcrO8AqaR5u0LB2WwVmzGJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255489; c=relaxed/simple;
	bh=7+rZyu0ElznE1cUAxyeaGLR0lWLqS6rrXfOKPWtvE9s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WrAutf3enqgYG1siQ87tnjEK1m3vG8PilLooSzRlLDK/Oqn+SyEX5dC1k5aFKV8GkYEvLptnPDlaGG4IhDUrTo6t5vlx08om82QSyEnVOIAh9DXWIG08ft10hLTuRlPIpsvb1VhDojRPSADLGfx8/p3D37Bwz7oE4RAWUXYkW8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kkHBSLBv; arc=fail smtp.client-ip=52.101.82.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kkHBSLBv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RahWhgbI+OQ5+O8plWU2DlDNdebip9JLE52DiT6YN98JyRpeh76eUV1hN5nWZLzIy0sPxxOrM49SUSGLDZpIgzDr5cWUgQL3xAgvTbtZk+db4sJz/eGhXQmg/hoglxRJjP2DJi+N2nvEU3+mu0+/lu1b3Ml3OPBwHwubUCnH4MtM4gV2df6jR+NYhVYQp7ONqFHT0QlU/KVuBuIEyNdDWXH87O+G17mRqVABK0M2GMUi9DHui3dCAvZ/fXxi+s/axpOn0YXxZG4IvHpvTOQwiI0D2iZPYAY9eJBDC9j3FuTkKdQZbpmuwTy/zUtfhCuWQMKyFLVRZ+GKdFj8EKohKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZQ4hyyrrdlMUzfMHsFVerGh0Q97RgleVpkui2ufjcA=;
 b=NnWiCoF31WdMu3qJjt+TGQKDzmdaellg8T8jbKuhNcCgA5ekE+LXlNCOcCQuR8OiM2diXSP43aZScewAlzA8HVilYY43V9qhEdURz7k2DW9e3D0kgwIo4a7c2ESxxWqm1pnoAU/8lNuxp6KrUbg+XLcelc+4BhxcMZGZgC5hd/eVWyU985EUVKQf3gWYSQWzD+aNgIMd6Wwyfe7sLRW9KGVR6dzweWxj1TCrXI36QAv70+F05MeFf5VOHe34P6zFuafvDhT7+FO2Ug5tDGiJNpLc6YsN0tzM35Cwtz8frle4al/SFVI9cX8saH7FHLihZ9Hkl3vgVmRIQwHPX9fHxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZQ4hyyrrdlMUzfMHsFVerGh0Q97RgleVpkui2ufjcA=;
 b=kkHBSLBv0wA6aJPrUJ0OOuYuv+iEhXLbnq4Kj7DAkPnQOwun5YirnCYQQ88wbwYgaJB+32siMtJWuhpYDFgi/gmD8QLp46bB2mrlgaHfhGJSDRsAZrUw0Y9JAizw3iQhGDSkFMdglEZoBkEA5c/A2xecEwJvgbFBmi14WZQtPPe7AqVeLjLKcQPDGxnC+ZXw0uzGnGDZTSnK59HSaSek4taWPrzBBR2aNbfwVg3IHU7SuiScNCqQlZZTr9HGHyNeObR6Dv8jWusdJ9dTscDpETtIPvMb+1BKNNz+VEQhlU330xSqrCowY6xvxPa88qxxVvVCnLunFKCXd6hLLnN0Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVZP280MB1987.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:23c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:11:23 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:11:23 +0000
Message-ID: <7706a203-f2e2-4d5b-9da9-c94b5cb428ef@gaisler.com>
Date: Fri, 12 Jun 2026 11:11:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc32: remove deadwood swift_flush_tlb_page() debug
 code
To: Kexin Sun <kexinsun@smail.nju.edu.cn>, davem@davemloft.net,
 akpm@linux-foundation.org, rppt@kernel.org, kevin.brodsky@arm.com,
 agordeev@linux.ibm.com, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: julia.lawall@inria.fr, xutong.ma@inria.fr, yunbolyu@smu.edu.sg,
 ratnadiraw@smu.edu.sg
References: <20260321105935.8068-1-kexinsun@smail.nju.edu.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260321105935.8068-1-kexinsun@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0004F08C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::634) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVZP280MB1987:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dec44f-2368-49a9-e285-08dec86292ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Amdf/Cl40Y/skn92AtckTF+OF2/E4LR2HPBkCYe2poG1upmAibYlYyI3SJgC7WyFwiqMoQJUQPXwArZaABImFtsc2fq5T6U1jq59JgPsQNxSEZEhJigjXbB2gg7XyaDlhZ0bKUHL7ocmwx5vmGnZhFwne3KG988PLwKrvz9oA9RERSnA74GQlchlWgEP5KVmmuEaE4xewU4nLjBkLsvJf6Teg+qU1SBBMY+0TF0K8qQAPHtQvjT2YQ6KdpMqwmCBOxG5ZTAKWr7TvroHG9rbCLiRfunkz3zx3QbD5XV/6F/pCdEUGZ0RGxdgof+uiIW1Gr97iRCa02Rqj8RoEOEajgm9Vk280OImfM9PzcVtWh8dodDx6qGaq4NnfhsDZplYAbsaEFr9CKLkZllJBDOrk+aGHAAxJPNTJnlAg2nx5PphCbACp6BuMAK2qW9sp8+l0h43pjdDKjr2XsqRVxTYHTItLRgXQqwqGfYixL1Mlv8p5Jfmq4I/KneErG9zwusPxGH7iK4Ns90euZBUbZJ0ATetuGiRd2WZAtNWQNoq8w14ZrQdodwzDYiI5wtIC5nBzgD3L2UBAIJSAnnyZmddxDN/i20vf8jXuQk+y0qMVZbQKQEkdPWWmP/P5nKK9LJzip4ZXN4z38hFQIcIL+loqRr7tF67oY5hFGLdlOil8zwb0qT/sAljOcqCJeWLT5Me
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dThha3RsTkhWOWc3TDgxR2RWNDBUTzBaSkpXMWhTTzhTbDlMS3E0WEtOM0ly?=
 =?utf-8?B?aGNRRENIQSt2Y1oxYUd3VmRxVXdRL3lvYW1OeUtuZmgzS05uTEdzM3kzQml5?=
 =?utf-8?B?ejBSS2JGWGpOU2tYdkVzYUpxSG1pbTNtTzZVL1R1VXVNL0lBQWxTK2F4dTRl?=
 =?utf-8?B?VVRtbElHL001SEpEWGxjRWNSNFhaWHZGRGRZaXBsMExYR05QYVJaOVd5b2xv?=
 =?utf-8?B?bElkWmxadzJTcXlGZ0F2VEVsc0RnNjBzWXA5a3F6UjVwQ2xONHl2amFtVzhj?=
 =?utf-8?B?VGlXMXl1WkxBQ0JQcTI3WEwveFZocDhSbUVIYVF2NDYrTTg4bnlSTWVROTVm?=
 =?utf-8?B?VngvL2NVUk1QMXpTOUdCOVZZa0JHWVp0MUpSWFVyenZIdkRxYldtQzdEQ1ZZ?=
 =?utf-8?B?dktvc25sbzJuZmMxZWRTaXQ4Q1c3TUlLOEkrT2Nwam9WVFM3L2J6QjF2Nllw?=
 =?utf-8?B?Rzlhc3hQT01Jdzlpa0UvUzRPU3JDSDZjcW5Tb2tYL3Z5UDNYQS9ZdFpIMG1L?=
 =?utf-8?B?UTFrSldhMnlUdldxOWlLaTFNUm03Vm9LTDJhS3ZqNHlucW83aml1VFJudmtW?=
 =?utf-8?B?S2tFRnd0YXpzb1NETGQ4NkZoQjR3cVIxUzFRNytvWGtzM210a3JIeUM4YkFr?=
 =?utf-8?B?TVhIQ0VvTFBZRmhPZGR1bXFqYXhDWkRYRXNxM2g0bVN3eE1scmlUT3E4dXps?=
 =?utf-8?B?aFI2Smg5QTdZTlh0OHF5bDU0ejk4M3VYbVhrbEd5eWEwQy9tcWFTQXY2SlRi?=
 =?utf-8?B?TC93RjNpUmRPSG5WZ1FCaXRoRk9NTkhMUGlYN2p3Y2VubFhxMkdRMi81L2Uw?=
 =?utf-8?B?bGJsVGg4MEFva3RTdExYWEhSR0xIKzdoZzJPOGQ1bndsZks4Yy8wTS9VRkg3?=
 =?utf-8?B?bkpMcVZzQlNobERhbTBIVTR1YmdINXExaTZiZ1ROV3piZThBdzM3L3FlaDVo?=
 =?utf-8?B?OEJ3MnpoQTEwMTBna2ViNTlVRzZQb1ZNYlhWWXR5UUgxSXl6VnVQMjB4Y3BV?=
 =?utf-8?B?VmpaNzBpNWp2eWxoY0V5UzdYZzkxTjNobzdhRUVvZ1Fhb0xJV0MxVmdpdjky?=
 =?utf-8?B?ZGJ0b1FzaEJ4UWdua1RrSXgremUxMFhKc2sxb2lJMVFiMzFKdDZDV0JVQlk0?=
 =?utf-8?B?TGdIU2JwaEpFaEk0cFE1UjN3ajBVMHV3ZkEyT0ZLcUptZnpqVUhUeENIejVU?=
 =?utf-8?B?SjBWdXdhR3FpSWl1S244RTY5OENyckNEZ2xJVUJ6VnFyZDcxam5GeUdKS1Az?=
 =?utf-8?B?VjJXQ21TV2xuK1JGemtObDN6NFVGS1dkVHVPNDFpcUgydVphV2lJUjlaNDNF?=
 =?utf-8?B?dEdWc0I3Ty9hRDFsbzdYVEoxYkJITmRienNWUm5OK1dLRFRHMGlpbzcxZVdR?=
 =?utf-8?B?R041SjVGYlB6dHVBNzE2SUk0b2poeFNod2I0WVVXaGpGUnI4U0pUc2VhNGpR?=
 =?utf-8?B?VDRrN05aa1NHaDBFdlZ0Uk96VU0wb20zbGZMTkRsZk1FOThUSngyQ01CQXZi?=
 =?utf-8?B?dDFSNzRJQzMyR2VOUkNlbW0rZTBSUEREWlRpdUg1dzMzSzFZellTb21OWk9j?=
 =?utf-8?B?U0UyYWIzUDdoZlI3RVBXdFpnRDhGT1NyQ2h6Q29WUkVkQjBmVFc3Z21UTGlq?=
 =?utf-8?B?TFJWZ05oT3RUM0NFczhHZ2Rmci85NThHSStsZnBxZW82dEpobUxYSWE1S2I0?=
 =?utf-8?B?SnoyQW5lZEJ3WE45a0wrZmp5SGVyM01jd1dBMStYT1ExNCtDWHY2Um44anJp?=
 =?utf-8?B?RHZBU0tqQzd1aEVXWjNsZW9tdGI2WnNIRjh4M3dVdWkyN1pOZ3RJVTZjeXl5?=
 =?utf-8?B?SEcwRkw1THJ6ZTBrblh3a2ZPR1ZRNEtnOUVmbjR3aVc1QUNteUVQWTh1bzRx?=
 =?utf-8?B?VVp6QW5CVUUzR0dPYUFVRVh0OCtqcTRDT1JVZzIrVGJQK2MwdmNCUnFqSmJq?=
 =?utf-8?B?bXBJMW9RZGNDbGtQNDhVRjhEZDBQVnExT0REMzBNVHh4OTl6MzlyVTRPSFEz?=
 =?utf-8?B?VjdWR1VKaGtRdWl1V0dnR2VTQmxSRWlHc2lnYjNtWTNzelZZdFRwYU9TV3JS?=
 =?utf-8?B?Yk9nNUk4QURxNHU2R2tpMG9FOXpVZkNjRGFQeE04NGx4d1ZpWVcrNXpYVUh5?=
 =?utf-8?B?Q0ZGSnlXS0tLaW50d3RvT2tpQkJ2cGJYNllOQW9GR3AzMGwyWW9BaXdUNG9B?=
 =?utf-8?B?NUQvQW43RGZzRTM3Mi9SL3hCaTJsdGFpdDhxRlVBN1Y4ZEpsanRnc3J1K3JK?=
 =?utf-8?B?am9yVGtCTzdpU3RLbmYxMGgyVDhtODU1UU9lRng1ZXp1dTJ4MVRhSnI2RzFH?=
 =?utf-8?B?NlZKUlk3L0NtS3F6Y21Wa3BKaHdINGNNV0NZU0xqQ054L2pOVHpLaC9SUEZ3?=
 =?utf-8?Q?+yV5iPwdqx3JBrik=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dec44f-2368-49a9-e285-08dec86292ce
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:11:23.0764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BH/fot8w2vlV2rQhvgWsccERFJy+6rWYHlbMoI6n2ROW4dUEh+WK62Q6NiCdvCzBJRxUbgr4HAQuuDtPs4ZA91h5jNC6Y1wJPfJbjCF0hWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1987

On 2026-03-21 11:59, Kexin Sun wrote:
> Remove an #if 0 block that has been dead since at least
> Linux 2.6.12.  The block was marked "P3: deadwood to debug
> precise flushes on Swift" and contained a never-compiled
> alternative implementation of swift_flush_tlb_page().  It also
> referenced the since-removed srmmu_flush_tlb_page(), dropped
> in commit 3d5f7d37c8b4 ("sparc32: drop unused functions in
> pgtsrmmu.h").
> 
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  arch/sparc/mm/srmmu.c | 29 -----------------------------
>  1 file changed, 29 deletions(-)
> 
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 1b24c5e8d73d..9a74902ad181 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -581,35 +581,6 @@ extern void swift_flush_tlb_range(struct vm_area_struct *vma,
>  				  unsigned long start, unsigned long end);
>  extern void swift_flush_tlb_page(struct vm_area_struct *vma, unsigned long page);
>  
> -#if 0  /* P3: deadwood to debug precise flushes on Swift. */
> -void swift_flush_tlb_page(struct vm_area_struct *vma, unsigned long page)
> -{
> -	int cctx, ctx1;
> -
> -	page &= PAGE_MASK;
> -	if ((ctx1 = vma->vm_mm->context) != -1) {
> -		cctx = srmmu_get_context();
> -/* Is context # ever different from current context? P3 */
> -		if (cctx != ctx1) {
> -			printk("flush ctx %02x curr %02x\n", ctx1, cctx);
> -			srmmu_set_context(ctx1);
> -			swift_flush_page(page);
> -			__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
> -					"r" (page), "i" (ASI_M_FLUSH_PROBE));
> -			srmmu_set_context(cctx);
> -		} else {
> -			 /* Rm. prot. bits from virt. c. */
> -			/* swift_flush_cache_all(); */
> -			/* swift_flush_cache_page(vma, page); */
> -			swift_flush_page(page);
> -
> -			__asm__ __volatile__("sta %%g0, [%0] %1\n\t" : :
> -				"r" (page), "i" (ASI_M_FLUSH_PROBE));
> -			/* same as above: srmmu_flush_tlb_page() */
> -		}
> -	}
> -}
> -#endif
>  
>  /*
>   * The following are all MBUS based SRMMU modules, and therefore could

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

