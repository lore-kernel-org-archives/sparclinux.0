Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794934156;
	b=4k6gkgkJqJlVGgGDhOD7r5N/20YBzMe0Lo8eLkpsO6yAzQC5g2vsyibRzDzHCQDjYGzs
	 59dRjI+uGz45fJl8pFC0XHY3V4Pn8A2Y4MVCF4K3/9EH9uDdFy/yAAqxhdnz8gkjE8NRq
	 VveLZqI/PEPIipfmwV9aNTlLi0kDey+k1EbEiThQOxj7YJC9P4JNhqFm2QveUmy4Ys5kZ
	 kh4OZ7xWRLl0IkIZExpXhVss2IrcugVPL6il4D6K7ZS9uhTxq3SpfTyX2lvTOf/GB2vmo
	 WQ5xt2Y3620ThRgymkgy7n9gKy1a4kOiUK4KJrZ5ooOyR8CWbgmsJ1U2IAiwv58YdYQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934156;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=CDGjUAKRH40rZDuk+MAX5dHwyxkcRP0qEUGDwxPXgLI=;
	b=b7V+WdnA9f/Gdgz8lZYYae3w+WIwngSCCb2jzGFnZcQWMkRR31ac3QIPb39u1Im6TUq7
	 Fm4mC3fH6H0GYgBjJLsxXIbJAX1jKo9RvHD1lU2GmRcWP7T6JlX8D5d515HUaLddwpzbh
	 o9ifFg8LaRXEP5KHxyXmsCqjJd6teYoVS5HCTNmKykv5P2G6/8bFD0MUcB+yCrydtGBox
	 4/gy6gVxT1pLqyMNnKBIwQpMvNYzmy7krYiUp4TU6p1IQMWVzuOtxcHcBJC3qI8+gVHZ1
	 dwMk7fIJYMJELfno/nCS9faLb/wfno34AHvAJCyMZLGoIfLtCNHecxweFfd0u4EzdyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OWc4EYfa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.9
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B104606A31C;
	Tue, 17 Nov 2026 16:49:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B104606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=OWc4EYfa
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9KhNFfzyVBU4BVxVZDNXpuBORrk6HXcex5iWPhUSlTRs2zVXK9Kn/J8+/NVkPHvQ/2PVE3fpPVy4PfPEN5nvfL6/ZPoDK0on9jUlNhQ7uqxgZRvJVDmlU/JzrYoOVXV0TmXhLU1sgCKF8HEXLS73g1HykvFWdl4qjvAF5USBYv0yGHklY4ymCaJpzhRNBg/1050zzMQaUyiyZ2jCtvC7+HkoYf1ileCigBAZNu63KUQh7rgRf+8QAZS5ouje6ZxnejyP361Q5HkfHRvf8LcqVt48NSQqO+93KA0F5bmAApi1nhnyilQU4ngVcdUDzHE6r7TbltFo4pU74gQNaYuoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDGjUAKRH40rZDuk+MAX5dHwyxkcRP0qEUGDwxPXgLI=;
 b=p4y3fkqxWLVO4RPpm3qbnbKqIBv+6k6Xb/KAUwtNJ1o798wrzp/YN+tB3fqERuDvHdoOYvaFxUvwUJis8q35T1FEu0nNPbw2KDpvZpi+ShLGy7Bfs8Lj/9xJRpGOANN0Z6bHlN2dTsrnDZyudcuXbhPMAC9P7sJ7z6ptP8TtbgQNl9oKdkFMnhyINEFwqHP3NNxDV1T4C8yG18bXSmBNZU2QSGUIMqPKJHfHLQ1HZK3wPPGcvh6imi5qQuPtEgk49Fv5PpZ6xT5mEk4yxe1JSV3y70bfVanqgAuJitXrEURi/SktHlx5rMwBzUOYueBnOpOKy5wt8vAcrUs58bbagg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDGjUAKRH40rZDuk+MAX5dHwyxkcRP0qEUGDwxPXgLI=;
 b=OWc4EYfaq7gAvxyqTPaFUT3TK3U3jjSP7yv1DnW6su4I6SOK3pjjE6zwT0JoHUaF5j3kSLF/J3Bu79fp2jccCrIjALQWHFhm0pXG4Bu/CipcYNBLxN5kCnj7cpxIGAvn72xl+pwNGqXEnwjK6G5hFIjp+6VNH1SpXwPlXOQqsCo=
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 16:49:05 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 16:49:05 +0000
From: "Garg, Shivank" <shivankg@amd.com>
To: "andreas@gaisler.com" <andreas@gaisler.com>, "dev.jain@arm.com"
	<dev.jain@arm.com>, "david@kernel.org" <david@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "hughd@google.com"
	<hughd@google.com>, "ljs@kernel.org" <ljs@kernel.org>, "chrisl@kernel.org"
	<chrisl@kernel.org>, "kasong@tencent.com" <kasong@tencent.com>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "geert@linux-m68k.org" <geert@linux-m68k.org>, "rppt@kernel.org"
	<rppt@kernel.org>, "nphamcs@gmail.com" <nphamcs@gmail.com>,
	"shikemeng@huaweicloud.com" <shikemeng@huaweicloud.com>, "vbabka@kernel.org"
	<vbabka@kernel.org>, "harry@kernel.org" <harry@kernel.org>,
	"riel@surriel.com" <riel@surriel.com>, "anshuman.khandual@arm.com"
	<anshuman.khandual@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "surenb@google.com" <surenb@google.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "youngjun.park@lge.com"
	<youngjun.park@lge.com>, "sparclinux@vger.kernel.org"
	<sparclinux@vger.kernel.org>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"jannh@google.com" <jannh@google.com>, "liam@infradead.org"
	<liam@infradead.org>, "baolin.wang@linux.alibaba.com"
	<baolin.wang@linux.alibaba.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"lance.yang@linux.dev" <lance.yang@linux.dev>, "baohua@kernel.org"
	<baohua@kernel.org>, "baoquan.he@linux.dev" <baoquan.he@linux.dev>,
	"pfalcato@suse.de" <pfalcato@suse.de>
