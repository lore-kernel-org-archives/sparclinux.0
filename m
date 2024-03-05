Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72F21E874
	for <sparclinux@vger.kernel.org>; Tue,  5 Mar 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650275; cv=fail; b=u78C7+q4+OX4g32XmogfswjDIoyfoHxg29oMaIm0OBSSEPHh9Llh34W2Zt3j4RgPRhVMj2Ms8h3wvUEFFF7a4pEMzHSwVoFuVIC8qfuXuM2LEkHYlhbEMiQ1OZPhr3DMoPSZBIWsxGoseLqB/6CvGBrALB369TM/VtCu2K0ou5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650275; c=relaxed/simple;
	bh=AlT2pYpoQEJECbTtTtwGQ5rUmrzf5Plx9epuB0Kqhbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blGKpK8+JiXhbIwRl8QLfaVxa+QtgOJ5JnbT0KtzE8ltVk0jO1GppbOA6frR5RlapmrYA3N+Kbv8vzhoP+t3mIVS4WRFc5rFx0bfgL927JjZ2cqmXeK+9zBIdD+K5jJn6U3zMSJ23IJYMsVxPcm4/7HSZyu5oFyASn12D4sqQhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b1+ZiMo4; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b1+ZiMo4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709650273; x=1741186273;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AlT2pYpoQEJECbTtTtwGQ5rUmrzf5Plx9epuB0Kqhbs=;
  b=b1+ZiMo4cItfaEIhOymBedBpMD/vIa4DuSrzRu1JcDPao/eW64VNNH/P
   qBftFtGHK1RY9YaDWGxGIAiXNffdo/nNkbtwdoqY4+vyUPzvyzKPTj0YM
   DDjV7HVEKH0qCERAWPmky2u5ARPntpKlmukI/S1MNhY3SKNAPxFYKKr8G
   AwYiahUnGZH8Yjlc+yV2p0dF2BIyYwNWnsvz1dJYnVQ8/DhuKGi63Izva
   EVdyjk2YPSrRj7VND3QsX+T6NaJEAFUL79IULJtFySJUirDe1ATHeeQX7
   Nmj1cBmvsAYov5ICAgzsiCycCEU3E+2PORkdkAEAVucJplFATWPpw/IBe
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4064547"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4064547"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:51:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9456871"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 06:51:13 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:12 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 06:51:12 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcCGfSmiappmBqVaEK1211Ynaslrtz1WI8bLmAsve2DBF6vj6YJTteM1/Ixw67aKBlGdmtoIu8zCO8bzY3ria+1myUQtokhWSF00sem+ZsX45w7EBF1uyzFiYEYmf+ZDhlJTBCeswjJCZPZ4R6FYwEUZRcOnkD00ZgUUsUI3MRjRstBlYgjHbHgIH3K0GW33AqxhtR9pb1A4YwqoFbysO0dIqNb6nksEOrdkYY8MkpPQTY30XYsaHWzbNj5rFZEHlehE9xMTjpbSX6DCOlVtl3hVLTZbcHn8y33RRGg6BZ96od6vXtASC/hqSx6pgAscS/QrLLKQi0AYyJsVP89PQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AlT2pYpoQEJECbTtTtwGQ5rUmrzf5Plx9epuB0Kqhbs=;
 b=VCzABCyLXFyRMqqrT6CDsKqgCYEBNyrTvpFi3EV6hQZK6v888KZf5r4oSbrPepONbp3DZB8TwlL6QF/qq3SgNqWWgvZHN1f3XskqksNoW3CIzMzBIRKBaoqnR85R+OpQjv7WAGdXLqOpeJWbRis4ewfUlg8na809j7luSl5ufDgaHlYH0NsaywOX6vr7o9JPFPM8oFfleF4XdxhP/IqKo3zdzmGy3q73u6r/o/lgAx32V4nMpEE1Qj7zOIkqSoVm5wS3ross95V8fTERpIF98IJgG+fbubr37CNs/Qs6qXFWWBbVm/4kWfvdaRstYZXjw+U5juqF0tGVCCAUAqJs4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SN7PR11MB8112.namprd11.prod.outlook.com (2603:10b6:806:2ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Tue, 5 Mar
 2024 14:50:50 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:50:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org"
	<luto@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"npiggin@gmail.com" <npiggin@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "bp@alien8.de" <bp@alien8.de>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>, "x86@kernel.org"
	<x86@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC v2.1 07/12] powerpc: Use initializer for struct
 vm_unmapped_area_info
Thread-Topic: [RFC v2.1 07/12] powerpc: Use initializer for struct
 vm_unmapped_area_info
Thread-Index: AQHabDcI6aim2A+6H0Sqq0xL6Ioq6LEoVgEAgADqeQA=
Date: Tue, 5 Mar 2024 14:50:50 +0000
Message-ID: <677385430623d94cebb252e2a846ea4ae31a48ba.camel@intel.com>
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
	 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
	 <20240302001714.674091-7-rick.p.edgecombe@intel.com>
	 <87a5ndpklb.fsf@mail.lhotse>
