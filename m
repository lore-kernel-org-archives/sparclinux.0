Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC14A15;
	Wed,  4 Sep 2024 03:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725418856; cv=fail; b=dXSwg12b1OQDdDqjoQPI4mVCMbG+6k8vc6klK8fys9NNNx3Yx2/X5FLEcHDDaZuo4ii+/1FzvFza9WM3bQlvOUilCuBAMdtX9E0ssnHhhFVZ0nk6iiu8aZB6qxhz26hLatsZFVAhQrhmOshtkydq8+5uRYJN/xhaassxGjJZnR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725418856; c=relaxed/simple;
	bh=0t463QiiQFA1KPg1C3xlVcsP4TK+VMPae24eif9Mylc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MkVHxXJrG16PORR4UlLuEB7vOznq8rtoAubPFtRd2Gas5CpFez6qoWQX+BgnXDwUrxMLr5J9qgoL2UfcihT0iqbLAmxIGFSbQ7AziUy3YAcWWQ5zSmdxnF9/jIy7B7gynpLwcObwIoBPBdAXCEV+D0T/hc6UwFR0CU+KN+BXNu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ni57yqwa; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ni57yqwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725418855; x=1756954855;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0t463QiiQFA1KPg1C3xlVcsP4TK+VMPae24eif9Mylc=;
  b=Ni57yqwa0Wg3pPKNtj7WH6n34JjfjjYtALKHfsH6ySobepELbI8aB8Pe
   1Cx9CyiYmABdDSDwlOw6dtcTRj5BYfgXkO/6JzYF0kGSy1YxWW9h+Vqyx
   4umhaeM1BkBCLmD6nvtI6Bx6m77buR7Xjg98IgCVrwOI75OMxjJacUsaj
   +EObhokuxwVSzOn11tFLD678JMVKQOdVYnhAhCNINfbeDI7Ku87/3eGdf
   yb10jYDiox9pJ2XZh2UrMqti0/73qJJXDkqilJedKVeN01nmjGAbPdQe3
   O6hj66jCGqhElUsOccPskqwnUFxLh71feEFsRHRAlVXXkqmL3u6vX+oIl
   A==;
X-CSE-ConnectionGUID: ic/9oPgzQE6G/CrtcF2A1A==
X-CSE-MsgGUID: n3aM3Ei3THeTLRvweX5Dzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34620650"
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="34620650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 20:00:01 -0700
X-CSE-ConnectionGUID: oZQLWqXjQzSz7d/EUDQleQ==
X-CSE-MsgGUID: Wb7WxS0+T+GNyfluCem/Yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,200,1719903600"; 
   d="scan'208";a="64932162"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Sep 2024 20:00:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 20:00:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 3 Sep 2024 19:59:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 3 Sep 2024 19:59:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 3 Sep 2024 19:59:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFp/KyTT+6JzrXxAuqFD3/EaPeN7TCg75XM2osM6voG0iZFEildWnmKcq/0R9H/vYKlXIylTp/CKjxX/dc3N9hlC8SzM1b+3iFT/ufRB6A0gS/pPDgyvGPMK79o8H/w05yNi+b7pmlqKBExiEEOOCsHYeB5q77KruR6zkt9NFYmi1xyKoEtN/u95bxaaf+KlGYF4TcGBX0z/tGriM5qU9TzN/kANhhoma0BI1ohcIzwbk456p1RVUuxwrekSJ4UqOZmH5ijJ6vLXXAzdxpXRFR/WZuQOCcZjLsXfZTHz/c7lSL+V4vXRyBGnswDJ0dW4MkG6cFUgEm1ccPSZCzvxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqClLdAEClnUjlQVp0jRCqRy0LhTHfHK0zismCTWM+o=;
 b=A1qkgP9HurKYAiMXT+nNnTDMWVOhO7TPO76sg30jU1oLXhjXPfOZo8x/qgOgi5r/IyGbT6R378HE00tRh2dXYiDhkeSd8fhYf5UyZniR+2R7TgBSHT6UhABQXUBB3dJcGjIJ0ZOW0Tl6ojqCcJ+eoPhznZaKQJ0h1/Mi53a3H02t8YFOE9tQENruwQIOFbLOqcOzLAM3nQOESHiD/2U2aV1rwo/fUt4gIusrf+NkAgp/jQbTKKkJcQkFV9zDxnQWPwlq12TKd5y4kAjIDtp3yAYey/gKVnYpPW0mQUXALOi2j3a/b+iSB/LkMguJdlywOkk8vHxEKDh3W9y6ucW6fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW3PR11MB4761.namprd11.prod.outlook.com (2603:10b6:303:53::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 02:59:57 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::7f88:f3b1:22ec:f508%6]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 02:59:57 +0000
