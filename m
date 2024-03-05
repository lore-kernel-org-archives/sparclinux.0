Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06241E874;
	Tue,  5 Mar 2024 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650311; cv=fail; b=JJVB8IqY4ioyqV66ZGOwYEn4xxNmXhcGLo5a+qw/aA14E2mF4CzZO37hIGVRa5ZC1r0fN6T8xEldXD4Jx2BvTuhwWVFv90iTKk88tQgj1YI5TP97EglDZud6zwOusQuwsjx5heFS6ZBooahT6xj6412WemEN1S2GP56LiX/vMXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650311; c=relaxed/simple;
	bh=Q0dFZY2C5pXQw8wFieESuDM5Jl6tHjLthU6kn2oVtJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X8vSqJiu1sQj4Zt+t8rqWccdeVWOqWOnjESvsjc3zB3ScjNTLkqwvONEbEjfPmpiZuNST+nqOyeCu1EjCTBzSMUr3RYZITg9DSpQlfYEp/dJCT+StKsNBZQLBZ6wOb8Jxm+IrzO+Nb4Z0kwwyID8H9939SupcRpBUmnH5mDX/Ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3MU6hn3; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3MU6hn3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709650309; x=1741186309;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q0dFZY2C5pXQw8wFieESuDM5Jl6tHjLthU6kn2oVtJ0=;
  b=L3MU6hn3f9p++qeqGaUev+EXd/2TKcxYZOx+wOtz0Lr/Ah+0lR9eGIpB
   RjBPRb55+n4kntKDugnYaTQBU/3Sed98oY9/bbIMzfrVeB/xsu7FZraY0
   iZHn7xqxoBLd1n/HCuCuFLE8t5FRx7jZirDLcbpQdt08Ol9iMNOQ9dKRU
   VyhpyR+pfM7HxlifnZLlF09r1WFIhXhEBkOEMcHOsPTYaI9A2m3AT6aQp
   ZXsV4DQkB7mgEJ0C/v3AFHYXXPNlO83PI4TI25I+03yfLrTauxlY5eAU+
   tyDqDCkHvS/6EDd0lyEoKZXHDGfRksFDPzbZkptYlWpj2t7DCZJpNpe/M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4064654"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4064654"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:51:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9456968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 06:51:48 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:47 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 06:51:38 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joPVH7Qlt8UCYhYM/hbuy2rv34G12Pfcfqbs3mbzDiP7jP7Tvz4djFLadMzeAXapD7JQrPUZJ5b7ZOlPinPhPLYXLtcb/ItqNVEXJKQM6AN7MSzM53d+TWWMvAoZ2GAoipnZdo1mfEqMBQ5PIIVi3sEc/M93ci9JQ1k1cxDGDRnJuEPgxjjrcN3raJcQ9ZYEQozzu0gA+Xh+9zkYRwxhFMOKjuKk8Xl8KTYsFwEkHC+NZsGfdi7tmh9X2IQhvFqPVekNITgcCTYcicfUKvJwn/+NVsv//e+qs00UIcqM8BWd34DihYF0Gf5PjUpk9vsIU5Q4iEZ8RtPnrP+pe7ckMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0dFZY2C5pXQw8wFieESuDM5Jl6tHjLthU6kn2oVtJ0=;
 b=RganegaG3qDADpSqyKUYWQLrspXwKmR0rWBdAUENdACtqWv78ZXfHz3jWsVYY/f5eCO+i2I6AGGDGx9bTs6W1k/8fVSHFxeb38Ysq6s/Jy8i3/S76PF57bGjzTd+E55brILrQX8qho1RvBb7fM01ocPs6DuSnRJTwsQDDX6QosCLDoIW8bvu+w0mVNQrM91WIM5Ry1IrVgdnzu9yELukFyb7/vMEXn0OvgBec0yW+Rh67q7N33PUFNiJJqMpwoNWhtg+7YFsiZ+ihQdjt5ojzP/bihm4kFwHi4Oh6TSw/f/ZwxTnEaexRtOmA1y7ilUQv6SAHzocZvoqoPkTk+0yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 14:51:03 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:51:03 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "guoren@kernel.org" <guoren@kernel.org>
CC: "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org"
	<luto@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC v2.1 03/12] csky: Use initializer for struct
 vm_unmapped_area_info
Thread-Topic: [RFC v2.1 03/12] csky: Use initializer for struct
 vm_unmapped_area_info
Thread-Index: AQHabDcEfBDrw0l2OEiC+cGApO2TFbElV9gAgAPozwA=
Date: Tue, 5 Mar 2024 14:51:02 +0000
Message-ID: <5bf60a9709a8b20853bb2fc0df32e58f6be79467.camel@intel.com>
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
	 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
	 <20240302001714.674091-3-rick.p.edgecombe@intel.com>
	 <CAJF2gTTjfW4DG8WaVrVopxQsak6X9YPnUXG3a-XWs2C=-vjxxg@mail.gmail.com>
