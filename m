Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022118.outbound.protection.outlook.com [52.101.82.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C941167F;
	Wed,  7 Oct 2026 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791373288; cv=fail; b=rEpUIjGTMmw9hYzo7mrJyq8jWHWwyzEnTcP2jvxA9OlIDLaj8JI9y+zH1e1Bf/w4VOaCIb7V3NlaiPpdj1Ya4KKrTQUmH6nip4+8q7/SHBXTDJlgQGEsC1p5ivjWW+neGw2FxXSwdHtCvKiPjXC2k2op/pjTtXJj9h7GNeNvYIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791373288; c=relaxed/simple;
	bh=Wwa+h/LSi8twwh7+nzGj+xgNcsFQJdYz866uY29SrW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Anv8W7sEWwWaSYXQcduilJPUUNcWy8rhSO8460xGzj4R6S+VQGqPeJYDbAxhjboaM9xWOprc/gEHGb9pi0xZ8tcMl26vEZea+TEN1hNJl/kJOn3hteFQANqaNix4ok388FEwYFI0GF/32JAaKErTOJ6dTL/p18wh9YIPFMEddzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=DMakqJ0+; arc=fail smtp.client-ip=52.101.82.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="DMakqJ0+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXtuImX8djQ6mFCUd4DuYkK2DHdW1ZqaeRJQB9UBOrXyBFME11ja7ceeuePhctZOf4yr3S5LYCag3TF+9P+Gbi8eble5uiZLaNOd6xdfHKzmyiHNIPvW3y+4ZDXRUj6IewHmOKMpZ6s0dbyiRZFbpjCCX9sCQUtowU3fF8IJF+hF6KmFAJCniWcUEieiT8G8fHBfd9QC8mRB5Tguv6dGm9CDz7QXSqjomTzu0SmdT8zD5cSFXGKcxPH10I4rWpjh03dot+iLMUf8jlnIE8iRMMJU6GnEtgYBcfC1K/vLC9Z65mVFJKmZqe5kptQ0dNs0nwT5DeXGZy5ftElR7ecTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDTJJZTuzuX8H/Oao4SLAMAcDPR9+FouctI2/fHb11g=;
 b=Gggeoi8sjbcazIW4hFatqnYzrg4a04BM/mwIF8Eny2Kku3BWQiMkpmGJdj9a2TWJYoXlMOqE1E5tEesgwj+uTCXlaFabtzAwh6ypjmLIy2Q93xsGasf1Vp5SUwxMp/FLs12yQM9pI3ONw/8UmDs7rYDPofoV6U+Xnue/4pjDWGogkFmvRD3c33iYoiqAJtW0KXO6ChWJraf+uyABxPzmYfs9l0FBNJ6ACCtKE6QX4NvOoGGAIP2jsbU/ENY0tJvEXRYqfHfJFd2HhV4PAKcMXLCoe+XuTT4pyHbSs2LGlXS8498RfmvsSkeaFHvyKgVC+z2zion4C2yMYdjrAGG/Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDTJJZTuzuX8H/Oao4SLAMAcDPR9+FouctI2/fHb11g=;
 b=DMakqJ0+MIS66GyhOaPFNiOCrYXA7IhCQNRk2ECMZoPFkChfJJ3L+W6ZhcG2eQ111+gOjx995UBHiSzIkvUqkpemcsM/3VyXVK/IPQ8WMQTXlOGOU7CvV1js6gD4S4mr4PctA4vVErZLjnf542gPldLJKWqmEHwPb8FDejAuX4nzXOKNIABef4O7BybldsO5q4iIJmLG9+ekM/PHKikhfk+V15vVwHZYhgj2vLKLQdU/8BcxBDtnwjNLfwmtO6Pdp/AvyJ/oke2aNcgLFigfbNlvTdHVKE/ux6+eTXztMRUn1y+u6c9g59bhIPWFPZ1lb9joUcC9u+ZJ2MKXPUqJSQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB1729.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 11:40:55 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 11:40:54 +0000
Message-ID: <2ba74adc-fb41-4317-a11d-03db8e5dbe18@gaisler.com>
Date: Wed, 7 Oct 2026 13:40:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] sparc64: fix a window fill fixup lockup and two
 fault bugs
