Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6CB1F4CAF;
	Thu, 21 Aug 2025 15:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788620; cv=fail; b=fo3PGtdMIHLQsDLRs9Zq3U0wKSZgFQZ8bOJYLeX7O8g8BOjc3Z2aQnI+7HYoJe+PWKzolSEwmXIkSqqRrnzsafiyd8XGiPCGU0RZySZs2ZK+3Qi3R3uACVjMCyx3aL0CEk9lNaJ2Fex/cYoHQB3l/b6vc4FNbQLqrYpTcEyx+8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788620; c=relaxed/simple;
	bh=FtHoM0sozqu3Ufc9Fooafj7HD5X6eXgZ7mVu4NubRew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoOqSGC0ZNkGOzPVHQpUQNJouSWhPwMhIrYMypmcOFywSWrMRTtmldK+MeLNQdGXjE/eQk6/bmjb2nBXx0KBZpGRsPJkI3+WZwA9C5NhOytosM+inaNLH9rD6jNrg1yeeYBLXXuSSGh6N9I0YiNeowk5eaGR8B/a/onnSLlKCAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NsJxoYpE; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NsJxoYpE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755788619; x=1787324619;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FtHoM0sozqu3Ufc9Fooafj7HD5X6eXgZ7mVu4NubRew=;
  b=NsJxoYpEV4Bned2r9LNHFxrgEP0FWbQIqEb93Y5P/OCic98NnXdxjaKj
   fLu0Z1V1H1/8lJY1XXK/PXoiyYlgR5Ri00dF8uLZwzfx+PdY5rEKL/MNw
   rs6y/VuD+YX8MuGE+5Pyc4lLIoCjUdQ2P7+Y4InnPD6ruOsRxSTNxDp6O
   plK+97uHtIsc5TZ+M81lHul8K2H0eoxhTMMjPtzQxM/Vhi2HDd1AEyP/6
   h3V5QqpXFgoKRM+8OB9RFxqhu2N+P3jFeRBsClgiFWDQxmEky8FC9IWVA
   0qLXnLwnAfiB4JVUvjKmeAVRZhvyay2SY2xlINjKRCOK1e8A45/xRM6oV
   w==;
X-CSE-ConnectionGUID: UwBjTQQNSm6+ijs+qm6tSQ==
X-CSE-MsgGUID: zAOSLRWVRYm76JhQz0L4SQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="58148193"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58148193"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:03:37 -0700
X-CSE-ConnectionGUID: R4FalM/jSfafMcPUubZXbQ==
X-CSE-MsgGUID: a4fR4FlZQhK8EVxlvcJZcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168669262"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 08:03:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 08:03:35 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 21 Aug 2025 08:03:35 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.77)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 Aug 2025 08:03:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yD/1Wnlw401SL8t9NldzwkeNZ36gyzR54LEb0qNNgpT57chQLvCwO1/gePK3pNXklcSwzWeR16ZHWqLdgHxbWEss5NPdCn1Xp9h4ffLWh/qejzTrauYe6ewPE/zu4ibZ0EIKpgO1lBSp162I9tevwGIw/lbjE8EaSc5vQb9wJsZ46IZNAxJ36s8AnYpm4+hweb+DnbJ3hWJo4uBsPUwB7JnVVHB97GLcMF2jYvqa3pAjpJkgkzjjqrOREfARMUZvS6ZE27LSgWoEfGcWIEtwp6f7G2v/jbIFwiPE3VMLLK177ouEzWOq3hWm4KxuxPAWJ+9oq0PCxNYASzIprAhOZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtHoM0sozqu3Ufc9Fooafj7HD5X6eXgZ7mVu4NubRew=;
 b=n6Q27H12bk4nnRMoU4VN/OSDZAm8r4ZqhOY7/qV54r6NLLvBvns6dC7lT25v2SAq+9gxWnI9+CfznYn1W3d4vt049FYLyoK1AAIRaQtMdBLH3ZVcczQqDjZmS54daATh++7zpYTaHc+zekoE2mOmdtlydVgK/dhaYmq1z44ARE2x43mvhHR9H9bSRITv8pHiuritdjo+P5BrzevFzkOi6qG6GPrCzQ8CpMm5PU/T6ttOZ2/HZ7udPE3lAHFZUmR5H3CcX31H1V5jvHWItBHIOi+5VfHsC8q/oOZGaytzlE1c+w1xHvX9MIZWvNXEkqe9hEXqEFH0Xd4PVFXKD+P/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7817.namprd11.prod.outlook.com (2603:10b6:610:123::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 15:03:32 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::edb2:a242:e0b8:5ac9%5]) with mapi id 15.20.9052.014; Thu, 21 Aug 2025
 15:03:32 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "andreas@gaisler.com" <andreas@gaisler.com>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "david@redhat.com"
	<david@redhat.com>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
