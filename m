Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022124.outbound.protection.outlook.com [52.101.77.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51261E7C23;
	Wed, 18 Mar 2026 15:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.77.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846481; cv=fail; b=aHZzJqxqxaRByR8D3iazx5xjeGXCTTJXZN7NsyPfLrKpPMtK4LOvU3xcFrNpO837QKr6V7vxO7HIHuvUMxPvfLOhY7aqpLIsWgwwTtrume8Ui/bexRONCEaPOC14RfeO9NRdzyccA+Xjp6Tryq0YKrPTrYI9DTh/npW4JWp/A4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846481; c=relaxed/simple;
	bh=w+Tt18Ooz/d3GEd6AMZdlY96QxTvaWC+RODzKQHTDLE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=huabCNF9A5x3Lmv+31Zezh2PQbIzggZiBnKusuK7ekH8K9uf5zQCSnIUaTspns0PjEdZBuXZzpbfT5V44e4YLA/deUaDJ1MLdpItehjcx3a/MO96alBIfFz8PXlipii2PpXL4HAC3w1BK4+Te0ahVTEo5w68EM+RyyifAxDnuRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; arc=fail smtp.client-ip=52.101.77.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aGODX9J8Hhh/QfLme0UAZi3MQJA39OWcddovqtpLLoKczArmotgiPb8PoYaPKV00Q8TzyCZbZqiXhj4rkgrc7hZjQhnAJ5aMfp8Ci9Zk+UUMIdHCNM/Em9ygPtFtD5ioX/xMVIRtLxdgaY7Kzf6vf7qbuIflNclwI1/Ohm5LwfEdCTDPwWb0cz6mwf5TIRtYWSb0c6gwBFtg7QjLPVWovhzbTsAzpWuAm9W+GUghbkNqpKuIPqILU/1FUXw3plnDxhcEqa0foIyd46D/AszwINrgsjJBLhtL7/Rj+SzeQ/J3jKHu0OHhBUhZQtSZlbLbmUFuKI+ypHXrCN6973RV9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpbMIsqvUF5TkdpHspvLo8KBTFUPJJGAZOVkwWVQ1a4=;
 b=k0DlQ9y7DzopT1+0gpnYz48Ao8RJQaMMzwECq97e8h/2zNmALr2CaED7iyhLfxihLWgz9qITwbCezTARD8EvgeJrd9d3+wsM7O6P4EJ1dFOZOK31WLNK3gtgcQ0ue4C92TeOdrssDBAbpHp8J3ilnKyi9AR8ur7n+M+0WObXVMqVC8lNALtGSCeG1B/RhNbyjZRiBljmgwpt4Oy25HYk1PnchQnTXoe20ajnhE+2cN9QzvdxueAlc66K/2edu2lL37Lgs5vh8lRqqLymtYLa5EG+skVbMOFFux3VpqEB4nNzr4gWCdIKHY+ofCq25LBkOqMtCWPc3Ly3G+One2quJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GV5P280MB2155.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:376::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 15:07:51 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 15:07:54 +0000
Message-ID: <ad2695a5-e696-4f40-9d66-3d46bb911e4b@gaisler.com>
Date: Wed, 18 Mar 2026 16:07:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] sparc: Use vmemmap_populate_hugepages for
 vmemmap_populate
To: chengkaitao <pilgrimtao@gmail.com>, davem@davemloft.net,
 andreas@gaisler.com, akpm@linux-foundation.org, david@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 Andrew Morton <akpm@linux-foundation.org>