To: Stian Halseth <stian@itx.no>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 glaubitz@physik.fu-berlin.de
References: <20261007085347.256789-1-stian@itx.no>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261007085347.256789-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0131.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3b::7) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB1729:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b992af-0891-4c16-15d3-08df2467d85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|6133799003|11063799006|56012099006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	NsU6tr3y4yF9A0KMF/ZutJzYnljd8L+gxKwk6q62ur7zKOVNoIm0Yur1BkN3LXatv36ZXfy3zyqjbTgOhg07xxbnGWC7mAVsUGFc/Khi+gjOAZ8RGxWB8brRigvYYd7KGQaD+FrbsNSBGw0PioYmlb9re8slTSitZGBrn5kNpdCO7NrUPDxv5d9ztEZKfZi+SLzcK6AqAwTeCUgHdjYXuOMJ7Fl/VusZkJRoCVxG4OZWBB85gqlqTOttNGsSfWnAEYeJ3gHMj8nB52dc+d1LF6BnBykclPEIO+qSks4dD7c7bgmZw3WgbUTnQEstDwc68Evzon1iIcuNGelNe1RRSZiqGtxDyfqi7HB56Y9TAi8pci3+5kGJQ4IMQ+YsUUAxdABav6FFBkTiwYNe5kccThGBiEU+vgLufu71sUrcr5jFjnvuST7vtlnPPDfmDrBUivXsoE2lwoXUA/dau0SuUdKptNGjTrd9C2H84Sj7f+GM8B1PgVVD19t6jUvJX/D6Iwq1Vk430d9jbsHMlJ+Zg5uYb3+A7kXhfkKYnLlLGB3tlywWhdWlbh56JbHWfy8+vqReslu/Y25/2ibsG89ZZ7adC8zsEu4NZ6t/uRXF7FwE0ppytXveA2P7d0MIvSOHt/rtvwqDY+EqgxQbfgAlFHYz1nogDVoIBt2ct2BoTik=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGZwb3Y5NVlJNjdtNEEyM3NuV3ZRUTUzR0I4ZUEwMWZsNmpCZVQyNGhJaG9U?=
 =?utf-8?B?OFNDbUx3SHhHMjJXeTF0NDZKbHY2QzE4Rzhpd0ZoWW84ck91K1VzZ3JRUG1Y?=
 =?utf-8?B?NjRxcmJFSmRxajllbjlZQUZNVksyZTZvSy9kODhJeWZzenlNaWpGMHF5UW9Q?=
 =?utf-8?B?L1F3aXk5ek0rM05ydFQzZE80cjF4ejBnNDU1SEQ2RGEyT05CK0tkOWVKckF6?=
 =?utf-8?B?UnNnMlFsZGNsUU8yckM3Z2lPbFNMSTFadFdzRCtzcmo4clAzcGJYQ2lmTkRs?=
 =?utf-8?B?dUhteWZKSHplanNSaXJBKzhIa3pIdkZTMlYzWEFjRFN5M2U0RGxMcVdIYlVM?=
 =?utf-8?B?cXJSS2N6NEFyTUNzeWtIaGJPUDJZM01wc0E5SFlkaXRERUdxV3VsdjgwRXFG?=
 =?utf-8?B?Y2Q1WTNQTVhQcUZ3b1dwVTNPdTZGYzZjTGFUV3pzdnNQVzB4ckltOUlZQy82?=
 =?utf-8?B?L1l2WFBPbFdSeVozU2FQY0t0ZDBQdW9TalN6SXhoNldqMklVd2tia1E3SSsv?=
 =?utf-8?B?cXlTbEtod01SZ1UxSW5KVkF2L3JmaStvLzRTd2dDQTRtc2NqSm10SG9ER01Y?=
 =?utf-8?B?dWJWRjdaMnFJUXBCK2ZwclBDMlZYZi9nQkhIcWYyVTFjM0E4anZBT2cxSjlh?=
 =?utf-8?B?djAwWXVlaHpieHRJUEVncmtqVmF5d1NUdm4xK2RNQWtOQ2pIcUx3dFk0Tk5x?=
 =?utf-8?B?V05nWTRIejdjeFZlTHJSTGVSekcvbEJ1ZE4xRTZicENicnJFZlU2SGVZV1NY?=
 =?utf-8?B?NFQxbmdKY1ZhVjN5MFJ3M3hlQzJlUGVteXB4R1NTNm1ZcGlDWm9kbkZiaXFR?=
 =?utf-8?B?ZGtsTUxPeStYY3ZLQUd6QzhhcDJpYXNYRlhqSWNjNzVqTVREME1qWVJvWmVw?=
 =?utf-8?B?T1BaenBUSkhjcEc0ZUYxYnlvUU13MEVnTXJzWjhJalpNbmUyRnZIamN5aFZ1?=
 =?utf-8?B?Tmg3eWpqc2lTZkhTZ2hDajRWei9CMWRqb1hsU1dua1hsQThoem1PR1dacUdh?=
 =?utf-8?B?dUp3bkc3dEp1YWpRWndKQTdHWXM0Y2d5TkFFNFNNejdqTkpVVHl6SDR0ZVlv?=
 =?utf-8?B?YVF3Q2p2TWVIWXIvQm0rbnFuQmxZNk5YK3V4SEdQeWhxUERrb0s4eVJLZ1dU?=
 =?utf-8?B?eXVjOXY5Zy94bmVCalAycWQ0TzFGNEFRRDB3YkVNdDU0ZjB2VG5CMWNUa05J?=
 =?utf-8?B?WmoxWFhoNFJyRWpReGdxaWtPNWhNUVBkNzJOa3c4UEVzWDFQOHZsVzZNVnla?=
 =?utf-8?B?V09EYmUwWjhOb2NCUENuL09VeWFsVnNvN2NlcW91dmh4QUowdkxSdmZSN1F5?=
 =?utf-8?B?Qy91Ymlva2E1YlpRNkR5SmtveVlkcDFwSjR4NThidWl5cjNGR0xwdWZUTmZj?=
 =?utf-8?B?aGpLR25OTVFsYnc4TXJCMGtBd2dSVlhia0VMdVlTdjVvbmN2OFQ3MDBjUUNO?=
 =?utf-8?B?c1hUVVlMcHVWZTI5Uk5idnFScGdqZ2R4MFRkdHhTcGVtQkNYTFhzeElsS0hT?=
 =?utf-8?B?a0Zydy9uVnF4U3NIcGRYUFQwL0IzamE0NE15OGw1Wk82L1VTUDY2TzU2U3Mx?=
 =?utf-8?B?YUhyZ3pMaHRZNkZ5R0ZPeGR3SG1Ycnk1UUVwTzdGdHFLQkxZUWxVQ0thWEFG?=
 =?utf-8?B?OW9XbG91ZkE4T2QrOXpuUUZGNkNmbEgxV1BTOHZaQkJMeHBLYmhkL2pwazE2?=
 =?utf-8?B?bzVXSWp4RmFwSmFuc3YvMldva2RwS2ZWTUZPOUNBVTg5TkUzdnVMaFVWMDRP?=
 =?utf-8?B?UUNtazNld2p5NlcxTVhIYmhxWmtJRTlKa1VWeFpQNmMwa25yQ0hhdjZ5ajZC?=
 =?utf-8?B?M0dpWDUydGJ2ZURuWTg4VkxiMWJ3KzVMUThoeVl5RjNUY3hhR1VHT3p4MjZq?=
 =?utf-8?B?RlZ4Rno1d2FETjhZNmp0QjBkeDFtdDNSQncxRTgvZFRURnhqN2dHOU9TUnhT?=
 =?utf-8?B?NG5zZHlIbHRleTVTTERvK25IdC81VEx4N0ZkMTFlYkZGZHJTZGw3Zys2d1Z0?=
 =?utf-8?B?UHNSM2hLRjFmNFlkMFRCUWZMeEtpRll6cFlHdUo4dVErell2cGgrcEJnWDQ0?=
 =?utf-8?B?K1MxanJQNVk2U29IZEFWWEgxQ3lOMHArRGIyZGhCSHdES2ZYRlMxSytxUEJx?=
 =?utf-8?B?SG5oenRKZnNUMXJHVVN1czdCV1VCbnl4SHFNQ0Q4Um00UlU4a1Z3YUN6Yjh4?=
 =?utf-8?B?NjJ1VzNNZURsQVZ6bVJKaTNuZnZUY3praVVzYjVBNk9FRjN1SlhabkpOTGlR?=
 =?utf-8?B?V1Qrem5ZOFlHdnVSeXVCUVZnYjlsM2lxbVZYTDZMaWZib3pEcTNXLzZrZGxm?=
 =?utf-8?B?QU53Nmw3dUVpL2VxNHdOdkQ3Qkc3TjlQOEhVcFRma0dlcXFyVVYrUy9MdzhV?=
 =?utf-8?Q?uAfUhy5eeB3INC/U=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b992af-0891-4c16-15d3-08df2467d85e
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 11:40:54.1289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 543RIIfsB5k4MHtVMDzZdcvymE+U3rgIVwvgde9rPJ+DlEYbTWc5BXVxmXrxtLpNuH/COoNAtlmRx/7TsXkKwAGfBv1OOe5IdFJKZk1wBPU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1729