CC: "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, "osalvador@suse.de"
	<osalvador@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "will@kernel.org" <will@kernel.org>,
	"mroos@linux.ee" <mroos@linux.ee>, "ryan.roberts@arm.com"
	<ryan.roberts@arm.com>
Subject: Re: Found it - was: Re: [PATCH] sparc64: fix hugetlb for sun4u
Thread-Topic: Found it - was: Re: [PATCH] sparc64: fix hugetlb for sun4u
Thread-Index: AQHcEppwFSxWT3DUvE+gMz7Rr04oUrRtNE0A
Date: Thu, 21 Aug 2025 15:03:32 +0000
Message-ID: <611a33b02282130d4015b5b8feeda8c46d249320.camel@intel.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
	 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
	 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
	 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
	 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
	 <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
	 <ff3d87634aedec28e7103f16a35031bfe86ca501.camel@physik.fu-berlin.de>
	 <b5b75976c94b7b46f86a5af4675a1a570aaf20cc.camel@physik.fu-berlin.de>
	 <2bcb018c8b237f7ab2356f4459e14ae81a6fec8b.camel@physik.fu-berlin.de>
	 <2daaa0648e9bcca42bf7a76d90580725f44fb4bc.camel@physik.fu-berlin.de>
	 <c50091bdbb0556ee74ec501381f1efc14a4e5929.camel@physik.fu-berlin.de>
	 <cd3c4a6a-abc5-4f4f-b829-72f86cfb5bde@redhat.com>
