Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020123.outbound.protection.outlook.com [52.101.75.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE9374183;
	Fri, 16 Oct 2026 14:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160889; cv=fail; b=C1UXOD0tDXi+AzXYcBGttJphf96CMlNdSBGouQwH0QmjUZwQo32hnn4DpzdHAnYhuGSB/qTH0CNP911P4fl8wQp/3I7j6W36+3F2JqB8HYhhDDMpxXD8Wuj4mdb5XzpL9Hhf2ogvr2rjp5WyFEv9GDROnWDRw3dtsyDfhK4N920=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160889; c=relaxed/simple;
	bh=/oXpTNPte50EVmAty2HqliuYtA+UiFUcqDqtRjtxqL8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HTUqU0naVwPteBriiD8+Tt8evElRTYxytRKm7FB1/O68BcFU8spIaUw5OiAH48Wgc86+Z9B49o0tNztya63yPwhcHhDP4heeEao5Yjhu4CJzLffQtukgsZyAqXFkH2XqQ1B6FRmA9FBi+41iSle/BGR9F+aGZ3u+FhbliRr3vXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=pTU9ODHV; arc=fail smtp.client-ip=52.101.75.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="pTU9ODHV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg245jmeQP9+OhUd2EAXL8QFNzg2kDkqH32V8k7lMFZEtuJqX+5rPHQBSZ1XsqX9jHmHwlFLz9sV313YzCmUlmSOhu6tDTQ2xU77dDe6pQYUJqhycdrNHVxThEJyEn+Uxh3YmwOGtTSrATN1Rb8WZ32N3I3M2rpF/a33jyVNnJ8DowBWD6WU7n29G7z+VWjc70GOSOSXDOio56Ytm8cAvYgBNrgFwitsOZicLdZ4hgeTfDj17d6cD+1U5cDSzhq62/3yNM5JuOrYLxZsH9U9F72n0PT2JUIJwGiQeTExynhVRGE6JdSL3/NGqC/yleS45RRLzyhcTV6Cqy1E4GQzfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74ASZYIaOz+UPA1zPeumouBpjUP4ZbwqA+PYVojTqDg=;
 b=Dv1SiCYUp8SEoRpxJAMk8XChv//kd51mZ42P/wlMW+PK0rCKyq9oKez/ms6gwYcfEjdgLYdmhAoob83tVdSTQ7dcEmV42pjApjAmyaybE2oDvIQDN17CTRIr4XPYBtD8ndKMtwXr1T9HrOAI6bhHcGMqjJzo5wJvH5I9fGQZpZxvqz1WhWMPFpI4rMmaOm7fQWgKdCQPL0UBx3Vo9cDUdWXHJfbIjSzLBsXMGU4YC8Qx0MKeCXGM0qW9pKprj7uSw/3vbhwC6WxXTBBtjasYVqyH/aI/ZAdFsvr5ld1q+3kZXu4EX5cy/JtCTfG0LaBPMOI7/ep2Thi74xpOl8k4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74ASZYIaOz+UPA1zPeumouBpjUP4ZbwqA+PYVojTqDg=;
 b=pTU9ODHVjN4OuTqX8JqKm6BDSOil+T630+KIK4XI1JtEtIoN1jviZqj4bhJyLXw6mhw/bHMxjg3KrZT/v7VY7ARfazfAEGZBUKGb2/7ZXfls1Zv4nOY96LdU/eddMDFpenAmqpkG7wURfHryQOTh+F0+eddcrdSx9GpACvTn25rpxofmnEtspJDOcgztboG7P0SPEIHQ1ULHFsnOdMN8I0QfznNaU1cv2BZ+IBNOdapZSAab6jrPt9r+jD2XEqokI56wdTnlX2VMK5j4RZqIAzjTY/eJf0PFHnvhTjadoBoqEyPfaiYyERvvcTybUB88mkbQXVdCBiB7+DHqU9pMoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB1998.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:379::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 14:28:02 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Fri, 16 Oct 2026
 14:28:02 +0000
Message-ID: <d1862c8a-d088-420d-ac94-d521f48ae9c9@gaisler.com>
Date: Fri, 16 Oct 2026 16:28:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc32: Fix pgd lookup in vmalloc fault handling
To: Ludwig Rydberg <ludwig.rydberg@gaisler.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20261014133431.8003-1-ludwig.rydberg@gaisler.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261014133431.8003-1-ludwig.rydberg@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0021.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:fa::29) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB1998:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c90988c-6421-43ec-bd6e-08df2b91af94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s39S3YHTTYE8YEJheIQ3f0rr3QuKMutpVlnB4AT3oN5VKMP9pVrN914LtLBUjmdSaUfEjJjRtcusLLePnJ+5mEIqmDBAAJ4O8XKmpuToY7p3yxOoaA89Zn1TTxLayxweW5UiEO75mlV4i/TdoENnp2LkhmykDGk3OeRU2TMehgGZ7lbhNU/ysw6fW/hu8FQA+mK2ESN3PfbGQbYA8rytYPvPURz8HgVJv/dP72oGyIdyjVLm8oDxQ9PnBDyoD1o/r+fuIJg95bOQAU0giiGRJ98u2tSWL8Lalut+XojfFqSRD7ZH+phz4wy62fRD2/pIQtgLD8GGrtngFP/rz13wPbEFnAEVCjStJr69awpto5ovERCrtolMVk3iQ3VRsOIfG6D8huBgC/aqrNkTJd0Are3C6d25rULwBHpkiHBaH2VVJLm7vr9dHAyD1JcBmVS64HoVbNAJZ3JsTOjIpzj2arI4POxLAk3vd6m8cVmrk9wpACVRPl7dkIzP+8nlfnH+ClwyZ5L79iCxHNDA7iolgyAufz6V5K5UXByVJVGEynYpvt+nIjJIj2LiGmLygIt8Jus6212xP2/0rehHnQXF8Mx/qnvAcSyH/EbxtF/UKFMZl31tcjn1cceIqnaUhjcpcMIKRMoI8g9yG48PaZgNKDN6F6TmqZcOTVVgnpTAohI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzBMZ3l3YUZIdVNsTE1FT1VnZUdNQzVqRVZNTDAvV28zci9ad1BNMk1GalFm?=
 =?utf-8?B?YUd6RWJwTmZhUld5UDBrOFZUVFJKeUx0dEFlT1h6eFYvVUZiNzJjd3ErSDBw?=
 =?utf-8?B?c1ozOXBwWUVsK0s4SHJ6d2dEcGhTMHRwTEdnSHVXanIvRXZxUHd3YU9MK2tH?=
 =?utf-8?B?MTFDaG9NZWlrazJNN0dRT2M0ZEN1S3dPd2RDekFxSEVSaUo1bTJueUhnSmtN?=
 =?utf-8?B?ZVpuaVp3bjJUS0p4ZDhvSklpV3BReVlpcUdOTzhHUHllUHMreEttT0pWd0Ri?=
 =?utf-8?B?Vno3cHl3WWZXY1V3d0RPR29FWXVPWHRlTVNZc0FWQjVYODlNM1RES2xpcTBm?=
 =?utf-8?B?RlpTbjRaSy9uWHNzMTlLSUpPYllKcXFscXhDRkpidlhGaW52RldMaC9YWjl1?=
 =?utf-8?B?MjNHaFp2Q1lGc1hpZlhFUEZHbGloVk1ZYVc2MlltYzRzOXNXQ0dMN2NDVVln?=
 =?utf-8?B?TzRaSGFkRXZ3SlFuL1c3UDZDKzFNY3d3eXZXNDJPeDZSUWRMT1V4S212TUMr?=
 =?utf-8?B?eDgwQW1sWjZHWlVneHBtN21aRHpDckFkMUpiMC9YUFlselJNODVYRWdFTUtt?=
 =?utf-8?B?S3g2d3dMa0hhdEwxTUM0K3ZBYTJwbUlSZFBzVW54WTJKOTVKbU5ENHpnLzhM?=
 =?utf-8?B?T0djWUMrQSswdGNXY1NRWjhDa2lOV2Nod21xak5tdEhrYVNLR2xOY2tFTm9v?=
 =?utf-8?B?L2lUaE5HaFp4dkJsNnpyUkw3K2l6K1oyY0RQMHFuekVETzI1Ulhzc2Q4QTdz?=
 =?utf-8?B?VDdGazVUT09uNEJIY3NRZ2J2V25BaWwzbmNiQmJTam9jZ01iUUN4RDdPa20x?=
 =?utf-8?B?b3psdkVDYUJIckI0U0F6Y2VQeEROQ1hvZitvbzRiMER4MWZrWThtckU1b3hC?=
 =?utf-8?B?RXNSTVRnL3dONDg4b0VmdzltRFp1WE9DYURjakttbnQzUWRmTmVjTm9SbW4x?=
 =?utf-8?B?aVp4TlBKWnRMaFN1ak1WWDB6RzdJV1Q3THZWNEVNYlZlbXRWUUNLby81MjhI?=
 =?utf-8?B?ZldJdWNHc1NENjgyVS9ZMkZxL3NrSkwvcVoxRER4djdTR05TbnY4c0VWNWY5?=
 =?utf-8?B?U0FnR1FYVTFHdkFDVDZTSWxYT1dubElWNGRXenl1Q1hKQlBWY0dFb2lKV2gr?=
 =?utf-8?B?R0o3bE1pZWlDMzdHZlBXSzk5WmZ6ZWdkczJVYTU4ZTJTWEJnYk5adVVlamZF?=
 =?utf-8?B?V3JJdjRra2xlRlJrREk3R3pYZmd5L0F3V2FXNWZsWlZ2aUluaG45cUxDelUw?=
 =?utf-8?B?dE9tY0Z2NFhaSk05ZlRhdWRTR3NBbkVaTmtNdnpzZTl5cll0dHlQLzUrbStS?=
 =?utf-8?B?SVFlbU5xUGVBVDNVU2lrM3V4b1JoUTlPYXl1Z2dmS014R0pKREJTc21lZzlj?=
 =?utf-8?B?NjNucWhtNmdLOStLQSthcUl3eHlKVUI1MDE3SGhwcTByYXc4TjVPT3dqemFF?=
 =?utf-8?B?ZXhFUk5VRVg5WGFRbzl5Qi9ucGY3YTJEOUdZcFN5TnFhNnd0K2Y4NXJPcDQv?=
 =?utf-8?B?M1lzdG56UTc1OVMzRFdIalJFeDFad0N0L1p4STg0OXNPdEEzaHdBUG54Q2d1?=
 =?utf-8?B?eEZtUWhPTnpsVjNPRWx6dU1ZRGRtM29aR0JvUFJQL1l5SWRqdEd5YndGRHFi?=
 =?utf-8?B?VCtiTTdOTHRXeGk2MEV3YlduV24xMm10bEViWHpJbWJzZis3djYxTXZwUkhj?=
 =?utf-8?B?a3BBc1cvQkNtSFlMa2ZoamgvM29vaGszQS9zM0pxTnpuQnRJQ29FbHd0K0VJ?=
 =?utf-8?B?TUMrbkF5T3NrRXg0Ky9FY2p6MUlMa0FkR3pzc005L2FoZWs4MFZQRU1YT3hU?=
 =?utf-8?B?eGtNQ0pOUGhXbUpiSFRZU2NwaG5HREpldFRhWXVjTGNBaGFablY1VmxhUURa?=
 =?utf-8?B?SGg3c1JUYm40Q1pZbmFIYWQyV0xEUXBIMk00UnN6MDVKbTZDeHhMalBvc2hN?=
 =?utf-8?B?UjhBaDJNeXRVemVzZk0yNDNhMjhON0U0eW10Qm1KaEphNVZISVA0UUtEYXJK?=
 =?utf-8?B?TXM3M1AxQ0wrL09OYksvQlAzMm9hS0c5aXJPWVZIdmhYVDg2aVZoZGsxQm1a?=
 =?utf-8?B?T3pZVDhwNGVuZHdoQzhMdCt1ZGI1WmE1TlRRWmcyYy9zQzZ1RVFDMU5sTWQ5?=
 =?utf-8?B?cDFwc1JGNWlUQTU2SG90VGs0aGhFNXBERHVoMVFHUlNRNGtvNFZjSmhuZzdQ?=
 =?utf-8?B?WEJoZ1ZnZ3E3eGU4WGhOUlpaL2FVdDFmK3g2WjlMMnBveGdUOEU4OG9uTkdp?=
 =?utf-8?B?dEZaWTFhU0NRcFRzU0tmWS9zSytkOHRaUnVvVjIyblFERTBWT01CQTBPdVFZ?=
 =?utf-8?B?L1pHSkZidWtHUzc0aU5hdkluWHpJekozSDB3OWtJcm9jbDU5UmVGY212cmF4?=
 =?utf-8?Q?05fl/mmyrguaJDfk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c90988c-6421-43ec-bd6e-08df2b91af94
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 14:28:02.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpNAOStBUVNxJRMwFnHjtlpvsPHM2Vqft4Q8/uGstrZP8i9TAi6BQKYizi3yUQOttZOAXGoO/MLfCgZtY+23rtULS6A/gLidAigRaPLI4Uk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1998