In-Reply-To: <CAJF2gTTjfW4DG8WaVrVopxQsak6X9YPnUXG3a-XWs2C=-vjxxg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB8112:EE_
x-ms-office365-filtering-correlation-id: 4ab9ca09-5c6a-4606-4368-08dc3d23ade5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bCf3fNy8MvJx8L8Lg9FjIMPsCqxGgJd8BXAq4xg36RPcjMyVc3EAE9w1sG66sPH9a/jX1h0IxlzYsGgfopJxlBlFKdgv/VT4RM+Gb1jRGMSL79jxwSVL/1Saom4B9cNHyJ+COs1i5IiG3tHiCJRl2y7QR+DMPjZcuPG3j7ZIlfPnwZW9agbY8/eoK/u2u0Wtig1+Uu5uuLfixCz+UJmgAuvK84485ZpPJBQFpb7LzR8ZuiC3bbp4LOo31YHUSbSwQoMDPVStkDinPixGT6JlfVyuXe4HTJ9ZxcjSISY3ZuJc0miUeD0Sjf8Eb4pKb9/rc0mxO9MTmGuoqi4pE+fMjrRGiP/ZIz9dmzKTucJY9PSefOoa+TU6pnjv77/tX0wwYC7n6uU+am++HYqeup5rsJE+nLlNsAV+xndyHbOzFxlOrBrUKo0nd29qOOAv2SpSRAVLdL8vVOGoJMfp6zogN6DrNHhUrGGsAPRAszedCGl6IeK1aN9fKirA753WTQnJNwD2A50qdAzg8UiF+iItUK6+RQoq8IA9YnT126nmDyzkb9Kx4P7i9TJcCEHUssmn4j5UXQMs0n0zD2WAc04iVy/Rss8m9PoKE8KgOrnrgKHHnpoeJTgMhZ1vVNLNm3Lzi+GeG3GUXYGkVWieGDsOakR1JjakbLybFPWeNfuLBj60eR3KYSoZZ9AomxjJetZzb9vqcFh9cruYYQqI5QhIVpGqzs9RT7gUzl7XQjOvVv8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkJMQUlSUXV1NVF6cys3b2k5em1PZXBydGZabDBDN2Fnb0ZzM2M1YjUzaDRG?=
 =?utf-8?B?cEpHZDA0aWF4WEQwNGhmR3dlL2tnSExyWk01VTl4a1N4eHlyZ2N2OUxLTW5F?=
 =?utf-8?B?RGpDdUVJZ3c0VDBTNnMvYkN6N0J5Q3F6YjFqMUNZVExFd2pFeXUrTjJ5Vm1G?=
 =?utf-8?B?dTIwekdnRnFtY0RHdjNSU0ZIRnJRSGllUXovS1ZSZXpvaVZuektqS2lCczR5?=
 =?utf-8?B?OFRaVjY3N2Q4MmEyaXVqUGJqVEhaTmlxeE9BR2hHS3UvYWVraUt2YmYwUjA2?=
 =?utf-8?B?d01TRCswQzJONU01VFo0RWhTOWpoaDExWHNYdG95TC9OYTJvV1g0L0NaaFlZ?=
 =?utf-8?B?TnpDclFIT25JUmRwYndIM3RRT2NUMVhvWXhCd0FyNGg2NGlDalFmcUhNWWFK?=
 =?utf-8?B?QkhscmJXUnhCbXMxbFJKMTQ3N2hOeUFiQ0dialpnR1doczhhenlua0xyRW1p?=
 =?utf-8?B?LzBxcEVQeVBqRllHU1oySGtqcUxWbm1pNW5scTllZ2IvOXR5RlJwMm1KMWpi?=
 =?utf-8?B?ekdpK0U3WHQ4dnZSODRkM2NmTUFjU0RnSkh6dlFaRm5nbStTRE0wc29UY0FL?=
 =?utf-8?B?dXpoaVJqZjRBcnRLNXBxMnN2ZFNNUlJkaTJiWWFLeW85SHZJNlBxRXpMbFll?=
 =?utf-8?B?dWdVVnZvaUZVRkJ3V1o3aUhBd01wRnA3K1JPTThEQjNpNXBHUXU5MWVCamxB?=
 =?utf-8?B?dzh2cEw5dTY1azNyTnFzblJpR3I0dnNySkErc04wU1BOYm9MLy83YmtsUHl5?=
 =?utf-8?B?NmsrbmZsTHE2Yzlndmx6bldpQVMvcVJGcE5HVWdkZGxnbi92Vlozcm1YRnVj?=
 =?utf-8?B?a3BQMytHemFPVlJJZFlmSUFhOS9jekpMengwQWdFaGhSL3BhZDNMRmdyQXdF?=
 =?utf-8?B?L1VLVzhoVmxublBVaGJHdzNEVWZVd3JEMWgvcUgvNC9pMXNmODlrMXRRYnJ5?=
 =?utf-8?B?VWtNaFV3SVFFRkcvNUxDYXp2RWxlNEx4bXNXRHJoTDJkN2VDZVNvaUhKYVMy?=
 =?utf-8?B?elpIdXh6Yy9WZTBoeHFMaWw4U0VuZXZab0swWjMvU1pnZWNQdmhsSkJqVHN2?=
 =?utf-8?B?SUVLbXBKSWZBUGVtNEVkSlN0dVowZzJ5UXl6Mk16NWNNSldaTDJaU1VvVHI4?=
 =?utf-8?B?bys2elhPUTM3T3ZzT2g4NXFYRi9tTWxENFRmZWVHTFMvOTBiSytHWitOV0s3?=
 =?utf-8?B?QWMwRXA5OWVMSnkwRnNFcC9hcklCSVVDMVplU2NqVDlkZXNOc2FFcTJ0QnBh?=
 =?utf-8?B?cy9tS1JBZFVFMURMTDdySEU5UTdhOUNJUFdlQjRBbkowSmdXN0tZam5uV01F?=
 =?utf-8?B?dUlnYkphQnYyRnRiMnl0cXMxOVNHMUFOL1RjenhucU4xSGZPeVUxTi9udzJs?=
 =?utf-8?B?MmVCQzFDUXhWQXJ2OENYSEwzYXAzWDdEckRlMDZKYk02eElYUUZwZVduL1JS?=
 =?utf-8?B?SURremZVMXhaV1VvdHI5SWFpNVhVUmhVYUJOLyt3T1ZrYUZWRFVKdGRseTBE?=
 =?utf-8?B?eFNXRS9CY2ZGeElSZnU4N0EweTBhSjFha2hpcFcrSHFlSVkwQ05vUlFtWWMy?=
 =?utf-8?B?Z1hwTk9NQVdGOFhLc3lBWGh3SFg2OVp6NWxMUkxUNFc1OW9yMGY1K0MzV0hs?=
 =?utf-8?B?TWkwa09JbFAySm1ETWl0RC8xaGtkTkRYM2NFUG9udHNnN29wWkZJakNsMTNP?=
 =?utf-8?B?L0hiN091c3B1TGpyb1g4U2hlZGJwR2pCY0lEN3FVVzF3aUQzMkhNZnp3cFdm?=
 =?utf-8?B?MFBabmozQ3pDWkNNeHp6VC9XVmRwaUh1dWlqbVEvR3dNSEtCNGVHTytlWm5O?=
 =?utf-8?B?UVl6RVRnRUJwakJZS2hrWmlkOGY0K096RW13REs0Y3pzcG9NTWdBQTUvVGlG?=
 =?utf-8?B?OWZpNHNiZlBWaDhoVlpOVnFSOC9yeXJGMFZ5MHNpMTF6bi9PdjJ0MTJYM2cx?=
 =?utf-8?B?QWRsYWhYcnE4Q2NEY3dzUWM0dy9MK0VWOC8zQzQ5RlFRS1JWRXpiMldlRWFT?=
 =?utf-8?B?T3Fwa0hyUlh4ajRmTTA0cnIxKzQxQWw3NEpDY2hqN3dabFRPU2piOW1zOElB?=
 =?utf-8?B?VE5mWjBWTkVHNXJvM0VjSUl1ZFpZd3o2SDREY0dKNGpnT0RQWWZmZEVrZ1dQ?=
 =?utf-8?B?c3lwZU51ZE9DT21qdUpnc0RWNmNQQi9teGV4TWtXWmZXVEF6SUNaT3d3bXE4?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD8ABC40F86A44183281EA42A4EEAEE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab9ca09-5c6a-4606-4368-08dc3d23ade5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 14:51:02.9978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: krUO13HGQUHjScUuCgZrwAeB+W3+5WoVnHUKpJP+4dbLO//GrReMfNclaj4DtPPzh+13Qav3cbFTBKHMBxz+7n60i3VWgCkW5r+3BikqwuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

T24gU3VuLCAyMDI0LTAzLTAzIGF0IDExOjA5ICswODAwLCBHdW8gUmVuIHdyb3RlOg0KPiBMR1RN
LCB0aGF0J3MgZXF1aXZhbGVudC4NCj4gDQo+IFJldmlld2VkLWJ5OiBHdW8gUmVuIDxndW9yZW5A
a2VybmVsLm9yZz4NCg0KVGhhbmtzIQ0K