Subject: Re: [PATCH v4 0/9] Optimize anonymous swapbacked large folio
 unmapping
Thread-Topic: [PATCH v4 0/9] Optimize anonymous swapbacked large folio
 unmapping
Thread-Index: AQHddrOOoRK0/oYJyUWJ5vzwhCg9vw==
Date: Tue, 17 Nov 2026 16:49:05 +0000
Message-ID: <4c351ae2672a817df071b5a8b6b402846b897a75.camel@amd.com>
References: <20261115143905.3045084-1-dev.jain@arm.com>
In-Reply-To: <20261115143905.3045084-1-dev.jain@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5259:EE_|DS7PR12MB9473:EE_
x-ms-office365-filtering-correlation-id: 0851e31e-092a-4b3a-0bea-08df44cab0f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|261009223027099003|11063799006|56012099006|261028144727099003|261102123227099003|261022115727099003|261021123027099003|261022105027099003|261026140227099003|261022075727099003|261026121527099003|261021135927099003|261021121427099003|38070700021|10067099003;
x-microsoft-antispam-message-info:
 fUZuYSsa3xjI2muGYyTT0oOf1N519cYQxcyee2Yaafe4VvJbgXRejKCTI5/oFTG3GJx1/AjvHSi3bZqDGIjwK19zNJQE6KAwir6yK6NlHTYrcXBvlyj9FY23MA88WKxGUfordPjzvr2v1cXPRjNlaZmnr3d2Q159gbk9HREA/dfS3wLDSKy1OYppshdAN/d7HxnmttEit/TDCT0gzDGG9XomEYA4F/7IeYvWvbtDHqrqVUKL5F7yOHJyYgPiFbZ95jyAvs5GxSmQXtnAKrMABRDmuTPeiXIZdoA1PFgM4IEypV4fgO91hc8PZqeLdn+fFvY99E6TEFI5NWE6/nIWsTOk2KI7PO8FY+UFW8ycQgMTLtMfQj1+TaE1AAtc4YiEl3IvbYmJR1Fthi51qmZxz9GrRAZjaTWmCNUzXQJPbMFTzY+xfJ3am2w2ZJMnaMws2kLQUxi5TQmwa+PO4CLowFe4TRFV15bsE4jcBrT4fcYKris8spWkyCU5tX7Es03yqWPRpyOhRD7LrtkYJPNkcK4XloDZrxQyUA2rAruFyMcWYag4EPRtKanKHk/Ak0ufEPP8T/3fOG8p9FYHC9eLY0tsaJhpj/AUi4fcghxNy7ilBPKd6RTnjwsragY+nVVEOTczym4st6iSU5AMQsIHFdq4WyYAYDx9kNIEzdpyQio=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022115727099003)(261021123027099003)(261022105027099003)(261026140227099003)(261022075727099003)(261026121527099003)(261021135927099003)(261021121427099003)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZDZUdmNERURmSHdXQXZMcDJOYkF2WVRIRGxORmxhci8yYjZ3UHYzK3UrSnhr?=
 =?utf-8?B?OE1tZlF1ekFuMGZNYzYrd3dvb29ULytWVmhmWkJ4SE14K09xcFFBaEx2Z3Jn?=
 =?utf-8?B?clZFSThqMENpdkVjN3lNSzZzUlBwYmw1MVlVOTRMZk1JOUs4RWNibjFST3Nh?=
 =?utf-8?B?Q1FjUGJoT2pWdCsxY050QXZaWHA4bDVqTjVQYVJxTHlRYkVJQitueDQ3LzZu?=
 =?utf-8?B?NzluOTJFeEJXSWFjT3VhZk9VNHEzWjdYSDRYUG9aVWR6ZnROS0Vaam03WDNi?=
 =?utf-8?B?VVE0WFpQaEpXS0VSdHZ2WHBNeWFpNmRWZFJJUFloYnpIdGF1cG1DL3pwekR5?=
 =?utf-8?B?YUxWTzhDazZDL1R2a0c3ZVBKc3pFK3BoazI0SUcxdm4ya0g3bFRkYTBTeWEx?=
 =?utf-8?B?RE9tM0g4WTF0WnFCSERHYnBzTmFPdHNxRWRWak9LUTlQTkJuRzdGNTJqYWxK?=
 =?utf-8?B?Ym5WdzB6TlI3cS9Lb21EdmRhSGE5REVWYjg5aEoyTTU4Skc4K09meW9Vb3Jz?=
 =?utf-8?B?ZngvelVCd0RLR1IxNWdpSWdqWUdOTjBIMU9lVU5MbmFjUUQyOGJyT1hWTmFJ?=
 =?utf-8?B?NnRjSlBhRXBmYVZId3djaXhnckFkYVE5NVlQOWF4WnlIYkxCckR6Nm1PVlRE?=
 =?utf-8?B?OWhNa056eFcyWUkrT2lRVlFpbEl2dU5CcG5teGM1aW9tUWVodDgrSnpDSVNq?=
 =?utf-8?B?NHl2WXRPSDdrVTVtNjVWTFJqSnlyQ0FPQUxkOCt0OEI0YXJmR2VLTERQVUgz?=
 =?utf-8?B?UmVIMCtlRDBEVnQrdUZOM05ETHRmbXBOby9GSVVEOTJhRTRmeTJSYTV1WWZN?=
 =?utf-8?B?LzNxcUUyck1FYUYrZlBqTHFPOHhLMUNaN3Y1b2tobFVaMnNHMXl4a1JwWmsw?=
 =?utf-8?B?RGJzS1l5VWhaYy9LOVAxMUI3Y1RhZWJybXZKR2lCbFNhNk1UMUcyYmJsckkx?=
 =?utf-8?B?YTUwWjNzRW1CcW04SjlwU1VpZmNjdll5SFZSN1Z2TEJURzdMc1JsV3FUdVhp?=
 =?utf-8?B?SFhGejhUdFlUMXlFR01KdVFITWJsSXQwaG81UEZHWWowNlVtNHBUZ0RuaEhL?=
 =?utf-8?B?blRINlc4NVM3L2hDR3lCQ05SMTNTQXBNN3dRZ0RJc2JMLzRKRFU1NHdLcFRY?=
 =?utf-8?B?UnN6WXJHMlByaTRjQ0ZmWXhLYmV6UWMrOXVYQjBzY3RJZ0NPc3c0NldPM1or?=
 =?utf-8?B?RlpETTNmY1RJY21IbllaaytXa3A4ZUc4Y1k2N05vTTBVL2dubm8wY2psUTJG?=
 =?utf-8?B?Qm1CQXdTOThUR2xPckU1NmRVUG5sVFdMZGVNN2ZrNXEvb2ZvZHN6dENmTnVN?=
 =?utf-8?B?OW1PMkpJNnJUZktEMGZvVC8rVCtLVlVONGhXVzB4TitjekZ4bzF6MElsU045?=
 =?utf-8?B?RytYYjRwalYxSVZEL2Rjc1dQWm1oeHJvcm9EdzZrNEtWUWkxSHZCek5CUkha?=
 =?utf-8?B?Z0J5Y0YveE5Bdnc0RWFpNTFhYWMwcmNZdXlwV0J2QmdrbmFXcEdGUTdtaDBw?=
 =?utf-8?B?aFl1TWQ4aGU2SkdBN3hYa3Z2ZEJtVVZRMGVPdmlrVVVQNGh6Uy9URFFuOWlk?=
 =?utf-8?B?YWpjWGVSZEtwOGdackJVNGN6Q2dBNjQyTXYxK2ZZRVNlRXlYeVluMm9QZngv?=
 =?utf-8?B?cE10QWV2Zm1zSU1JRGxWMC9oRFd5Qm9KNDlaV213SGRRanhtTSs5WHpSa1Zq?=
 =?utf-8?B?YlU3endjZmpNN3Jjb1Q2ZkFrbG9VNC94OEE4OE1HOVFDdTFvU0w0MTJxTmpo?=
 =?utf-8?B?UXhPK0tCRTNsdGhwNXo2N01KUkwrQXI0ZEhqUUpLa1dTamt6L0liWm5GRy9v?=
 =?utf-8?B?ZWt1L1VYclh1bEh0Q0F6bi8rZmJvN0R2REtwOFpaL0p4VkJZK3czdHl6aUFt?=
 =?utf-8?B?ZWdLTWVkMHc2QmthK25WQzNpTWNxMDBENU1QT1R1N0NMUUNncWtFTWphNlZ4?=
 =?utf-8?B?YzRIdW9DWE84dEJTZVI4TzBsUk8wUTFsdzcxU1daVU1TRmxUM21NcEo4dnd6?=
 =?utf-8?B?Mm9sVndrR3VrcE5YRHgrTzI4SmNGT2ZuRkVvdVIyWWlDZ0lNeDJ4aWJxYnYz?=
 =?utf-8?B?aVpHZ2NIRHNFaWo2T2VuU2N0M1ZMWmdtUmdqejh5c21yNnZxb3hrWFAzbWho?=
 =?utf-8?B?WFY3VkIzY2hxSW5MMFAzM2xtUXZZb0xnVStyalpGRGViV0ZQN3NweU8zTEFK?=
 =?utf-8?B?SW1pa1ZUVWtMMlBvL1VlMVB2WVhqMFphTDFtWmNzS0lSa2Y5RU9mWjE1QXY1?=
 =?utf-8?B?YVRadFRRdS93TCtIemlrRFNDVjlSRCs4L2E0Nm9EWmhCdTRST3c0dVZMMklW?=
 =?utf-8?B?NU10OS9RRW12RTladHNORmtiZ3FDRHRvVFk0bE1BdDNLeFlMQXlBZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBE0382165A2964DAD58B6355D988C90@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0851e31e-092a-4b3a-0bea-08df44cab0f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2026 16:49:05.2793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6s4t+V0W2VEJ7HdTk1n//k4XladTX6k3dtxSAp+fOhMAw2smq0XnodoHcGSodailaS+cHqfqQ/0zY4GSlEtIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9473