In-Reply-To: <87a5ndpklb.fsf@mail.lhotse>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SN7PR11MB8112:EE_
x-ms-office365-filtering-correlation-id: 665191a4-1946-430a-0974-08dc3d23a672
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dcy2n53FC/JPJUBRtOI2DZWfUOnEYpUF2YwgX0ZN2vQzeP2jpYac0HNJjm+sk14804vrknMn4tlwualeLPVfcyWza47ccaTbC/hS+vclNvKYOWu6Vi5UDnC80a3PwjlqB+MgEeV2E2/k0ZWWs3nIjP80ypRQq3Xeugneu8Mbwu2WW8vFvbTrr9TOGx97mYNbKXBolzrehxpxoZ/hDEY92dz96iY8Bplrr6PclbkaAK4TDD5KGiXKivduf6CTeoQhlaWbH6aefaza4mt9lXOO2/91Dcbh4YafF2DOLLaBvqq8n/ILmy2VXgGY4Fhtyrkn8if13xV7yuo0f8AZcdiFsiiG6D0Bf0zFc6r//wvMXwKbxtQqRY8f7CZXSskBC/Ww4uGQ/FXI+kzmuntvDgatEaVFA2sckwi8GbH2uthGlzPhQT2FMCglhisSi9tAc7/9XBPsXD7DvuDxJVh0wxnJBf25mJxcY6kpEBMd/B/5NBpKUkZ+f8CUSwEERCwCHfpbkuL7n8OQ9NS9Z8St4otL6Db/5h2azGCAYqe+R8Qup9P3Pm0R6+yEoprKcYZEUpyN2nQLdACkCjuKItKoU+gJCMqFGGLHA3S6lxA8uubXHKM60MNtOEKsB3PM0FWmK2mjNzFOM0sdEUMDjDCmx8XoV/FmhqFSRqLWUmweJYKC+aQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFNXYit5Rm44QS9yZ0FNcGxFYzhEaG9Kc25IQXhCd0hINk1OZndjOFhmdmNJ?=
 =?utf-8?B?TE8rM2w3elg1aTcwV1kyd2pJcWZNL2lmTTk0ODYwRFo4RHFkVFI3MW1wUEpy?=
 =?utf-8?B?M2oyWEV1cmFQTnpYMWs4dG1haVhCdVd3Yi9zaXR0bFpJeFRYelhkWTlTdGt6?=
 =?utf-8?B?YmwyWmI0QlRYVmlnK3RQNEFVZ3F6ODFwc2lYSnNKajVaejBDczRDdkRaM2NL?=
 =?utf-8?B?VHZNWFNuNmdSNzBUblFkZ09pSi82WmhKTTZ4UmtsZmtLOVNwMUdXTXJTMldm?=
 =?utf-8?B?RlBscndmenQxVFZjQncyQi9qOGZsRHFGUlFrTjM1ZEZkWWVxWkQ5Ti9GbXNN?=
 =?utf-8?B?SW9qZGoweXJvREFIT1RqR1ZSOWJRRzEwaDZzUHVRSjFiZXdVOGUwNFo1T0dR?=
 =?utf-8?B?K284bDdyZE5jckV6UzZ4aTUrZkVIdWxRRG5RckZRTy9xZ3hjTDBXaXZPZkZ1?=
 =?utf-8?B?YXlpcXBuUFBRQ2pQNGQ0MmJZR2k4dlhPOVR1b2NFUDFOTDZHV2dONmJXSUc5?=
 =?utf-8?B?TTQ2NnBFNHBrQlpBOWNCcnRYb0JmUXlNdWlMVU8wdVZDKzR4Z2RuTUlPWk9p?=
 =?utf-8?B?Y3Z5c3lPNzN4TTVtRkJFMGhqbVRWdFdVY3lJMXlGVVErOS8yTGpDYnNVVlRn?=
 =?utf-8?B?eDlhcm9HZmRrQklFaTFjeWZXRlRiSkV2Y29FYlgxKzQ3bmE5TGZIeENTSXNq?=
 =?utf-8?B?WkE1T1I3aFFFaGJSVlFCOENHOGVZMVpWbjlyM0ZVQktYVXYzbDZ6QXRSQ2xt?=
 =?utf-8?B?OE9TRWhrTFVVY0tpV01EWU9FTGxjNHJUK2VaNVJrZ29UUzBwUytKK1B6Y2hs?=
 =?utf-8?B?cytIQ29vNmkra0Uwa0VvQVRIRTlLS1BrakNLYitkbEwyZFEybkY3TTFkK2R4?=
 =?utf-8?B?WjNHZk8xVWd2L0docjlldkVVWkYvaDk5VzlESFVGSEtROFZ6SlpEUTY5Tkpa?=
 =?utf-8?B?MHJjLzBUTGo2S2tLMzg4L1VrdGpzZ0tFOTlzREJRVGNSVlVHZExEZzNTOW44?=
 =?utf-8?B?WGVSM1RCUDZRQ1dnQmZMMVB1cHIweHBIUEgxbFhzaHRnMmNqRXlMbUFtZGFz?=
 =?utf-8?B?VUlHeXlqUEc2d0lVSWJ0K2VtY3BNSE9mUllqdjJTTU5meVZWWnpCNFQ1SDlP?=
 =?utf-8?B?ZGFOWmgzVUdJTU0yazBWVVJ3L09IVkNuTkxvRWxLc1IyQ0V6N05TcXVvUFdW?=
 =?utf-8?B?dTYwNXVyWm5ob1pFM2tONUtlZ0RRVkZ4cFIrNXZPQVIydTgrZUQvTHhwR1Vj?=
 =?utf-8?B?cHh4U2hUUmZyZWJaK3J2SEFCeGt4SXpqS3REQm95YXBWTXVqZjExN0hnRkEr?=
 =?utf-8?B?cEFKSVc5WXNVMDBaT2EvRDVrK050R2Y5dWdYUzNCNHBSK3ZHTnpYcktQanFV?=
 =?utf-8?B?V1VIbm1NZlRBR1puWjFiM0djNkwzWGF6b1JRMHJaZlN3RnhHYUw0WTczeTln?=
 =?utf-8?B?UDY5ZGkrelY3QUNUVVkwV1JibVZUZnZNQjhNTWc3K0d1cG12VXFSbmY3S2M5?=
 =?utf-8?B?QU1yVGJvNlZTNlowNUpISkFFQk0xRDE0dWZyRm5YblFpd0FuRDBaNkxKZHBk?=
 =?utf-8?B?ODhJS2QzY0s4TGxUbmlvS2NJcC9ralpjM2R1RGlTYXgrSDlMRkF0Sk5SbThx?=
 =?utf-8?B?UW9pZlB3aUV2Nk9SUVdGMUpJY1YxWlUxRmk1V3RxeVM1eVhCQ2cvcng1YVRG?=
 =?utf-8?B?anBMdytDWVNydEZSK01BVnFVb1AwSnB0N1E4MGF0SlJnZXYrM1JZblc4ZHQ2?=
 =?utf-8?B?ek9BZ29aZUlKWDdJdTd5d05Ya1JHOUdmcWZiU1hoa2JYUUdnVDAvdExSR3NY?=
 =?utf-8?B?Z1NFN05pOHFmU1p2emtxRzFBU0hTVktuWGtsYmNQbnpnQUp3eWpPTERsR2Ra?=
 =?utf-8?B?SGJUUUJhR210OFVsTSt5NVA3NDBwQTA1N1hxbnF4OHJOSW4xeWF4bFNkcnE0?=
 =?utf-8?B?K3pGT0JGSXdTRld0OXFRRFN4S1hEMkZwd0FRK213RzRUanA4RHB3TmNoRW16?=
 =?utf-8?B?ZW5iK3FJMVZyK25vRDdVMzdnY3p4MWE1MkF5Q29NQkdmeUJNNUJIMHA0YW5J?=
 =?utf-8?B?bVQ4RitnS3B2U2tiVm9YWE5CUFR6ZTVTQUpXT0ZaNDVnK2lvMDlGeUpHUDBY?=
 =?utf-8?B?SDZiSndidldLemE3SjRPbUhEaVlNUFdmQlkvK2pkcGpSb0J5QUVEZ2tYcW4w?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4827E1BD9BCAE042913A3C98A795921F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 665191a4-1946-430a-0974-08dc3d23a672
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 14:50:50.4892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IG2H06kEHKf5atyC15k/GXbZ0aKGzOEQKBZK1wXCydGt5b4hXb2lgFXEl3fnFesva/3Zwg1tBkGyfL3ywu3RGDupURa6K6W7EI1gJ44FmkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8112
X-OriginatorOrg: intel.com

T24gVHVlLCAyMDI0LTAzLTA1IGF0IDExOjUxICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiBJIGdhdmUgaXQgYSBxdWljayBib290IHRlc3QsIGFsbCBnb29kLg0KPiANCj4gQWNrZWQt
Ynk6IE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4gKHBvd2VycGMpDQoNClRo
YW5rcyEgQ2hyaXN0b3BoZSB3YXMgYWR2b2NhdGluZyBmb3Igc2xpZ2h0IHNwaW4gb24gdGhpcyAo
bm90IGRvaW5nDQp0aGUgbWVtYmVyIGluaXRpYWxpemluZyBpbiB0aGUgZGVjbGFyYXRpb24sIGJ1
dCBkcm9wcGluZyB0aGUNCmFzc2lnbm1lbnRzIHRoYXQgc2V0IDApOg0KaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGttbC9lYzNlMzc3YS1jMGEwLTRkZDMtOWNiOS05NjUxN2U1NGQxN2VAY3Nncm91
cC5ldS8NCg0KSSdsbCBsZWF2ZSBpdCBhcyB0ZXN0ZWQgaGVyZSwgdW5sZXNzIEkgaGVhciBvdGhl
cndpc2UuDQo=
