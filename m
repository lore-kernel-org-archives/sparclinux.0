Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B985928;
	Tue,  5 Mar 2024 14:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709650267; cv=fail; b=CoPqKnUEQZCk7Kv7NKR3GhxMlj0jwnG3BatvhlXXfh4EgtMza4E3esYLY+J1SsIvqTce79b9v7dmIRtO2zmvDaNspkXjFc+S0zuycWk5btEgvEPbLuXNsqUCRPKOhD92F0AG35X+VTzk4Srdy5n3m/c1aXqPOvr1yg1C/+hv/Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709650267; c=relaxed/simple;
	bh=h+9cBE04FTeMQFUwC+nkso8JIxQVtpSB3UI1Y4bGCrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NCTvdSTKjr2XvLfuVDzpf6pECfgu+7k/C7UO4ZKX/xjdE3o9gbU3XhHmS7nwm8f8FY8eibL146ywarXicLh6E4IvEABA256U+z/NNJtYvom/HQ7rvUhItD8/ZaR4wOzEur93SpYQX82c+ypQu6+8XmFaKkGBpnQKbvmNGVeyjSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YML4ymLG; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YML4ymLG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709650265; x=1741186265;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h+9cBE04FTeMQFUwC+nkso8JIxQVtpSB3UI1Y4bGCrI=;
  b=YML4ymLGECFBsw1NhDwQYx2yINPtM08g+7t+wTsHM2FVqVPOSdjjjqIJ
   b6TXW4NdEZQdmkaB/mgLKHAq0ZNDDdDLveXTHFECmOdvZABtQTkT/1nwm
   GF+0GB8Dc233iHcveY3h+xW6EfWYs/8/n4C5rnmtVG7qeVQnzwN+q4MxF
   d8W7Mt1z8z9+NPdWL2SvaR2McS5xb3U4UEj8rT6zSJNaJi21is3oUi0EW
   M+qW2pHQIbdgxqk58ZoXl7ht05YdLJyvPix0DCOiDTBZN4QSVaxYKaYJT
   LCdG6RXEfDltawbwWX/5N/HXwHXTRX+u95zGVio5Xfz4f5xm3MDgl4+xR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4130674"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4130674"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 06:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="14066118"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 06:51:05 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:04 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 06:51:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 06:51:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeRWsZpLJ9RgNtd1oRN28DYYlIdoKSjrjb324fYmcwf/O/cgXHuqLLq65ppn6uQ4NMl5mt8K6v1m8MhLL6qdNxgNUXpncbqb5v1tKk/jby5eljHB/8fboIeOXOkb405r24Grb658T7Tx5t7jV5LYpqLkfLaf/nevp4kgwKxB0jwjddWy1wCqsHW/XDr7iTKrQkTerQRlr14o/W1x9hHrixd4WSDgVIkMLlajvTWSUIAfESYnOVkUcVZeBmH9SAEfdUu38jXzQg0FtKGo1Su7sBeXW8XpSL9RvoNzWwkwuB/CCXtue1zp2GL2EGct/53gYwZZHfpuOffd7ps3YZIoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+9cBE04FTeMQFUwC+nkso8JIxQVtpSB3UI1Y4bGCrI=;
 b=EglsXiSJ/k2ipIn4SnHbjS6x9MIE5sOe2WyP5/0XjyAB7owZJHtsfIudrq2QOLyexYkGgQVU3nb0v16waw9b6aZiJsdVnNNSD+VJ00G3gQxyb7sC8tYFUkJhQWFLDIXo+3fE5W/0dkWrVe1mZ/tlav0Muo3pQEpMbUnLQhFPmN+IT3K1G2s28ZAqRN35RujwMluGCmNxj81b1ktqsivbEraAIHOpmjWmmirUEg3ZCkmTahFFeEyJD/YAOS6BJEu4bb0IvjxZTiudm1gSRpkR4Kg0M2becpc9UfNQas3YLq3pxh4Prjo1xmEQT0RXKw/NmfnhIGbiPthg0guWY6nFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by MN0PR11MB6301.namprd11.prod.outlook.com (2603:10b6:208:3c3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 14:51:00 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 14:51:00 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "deller@gmx.de" <deller@gmx.de>
CC: "keescook@chromium.org" <keescook@chromium.org>,
	"James.Bottomley@HansenPartnership.com"
	<James.Bottomley@HansenPartnership.com>, "luto@kernel.org" <luto@kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"debug@rivosinc.com" <debug@rivosinc.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC v2.1 06/12] parisc: Use initializer for struct
 vm_unmapped_area_info
Thread-Topic: [RFC v2.1 06/12] parisc: Use initializer for struct
 vm_unmapped_area_info
