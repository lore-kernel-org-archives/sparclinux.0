Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9991CB339;
	Fri,  6 Sep 2024 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725623276; cv=fail; b=JxRoG+i/gDfMiQgzV9n2CiAyPtpR6+ETLClop29RvGiVaELblBXnz63AqDDD0LFGrrrezhNLIoApx/gIYKm93/AFFbq8x2EvXAkzIrMR4qQHIKwne287JWH9ximHvoQVJscHYufudoTbdpVD4YAI5vxuQXhYdAefyJrcVpRcHaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725623276; c=relaxed/simple;
	bh=1K4ETqRz6d/Dm8hiIG25e7dDlt09xqHnBM0IPhPeU2U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=APkcjhTgHaOh7ixV5fSVhPy1jgsjOPbrsgxi0h4iACJu1vG9Ue7km3CCL8i43n1R9d0+K3myPSk6uKw+cAqIl0PCbiu6P6uwfDNXA43T4YQ8PqszEHE559HJS2U2OoLyih4p2PYzTPRH9Kkbo5UkXWkJrIspTfQl0/0bbD/dcO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n4vkr2nJ; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n4vkr2nJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725623275; x=1757159275;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=1K4ETqRz6d/Dm8hiIG25e7dDlt09xqHnBM0IPhPeU2U=;
  b=n4vkr2nJJNb2gfhqvFIJ0cnv2sQF0ZjTaZTmH1o4Fs4b2JvHIh2ylXUn
   sg3YHP6MY76osvBz4Hbn/mMTqYLSH4HnsXqnZ5Sgg/qigqsOLGDpErhHD
   FzcmbHzoHlVdVEK3meAwypN7A4UqZebx2txyL6Z8XKfE9vEe7LumjllS6
   l0I5Q7ZZzlhYojhAx5bPvQKKnQW3r/H8z06EXRGr2iPq3UKAJA5uStZwT
   GAsaEKNNjX7aPMCP//+OOxZnWhPUcGunFRzmge/WHxtdRHxdIdXq1xmfE
   U671xrTo4itWz5XGMJpZQ+bTyva0ideoNJOGeO42qQupXjWqcyPDHx0Uw
   Q==;