On 2026-10-07 10:53, Stian Halseth wrote:
> A register window fill that faults is mishandled in three ways on
> sparc64.  The first wedges the CPU in kernel mode and takes the machine
> with it; the other two corrupt what the kernel reports about the fault,
> and were found while chasing the first.
> 
> 1/3 is the lockup.  user_rtt_fill_fixup_common() re-enters the kernel
> without passing through etrap, so %asi is left as the ASI_AIUP that
> rtrap set for the fill while the primary context has been restored to
> the kernel's.  Every subsequent %asi-based user access then translates
> in the kernel context, and a user address below the VA hole can never be
> resolved: the fault repeats forever, the task survives SIGKILL, and RCU
> eventually reports the CPU stalled.
> 
> The reproducer in the v1 cover letter moves %sp onto a page, flushes the
> register windows, mprotects that page PROT_NONE and takes a signal, so
> the fill on the signal return path faults.  It needs no unusual
> configuration and wedges a stock kernel in a few seconds; mind where you
> run it, as the machine needs a hard reset afterwards.  On a fixed kernel
> it prints PASS and exits.
> 
> 2/3 and 3/3 came out of that investigation.  do_fault_siginfo() decodes
> the instruction at regs->tpc to compute si_addr, which is not the
> faulting access when the fault came from a spill or fill; in one capture
> it decoded a branch and reported the contents of %g5.  And the huge-page
> path in the TSB miss handler tested TL after switching the global
> register bank, so it consumed a fault code and a PTE that no longer
> existed and killed the task with SIGSEGV at an address that had never
> been mapped.  That one needs CONFIG_TRANSPARENT_HUGEPAGE and only
> appears under load.
> 
> 1/3 is reproduced and fixed on an UltraSPARC T4-1 (sun4v, Niagara4) and
> on a Sun Fire V240 (sun4u, UltraSPARC-IIIi), which between them cover
> both forms of the global register bank switch, SET_GL and the
> PSTATE_AG|PSTATE_MG write.  2/3 and 3/3 are tested on the T4-1, where
> with all three applied a Go toolchain build now completes five times
> running with THP enabled, having previously died within a minute.
> 
> Link: https://github.com/sparclinux/issues/issues/87
> 
> v2:
>   - 1/3: reword the comment above the %asi write as suggested by
>     Andreas: state the restored invariant first, phrase it as why the
>     write is needed, and leave the failure-mode details to the commit
>     message.  No code change.
>   - 2/3, 3/3: unchanged.
> 
> v1: https://lore.kernel.org/all/20260828123707.1852437-1-stian@itx.no/
> 
> Stian Halseth (3):
>   sparc64: restore %asi in user_rtt_fill_fixup_common
>   sparc64: use the fault address for si_addr on window fixup faults
>   sparc64: decide the TSB huge-page window fixup before the bank switch
> 
>  arch/sparc/kernel/tsb.S       | 24 ++++++++++++++++++++----
>  arch/sparc/kernel/urtt_fill.S | 10 ++++++++++
>  arch/sparc/mm/fault_64.c      |  9 +++++++++
>  3 files changed, 39 insertions(+), 4 deletions(-)
> 

The Tested-by from v1 was unfortunately not incorporated in this
version, so I add it here:

Tested-by: Imre Kaloz <kaloz@kernel.org>


Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