Thread-Index: AQHabDcIJMuNY9YEPkKgeGf/L8KJw7Ej/yOAgAVBgIA=
Date: Tue, 5 Mar 2024 14:51:00 +0000
Message-ID: <bf126898a8582e39da64cc8538d055faa9debd39.camel@intel.com>
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
	 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
	 <20240302001714.674091-6-rick.p.edgecombe@intel.com>
	 <ce73b0b4-a720-4e1b-8ab9-1990d76a6425@gmx.de>
In-Reply-To: <ce73b0b4-a720-4e1b-8ab9-1990d76a6425@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|MN0PR11MB6301:EE_
x-ms-office365-filtering-correlation-id: d57ab5fd-f3a6-4232-0765-08dc3d23ac25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ED92Od8s1cy5EDQOQdw58lee1SFQzLJRXad2S3ObxSu73RWbola4iwlqwB0sq42PjX7nooA+xFQXGVRAbhb3bC308IkvvAa4rMqpt/h0onUrnGkV4Bxi3ZMKRcNwBYxzsyVnBHb3D56k7BrLg1CnUqGkhMqjtj4dB9590ld0UH3Cto1lQk0RvqbNzku4KtquHo56438GuIFRFyA5VZgB3Abuhs1OwynZLt9fAKjpYgKKjDWEvRtlqXJ9wCs0CNi+7HsTeRvTjWsfPdMs0wN6gIrzcTaviXPL7mXgqcNOy5kCxzrFb3GYlYIbrvQsI7aug0PAfXAoitGx6r3xnSzYTFwUw/4LnA6lfTU38K7P7G3wMdJxWMB5y2cgoq+kKsKLinzXuYwWRhWDXd/JNTa35qEAm/Da3jCgC7KbsfzlYQbOPmVKzwU3Wd0z27XUUnWzetV82QkBERxOuyEEg/ap9AdoUIYjhJaY5zyrznS7mQClOt10BSFcwJtDiMXEZIkV4vjIXWG4CsRGJ/i4jJR6CUtmRIAbiHc6IeWL5OzMK3tg5cTNKMMJ2snsrLl6JnIUOoab0uZBLfBrkzSIVrHnIo0uj43Su70x409CSwCX/Oc8GOJqfyxF9XszJXgUS27YS6EUfehu2RNaPINWBxoym7LB+uZvi3rciw22MoP8tfeizAE7bwLO0emd0QysZ8dSFeWmn6N/703YQYp9GpZ8mQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTRPZTV1QmlPV0t0QmszZUI0MDlGR1lqMGNQRUNZRkRMd0VPckdYY0UzVXo5?=
 =?utf-8?B?Z1BMM1UvSHV6QVlkeFVzdGE3V0xvakszVGlOZXFRdG5pSTBFM1N6VXN2VXcx?=
 =?utf-8?B?bm9mWlZIVnZXZEp6dTk5RE0wUTFGZkhPZmpVdFNpcERsbzN6dUNTSWFrOEpk?=
 =?utf-8?B?NkE5ODJuUFFGSW5uNHIwODVmNTZQUXBFTEU4QWNJK0JFQnRyT2tqT0ViQWRn?=
 =?utf-8?B?SUtiUTRqRFRRZ2lQSzU1TFZtZXkxYjJTUGpMMXUvb0ZSQ1VkZktQUWlqc1pI?=
 =?utf-8?B?YVJuWVJkZFJmZ1JGeGlneUtFcEVLYS96Sk5kNHhWTjBOQnppR2VrT1Joc0hT?=
 =?utf-8?B?Y2syVUp6aHp1c0ZYM29FdnBlOXBzOFVMb3pmeXdwU0dMYXhIaTBTSnRnL25r?=
 =?utf-8?B?S0dRL1VyZjk4RnBNVGJsV3huU3V5a2sva0Y3NWhaK1hKV2RvMHVoRXl3dzZS?=
 =?utf-8?B?ZldKRXNqNmo1bHlHaStOVGkrbEJRTDRFaHVBaDV0V1VTdTlLQ2xEZUJHTFNw?=
 =?utf-8?B?U1RRTmVwZit2UXgyTHFvSFc0Sld1ZFVXZU5rL0JPYU1ncHF6T2FpcnBjMDFk?=
 =?utf-8?B?NHgvSlU0OW00anZLZ2pHYnIwQ2FWQ0VvK3FHdXJ4WHE5REplM3dEbFA0UlF3?=
 =?utf-8?B?TmVhN2ppVnNVV0djVzlQWTV5aFlIckk0QWVreGl4aFRBSTExZVZoVmdoMG50?=
 =?utf-8?B?bDM3QzRxM3BSaC9RWXVuemNUeWNiMVkzOXBuT0x6NUd1UEt6Q3dZWjZ2SlFH?=
 =?utf-8?B?Z2R2VzFFL2RubmpUdWxvWG9ueGZBRU4raTBKSXRpVDRlU1RIT3BHWGhubXdS?=
 =?utf-8?B?L1dyUG4rS2NQUFRwcWZsSTJvbHU2MUkrTGxUNXZVcVpDWm5zYmc3RDNmbzFX?=
 =?utf-8?B?RmFsdkh4cHhnSzZnWHplWXFKS0hCMjk0bWhZTHBSWU0vNWJYT2h1TFBCeHNC?=
 =?utf-8?B?K0JRRnd3NlNGajlLOW1LRXdGTDAyNXJUbVZ2aWVTYzVnKzRxN3dKRDNINnlW?=
 =?utf-8?B?QkFkMXk1ZHdQa0NKUjVCM1c5bzIyd3F5ejE2bXVUbEZlZlpHWERVK21tTWRl?=
 =?utf-8?B?U3ladThhenZZNjNVdmtkdmwybTFFQk1FbVZoci8rQ0dIYUtKdGFIcEVQUHQ5?=
 =?utf-8?B?Qm9OeGdXRXRiaXBVa0MzT2x1V2JNb1pKSXh1MjhkNCs3SkUxQ3N2KzVqQzND?=
 =?utf-8?B?WWxCWmZTNTJac3ozQytMMnl0NmRsMkwrcTZyOEE3ZkxaY0p4Z3FBdG5iOGxz?=
 =?utf-8?B?SU1LVENCdGdRaHg3TXFFVnhYamx4TkxSWVN3dncrUHRFTmkyVWw3MFdzYkFq?=
 =?utf-8?B?SUxncWNaVERZQk9XcDNwMERrbnRDdVNTcHljZ2FHbnArQ2tFU3RtWnJjc3Bn?=
 =?utf-8?B?TmRVWDdxWHdmRllZNG1sZlpyUjFwYW1CRTliNXFpN0hZMmc0SjBMYkZwRmgv?=
 =?utf-8?B?dkxLV254bHBYd3dndm5zQmQxbjZKVEJ6cmpVdkc5NlV6ODQzOERhSEZsbEF2?=
 =?utf-8?B?RkNaRHdMN2tBTFEwSFcxU1VDY0tldTlmdnpFUzZiSUNCMlB0QjJzSDBrMnp5?=
 =?utf-8?B?MVhrWnJwVmh5ajBCOWxqWUFKNk14WW5YL1VTSmNXRjhoY21acHhjK09QUUlx?=
 =?utf-8?B?a3dIc0dXenlCaXZlVjRvczZFWG94TkdvRCtYcmdlYndHYjVSNEE4d1JzTS9h?=
 =?utf-8?B?NDQwTGVrSk9CbTVCckJ6UEpuNkVacHRHOThhemVWN0ZTejZRYUNJOXU3dnM1?=
 =?utf-8?B?UmVvWlVsUnA1R2Z5ZjdtMk1vRzc2dC9wcVBXWFdCV0F3WVVVQmF4Q3FDZTFT?=
 =?utf-8?B?N3VPUjJQY0dNYXhRT1BVeEZKRGRXazVJVVVCOFg5VHpEYUkwc1luK3lsTFZP?=
 =?utf-8?B?Zlk4WHYrZEl5b284RGhMUncrcm5YNlJMK2FDT3pmK1pRTmQ1aDJLQTZIVG4w?=
 =?utf-8?B?d2xSVVZSY3JUck1tVXVUQVREQ0I3MDNJbC94TTlocWgyenZIVTZqQkZsMHVj?=
 =?utf-8?B?ZHV1dm9KYmdVdGd3c3dZVzRDemx4akFTSWRsWSs0dllGU3V6SzRlNjRiL1Ju?=
 =?utf-8?B?TDVHZDI2aEZ4RHlHODNVa3VrWHVGU1FFUEpRcWp5cW9PWWJCd1E1UThabTRt?=
 =?utf-8?B?UHNickg2aDFuYnJPUHZTZXBBQ1d2eHY1dFJ5V1FWTStUcUlUN3JqUS9sUnFj?=
 =?utf-8?B?dnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ADF2B28435C4D8408B2A84E48A7F1C29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57ab5fd-f3a6-4232-0765-08dc3d23ac25
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 14:51:00.0777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: igTshxrJ3EA4WjxJucXHPbZFw4Dgn03tLoISShodXWKS/WYeUC2PMH88hvCb4KRxu7+79KHk6gKZ9bNX+puitWRN9D5hqSp0Dn5rmuHoPXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6301
X-OriginatorOrg: intel.com

T24gU2F0LCAyMDI0LTAzLTAyIGF0IDA3OjM1ICswMTAwLCBIZWxnZSBEZWxsZXIgd3JvdGU6DQo+
IEFja2VkLWJ5OiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+DQoNClRoYW5rcyENCg==