On 2026-10-14 15:34, Ludwig Rydberg wrote:
> Check and synchronize the level-1 entry with the PUD accessors instead
> of the PGD ones. SPARC32 folds the P4D and PUD levels into the PGD and
> pgd_present() always returns 1. The PGD accessors therefore skipped the
> synchronization and the handler dereferenced a PMD pointer derived from
> the missing entry (seen in this kernel panic running v5.10.194):
> 
>   Unable to handle kernel paging request at virtual address ff780000
>   PC: <do_sparc_fault+0x20c/0x3c8>
>   Caller[f0007ed4]: srmmu_fault+0x60/0x70
> 
>   do_sparc_fault+0x20c/0x3c8:
>     pmd_present at arch/sparc/include/asm/pgtable_32.h:193
>     (inlined by) do_sparc_fault at arch/sparc/mm/fault_32.c:358
> 
> Fixes: 7235db268a27 ("sparc32: use pgtable-nopud instead of 4level-fixup")
> Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
> ---
>  arch/sparc/mm/fault_32.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
> index 86a831ebd8c8..f9befdbb3e72 100644
> --- a/arch/sparc/mm/fault_32.c
> +++ b/arch/sparc/mm/fault_32.c
> @@ -276,21 +276,21 @@ asmlinkage void do_sparc_fault(struct pt_regs *regs, int text_fault, int write,
>  		pmd_t *pmd, *pmd_k;
>  
>  		pgd = tsk->active_mm->pgd + offset;
> +		p4d = p4d_offset(pgd, address);
> +		pud = pud_offset(p4d, address);
> +
>  		pgd_k = init_mm.pgd + offset;
> +		p4d_k = p4d_offset(pgd_k, address);
> +		pud_k = pud_offset(p4d_k, address);
>  
> -		if (!pgd_present(*pgd)) {
> -			if (!pgd_present(*pgd_k))
> +		if (!pud_present(*pud)) {
> +			if (!pud_present(*pud_k))
>  				goto bad_area_nosemaphore;
> -			pgd_val(*pgd) = pgd_val(*pgd_k);
> +			pud_val(*pud) = pud_val(*pud_k);
>  			return;
>  		}
>  
> -		p4d = p4d_offset(pgd, address);
> -		pud = pud_offset(p4d, address);
>  		pmd = pmd_offset(pud, address);
> -
> -		p4d_k = p4d_offset(pgd_k, address);
> -		pud_k = pud_offset(p4d_k, address);
>  		pmd_k = pmd_offset(pud_k, address);
>  
>  		if (pmd_present(*pmd) || !pmd_present(*pmd_k))
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