Cc: kevin.brodsky@arm.com, dave.hansen@linux.intel.com, ziy@nvidia.com,
 chengkaitao@kylinos.cn, willy@infradead.org, zhengqi.arch@bytedance.com,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260201063532.44807-1-pilgrimtao@gmail.com>
 <20260201063532.44807-2-pilgrimtao@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260201063532.44807-2-pilgrimtao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0002399C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::19c) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GV5P280MB2155:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e43330f-b8a9-4c86-e0d4-08de85002192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|18002099003|22082099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	qX+Q8n/fy8K74FZ/82wGBGlqOyxDcQ6BcSKAPJNMbth6mWy3yOo/qarrZ7Dg3azye09eGF3uKeaKu5ZH7YLnAPkxgAsr4K+tb0kehQVqD6Nts6QQ2gGE1RqAR3CXF+DTuWtonr3ZZdHJZESTRGDDfsPYqZVc2r1XNX9xgIxo83SkIiUVZL/TDezM4q46xwmNVKHMDPSw7fb/hmhNc1ISAzaugDb+zkmpNRvDUYqGVALdrMuJQKqhHo2IkFdrE2mDqzjFCov5c8CGn8xB6IWv/LmpZF1qgYbDJszuNzYeM0EizX4Z3d6wcZmdOCIkZZ7DzhXX8fD/oMhnUgx4yeoHRF8DTWFTdEAJeVfOiBrUodfJHQZVyfqib4+xqJEhtYK6wfLhcUgyUqW5mvntDpUeFad40Lyk7Ej8g9IQpD/z90HzVeg6efJMxM+Bk/kbRBoWJOYQOem/O64oDU75rW6Djet6gakRaopNf1GSvfGl8KoU0KzNhZ9BKQWrzQDjudg/c/yi5mKTsUaGWnqhiTVOG1ZyOa15mecBxWh1/Y3foY8b7yLi/45WRmVfPPwt1UoJ/1J+WFf9szdND69geTMtHwEdCCzRZW8oNBY9yBjxev2kjQajYmRkRcodv3BlzAAX5JweoSm9gt4hcBBr0Pk5u9ukRIOmN+uM40ali6qShfBkcnzv1tLrnJPeqSBqrGKXZv0COQMYe8LkRj9xtdeT3JmzGu2xaAOD1CsdJQGvsde1Fv3FG7eosCK111h0/egHrgvIW66ZPFsvEmE3k2H3ug==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(18002099003)(22082099003)(56012099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDdQMmF6MHR3Nk1MVVN1QUk3WTNid3lMS2N2ejVTMGpBaVZvZ3NtYjJFdmt6?=
 =?utf-8?B?eU9EeElMdjFOcFR5dEJ3WVFGUCsrYWtJaFEyZXVGRGJldUgxaE9vYkE4Y0Y5?=
 =?utf-8?B?SmNaQ2ZRN2pPZU9BdGozUGRRZkhidkVHc0FkUkpGMERPdm4waHZlNjFjMFpn?=
 =?utf-8?B?ZmFKQ29yMkY5NTdXNWRHcEE4MXZUbkx1UitDTEMzMGc5dzlPcGJJRm9WUlhw?=
 =?utf-8?B?U05UaTRtbGozNWphc1Via2NldEtRd2FncXhoVmh2RHBDWGpVTUx2YURKMElW?=
 =?utf-8?B?K2w5VGpWQm92dEhtbGxTN09RanFjOFhXd0NLc1J6ZkRaRUZSbU53WkJlaDlZ?=
 =?utf-8?B?L2ZtYVUvSGVDOTFjN202cmJnSHhkT3RISzI3OC90eGlaTXJ3eEhMd1FvZDVy?=
 =?utf-8?B?SEFsSDgrbm5vMFJIdDBPNXhGd295SDdxRlNPYWMrdlBHMG9RRmZFbHNBMzU0?=
 =?utf-8?B?QXZoSVZUbXRQc0M4YWF3RHNvaG5pUFFBMFJDUnk3YlBQUVlNR0tLaStYZ3dr?=
 =?utf-8?B?L2pnVVhLbXBWdFJDMXlDSEw0aDhJeWlaNFRJMGxBTzVvSWRGOU42VzVES0RI?=
 =?utf-8?B?c1FKb09lY0tMazRBYVRFZ0tySGlva3lNVFZLSXZOd21kejhNTEEzNG1mNlRO?=
 =?utf-8?B?Z2RFZGVtMk4xbWFjSUF6cmRSOGZTa2VucXU1NnZYSFRBc2VuZEtPRXF4WWE0?=
 =?utf-8?B?THhzaVZqa0RYTkU2cDJTRStZdVNNczF0L0o5MjJOcEFZd3lnSnNhQTFkQUox?=
 =?utf-8?B?cWNHbDAzNzdRelFXUDA3cVdpTmQzTTRFZHNYdU9tZ2JUSFc2RWl1WWovYVl3?=
 =?utf-8?B?ZzNoMm5YV0U1ZWZ3V3FnUlNZRHllcWhXbGhIbVJKd3VNUndUL0h3S0kwTXk5?=
 =?utf-8?B?eHVhRHlFbTR6Q2MxeEdVTmdTUG1lRFdLR3dmS3Frbi9RVWltaHpkUnA1UWhS?=
 =?utf-8?B?N3ltWlVoOTRYdnBMTDI5OUQ4UE56N0tJRVZ5TVJ0ditWU0IzeWIzV0EyN01Z?=
 =?utf-8?B?Z1VqQnlBUCthc2ZtOGhtUHg4OFVzM0Q3NEQ0RzBTaCtUK3M2ZVVacFlCTXQ5?=
 =?utf-8?B?by9QalNPaWZyNy9hdkZValM3Z0NrcC9yc0t5MUhQNWdnMmNWcFJ5RURPY2dH?=
 =?utf-8?B?SVlldWlQOGdXckJXcWlsTlRpck94Vk8vVm5qZDVKM3pnQzlSQlN4U2hkZVNJ?=
 =?utf-8?B?RG1BUzJPVnZiSlpMRTJINVRxcVdORlRrWHdTVC9Nb09pR3o3SEh4SXpVRWFa?=
 =?utf-8?B?SzNyNUQvVzg0dEdDM1FIOXUwRmxVT3E0QzJzcGkvTHl2dDZEQzZrRUcyN2lH?=
 =?utf-8?B?dlIxVklmbE5EZmdHbDFrRTZka0lYWWgraDdXc3E0YTF0bksyT2FYUHE2b2dt?=
 =?utf-8?B?RHNZbFBndkFpVXlxZXZUV05BY2lnM0kzYUlpcnZnN3VNYk5POXhQdFZhWDNS?=
 =?utf-8?B?azdlTUVYNWliRWE0dUpqMGhxQm5wekEyNG93WDBEN0pCS2E5SGVWYnhtV1Fs?=
 =?utf-8?B?OE1ONGQvQlRFQTBndDJOT0JHb2kwLzRYM2c5dThIWUx6YTkzc2Q5L3Jpa04v?=
 =?utf-8?B?TmlMSTNJaW4rQlJFNEpmcXZRTUtHcXlUd1V4dkk4cUVDMFl3SXpsRmlOeVpz?=
 =?utf-8?B?N2N0alNKL2h2bnpjcE5jSC9iWDhBdzJ1Z1pldHV0V3E0U1lUbFY1eWkrNDlH?=
 =?utf-8?B?WWhPV2VDN2xJVWpwQmRhNisreWxZTTdkdWZoeDRYcXFBSHJOSDMyS3A4SzlX?=
 =?utf-8?B?QlZjeDJSenAvUkl6KzA2NmlFbFYyaDYzZ3pKYmtpU2tCM1BGQjhWbUNvVkFv?=
 =?utf-8?B?U1Q4SDArZ2lGSjhtSFY1S0I1UnE3WmJoMVg5YXZCbm8yRE04MGhXSFljVUla?=
 =?utf-8?B?cmNLK3Y0NXNUV0h3ZDRQWnhrU0NFNXJBZk5reTZxM2JUUkxPc0FlcE1OUTZB?=
 =?utf-8?B?cXJzUDgxcjdOYlNxUzc2QUtyZlEwbHNXN2Z5cTBDV0UzRlU5TnBLSFhqRDQ4?=
 =?utf-8?B?aDRqd0Y2RDFQZk1LUDZzOU1DbkRqOTlEdkI5MnVzYUU4ZlhTaU5sTVpUc2l6?=
 =?utf-8?B?MFhHbC9URVFtSzFxZVdHT2hxOXNuTWc3MWVNeklYRUJLTTZaektPMTRhREJv?=
 =?utf-8?B?Yks5dy95QStRQnhNTVpzaHo3MnpkZVJBa3I5Mm5YeXBDU2N0Y25qRTJLVWNB?=
 =?utf-8?B?UWxLd1gybXVVV2wzVTRNRGdFM3dvTWIwTno4NHQvakQvVEJRZjlnSlU1V3Zj?=
 =?utf-8?B?WHYvb3JycnNMaGwxN1doNEZOL0ZLNTlWRk9mZXhWR1R5Y01GZTRHTHpGWlUv?=
 =?utf-8?B?cGF4UE1VZ2dzWEx3cVFESXROcTcyR0Z5Q29wdjFnT3VmRFc5Q1ZIZFFZRWx2?=
 =?utf-8?Q?jskVyLwPnCi4Kmuw=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e43330f-b8a9-4c86-e0d4-08de85002192
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 15:07:54.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuhBRUGDPwVZ0kqE60WGfft6TeaCL92vO/RSBYvn7S+6j8nZW82DuB+Lhg7RGqyBmhstFotc2GQlyWJ6K4W+SN5US05gtqs0sjPDYQlH5n4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV5P280MB2155

On 2026-02-01 07:35, chengkaitao wrote:
> From: Chengkaitao <chengkaitao@kylinos.cn>
> 
> 1. In the SPARC architecture, reimplement vmemmap_populate using
> vmemmap_populate_hugepages.
> 2. Allow the SPARC arch to fallback to vmemmap_populate_basepages(),
> when vmemmap_alloc_block returns NULL.
> 
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>
> ---
>  arch/sparc/mm/init_64.c | 47 ++++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index df9f7c444c39..f1981adc99ac 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2581,8 +2581,8 @@ unsigned long _PAGE_CACHE __read_mostly;
>  EXPORT_SYMBOL(_PAGE_CACHE);
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
> -			       int node, struct vmem_altmap *altmap)
> +void __meminit vmemmap_set_pmd(pmd_t *pmd, void *p, int node,
> +			       unsigned long addr, unsigned long next)
>  {
>  	unsigned long pte_base;
>  
> @@ -2595,39 +2595,24 @@ int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
>  
>  	pte_base |= _PAGE_PMD_HUGE;
>  
> -	vstart = vstart & PMD_MASK;
> -	vend = ALIGN(vend, PMD_SIZE);
> -	for (; vstart < vend; vstart += PMD_SIZE) {
> -		pgd_t *pgd = vmemmap_pgd_populate(vstart, node);
> -		unsigned long pte;
> -		p4d_t *p4d;
> -		pud_t *pud;
> -		pmd_t *pmd;
> -
> -		if (!pgd)
> -			return -ENOMEM;
> -
> -		p4d = vmemmap_p4d_populate(pgd, vstart, node);
> -		if (!p4d)
> -			return -ENOMEM;
> -
> -		pud = vmemmap_pud_populate(p4d, vstart, node);
> -		if (!pud)
> -			return -ENOMEM;
> +	pmd_val(*pmd) = pte_base | __pa(p);
> +}
>  
> -		pmd = pmd_offset(pud, vstart);
> -		pte = pmd_val(*pmd);
> -		if (!(pte & _PAGE_VALID)) {
> -			void *block = vmemmap_alloc_block(PMD_SIZE, node);
> +int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
> +				unsigned long addr, unsigned long next)
> +{
> +	int large = pmd_leaf(*pmdp);
>  
> -			if (!block)
> -				return -ENOMEM;
> +	if (large)
> +		vmemmap_verify((pte_t *)pmdp, node, addr, next);
>  
> -			pmd_val(*pmd) = pte_base | __pa(block);
> -		}
> -	}
> +	return large;
> +}
>  
> -	return 0;
> +int __meminit vmemmap_populate(unsigned long vstart, unsigned long vend,
> +			       int node, struct vmem_altmap *altmap)
> +{
> +	return vmemmap_populate_hugepages(vstart, vend, node, NULL);
>  }
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  

Tested-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>

I assume this goes through the mm tree.

Cheers,
Andreas
