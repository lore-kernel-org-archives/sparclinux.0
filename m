Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022119.outbound.protection.outlook.com [52.101.82.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A43B9608;
	Wed,  7 Oct 2026 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791350905; cv=fail; b=NZX/aM+GGCC8kGaNB8hoGJLcXcAw8SAzNfMDJUUW8yxN3unSmUdhzufP+syp1v70CRoChSvBE+En+1RhtFwgUeWfuQREZV0ZQAC4jst/INdAALYs0CP7Uf1Kwfe23+RooQOVF/gUq7vUwKIyanzPxQe9JRd6qXlzGz4z8zBgliA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791350905; c=relaxed/simple;
	bh=ID23NPl5+wgvRM/Keyq3JIzi0ywC1h+/lXlDCXsURWU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oVCFFbiHAvmlMFZelWB3HTXksV8tiEIZycSKADjwn5zUb7qXiiuwVgXG5MGHgrqnhBL1jprngrOKtRRuG2zhYUhBcUqSYioOhlFqC7bP5ElqH4xvQB/XiH5k44X+j9ml2siFn7jNdl2ALs8rqQhpkyR+mzoEYgoI+cOnYT0Hjv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=bi7GYfDy; arc=fail smtp.client-ip=52.101.82.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="bi7GYfDy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JVqzZr3SMjEO5MITpi0OE89GbTbsRrhAJh28rq5L1x6DsbIKaSxyGShTOgczFaFoQdz/rN8lcgRcNMSCB3iwgmnrCCBtscriiICP3NUW4Ih+XUtKCjVtRApOKKg1xsJVFA5Fx3T5nTmd1qdOgP3+/XHhAc/ZGzL6ekrxxV78PDnpM0QMoqvROQU6LN7BS5jiYG72fG5DWNUpE8cEPKnvbmMrmSum5QNDxy/YBaODYA5ueiAj1jJo9TqsOYrnuD4shsCD9CVqsoLfPPZq6J6xaV8XHJzW4pkFboT7DWZ1CF8OK7CTueTuLgVqsDMEXBIez69uqX3q/N25PaG4dYSzuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/LMeMKh+ysFcaO8wX29JbiQNPszmWiEj7TmD426/l8=;
 b=q0H1K0BXR6fEFqAsgVXbbu9rNz1je8j7Tofn71XhRuNWRr12hhkZ721gq9xr8w5d0Qd5YmzbBqhTJL/sYrto347FEJK1UhOlkyVsoAp5Mbj9ay+rsdW8pPW/xdWZyY1Y1XK3dfEw/Mov5xcySBfuBLtAIyXDzBc0ITBXsD1ELMx+i6oCf/6T9bwK+kE+Uv5XsfZNIa8ZfdXOHLe1fDYWr10AO6zqGTrOre0BBc5XdsmgcKhz80Jt4fBVhsrQTEPrvx/FKMytRJFOsSTN8feo0wLPGXjPtP3mxpGriwWeNp+KCKslvUlac4JXPeMBU9ei9H017x+k/rOzw7b4XApHRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/LMeMKh+ysFcaO8wX29JbiQNPszmWiEj7TmD426/l8=;
 b=bi7GYfDyGI/6uiwuooAucBlOuWoetrgF66uyF7UCIJ83xHAX+//sVvxrIQOnlV5709d8XAAOmsU0J+WgxiEVzCs4sFbCSPNVselhR/XKeoL/ooJD6ZAmf24qA+vBBiRey0guf5WRGtuAbT6YbqyfNOLHVDxpeIYd+iQNzEFGBMm9pKwSVTju8KdZ3WC6Y/t1VJPTK/+NTFyk0B94Jeg9MMdNBVo6q52ab/yX35MaTWyyqm5XF1CWGGTRTepGBOHqKYNplcfofd8+vsUB8Kh4lGc4ZaJ3IUcD84nUxNTcVWQU2nCjAGbbn49Yv56E4wcGtSJlHXI1amsYiVMqiDWFnQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB347181.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:603::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 05:28:16 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 05:28:15 +0000
Message-ID: <41f27374-9beb-4950-b612-1a676cbcf92a@gaisler.com>
Date: Wed, 7 Oct 2026 07:28:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] sparc32: allow a kernel loaded away from the start
 of RAM
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1790548064.git.linmag7@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <cover.1790548064.git.linmag7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F6CF.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::64c) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB347181:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fe849f5-b9dd-4602-f4ff-08df2433c9c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|18002099003|10067099003|3023799007|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	EqAFXRrPEUYVroftBC6ETRotNqPCGTWKmHkLg+69PnsDnmF1IgL5SHOkU0a0X+LBsNtedYdgEVR84eQqaoVS9zCGMRW+0b3OAuDutyA8WDilfpuVEWo9LQp4tfkrUBhbnZt+UC/uzfCDj3GrDUYrgI4eHUFmf+p+o0fdZ8ueLGbJXzvwqHDUHKBWrJrLpQPG5RsX43iKvyhupWd2CMRcIGtE5E2rKgJty5gmuk47E8oGK6AgYLoEe5c0fgPGKCnsF+ogZr3vD3mFmA642HOLC2T2uJvWDht7hdbpaFp0Rr/qpxWOO2436KEoUscN8XosMSwXfjR/8rtaIxUVWDYl2ChrrXn/KSvzRg46+vGZtfw7XEKkTubx5AFyXNSG3d1FR4GiyxxPO2C0p7OOPL7lpTYCIUXiPjFMoygLv38V5bGy9f35PmGpxKOR4EWfLd6iFedDu6kFaVGchxQLcB8U5/W3eD3J4QMzctc+ehmeBm5TZGFcaKWeGdBxv5+GlTWV7HAPlvBl3elHgsuev3/5g/BfmmecoWdEt+j2RQtwHrn+5MaTrZTqFP/q+25Ce8gwTxfxcKWx/DqCUZEpR+ZfWIvdvrIDR4CPufyrwHlLXF9Lm35Oyif8qdxnXxXSNXNb3pUpJk3hZetwaufLgoY1CRvQsajE5B2fUWnLN1nsZvk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(10067099003)(3023799007)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEtDUW5XNk1Qd2hteExJb0NRWnVFUlBGWHVCa25rYy9zYjFIMkpZY0xyeTdz?=
 =?utf-8?B?TnRnS2lOZERjTUlac2FISDFNdll2UzY4TGdDOWI5Nkc5QlY1bFZzYjNJNGtR?=
 =?utf-8?B?elB6bHVMb2dNcTgxMkdiU2dnbFBMSFVNQ2llTE84S01RWWhVbVJSbUFPVE4z?=
 =?utf-8?B?aHZSVk1OOTFhbUhJQWZlMGx3UmNSSkNrbU4weDNOZ0FRUjM0ZjM4ZXVwQW5M?=
 =?utf-8?B?d0hZaC9PbFJwditGT0JFeW05NXgvcTVCb2VtYVVNb0N1RkZrcnZ1MWJPUFFh?=
 =?utf-8?B?MmpFMlRwQ1B0dnJ3MUFWOGtyRjhKUWY5ckRsWHI3VlJvNjRSUVcxTFE1U1dw?=
 =?utf-8?B?ZFRDTEVKOFNtL09nbVhmdmZiUlI1dTlETDRqZ1A0K2xmeFJIdS9RMkJ0K3J6?=
 =?utf-8?B?blkyNWlZbWdVclRKRDEzbEE5M1VLUXlXa004ZVV0QkE1N3FkUmYrS0lGdURr?=
 =?utf-8?B?VEpzNy9RL2dTSDh3dXZMSmtZQjVHR1p1M2swcFlUbTBYTDk3eUVVcFFpMWJ3?=
 =?utf-8?B?aHV3Qk9GaktzOGlQOXVPOXhHRjV2RWVhU3d4Ymtwbi9CeTA5ekMxU1NxQ3pm?=
 =?utf-8?B?VFBTb0h4eU1wd2F5elJTZEdxNDNlYXVESFBPYnpXNVFuK2hjQVVLWUo4RU11?=
 =?utf-8?B?NzNRaUc4dmRCaDArbkVxNlVsZVJkdmhmSnlTTWlqOVcrTTFnZkdqck54R1I0?=
 =?utf-8?B?M3pRMUJFM2tGODV6VWZIRFpQYnlrclFEcHVsaGZseGFldFdINHZDOHZIaFQy?=
 =?utf-8?B?alRia0JWbnRhNmFxc2krdlpFMm50UFhZUUVDbTRzcVBjUE42Q3doKzA2THhO?=
 =?utf-8?B?THpMVGNOYUFHK0RXdkk2aXdYRlFUVkUyQmgyLzQyeE00d0F6T3IydzBlZkxz?=
 =?utf-8?B?c1czb1phdnZlUDkyZWMwS09RY3R6bjdXSys1Q1BmcTRkb3RMMHJEUlkyK0U1?=
 =?utf-8?B?NWZmZStuNjFRMFVFR09SYTIzWVkxL2htQjNaVjBialo4Z0FmSUljdXNtM3Bi?=
 =?utf-8?B?MEVOTm9acFF1bWp1ZW11MjdOSlYxNVBQQ0MvRU0xWFNlSmNtMUkvaFdsak1W?=
 =?utf-8?B?cXRDZTZ0RXFibVlNeHVuRUVaemxuSlE1dXU2SVp5OHVrYlpZR1RVSFBUSndy?=
 =?utf-8?B?S1lSV29rSVFXWEFxK2RzK0N5Z2NBVFB5NHlkL1RxaS9aL1FNTSs3eTBCRmZz?=
 =?utf-8?B?dHo2UGxYRUgwYmdNNTFSVnk2NHRvL1lFZGUxSmdpTDd5RHVwOTlaRWtEMkRn?=
 =?utf-8?B?eFAxekdPSlN0MHRGcStxUFd1OFZCd2VSd3YyekRCS1VFQ1ZnQjJuWFZXM1VX?=
 =?utf-8?B?ZlNpMFhMeERpdHV3T2VjdWlScklweEpyemI1OUhrMkdwZnA0emwrdEcxOWlh?=
 =?utf-8?B?TGp2NGpoVW5RR0Q2MHZETmUyc1IzY3U2TUFmRmxVZDZaK1NwVmVUTVltb2Rx?=
 =?utf-8?B?OXVYWXJ1NXBlVzJneVNvbEhBSDdEYVhqcFNzbW9EQjdHbFluZ1QxTVBMT2xq?=
 =?utf-8?B?dk4vNFplbXBRQzlYSXZPNVVaUFRtOFJLMkU5TmFRQ1M0UENUN0dtVWs2VXdx?=
 =?utf-8?B?bHlDZXd0aUVJS0JjSzhoZnRZbkFFeEUrSEtmUVY4UjUzU2U3SG9SWE81YjAx?=
 =?utf-8?B?bW1FZGtCWlZsYnQ5VDIwL0xzUlQ4UEhobFpON3pwVEp5MHJIVmhBMVladmpx?=
 =?utf-8?B?cncrNm1zYmdtd3BMQ3NydlM2NDRXUDlqRFgrZnNyTnRTVDRaN2szeXpXeEYx?=
 =?utf-8?B?aEIxN1JlZnRBOWlMTnZsMEtLVXNjcXpKTmhneVA4b09pbkhKNkRlVTFJTnps?=
 =?utf-8?B?RzlwTVF6ekNPUk11TGJVdUxpeHJzZ0hvc3hIM3diazdjUEtyUkIzbnJFb3Mr?=
 =?utf-8?B?cFRuTkVEYkJQMldqaml0L2ZxM1Ayc1RMekhWQjlhNG1iZ3JFNWFEOHJCL0Q1?=
 =?utf-8?B?TUxzY2RKTGFMUTR5S0VzYTFFM0EvRkl4NkNMTm9DbWQvdmZtc1lZeVhBbXpv?=
 =?utf-8?B?SmFSZW9sYWhoT2lsRElHNG1vOExCcHFOR09DV0RRSmxJZTlyZklvV3p3bERs?=
 =?utf-8?B?clBSVXN5Z1MrVkxGdnBJbXRmN2ZNSno1YXp1aUlHUHp6eEk2aDdXTGJCdVpz?=
 =?utf-8?B?TFUxRFcrWlVCTThoSzJXY3VMcUpZTFFwUVZQdnNVRzViU0hQd0RwUjV3V2Z3?=
 =?utf-8?B?emF3S0p6RHlBK1hvaVgvRzJZditzdHZtYm9SWlRkaWhwTjZma3dGQkVwaEVU?=
 =?utf-8?B?cFlDcjlBelhLcGhEWlZUNThyVDE0eDRQRWphV3JUTGpyOFIyQytpK2hHQjRk?=
 =?utf-8?B?L0JHZnBmQnVnc2ZFQlk1YWlmR3ptYy84dGJ2YnQrV01UbjczNjNhV0l4KzUz?=
 =?utf-8?Q?xL/9lElkE1RcGnrk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fe849f5-b9dd-4602-f4ff-08df2433c9c2
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:28:15.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49MyfO/AUpbfpwhbNKp7Ak4qTKGqJKeKn2NVixkonA/VcIyPgwuO7t8gyIy478bizQQMqvjgLduOdYYqdaiDNc5ths6L2kuBLBduFvg2HBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB347181