Date: Wed, 4 Sep 2024 10:59:44 +0800
From: Feng Tang <feng.tang@intel.com>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	<peterz@infradead.org>, <mingo@redhat.com>
CC: <akpm@linux-foundation.org>, <bristot@redhat.com>, <bsegall@google.com>,
	<dietmar.eggemann@arm.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vbabka@suse.cz>,
	<vincent.guittot@linaro.org>, <vschneid@redhat.com>,
	<sparclinux@vger.kernel.org>
Subject: Re: sched/debug: Dump end of stack when detected corrupted
Message-ID: <ZtfNINc0hAJUtNRc@feng-clx.sh.intel.com>
References: <20231219032254.96685-1-feng.tang@intel.com>
 <20240903163355.3187-1-glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240903163355.3187-1-glaubitz@physik.fu-berlin.de>
X-ClientProxiedBy: SG2PR02CA0065.apcprd02.prod.outlook.com
 (2603:1096:4:54::29) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6304:EE_|MW3PR11MB4761:EE_
X-MS-Office365-Filtering-Correlation-Id: df1b482d-4037-49a9-c4cf-08dccc8da873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4QP0GQqGipGhIuoLe92bSHzXSS6yrs9HR4631H8UJk2kdlq/7XPyEUVvTzPW?=
 =?us-ascii?Q?Wx3uR965UuGAhPUrZwLyOqaFV7hg69kbl/K56UwIeDpiHOaP7g7FSfTwxbO/?=
 =?us-ascii?Q?gPE8ybgLUhTGEvGs1zup+Z6u2HSRmJKmBrLWZ3tK9d806yUuKKT98joYv/6C?=
 =?us-ascii?Q?PfDBff//PyWX83tjuvSMRbI4JZAgsQnkDhEGVdKN/UXv6v90SIqp69Uf//nd?=
 =?us-ascii?Q?jMMhL9ZOf1TgYem77ktEP2vwSwthh1dkEvy25p28pfZSGJYGfNSjDKbj3Uhl?=
 =?us-ascii?Q?g5fvJ7ZeF+Or6T10+XeHRXhov/KI9FJ+pm0sWN0CI6Pyk3lJjVzBou+WCOSt?=
 =?us-ascii?Q?NbQ2F6ul8JG1VMxop8bcK3yW0WNJSvlvyura5iqVGuOzPW0pPr9Pn/a/RYGH?=
 =?us-ascii?Q?B61lfz4worye8Bg70wiHqyNPSInw69GZsC21KteAhsWKMqJbvU7F3jslZ/jI?=
 =?us-ascii?Q?dELyTeqqXYDbPGwh7nu0Oi0gq/KPoyetcaovq8dGXe5OhYliEaHCVK8M5+kR?=
 =?us-ascii?Q?W6KHW18fZxUXG5ng/MRWHabxMqmAAxU3LErvIM/xxeDTrN+ch6d0a2JNBDdb?=
 =?us-ascii?Q?neHGjM9FwU509SQ4+2OOSMrk+A6BXxTCXLJ4P2AqkYoTvYm1pDdP0B3Z2EMU?=
 =?us-ascii?Q?5S1z1Ua8Pwb4b+vGE+fJ7SfFQh8XrzNgzv2Ak35KNXOf/0jtuWKaO0ouPZhL?=
 =?us-ascii?Q?nBJ2SsM+ycjyGnlme31k3l7f9kCmYHdfQj1GTRsjOsu/WUkKqCIiYOgLhybd?=
 =?us-ascii?Q?LXY35MiGY7PUnuuMBtbtdL89Ol+lfgwPHhOplpg9uc4ZNjCHn2s1DRSD+xXH?=
 =?us-ascii?Q?oHnmtTZ3oUt52VOB8tMCVWIUqM5Ba8g5pUlQXKMm+CACJc/vMxKRxdAGYlVi?=
 =?us-ascii?Q?MJB8BfyqMtjeAvyRy/IHi+mT8wZnMzDFHCEqd5HDzcZeb61CNgMZiCCsn5Cl?=
 =?us-ascii?Q?fHzyDm8KUyv21hba6MI5PDYf599/s92X4e/NgRSMpfhmBYxpxJaZY6XH2CJy?=
 =?us-ascii?Q?rcA48zsERu6kIAlEGu0AdpnAMAuKzYalpxF//8MO/W5vT8GiXyyKr3efApwm?=
 =?us-ascii?Q?PxbD7l8kZ8ZKFJQ4i6y22JEcGuHwWmTiw8G2YN+L1r1sjnWD6Fqxezwo1Vuc?=
 =?us-ascii?Q?1qI6exedqgm+L2cpAE8NibEyMLRstIy8CNic6nwhu0V26XR5VyO0tR81ADLT?=
 =?us-ascii?Q?NoWgWZUNWbFfyhuanOclHFRpydX4Ove58t/qPC/MXpdBhbZjJ+fS4du46wy4?=
 =?us-ascii?Q?ur3Hr7cN+nfYI98Eg+umjxnJqHQUp400CDkuWX12zsOr4krffa7bmNB00yE2?=
 =?us-ascii?Q?W6PCms5SZpweb9YZ5l9DsTfDo9NeovQPg8JG9+pVgiQR4SF6ZzPx75JGqzfX?=
 =?us-ascii?Q?bKiGVFQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0u7gw/P3GGWBKAi7QKXoGvoYr/A8Yb30tSl9RSJxx0s6gSoleED/GQf1NK6?=
 =?us-ascii?Q?1U0YAOYg+rQXErg2j+ulK2n5Qhy+er6XH34X8M3cqNOGxWgLv2AzJf/k8dmI?=
 =?us-ascii?Q?IfyMsYnPwm8pWFIHwiLZQx2CSq9qY+5/4F4XeVftK7p9TO8suSA4vErxoPq6?=
 =?us-ascii?Q?5Hx1lnVPOs5Akkyf43l3Wj9iOR0f+kA8wd312ReuYYtMtvs70n1NfI8M5vdV?=
 =?us-ascii?Q?v0ewcZdlDzj1pCfauOBP8rFORyPH3Sl2XyGWOYtQXYmL5fsH3/CNLwOVyr5j?=
 =?us-ascii?Q?fM1gbJmB+DavlX8VA3mXGJl1LKhR+j3a25DstdjfePmsuFXv4T7fbOTybSmS?=
 =?us-ascii?Q?c36eX0I16VvZatPO13HNapgwpWhNMBS+PvC8EDUCWGTYcPv3cqNbIzafjKfH?=
 =?us-ascii?Q?k7QNLBeBO19M+ey3NJ60luI1eieZOyX1R7At8EdvCUAAKDjWiWrg7xBVgtYr?=
 =?us-ascii?Q?2uy8V37iFrEhh5QwBKP8y68EU27feHg8ZzOrXaprQI4Bnzih/Mwto9wxf72J?=
 =?us-ascii?Q?nGIEuiuVre8IpWiUQa/2Kqz9t8oOPdLMsDN8Fh71Do3BY7XEOXyyIu11j+TL?=
 =?us-ascii?Q?3HjezpeVXqxzMpOZjvkXZ0Tr4t9HpVBLw2Onr/xiFObH7zzoZ2ItQ+/SftbC?=
 =?us-ascii?Q?BJ0j8+7m+kVK4+lCyF1nCy44BEkSewr8z918UM9u6EpmgQ6Yfy5ofQvUIK5M?=
 =?us-ascii?Q?jdiD7JJje/RrN0WMrqQvt8wftxvmXayIAb7w5SWzMQslWMoLUFYaU8DfRd0Y?=
 =?us-ascii?Q?wYvsFzuhSTJw3IO2gRFHOWt7h1I8gXu+eU060i+3tDZybews5qsc0ePFlh8G?=
 =?us-ascii?Q?Ro36MhG5zbQmS13NH+Xm9K/W9fF0y4gwGMPCOKgxbQYMVMfUq6bI0yqwqgby?=
 =?us-ascii?Q?zcvhnoi65VBB7k3QbSl20JU51h9TcGadncCumgxXQuKmNfpRghwUNPKOmdV8?=
 =?us-ascii?Q?cCIj+xZBYV/daYv18RG85kCF7GE7eVsWwMmuoMnxq6JeQJG93tiQb3NjoFHA?=
 =?us-ascii?Q?cU1qZTLzkDFONLE5I0cjtSRuuGeyhG6uxmtI6jF+TF/B7AZWPaA12EBpp1R4?=
 =?us-ascii?Q?5yl9vpsvA2tgDhzZOq8jyep8kw1aXTMtOmnqJfMTYfS1GQ0AtXZqEPLkuoFk?=
 =?us-ascii?Q?luvSrtHYGk2FV3nUqVmgCJ2h+QV1f6XO8xiovcyF4iTQxvsU+7iF7GlpRCrW?=
 =?us-ascii?Q?z/Y1hIP8Dc6WEiD2Sv+bM771JaVXgYZ/iNG9/n3OKn8XDJ7fjwlunQbcDhSH?=
 =?us-ascii?Q?ObfTsst6aXWcVv8Aem6jeIPeNRUS9hCcJYR3c6dczF0AXsGGwldVm2dmZdTz?=
 =?us-ascii?Q?RMHRhfswN9dt/QtXWqVssxU3MntDBNi7pM/NeJqOs8ql9FSu+pbah5ojWyNh?=
 =?us-ascii?Q?I0ZRGLePRN5puDixenjEf5lBoGiKk+qBDTFBimcHzELCFNJAQjAJkcgFjeSs?=
 =?us-ascii?Q?puhfH2IRaUQywf8vd6CnFW3WTj/CB9E4js06gTjw/EoPLPBcZq9Lua+sO8Nc?=
 =?us-ascii?Q?rbs3/eSa8yxypbc2e7xjpBdgxCHh8tTqljc/XlDoUdSQ9Atxk3Q+QzeNdWq7?=
 =?us-ascii?Q?ybY/yed+lwef6IzQzPB7eAGzZ+2nZPgmJVvq7IxZ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df1b482d-4037-49a9-c4cf-08dccc8da873
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 02:59:57.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tx50weQlxSRnrdAoeQwrQYTfJphQT4CZ691oyErD4qnTZwspLeIba95h11Ctrfhf8pYT5WRGwx1a3byeyIaxvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4761
X-OriginatorOrg: intel.com