In-Reply-To: <cd3c4a6a-abc5-4f4f-b829-72f86cfb5bde@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7817:EE_
x-ms-office365-filtering-correlation-id: b48be27a-de7a-4256-e52c-08dde0c3e4fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UVJBZWlNc0dRYjNoQjA5YnVnakk3bzRPRWdKSHVLTjVLUDd3SVRzd0JMYVZK?=
 =?utf-8?B?S0RhNmlCRWdKR1FDSlIyM1g5L0ZmZDBCK2cyNXFXNVJ2T0V1czdjSzNUcExB?=
 =?utf-8?B?a3lhdWtZT29vTmN2TGY5bnJEb0s0UHh6N0NiUWhBL2tIVzI4VVc5aGI5ZVg3?=
 =?utf-8?B?RmhVMFdHV05DZEEyVkxyNDlmNzJaOGtZQUw1YzJPcHlqRXNjWmdjalYvVVhw?=
 =?utf-8?B?MHNqcnN3NlQ3YWlRRExDQklaVzkvNHpCL2pPMWNCTzRzNUd4dEhSeUI2elNN?=
 =?utf-8?B?VFlOdXR1T2dKcm5ycWg3UU9GZTFhcCtGb2sxOTlRbGdiQlB3cXZwTUN4ZnlB?=
 =?utf-8?B?S1U0NUpKMTNjMm1rZTFsOXBvQXBhdWQ0bnpmUGpIeFVCbzNPT0cvRmZhMVFD?=
 =?utf-8?B?R1MxUEJ4YTVzMUdzOTJ2c3o4aHNBQi91MW9GL0JrcFZxS2hURnJFUWdpZzFu?=
 =?utf-8?B?MGQwWWorVldveHRjZktvaXRIQ3pNcWJabEpTcEZCQTM2a0FqdmNManRseVNW?=
 =?utf-8?B?VWoxc1B0bi8wMFpmWjM0VlUvdDhkczA2alR2U1l0RWw0UzJuTVgvWnhaeFFr?=
 =?utf-8?B?amtGYm5oS2xZKzhqbzFkV080cElrRUh2Y1RXY2xEY1pSRFdrNUdpdk1lS211?=
 =?utf-8?B?SEhocVlNUzlZVnpYUkJSRmtoSnZPYjJkT1VCbVdGS09PQXQ3M1pIQ1VCNUpX?=
 =?utf-8?B?U0YyK3lSdjdCaHN1RXJDVnA0MW44QTFEeHR1RExXajdUVUFub2puS3hlTThv?=
 =?utf-8?B?c0pUZXk0T1ZoZGh3a3Rsc1QxRG9CNXNXeHMzOE1GU1p5ZTBXODVPUkZOSGFU?=
 =?utf-8?B?ZnFzRDFaQm5rZDB0RldLOXFrTUJSQnZFVzFrV0pVYmh6MXdVcWFsSC9TWDEz?=
 =?utf-8?B?STBkV3FtSjIvWEgwR2pEZUJzOHZDOVFxMCs2WnduSmNRMXVKeTJ6dmExRUp6?=
 =?utf-8?B?TGc0WWJTSEw4NUdGS0tsSmEvdU9hb09MVjlvK0dQVFcvNkgvMlJrSDJsem56?=
 =?utf-8?B?d1NnTHo1VzdydC9wc3M5SlZpL0x2czhiZGpFTzZXSkQwQXFnQWNaYXIwRW5x?=
 =?utf-8?B?Sng1NWt4R0hWSzJlbXdGUW9FaGtCR1FpeEdCeG04Nm9XdjBNRE83NktYZ0hT?=
 =?utf-8?B?cGhkSEZPVGcrNDlNNGwrc0xmWlR4QjRhVllnbWpNeWRaclhLNVMyOGFOdGhI?=
 =?utf-8?B?cDdqSllLUGV5czFTbFVIcnY4ZThlOHozYW4yVlNSNmFpeFlvZmtIdmsrQjdz?=
 =?utf-8?B?b3ZqYzh4eWV4aG1qeHhvOWRGcXNUNkN1aExuazZFVWJpRXlqYzVvYXZNL1Q5?=
 =?utf-8?B?eDRRRER6MTBhUFJqL3ZiTHpjS1Mxa1NxOXlBSDgxOHZ4bDlkelZESzl1NEMv?=
 =?utf-8?B?RFQyajhFbXpzTkNUQmZNeDBHcGRzMUw4NjBZMGlaUXBjc21tVHZNdjFUYTds?=
 =?utf-8?B?OVFFT2hYWW9ZTjB5TXV3M2NnY21ubERjUm1jK1dsMnZDVWRmNG1nYTJwQUR1?=
 =?utf-8?B?eUFqcC9SWVBzUW1vRmpoK2ZBTDFUa3Y0ekxZQnUyOGRXanpHaUdNYk54RVlB?=
 =?utf-8?B?Mk94c0tyNVZxREMzUmxORkZlOGVOUEtTSHhZc0lvZll2UmN5aG9kNTZrTzBo?=
 =?utf-8?B?SDBaalFWVlVNemJsZ0ZHdXcvUkkwWFBqMkJLaXlsQWVjRVFFWmpuM284UVRC?=
 =?utf-8?B?TWczTlBJNjhsak9tT0krNUpWSG0rdXdJSEhoeFc4eFZxWEFRL1NsTEk4SmRo?=
 =?utf-8?B?Z3pXVHBJOUFZN09XdEROS1A3VmFBdW1vUDY2R01TbmNYb3FqOVNUMHN0dlFP?=
 =?utf-8?B?ZVFJamhkRXlDRnQ0bDFkMldTT3gxTk9ta1dmMFh5MEwxMHZ5YlhUSmM5bnJP?=
 =?utf-8?B?VW9MOHo1ZlhSTzN3RERNQmZ3emloQ0d0WUxOdnBxLzdzUk9kZ2ZPRzh1N3Za?=
 =?utf-8?B?VFErZVhrN2g0VDVHYmJEeTdkWGRGK0V0VUhid040QXBZdDRRM1lhWXd3elp5?=
 =?utf-8?Q?HTXuffeenxJ0jDSjlSk/ISlbmuoa9c=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEJqTEs0eDU3MVhLV0hEMDBNSEZDWWE4VndJUUh6Yjc2TjRKTnNFNlJvVFNS?=
 =?utf-8?B?UTBoLytKZzA4ZHgxaXRBZ2hvYkRGZ0EvTjNlNnp1czF3ZFI4OThFamdkblp5?=
 =?utf-8?B?LyszU2JqU3JZMFpnK1J2SjhZbGUyY3hpRzF6ZHN3MStObTdGMmxYVktLNm1Q?=
 =?utf-8?B?SWNKSDgybSticWw2NkR5MmFyQWNZemhoNkRSMGF6TmprUGZmcWpnUWdNQWJP?=
 =?utf-8?B?cWNHYTdJNTI1SkpiaHVJNTZKbVRxeDhldG1jVkU1bjRraU0zYzNJSjBMSVNZ?=
 =?utf-8?B?TFc3SWdWUEc4L08yL3ZhMVMyR0dLWjF2eDBGd0d2T1FNOHdLTDFOTmYwQW9Z?=
 =?utf-8?B?WHhmOHZxdERML1VqWTFkVWFMaGZET0JhS1JZZ2tFTTdvTmRUem5USEE1bHlL?=
 =?utf-8?B?YzNTUkRRcmF1czVyRlJRUkJFQlFCL0xhRER0a2hLTlhOSmc4N3FFejZmdUNH?=
 =?utf-8?B?d0tWWWFqK2hsNERXNEV5NUpZTFpUcnlmdFgzSTM5ZFAvcW5SakNWNi9TaXZF?=
 =?utf-8?B?M3phRERPOU5NR0kyNWt2Sk1Nc2hUcHNxMHhUUTM0T3ZaeWZtQllZOFA0ZUd5?=
 =?utf-8?B?Q0dKeTNqTENTZFRibjRvendXcmlLZk52L1llNVM1NXB3dFdHWUhlclF3Ym4x?=
 =?utf-8?B?dUQzL1IyK2pudWFtVXdKdGhVaUJ1eEI4YUFYQ09iSS85TFhnRUxCOXozbXBR?=
 =?utf-8?B?ZEZYdHJnd3UxWmJmWTBMa3dmdnJTaXdsQ3VMWGxjdFMraW81NWpTUnVxSHo3?=
 =?utf-8?B?ZDVwMXkrTGEzeDR5WmhlVU5rcllUb082a0RmRzZvSlRlYUFXTHZBb1lpdXlS?=
 =?utf-8?B?UmJrZEtFSGlDSXdwV3N5R0VYdkhKUEc0WGRmSTI2c0krbHJ1RTNNQ1U1MWo1?=
 =?utf-8?B?ZFpaT1FkRHFyaVMzTk5EVGtOVDhuSFVPK2I0TTcwZlhoTGlPckR2NjBVb0sv?=
 =?utf-8?B?TXlKV3I1VlY0alRMcFRpbTRLZFl2QUt4VXVkOERVVWlwUzlPVlM2emFJeEtq?=
 =?utf-8?B?djVpZmdmZDFyTEc0d21HYzBYZisvNFB4aEMyL1hueFRlR3h2OTB5WEJjeGlD?=
 =?utf-8?B?QnhSeFk2S29zWmkyOUpwTi9QeElNSXB0ZDcyZGdWMk9oUkVpYlorb3lzKy9P?=
 =?utf-8?B?WWY5TVRCdHdsMlZxenQreGE5dkFCMHh6enZGajVLcjVXWDhhRXlUNFZQWXVm?=
 =?utf-8?B?VTRJWkRTSDNZaUNZR3FvTThtRHRNMThTZ3V1cDdKenVvb0MzV08wckdabk81?=
 =?utf-8?B?QlJhSEd1dkpnYm1mNHd4NHJlZTRFbnFJZmlvVkZYRlBYa2RMRFZHZTRIbU5T?=
 =?utf-8?B?VVlIblBVYVV3bS92SUk5dnZldXBDT1dkVnNDcHZpUXlRQXVBYjNHMUVPcVps?=
 =?utf-8?B?NE5mTHlQRW1Dd2xSRTJVTWQxZlRUeVJwcDIvVTd5Uis3R1JXOG0vMnBnS2VE?=
 =?utf-8?B?WUp0dUQ0Um5rZi9RZ0NwQ3hkRmxWbExkeHd0UHFWVXJ5MDFXUnl4dlJPYnFK?=
 =?utf-8?B?RnJOYk5OOEc4RGk2enNpZE1jcTd2aVlBTTUvLzQxZVRnWHZWQXNUcjBFbmpC?=
 =?utf-8?B?YUhlRkV1SUtCQUZPS1VBZVA0M2V6K3FJeFJ6a0tlSG52aVI2Tkh1d0czL3Nq?=
 =?utf-8?B?WjhUdjB5VjZzSkp0UUhocnJlbUwzanBFc2pjcFR3ak9sdUV1NUhLQVB1ckIx?=
 =?utf-8?B?ZitSSE52ellDbVhyRHVwcGVqdFR2R1pXNjBGcTZtVDYwMFh5U0FUcHJ2dll6?=
 =?utf-8?B?Wkkra3oxMko5bURXSC9idFpkOHdFSlVZbUpNWmJxT25TV3hGVU12YTY1OWhH?=
 =?utf-8?B?NmlYTmdUWTdxSWlnV1d0YmZTSVB4Q3FwZExpNmdUWmE3SjRPM08zNWFOakZj?=
 =?utf-8?B?TlR0RE92M0JIeDdXUlhWM080UW9DYzJ2MVBYZ0gxMElFNHduUFBqSXRLRnYy?=
 =?utf-8?B?emFPdklIWHFwU2oxSEp2STFsdVUrYm5jVWR4T0MxSnFMSXYzSFFjenVkc3pH?=
 =?utf-8?B?dmQyYkM2OGJGUUhlWlVPcTF6bWsvODhtVDFrbTBjbHRCZkJSMVZNbWhSVjA2?=
 =?utf-8?B?c3djL2kzbi9LMXlxb0Y1N0RFa2ZNenpibzhGQ2VibkMyUjFVT1BiSUxpUnla?=
 =?utf-8?B?MGV0MzVlZWlMMXNmb1RlcXVOYTJGV1p6TTB2aVRwS1BGeFg2YkNFU0dRVkVt?=
 =?utf-8?B?SkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBCE1178D1844B48830A062BA38390C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48be27a-de7a-4256-e52c-08dde0c3e4fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 15:03:32.1110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GiX8MUlKvNLZJJh9+RRs8SZDYMxBWPYXsKczyjrNyr+EUuyqic/ogm6WKPKZLVOLf5ojqfcZldz47dR+Gsqg9Aj4VcUcDyLTWWJ5Kcr8M0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7817
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI1LTA4LTIxIGF0IDE0OjUyICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToNCj4gPiA+IA0KPiA+ID4gQEFudGhvbnk6IENhbiB5b3Ugc2VlIGFueSBzdXNwaWNpb3VzIGlu
IHRoZSBkaXNhc3NlbWJsZWQgY29kZSB0aGF0IE1lZWxpcw0KPiA+ID4gKENDJ2VkKSBwb3N0ZWQ/
DQo+ID4gDQo+ID4gT0ssIGJpc2VjdGluZyBoYXMgbGVhZCBtZSB0byB0aGUgZm9sbG93aW5nIGNv
bW1pdDoNCj4gDQo+IENDaW5nIFJpY2suDQo+IA0KPiBIbSwgYnV0IHRoYXQncyBicGYtb25seSBj
b2RlLiBBcmUgeW91IHN1cmUgdGhhdCBpdCdzIHRoaXMgZXhhY3QgY29tbWl0IA0KPiBvciByYXRo
ZXIgLi4uLg0KPiANCj4gPiANCj4gPiBkNTNkMmY3OGNlYWRiYTA4MWZjNzc4NTU3MDc5OGMzYzhk
NTBhNzE4IGlzIHRoZSBmaXJzdCBiYWQgY29tbWl0DQo+ID4gY29tbWl0IGQ1M2QyZjc4Y2VhZGJh
MDgxZmM3Nzg1NTcwNzk4YzNjOGQ1MGE3MTggKEhFQUQpDQo+ID4gQXV0aG9yOiBSaWNrIEVkZ2Vj
b21iZSA8cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+DQo+ID4gRGF0ZTrCoMKgIFRodSBBcHIg
MjUgMTc6MTE6MzggMjAxOSAtMDcwMA0KPiA+IA0KPiA+IMKgwqDCoMKgwqAgYnBmOiBVc2Ugdm1h
bGxvYyBzcGVjaWFsIGZsYWcNCg0KSm9obiBwaW5nZWQgbWUgb24gdGhpcyBvbiBhbm90aGVyIHRo
cmVhZDoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvN2U0ZGZjMDFlMTMyMTk2ZDNmZjEw
ZGYxODYyMjI1MmE4NDU1ZDFiOC5jYW1lbEBpbnRlbC5jb20vDQoNClF1b3RlZDoNCiAgIFNvIGZh
ciB0d28gaXNzdWVzIHdlcmUgZm91bmQgd2l0aCB0aGF0IHBhdGNoIGFuZCB0aGV5IHdlcmUgYm90
aCByYXJlDQogICBhcmNoaXRlY3R1cmVzIHdpdGggYnJva2VuIGtlcm5lbCBUTEIgZmx1c2hlcy4g
S2VybmVsIFRMQiBmbHVzaGVzIGNhbiBhY3R1YWxseQ0KICAgbm90IGJlIHJlcXVpcmVkIGZvciBh
IGxvbmcgdGltZSwgc28gcHJvYmFibHkgdGhlIGJ1ZyBub3JtYWxseSBsb29rZWQgbGlrZQ0KICAg
dW5leHBsYWluZWQgY3Jhc2hlcyBhZnRlciBkYXlzLiBUaGUgVk1fRkxVU0hfUkVTRVRfUEVSTVMg
anVzdCBtYWRlIHRoZW0gc2hvdw0KICAgdXAgZWFybGllciBpbiBhIGJpc2VjdGFibGUgd2F5Lg0K
ICAgDQpBbmQgYWN0dWFsbHkgb25lIG9mIHRoZSBhcmNoaXRlY3R1cmVzIHRoYXQgd2FzIGJyb2tl
biB3YXMgc3BhcmMsIHdoaWNoIGdvdCBmaXhlZCBpbg0KZDNjOTc2YzE0YWQ4ICgic3BhcmM2NDog
Rml4IHJlZ3Jlc3Npb24gaW4gbm9uLWh5cGVydmlzb3IgVExCIGZsdXNoIHhjYWxsIikuIEpvaG4N
CndhcyBnb2luZyB0byBleHBsb3JlIHdoZXRoZXIgdGhlIGZpeCBtaWdodCBoYXZlIGJlZW4gaW5j
b21wbGV0ZS4NCg==