T24gU3VuLCAyMDI2LTExLTE1IGF0IDE0OjM4ICswMDAwLCBEZXYgSmFpbiB3cm90ZToNCj4gU3Bl
ZWQgdXAgdW5tYXBwaW5nIG9mIGFub255bW91cyBzd2FwYmFja2VkIGxhcmdlIGZvbGlvcyBieSBj
bGVhcmluZw0KPiB0aGUgcHRlcywgYW5kIHNldHRpbmcgc3dhcCBwdGVzLCBpbiBvbmUgZ28uDQo+
IA0KPiBUaGUgZm9sbG93aW5nIGJlbmNobWFyayAoc3RvbGVuIGZyb20gQmFycnkpIGlzIHVzZWQg
dG8gbWVhc3VyZSB0aGUNCj4gdGltZSB0YWtlbiB0byBzd2Fwb3V0IDI1Nk0gd29ydGggb2YgbWVt
b3J5IGJhY2tlZCBieSA2NEsgbGFyZ2UgZm9saW9zOg0KPiANCj4gICNkZWZpbmUgX0dOVV9TT1VS
Q0UNCj4gICNpbmNsdWRlIDxzdGRpby5oPg0KPiAgI2luY2x1ZGUgPHN0ZGxpYi5oPg0KPiAgI2lu
Y2x1ZGUgPHN5cy9tbWFuLmg+DQo+ICAjaW5jbHVkZSA8c3RyaW5nLmg+DQo+ICAjaW5jbHVkZSA8
dGltZS5oPg0KPiAgI2luY2x1ZGUgPHVuaXN0ZC5oPg0KPiAgI2luY2x1ZGUgPGVycm5vLmg+DQo+
IA0KPiAgI2RlZmluZSBTSVpFX01CIDI1Ng0KPiAgI2RlZmluZSBTSVpFX0JZVEVTIChTSVpFX01C
ICogMTAyNCAqIDEwMjQpDQo+IA0KPiAgaW50IG1haW4oKSB7DQo+ICAgICAgdm9pZCAqYWRkciA9
IG1tYXAoTlVMTCwgU0laRV9CWVRFUywgUFJPVF9SRUFEIHwgUFJPVF9XUklURSwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICBNQVBfUFJJVkFURSB8IE1BUF9BTk9OWU1PVVMsIC0xLCAwKTsNCj4g
ICAgICBpZiAoYWRkciA9PSBNQVBfRkFJTEVEKSB7DQo+ICAgICAgICAgIHBlcnJvcigibW1hcCBm
YWlsZWQiKTsNCj4gICAgICAgICAgcmV0dXJuIDE7DQo+ICAgICAgfQ0KPiANCj4gICAgICBtZW1z
ZXQoYWRkciwgMCwgU0laRV9CWVRFUyk7DQo+IA0KPiAgICAgIHN0cnVjdCB0aW1lc3BlYyBzdGFy
dCwgZW5kOw0KPiAgICAgIGNsb2NrX2dldHRpbWUoQ0xPQ0tfTU9OT1RPTklDLCAmc3RhcnQpOw0K
PiANCj4gICAgICBpZiAobWFkdmlzZShhZGRyLCBTSVpFX0JZVEVTLCBNQURWX1BBR0VPVVQpICE9
IDApIHsNCj4gICAgICAgICAgcGVycm9yKCJtYWR2aXNlKE1BRFZfUEFHRU9VVCkgZmFpbGVkIik7
DQo+ICAgICAgICAgIG11bm1hcChhZGRyLCBTSVpFX0JZVEVTKTsNCj4gICAgICAgICAgcmV0dXJu
IDE7DQo+ICAgICAgfQ0KPiANCj4gICAgICBjbG9ja19nZXR0aW1lKENMT0NLX01PTk9UT05JQywg
JmVuZCk7DQo+IA0KPiAgICAgIGxvbmcgZHVyYXRpb25fbnMgPSAoZW5kLnR2X3NlYyAtIHN0YXJ0
LnR2X3NlYykgKiAxZTkgKw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAoZW5kLnR2X25zZWMg
LSBzdGFydC50dl9uc2VjKTsNCj4gICAgICBwcmludGYoIm1hZHZpc2UoTUFEVl9QQUdFT1VUKSB0
b29rICVsZCBucyAoJS4zZiBtcylcbiIsDQo+ICAgICAgICAgICAgIGR1cmF0aW9uX25zLCBkdXJh
dGlvbl9ucyAvIDFlNik7DQo+IA0KPiAgICAgIG11bm1hcChhZGRyLCBTSVpFX0JZVEVTKTsNCj4g
ICAgICByZXR1cm4gMDsNCj4gIH0NCj4gDQo+IFBlcmZvcm1hbmNlIGFzIG1lYXN1cmVkIG9uIGEg
TGludXggVk0gb24gQXBwbGUgTTMgKGFybTY0KToNCj4gDQo+IFZhbmlsbGEgLSBNZWFuOiAzNzQw
MTkxMyBucywgc3RkIGRldjogMTIlDQo+IFBhdGNoZWQgLSBNZWFuOiAxNzQyMDI4MiBucywgc3Rk
IGRldjogMTElDQo+IA0KPiByZXN1bHRpbmcgaW4gbW9yZSB0aGFuIDJ4IHNwZWVkdXAuDQo+IA0K
PiBObyByZWdyZXNzaW9uIG9ic2VydmVkIG9uIDRLIGZvbGlvcy4NCj4gDQo+IFBlcmZvcm1hbmNl
IGFzIG1lYXN1cmVkIG9uIGJhcmUgbWV0YWwgeDg2Og0KPiANCj4gVmFuaWxsYSAtIG1lYW46IDU0
OTg2Mjg2IG5zLCBzdGQgZGV2OiAxLjUlDQo+IFBhdGNoZWQgLSBtZWFuOiA1MTkzMDc5NSBucywg
c3RkIGRldjogMyUNCj4gDQo+IEkgdHJpZWQgbWFnbmlmeWluZyB0aGUgZGlmZmVyZW5jZSBvbiB4
ODYgYnkgdXNpbmcgMU0gbGFyZ2UgZm9saW9zLCBidXQNCj4gY2FuJ3Qgc3BvdCBhbiBvYnZpb3Vz
IGltcHJvdmVtZW50IChsb29rcyBsaWtlIG15IHN5c3RlbSBpcyB0b28gZmFzdCB0bw0KPiBiZW5l
Zml0IGZyb20gYmF0Y2hlZCBhdG9taWMgb3BlcmF0aW9ucyEpLCBoaW50aW5nIHRoYXQgdGhlIGJl
bmVmaXQgbGllcw0KPiBtYWlubHkgaW4gdGhlIHJlZHVjdGlvbiBvZiBwdGVwX2dldCgpIGNhbGxz
IGFuZCB0aGUgcmVkdWN0aW9uIG9mIFRMQg0KPiBmbHVzaGVzIGR1cmluZyBjb250cHRlLXVuZm9s
ZGluZywgb24gYXJtNjQuDQo+IA0KPiBObyByZWdyZXNzaW9uIGlzIG9ic2VydmVkIG9uIDRLIGZv
bGlvcyBvbiB4ODYgdG9vLg0KPiANCj4gLS0tDQo+IEFwcGxpZXMgb24gbW0tdW5zdGFibGUgKDI0
MjMxNTk2ZWRmMikuDQoNCkhpIERldiwNCg0KTW9zdCBvZiB0aGlzIHNlcmllcyB0b3VjaGVzIHJt
YXAgYW5kIGNvcmUgTU0gY29kZSwgd2hpY2ggbm93IGdvDQp0aHJvdWdoIHRoZSBuZXcgTU0gY29y
ZSB0cmVlOg0KDQpUOiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvbW0vY29yZS5naXQgZm9yLW5leHQNCg0KU28sIGl0IHdvdWxkIHByb2JhYmx5IGJlIGJldHRl
ciB0byBiYXNlIHRoZSBuZXh0IHZlcnNpb24gb24gdGhpcyByYXRoZXIgdGhhbiBtbS11bnN0YWJs
ZS4NCg0KVGhhbmtzLA0KU2hpdmFuaw0KDQo+IA0KPiBtbS1zZWxmdGVzdHMgcGFzcy4NCj4gDQo+
IFRoaXMgYnJlYWtvdXQgcGF0Y2hzZXQgaXMgdGhlIGZpbmFsIGNvbXBsZXRpb24gb2YNCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjYwNTI2MDYzNjM1LjYxNzIxLTEtZGV2LmphaW5A
YXJtLmNvbS8NCj4gDQo+IFRoZSBleHRyYSBhZGRpdGlvbiBpcyB0aGUgZ2VuZXJpYyBzZXRfc29m
dGxlYWZfcHRlcygpIGhlbHBlci4NCj4gDQo+IHYzLT52NDoNCj4gIC0gTWFrZSBwYWdlX2Fub25f
ZXhjbHVzaXZlX2JhdGNoIHJldHVybiB0aGUgZXhjbHVzaXZpdHkgaW5zdGVhZCBvZg0KPiAgICBj
b21wdXRpbmcgdGhhdCBpbiB0aGUgY2FsbGVyDQo+ICAtIE1ha2UgdHR1X2Fub25fZm9saW8oKSBy
ZXR1cm4gdGhlIG51bWJlciBvZiB1bm1hcHBlZCBwYWdlcywgdG8gc2ltcGxpZnkNCj4gICAgdGhl
IGNvZGUNCj4gDQo+IHYyLT52MzoNCj4gIC0gcGFnZV9hbm9uX2V4Y2x1c2l2ZV9iYXRjaCByZXR1
cm5zIHVuc2lnbmVkIGxvbmcsIHNoaWZ0IHRvIHJtYXAuaA0KPiAgLSBEcm9wIGEgcGFyYSBpbiBk
ZXNjcmlwdGlvbiBvZiBwYXRjaCA1LCB1c2Ugc29mdGxlYWZfaXNfc3dhcCB0byBnYXRlDQo+ICAg
IHB0ZV9zd3BfZXhjbHVzaXZlDQo+ICAtIGZpbmlzaF9mb2xpb191bm1hcCAtPiBmaW5pc2hfZm9s
aW9fdW5tYXBfYmF0Y2gNCj4gIC0gQWRkIHBhdGNoIDkgdG8gZG8gYmF0Y2hpbmcgZm9yIHNwYXJj
DQo+ICAgIA0KPiB2MS0+djI6DQo+ICAtIEFkZCBXQVJOcyBmb3IgZm9saW8gc3BhbiBpbiBmb2xp
b18qX3N3YXBfcGFnZXMNCj4gIC0gVHJpdmlhbCBjaGFuZ2VzIHRvIHBhZ2VfYW5vbl9leGNsdXNp
dmVfYmF0Y2gNCj4gIC0gQWRkIHR3byBzYW5pdHkgY2hlY2tzIGluIHBhdGNoIDQNCj4gDQo+IERl
diBKYWluICg5KToNCj4gICBtbS9zd2FwZmlsZTogYWRkIGJhdGNoZWQgdmVyc2lvbiBvZiBmb2xp
b19kdXBfc3dhcA0KPiAgIG1tL3N3YXBmaWxlOiBhZGQgYmF0Y2hlZCB2ZXJzaW9uIG9mIGZvbGlv
X3B1dF9zd2FwDQo+ICAgbW06IG1vdmUgYW5vbi1leGNsdXNpdmUgYmF0Y2ggaGVscGVyIHRvIHJt
YXAuaA0KPiAgIG1tL3JtYXA6IEFkZCBiYXRjaGVkIHZlcnNpb24gb2YgZm9saW9fdHJ5X3NoYXJl
X2Fub25fcm1hcF9wdGUNCj4gICBtbS9pbnRlcm5hbDogcmVuYW1lIHN3YXAgb2Zmc2V0IGhlbHBl
cnMgdG8gc29mdGxlYWYgb2Zmc2V0DQo+ICAgbW0vaW50ZXJuYWw6IGFkZCBzZXRfc29mdGxlYWZf
cHRlcw0KPiAgIG1tL21lbW9yeTogdXNlIHNldF9zb2Z0bGVhZl9wdGVzIGZvciB1ZmZkLXdwIG1h
cmtlcnMNCj4gICBtbS9ybWFwOiBiYXRjaCB1bm1hcCBhbm9ueW1vdXMgc3dhcC1iYWNrZWQgbGFy
Z2UgZm9saW9zDQo+ICAgbW0sIHNwYXJjOiBiYXRjaCBhcmNoX3VubWFwX29uZSgpDQo+IA0KPiAg
YXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmggfCAgMTAgKystDQo+ICBhcmNoL3Nw
YXJjL2tlcm5lbC9hZGlfNjQuYyAgICAgICAgICB8ICAyMSArKysrKw0KPiAgaW5jbHVkZS9saW51
eC9wZ3RhYmxlLmggICAgICAgICAgICAgfCAgIDYgKy0NCj4gIGluY2x1ZGUvbGludXgvcm1hcC5o
ICAgICAgICAgICAgICAgIHwgIDc2ICsrKysrKysrKysrKysrLS0tLQ0KPiAgbW0vaW50ZXJuYWwu
aCAgICAgICAgICAgICAgICAgICAgICAgfCAgNjQgKysrKysrKysrKystLS0tDQo+ICBtbS9tZW1v
cnkuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAyMyArKystLS0NCj4gIG1tL21wcm90ZWN0
LmMgICAgICAgICAgICAgICAgICAgICAgIHwgIDI1ICstLS0tLQ0KPiAgbW0vcm1hcC5jICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAxMTkgKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
PiAgbW0vc2htZW0uYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDggKy0NCj4gIG1tL3N3
YXAuaCAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM1ICsrKysrKystDQo+ICBtbS9zd2Fw
ZmlsZS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAzOSArKysrKy0tLS0NCj4gIDExIGZpbGVz
IGNoYW5nZWQsIDI4OSBpbnNlcnRpb25zKCspLCAxMzcgZGVsZXRpb25zKC0pDQo=
