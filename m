Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022106.outbound.protection.outlook.com [52.101.77.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0D1DFDA1;
	Wed,  7 Oct 2026 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352092; cv=fail; b=poqr2SJ47p2vi9ft1ouqviZNdHHyMo41bSHK37dROhEQV5Ybyx8nv7XkiE8B3Ppv03y7X7ga+Ga6rH3ty+yAx8PckwqJVdtp7bHJB6YRz0Ts56ZFHfEsdmEkiVJRCdGceuaz/r8GFNH8DlDHp7ZDql54rOYx3mLcxs/vEZ68TJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352092; c=relaxed/simple;
	bh=EEmhcB19kf8lCKkaHfqj5CxMIR+usmTq9RaGYCi4Otg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jy2j68Y0GNWnYQtCc8uiDkN9UAMcnSb0JkV4oYoYUy0MXNOXak3p1zs5qUU2a/PdryCOzUlITCWVoa2RAEYxcHLcPsRFpUHy5GQJ31SLI9IpPsAZnP59db+JzOGMtrgkTUURHQs/NPkIlU2pEzlipYoW6D/PQVk6TSUr8PJ8vOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=kAoIGUeA; arc=fail smtp.client-ip=52.101.77.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="kAoIGUeA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7/uOCDDWqFVKzBK033WLjDU27ZasS51XwisnF1TrzOYB5my9CFoRvqg4njl1wrTWW7+HbQTQL5Hzr9iqOK1bNWvGGz9czYq7RJCSpW9alsBuCiAidT/vEfCTTp/llxYTdeBMNG0P3GvZpblnH+SZsGJcVLRxEtwitO76G1vEnnC+2tb9L6q7EMx/zL46tbmLEksmv1IxZNnMiHg41u48vAFhMX/27KafqA+wLVWHN/Mi3pb3WaAfw3r7zpc0gWp4xdjCTbFZ5MPiqvV/P8545xJ2JtiyJ4GgUnjAsWI/m6R/tw6IjqOLP78mGOEbjwUS1tGnu/7Kwb+qOxqrNhx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFNBcEOLeUk/5rvFCiGCV3uIJbeqHaGybTu3ndgEzkQ=;
 b=DtFemtu67CRZT1SLNHEOQ29gVa0eSFYQdPmUsSkKfiy+JSuJluIKr64S1COvovrtpap+cgNAhZbh0eMcx3FrrdPgO75f+yurLPRdpwUZqRFB8OHR99aDhja6hp4lgFPnTo3zwEApI6GOe9qW5kjcj3LtzOiD7RDRk91LW4WYa3be7zk8Ope1m7dO6iUhDxOhVctnHN9hmjo/mvMUsxG9wkZyhGPFTSkFSkhJgyIVDxQnUuqeoE0uwEdJN8LqqtCsBpcRxAzk+om9h/Nbwg6fOYqnVqzj7/PFhMgNFLFO6EWOh+HSsYlh4MSXNz0l55Odf2s7Vo/XclG5fHxNbhsBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFNBcEOLeUk/5rvFCiGCV3uIJbeqHaGybTu3ndgEzkQ=;
 b=kAoIGUeAinrZb4tJxsL7UB/2fsy2sHgiaBFDEoSesArgend+XKiLFX9ZP4B+OkqKmDd6rygRG+9OKrd+dBnx8PT0aaL/Pujw0F9VFQhsVDCX+4fxm5rPBlCa7B0dLKd20HgaYiJ/+SVNM7Csqrk9S4DfX/qj6D28UkeuxswfBBV+oHzCvxAwNcbYGg21yNlcGPw/F84Dqr9BMHm9IxvpnKnCiCB+HlY8rYqHKzeok5RhfexwmXuJQA6dCPosXYAQCqtw34XTs6OOV0xQi1r9jJrAWk2Mbp0cNAkFOkUnHt8f49cIKFHNpwHTOXgiWqxi7ix7aiAIRD2/d+gZZBNaDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GV3P280MB0481.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:10::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Wed, 7 Oct
 2026 05:48:04 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 05:48:04 +0000
Message-ID: <2b6757c5-4cbc-488e-bc3d-42a79c7273f8@gaisler.com>
Date: Wed, 7 Oct 2026 07:48:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/6] sparc32: move early memory setup to setup_arch
To: Magnus Lindholm <linmag7@gmail.com>, davem@davemloft.net
Cc: sam@ravnborg.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260927214334.886582-1-linmag7@gmail.com>
 <20260927214334.886582-6-linmag7@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260927214334.886582-6-linmag7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0001A336.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::69b) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GV3P280MB0481:EE_