Hi Adrian, 

On Tue, Sep 03, 2024 at 06:33:55PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Feng,
> 
> > When debugging a kernel hang during suspend/resume, there are random
> > memory corruptions in different places like being detected by scheduler
> > with error message:
> > 
> >   "Kernel panic - not syncing: corrupted stack end detected inside scheduler"
> > 
> > Dump the corrupted memory around the stack end will give more direct
> > hints about how the memory is corrupted:
> > 
> >  "
> >  Corrupted Stack: ff11000122770000: ff ff ff ff ff ff 14 91 82 3b 78 e8 08 00 45 00  .........;x...E.
> >  Corrupted Stack: ff11000122770010: 00 1d 2a ff 40 00 40 11 98 c8 0a ef 30 2c 0a ef  ..*.@.@.....0,..
> >  Corrupted Stack: ff11000122770020: 30 ff a2 00 22 3d 00 09 9a 95 2a 00 00 00 00 00  0..."=....*.....
> >  ...
> >  Kernel panic - not syncing: corrupted stack end detected inside scheduler
> >  "
> > 
> > And with it, the culprit was quickly identified to be an ethernet
> > driver with its DMA operations.
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  kernel/sched/core.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a795e030678c..1280f7012bc5 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -5949,8 +5949,18 @@ static noinline void __schedule_bug(struct task_struct *prev)
> >  static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >  {
> >  #ifdef CONFIG_SCHED_STACK_END_CHECK
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
> >  		panic("corrupted stack end detected inside scheduler\n");
> > +	}
> >  
> >  	if (task_scs_end_corrupted(prev))
> >  		panic("corrupted shadow stack detected inside scheduler\n");
> 
> Have you gotten any feedback on this? Would be nice to get this merged as we're
> seeing crashes due to stack corruption on sparc from time to time and having the
> end of the stack dumped in such cases would make debugging here a bit easier.

Thanks for the review and providing feedback! So far I haven't got response
from maintainers yet.

Hi Peter and maintainers,

Could you help to review this patch which can help debugging those naughty
memory corruption issues? Thanks!

There is a v2 version which can be applied to latest linux-next branch:
https://lore.kernel.org/lkml/20240207143523.438816-1-feng.tang@intel.com/

- Feng