X-CSE-ConnectionGUID: thtuFAdYSNuDO0K/TOTRPQ==
X-CSE-MsgGUID: ywhTtBBxSTmUJ9lxn5LtMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24488974"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24488974"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 04:47:54 -0700
X-CSE-ConnectionGUID: NIrOrQ1RSvmrNoxEkFsS4g==
X-CSE-MsgGUID: 8YsOjzbTTvKVRaryQ9eFZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70349102"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2024 04:47:53 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 6 Sep 2024 04:47:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 6 Sep 2024 04:47:52 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Sep 2024 04:47:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=diC7vAXs20AW66q33OKB1QxfQrXmNxTeM+DSqYZ0CzD50wEkPv5IEEO1fM6t3dlirhlSRwwlFUqo01xiqoOdmXAagI3OyQFWUJS1jOqW2WPv0g6pBZn9oa2Kwh+6xZQq9A1iNcgId/SbmbYIcDNu6LeGMB5+qsZi3NytVMZZlhInIAsncTiJQ3Nib4C6gADWmTlO/1QkpEEjKI42mM3ZYPQQdDpwjk3jkFELvco5w/QU9aCCJKjnmXELY8d+1uZILpdjNOM7SDFNiW5qgfpjBmJfRa57IeF5LCpJ2xRSDE73kvO9NLwQfJimrOqg44rJQnRvPvXEds3o9B4eSJikZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK6JPwf7Y4kKALXu6EB3IA/+2ZpAhL+6M8LAF4n3av0=;
 b=ASVf4UvssDDQVzO+kLUHt5Wn4fQJQOOvkJhAjZN3H0ryIDsUCF2weD9bIrNe+keEtK7DTdJteMuJzUwnITPdYwpgKqe5odXOTo1X0VsryBU9b1Et2lNrFWrDvUt+QwDKNW51Qukygd6ATQv7R6Xjj+gMusOhMuC5HeAPZNrxnW3eV5whmP49mo4PkIK7kLdxXRt45NcAJNz0qGeEuAg8ISGhydtWyUH5aD6iQMdGn69OxnZeV3x4lXSrW586qMIlNrqX2yJC+75qO0wHcGEk1Hm15I3SbyOuDY+k5zUJr03M5mwT7O31mfieTt7yzFOEbDmc7yRKFqjg56EjVrMrjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB7091.namprd11.prod.outlook.com (2603:10b6:806:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Fri, 6 Sep
 2024 11:47:50 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 11:47:50 +0000
Date: Fri, 6 Sep 2024 19:47:35 +0800
From: Feng Tang <feng.tang@intel.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
CC: <akpm@linux-foundation.org>, <bristot@redhat.com>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vbabka@suse.cz>,
	<vincent.guittot@linaro.org>, <vschneid@redhat.com>,
	<sparclinux@vger.kernel.org>
Subject: Re: sched/debug: Dump end of stack when detected corrupted
Message-ID: <Ztrr10sxYvQQGonC@feng-clx.sh.intel.com>
References: <20231219032254.96685-1-feng.tang@intel.com>
 <20240906084546.3304-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240906084546.3304-1-glaubitz@physik.fu-berlin.de>
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|SN7PR11MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: d19ef495-4ccc-437d-9b2c-08dcce69bc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J4mkCvYLagATJTQvQ/8FpRU+BP64MNLmN3WZHO7yik9USxmrmv4Q1hQv3l4G?=
 =?us-ascii?Q?GpYdxsaLbA0YY1myTqSMlplrraV5xUumpw4v2FxdEpZ4ykvijai8v1asbqdN?=
 =?us-ascii?Q?cF/muGiJ829hg+mEVdCWOuIxLslUUa9+NBRanb03HQT65qioyjx9Mc4YOkYJ?=
 =?us-ascii?Q?wunJP92TQQik4375fl8jJ7I9PjUnhF62EOZG0wEAqy1w0DI0poKlUwgnQXbt?=
 =?us-ascii?Q?RkaIYdX5PnxnmTdZZYTb9xgOJ+hlJwjY1PmziIn8zGPkTJQW3gSuqcHHmACU?=
 =?us-ascii?Q?j15kulsoNHGJXE2YtRDZ7msiVDhmgPsFAy/HQTCHxAnyxgBKKrPV43IOPn33?=
 =?us-ascii?Q?rbGqXp4Pd4P+b2JNOSmm6WCAe/3/XFNVB5ZfGoTljFfkRDO3S/4MDD8wo8zy?=
 =?us-ascii?Q?/HoJIwyYhEPwSZDgz0/Uu2nrwy1sh4SU4CkdWbSjplyTtae/vcVXIiG4ZiwX?=
 =?us-ascii?Q?3RCa6Z1Mx+woc9tDfUKkDaU9azC2r1PPk1253goadUaIz5U3cw8KEucc6rYZ?=
 =?us-ascii?Q?YfCgX1zgST7D3LsKi0PE+R0LnGrvmvkiwSMuL1dcoS2RSQmBBC5HBM4tJ91g?=
 =?us-ascii?Q?hJAWXmUvXXN68+tz9iW16ggYILxjPkgBsKJr9sVbMseahFTKxhG22fMK+bOt?=
 =?us-ascii?Q?wiX8/vpHmES8s2EvLGaLlPCqVGjbrL4WFN2XJUY4F70cJ3Oi9NDBboNz6czq?=
 =?us-ascii?Q?ToWmnFu54CoGF7ZMMx1inOf7K0b5OuPplFEi4fU8UU3i6D2l/dDpY87u3mL/?=
 =?us-ascii?Q?7WX9EZfaS2Kj6P3RZrOJmEyhNF2I/HJVqJw5by0sVZ53dXEhyCtupvIXnkHp?=
 =?us-ascii?Q?bmfHxC+4gvECQatLFdtsQHaOmadYq/TNeD9sJu88mMdamzLe8iImMMvLLCJZ?=
 =?us-ascii?Q?V67BTKH6wnUNY/cGG1/8hnCW8GmcUNLQwqb3t3sP7ngECsTGVKlPGuVKG0oY?=
 =?us-ascii?Q?2bFczsxzIYCoiAP8jH1U+bJW4FRBzRT7E9B7N9CmELVXyI5xJZoFAnE+Olxy?=
 =?us-ascii?Q?O/4KWpftRUI+1amZPePHCcngT7a8tpFKxZbXiXMrjkNKkf9wNjfrR16qSxm6?=
 =?us-ascii?Q?Bw/D9KzhhSpHo/uZA2zHbBhkhDCuKOFI2ByYCp0DhJeY7o30i3HaWt2JVECz?=
 =?us-ascii?Q?jVkNB5DT1pIFWAUUhp+qz2DDbbOfHsmba0Om0qbW+nCHV7asntL+PgzbJrEC?=
 =?us-ascii?Q?Ihn07KGgK//+YlFl/Gu6Au4pbdsQjE7mLZ0zCv680q4t3RA5u7f+x9tjQHu0?=
 =?us-ascii?Q?n26P9K+4k4jr/irAetfiC+KMMLasRFGC9VDJBM5puCspmiU535nTFnGSx3M9?=
 =?us-ascii?Q?c1M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iksbUjnpBd2X8aIB9NHFs8uHP+Y4UDdF529d/xTWCgT90lhFXPTPoTVcHJbY?=
 =?us-ascii?Q?67wX/MD7FkgP2ukeVRdgR+2o2kqomfr603esqYGq7ziy2ZG7k+wApBakvZFD?=
 =?us-ascii?Q?TiObC9ksTD6zdwwunmMEFMYdHjdDuBdn+hJ3MsDL2N28hqkW5AC1o8OfSI+F?=
 =?us-ascii?Q?lQkJCsGAWoBBm639rP2DPL/9oVEfNLWjQbUlrzFq2pYEBmdJLzy2T2aWq5jC?=
 =?us-ascii?Q?Bz/aS//0jlQzguu8fZtTZCWpNneLxJ2i8Aqb15ZvGzqi5GuphXU9A/OyFkFw?=
 =?us-ascii?Q?y9aXvTEV2g0Hpe9eS1dj2CoGSXLpFMNclScrj4ALbqjfPishrvkZBc8Hu2+h?=
 =?us-ascii?Q?eGtCj1cv2quh2LQ7oVdpQ4rCHH7jfswCL8xzxBP0oLHvU13ptJGuXTy3Hc4a?=
 =?us-ascii?Q?axz418iz67DgEHlXtja1YhHxDZovsqUAmYoBiZ1CtBf33lL9diplCDAd2lGc?=
 =?us-ascii?Q?zAetxh+aa+Ub+QAo6bVnMkN7o9Xt3ALKD21anxDSbwOlsd2kWIBYH4J1hQJM?=
 =?us-ascii?Q?PrSLiAKTx4QWTACyqKD8uYSW+av0S3JdKLYGW8/+3VzLqTzZJxt2zPsPbrkX?=
 =?us-ascii?Q?jScZf3Jj9DkVHYIEz+Vr+PS3Uhb88RaORFaGKuWzm9lQoALw2D/ZFqsGetT2?=
 =?us-ascii?Q?UAaNWNDdv3fzdROi52+zo+s7trXF3HyDaVwbIpNHTCtPZ6yI08Sxc+92gN79?=
 =?us-ascii?Q?GwAZGr3mh69COZYzv/er609+G0dA/BUDXvABKB4g0XB2VU8ZfQaFxQLJRCSH?=
 =?us-ascii?Q?7jbpyuK99bSXwVZ2Z5XVas6TiuA9GNePpmnaeYsHBLn3D3GmM8hTPQlrblam?=
 =?us-ascii?Q?4qlIxr/Mg7qcTVa/1zEVcbxURfctdWPmxj3MTZV176HtHLpNJnzCZN1ooxYk?=
 =?us-ascii?Q?zt4GyVhCE9wI3gYMS8HAwZg8ntZFH0qvqD0PifqJUj1l7lURoLLLZAkhLmz/?=
 =?us-ascii?Q?XKiZq1bwEGWxrpLsio2FtDtU5soP3Y7Wjy6wQdrPJBEsAlVe5RzbGcjh+NMC?=
 =?us-ascii?Q?EK0zNf6UVdIBiVHU2N/dUwi5Ugu1+PTUFNhnx5HPU36sP5hG5gxS49R9zgwq?=
 =?us-ascii?Q?gnwUDpllH09EsmMS1WId52UxQ0p+MdaCjHSRrS77zz7IxHuctiN7iApjsw/w?=
 =?us-ascii?Q?8fEejAk2VrjuUmLMZzLq91aK3Vh84Ilbm+4+vEOEjer9cSm1r3lvpjrv/q/k?=
 =?us-ascii?Q?qGc2y+BWPMte72xCk6r1p/3rzunXfK2gqOTR8saBMqJOSpYTNbqFt0CZmXwt?=
 =?us-ascii?Q?2ua/eZ9gA1Led3wT7YaOiRxqK38Wu+vNz+cT/RkOoCUJjsMhwktcSFcSBdF+?=
 =?us-ascii?Q?m/qGDaNWFivcq3NIQqUWGoCoWvEaDxdCOYG/vLbkiSbENItjN25vXArgG4gv?=
 =?us-ascii?Q?iE+hC5t7f4gyId4WumYUbNLVu4dFZAoZgOEq6apCwtIaRIP+v7l7NBdbdFc6?=
 =?us-ascii?Q?fO3VgTQnUaMQ8C4rrn0/YprS9VqO/WBcewYkFGWU55XlqADif+ZaP7oPYDBC?=
 =?us-ascii?Q?MTA3ENeOaEB6HY7Y2Vi0m6LxihPR3IvBkq5gEFWULQ4+mrmNPsVJZ6r/CYjg?=
 =?us-ascii?Q?EWrGamUp73rvXFWP5KZ9GjkJaq/IBI3MK3UYybtQ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d19ef495-4ccc-437d-9b2c-08dcce69bc23
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 11:47:50.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pY3GrIVrQtHti24RwCQalIMg76u61g+kQUeqntqvjjvA3PH+bbcw1atTd2XeppNlbvmxnxz2I9hfxeLnfKlPDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7091
X-OriginatorOrg: intel.com

Hi Andrian,

On Fri, Sep 06, 2024 at 10:45:46AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Feng,
> 
> > -	if (task_stack_end_corrupted(prev))
> > +	if (task_stack_end_corrupted(prev)) {
> > +		unsigned long *ptr = end_of_stack(prev);
> > +
> > +		/* Dump 16 ulong words around the corruption point */
> > +#ifdef CONFIG_STACK_GROWSUP
> > +		ptr -= 15;
> > +#endif
> > +		print_hex_dump(KERN_ERR, "Corrupted Stack: ",
> > +			DUMP_PREFIX_ADDRESS, 16, 1, ptr, 16 * sizeof(*ptr), 1);
> > +
> 
> I would recommend determining the buffer element size with sizeof(unsigned long) for
> better readability and using "true" instead of "1" to set the value of the ascii
> parameter to print_hex_dump(), see [1]. Otherwise looks good to me.

Thanks for the review! Yes, I can make that change.

> Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> 
> PS: Please CC me for a potential v3.

Sure.

Thanks,
Feng

> Thanks,
> Adrian
> 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/hexdump.c#n252