X-MS-Office365-Filtering-Correlation-Id: bfee37e1-6f6c-4349-ff2c-08df24368e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|4143699003|11063799006|260925021911599003|260925022911599003|260925021311599003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	av6VGKz6zRs9wSw1mK69Ctawf19p+ztIMlcx0uw9gS3gWHa5nwlnerxdwb0viJ07BQnP+Uu0Nr5Cknl790MnJDZEO8i5io9JdCsPnUsvHGRN7Dq7fEeiF7OaqIju0/0i4dJTH+JYQHXH1pwjqxJ3es8wYo5O/CbDMR7nvQKW3yfCYaPfK0/dia6BkyjHB4Q20JPmPjOBtv06khKm3ybzZnoGdsUB4TDYU9ykApv1SeXIDvWgPltApeGen/yNXWzKhk71frww37Z1Y7YVjYXNcui8IrzCfxt6d4xpghNhs+Xq99HrYPfmG8h/Rx/SA9DZpNqGbTYI0Vr0Ic4OQoxqy1BjvewgcUQJ9AfZTugC8LPDTGxP/JYehQvCW3P2BjDF+w3H4S9EVOhxFtQSBjwMjFl1NvPwQutdoNW1/J+kpVGOGAHaJQhqmd4Ls8D+bGU62Pn9ge6BbX7x5IEDfkpRNAqPBXNY4u1wQmrY9vo6ofG1l+qush0y6HqFvTFVVqUR/QwIJWSZCFYw8GIlqh67Y+wBi5AM1w4CjOvs7PktzmdZeySZlxl9bovG/LLOr9GF16ZWpqqmw9X6eoJKMQghGI14bU3CqRw4zKqLqvfwT77ki1cIn6Rverzu0Hqr8dkw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXRia1pBUFpiSFc1YWtBM3VFQmZDRnUrcG9zKzlkNU5ZZ2hFc0RvRDhKRkJG?=
 =?utf-8?B?STRPb0Fvb3pVSTJXQ2V2UXBTMFlwWjRjR0pLT2xpZnVqeUxWa3FqV0hZdGlw?=
 =?utf-8?B?OXRhVnBpWm5JLzBVajJQR1dPR3dhcEx1cmJJSnBET3h3QVpWQ3lXa2hpK2c0?=
 =?utf-8?B?TTlwV0pBODc5SFNOMnZ3MG1lL0RuRElMYkw5c0FYU0h4TFJFaFdYR1VpSXov?=
 =?utf-8?B?S1N6VDBOVFZuMW1QWVUzYlB3UzZvODMvZzNGTGowRTlkVVo1bmFzQTJIQlBB?=
 =?utf-8?B?Z1BlWUVva05aVUgrUnhNeWlVbEl5VWhYeXI3TkxZbjZsMWxFcnhqb2ljbVBD?=
 =?utf-8?B?YUJva1o0TndQYmVLcGU4V3VPTXc5TE5Fa0hQQ2hRYkNoeTFEcy9lQlF2SFh5?=
 =?utf-8?B?N0pmdGsrWU1Xand5SmFxMXVrSVU0STE2R0srN3lCaXkzWStHS3QzRlZNUnVV?=
 =?utf-8?B?YmpUY3h3OFJKL0E2T01tVmdzcFNrMmJEWGFLcWRoUldGYkMxM0l0SHA4MmVr?=
 =?utf-8?B?Y0tLelhLNGlRRnpsOXVxcmFMU3NoVTBqbDExRUdidUNPeGpOd2lKUkEwTUpS?=
 =?utf-8?B?VTNmYzBkQURRY0dMZk9UTkxNMEtNbCthMzZXbmVHdFVvSzdXMWZEVjVFYWhm?=
 =?utf-8?B?aEFoeTYvdHRiU3FLM1VkbFc3ZHJBU0UxM2wwdUpVU1BhUWVNZm1VWlN4YSsy?=
 =?utf-8?B?VDkvdmpBenFFT29nWGdHTS9odVgrUXJzcitjdWpnaDEvM2xZU2duUWdRVlJi?=
 =?utf-8?B?dnFINGZ5STRzNS8zNytKd1pkcFJzQ2gwMmtZdjhDQzlxK21oUWNZMEt6amgx?=
 =?utf-8?B?R3pGZHAyMlV3RXBIR3pyWFpadlIrTC9nVjFZRmxYbUpPbGt2MFFaTzErd2Fp?=
 =?utf-8?B?YnBWdW5JZVgxMHlkOFlId2xlRStCK09ydE1KeXU5UnduWlV3cGd5OWhtQ054?=
 =?utf-8?B?a0ZiS1FvZWJMeGlHSWdSZnJVY1ArSUYrU21JampXc2pQKzlnc2x0Vng5a2R6?=
 =?utf-8?B?d3UwclpxOXFpNWhSY3V5eWl2TCtFNVNPNU5vSDhkUVdKWm94VS81cHRGRElK?=
 =?utf-8?B?U2VTUkVDMTZUL3VkUTJ5ZG50VnpRMlZsT0FFaDljQVJxNWpSTWFXU29ITXlX?=
 =?utf-8?B?RVdXcE03ei9YK09taXdxS2drVXFRUGpXSzFNeHN0VHJIc25JWkVGR0VxYVg0?=
 =?utf-8?B?VStaNVJ3NXhvUVBpR2Nwb0tqdjRzbDB1eFZxT3BhTzlOUE1RQ3pSQWo5VU1U?=
 =?utf-8?B?TWRxMURCcko5d3RiaER5c1N4cUlXdC95ZG5oeTFKcGhWOVBHVk82OU9sTElo?=
 =?utf-8?B?Yzd0a3BnSUlWeFNHL2xYc0pOUnQyRnFXeFJWSll2WWRObWN4bWh6b1RRdTVi?=
 =?utf-8?B?dWRhNDZWejhUaTBGc2hNckp3UHhzMTJQWFNLRC9RTjJMWVFJa25TUklmQ002?=
 =?utf-8?B?NDhiZkordlFLKzJSeXpYK29HQ2h3Z2RiMFNBM2RDWFpNU2JIaU5uLzRIcmla?=
 =?utf-8?B?QTBGc3JqMFpaQzZZWkdhVnFNQ0RvMVh0ZTZEeE5TMEd1SUk3TTVTcTVaaWph?=
 =?utf-8?B?czN1Snc0R1dlbFJaUHNOa1RCbVlBNGdXRkU4WlNBb3orb0ppOVJBTkhFc0NH?=
 =?utf-8?B?YjN6dDZxZlVBWEVldEJscDZ1STFwaG9NbXZ0cjdvOFRibEE1WmphZUlzczRL?=
 =?utf-8?B?MjR4YVU1dVAxN1A5KytWMlVBUFR5cHJyUFFFczNnUmtJSFVxWXJ6UU56cjd6?=
 =?utf-8?B?Ym1jT0dJZUxmSXdPS3ZLUERiZ0pVTFdteVBtTE11QThWOTRMbFQwWEgvdmJE?=
 =?utf-8?B?aWZMNS85NzhjNi9jZ2U3WUdUa3Nvd2NwQnhZaGlmZldqV1NPMlpmUVcramVH?=
 =?utf-8?B?cy9DQzh6QXRtRXRKNUhnUGVZTXdsVjFYU20vb1N4MmhLTFdlKzBLSUIzN3RS?=
 =?utf-8?B?Z2xjZ2x5aE43cXdObTJiZzZnTmtaRjFmZHllRFdSTzJSdGdoUURQeWloV1dw?=
 =?utf-8?B?b3lIMkNBNUJGbzZIdWczNGJpSDhwdlVwSlVhSGtHaVhuTXY4WE93M2JIVy9n?=
 =?utf-8?B?ZWtySkRvVTVLRjNwbTd2YnR3RTFDV21oQUQvTW9pK1U3TUVvcm5jdWlzaTQx?=
 =?utf-8?B?MEVSaEVTbVE4b1Y3Z1dPNGZtMDZlL3Q1T1o1VmxTaWd6VnA5TlB6VEMzcUVj?=
 =?utf-8?B?UUw2Tk1IRklRTi81YW5UU3VtQWZPQkZnTFh1S0w2cEFUSUlLU09TdzZ2V2ty?=
 =?utf-8?B?Q3VQUUY4ZVVtbE5IMHlDdkpKbkJaYzlubXQ2SHVYTGhBYVpuWW1PQkFQYXhG?=
 =?utf-8?B?eU1FTnBJcUUwcmZYU3hVZkhuWFE5TFFTWGQ0N0NNVnF0ZFBXbXVMak9jdkl0?=
 =?utf-8?Q?4C0WME2jXA4jZNfk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfee37e1-6f6c-4349-ff2c-08df24368e13
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 05:48:04.1349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCxa5J0PqNMH1FhpkFe/oMgNlPoBuRcyfwP3rChSfymxpx7v97oZ5Z0fUSY8rirSvl9MOdIjSnkEawMLxqgIl/nuFhyQFAh1xzbtMLD6koM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0481

On 2026-09-27 23:43, Magnus Lindholm wrote:
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

This undos the v3 changes of https://lore.kernel.org/sparclinux/cover.1790548064.git.linmag7@gmail.com/T/#t ...

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

...and does not apply on top of that. 

Please rework the series on top of the for-next branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git

Thanks,
Andreas