On 2026-09-28 22:06, Magnus Lindholm wrote:
> Many years ago I ran Linux on my SPARCstation hardware and tried to keep
> up with new releases, but somewhere around 3.x I hit a wall, sooner for
> SMP builds since they are larger. As the kernel grew it simply became too
> big for SILO to load. On this machine the last one that fit was 2.6.32,
> at 2598956 bytes against a 2605056 byte window: six kilobytes to spare.
> 3.12 was 184KB over. Fixing it turned out to need more than SILO changes,
> the kernel side needed work too, and I never got around to giving it
> serious thought. I recently dusted off my old SPARCs and picked the
> journey back up.
> 
> Link to SILO repo containing fixes:
> https://github.com/linmag7/silo/tree/release
> 
> A current sparc32 kernel no longer fits in the window SILO loads into:
> 0x4000 up to SILO's own text at 0x280000, about 2.5MB. Loading it higher
> instead exposes two places that assume the kernel sits at the start of
> RAM.
> 
> Patch 1 is an independent pre-existing bug. viking_flush_page() and
> viking_mxcc_flush_page() compute a physical address as vaddr -
> PAGE_OFFSET, which is __pa() without phys_base. It is wrong regardless of
> the rest of this series; it simply cannot be observed while phys_base is
> zero. When it is not, iommu_flush_iotlb() flushes the wrong page, the
> IOMMU walks stale IOPTEs and every DMA transfer fails. It comes first so
> that no commit in the series leaves Viking DMA broken.
> 
> Patch 2 makes setup_arch() discover a non-zero phys_base. It takes it from
> the lowest sp_banks[] entry today, and phys_base is the offset __pa() and
> __va() are defined in terms of, so once the kernel is loaded elsewhere
> every early translation is wrong by the difference, including the physical
> addresses written into page table descriptors. The tablewalker then
> follows pointers into pages holding nothing, while the same tables read
> back correctly through the nocache view, and the machine stops right after
> the context table pointer is installed with no console left to say why.
> The probe is the architecture's existing __get_phys(), which already
> implements it for sun4m and sun4d. The probe and diagnostic are limited
> to those platforms, avoiding a bogus kernel address on LEON.
> 
> Patch 3 sets HdrS to 0x0300, the protocol level that tells a boot loader
> the kernel supports being located somewhere other than physical 0x4000.
> 
> No change in behaviour when phys_base is zero.
> 
> Changes since v2:
>  - restrict the PAGE_OFFSET probe and diagnostic to sun4m and sun4d,
>    avoiding a bogus kernel address on LEON (Andreas Larsson)
>  - fix the diagnostic wording to "RAM starts at" (Andreas Larsson)
> 
> Patches 1 and 3 are unchanged from v2.
> 
> Changes since v1:
>  - drop the (unsigned int) casts and print with %lx (Sam Ravnborg)
>  - always report RAM start and kernel start, not only when they differ
>    (Sam Ravnborg); in v3 this reporting is limited to sun4m and sun4d
>  - collect Reviewed-by from Sam Ravnborg on patches 1 and 3
> 
> Patches 1 and 3 are unchanged from v1 apart from the collected tag.
> 
> The v2 series was tested on a SPARCstation 20 booting from SCSI to a
> full userspace, with and without an initramfs, using a SILO carrying the
> matching loader changes. Also boot tested under qemu-system-sparc -M
> SS-5, and build tested for LEON and plain sparc32_defconfig. Each commit
> builds on its own. 
> The v3 version has been build and boot-tested on the SS-20. Emulation
> cannot exercise patch 1: microSPARC-II takes a different cache flush
> path, and qemu models no write-back cache, so a missed flush has no
> consequence there.
> 
> The cost is the RAM below the load address, which the loader chooses.
> 
> Magnus Lindholm (3):
>   sparc32: honour phys_base in the viking cache flush routines
>   sparc32: derive phys_base from the PAGE_OFFSET mapping
>   sparc32: advertise relocatable kernel with HdrS 0x0300
> 
>  arch/sparc/kernel/head_32.S  |  2 +-
>  arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
>  arch/sparc/mm/viking.S       |  6 ++++++
>  3 files changed, 47 insertions(+), 1 deletion(-)
> 

Tested on LEON.

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

