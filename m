Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.76.130
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793345156;
	b=LHhEratdqPwUCfaAxBRQWdSahBq/0cZ7f4Rr/9giMM0gzszI5HznFsdAb8l1i/6Y5Msy
	 9FXp3Wzdd88wo8McbpDr1HYF/667p+H5juOE/cCRtDHWJ11nrwedG9zodBTwLKx/7q42d
	 HGHconLDvUf96s8+6P2hcEsDfYkH2g060omf7e1HiOIZxCfsxUlBuLJCkghKHPmpIOk4B
	 Zyp51gc+tKtCOcS0w82kYrmAN/ayrrK6eLJZwaI7nQBFvKEa/4zLRTUCQOvKRtKrhDpmw
	 1KTPSBItHCcNFQLFCmEGhLlaRiLNHwetvMYAwkbbdp9Tl+xPDjZRCmZj7GLTVdfvVKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793345156;
	h=DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=WAJ4v3TpH3AXMlqx3UvU/u3nqYiw7BCGculn/TuytOM=;
	b=FclZL+hpby/0GJ3UMLifg6g94nAyYzQAy0FO7aOjlSEZoaUYk5INhPtAfeIPjkxvP/7k
	 Gh/3FvDkuF7EF/DWpYJM2xh4TBUuzUYj9U/pYwcXZyo3vtaQM1ZE4yIlt53KZcsFGh88e
	 tPZiqj7/Gi8VigxTF/r/lC8/rUBR6/SQ9inCryZteSrpyiDVuaVVBQkMw54Rl7w0c5ntE
	 G7Q6O697ipJETDUnwklzr2nfVemvbQGrIDlTzDJkyJU6tHKe16vQtXUTf/jVgbCCjI9A+
	 jKMWt7V0vBWwxuxAnfCC1CQgREoDEWICys8anqQktC6vXIc8H6bOmR8sXTV+8eFovuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=ITRXOG4T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.76.130
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021130.outbound.protection.outlook.com [52.101.76.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22058606A31A;
	Fri, 30 Oct 2026 07:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=ITRXOG4T
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nFJoOkHGXVtWgOuG5ICiV9OnDisOsHkXKE8nPblco2qahaZX2BnE4Gbc/kSdGjgZqte7MsfjRd3VgJ62jUmQqRomjavmit4UfJ4QtXCmMtUV9LqMwXLtkFQ7Hf+IsAEftU6Hm2Mq3damCUgiQz1SNLzziiPHUllb5jtPEEMUPMHOEddBz1Dlb0sSh5LlJChIqt4qVCN2NuYC435jQ6fmMiY1Fdq4WToQUXw67rw6qmaErIillFMXTzNeAR18xK4jo9jk21mtD9qudblsdBOTe+EiiGPyOlEQRDnUGzl5D3vpWSO4B1FQ8obhk0hFf+tFpK//DL4dGFzwgBfpqwGMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAJ4v3TpH3AXMlqx3UvU/u3nqYiw7BCGculn/TuytOM=;
 b=kxcvhwsm02hRw5TcpSzPMPStBJKaiqu0GldHC4xXeCJf5gU21HyQfaNQLazDdcpxDTCuLv4XmcWAI/WwNZudcY9ifijjenB6yjR3qNQc1iZe76gh9Tk1wTJ8/19PVMdUPwI18lSuKBR2XvQ1wiruSUoq4asysfFf2mZXOxfArKT+qyvW5eg1YMj5PCZy8hyxdApKxHY9hlz8UQvP1qKKOBuC4GUcqxjM3HceUQqvHGSznt0fbvU5ULbLY6rGfx6tCANyoQMNbhcvNaAQgonPk3rRQkPxTFL+hGKx+tC/wDJieiMb+hJMKZTDbvyGqF5s2+82rPrfrM07y8vh16Rulw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAJ4v3TpH3AXMlqx3UvU/u3nqYiw7BCGculn/TuytOM=;
 b=ITRXOG4T1+ALnM4MvdLIH1TaP7FSCGC0XFvl7K7Av9agJu8RNUNUnhAcGQajs3HMpKL+9c5jZXARTwT4vZRIr+FFN86k97KGOo9KmHOY6wkgYPvpIf2M4INAXBNbQ7StBkRLzkpRerJx0nV3m91Sx/G6ut0AgYYc+Ma8jKaDzd2Q1dI+/hvQGtHaSH9StfPUPcv0ZZ0g5SYQcYccrlYRQmnjCw4k4AC21RinPEK8JF3aQS6HEeMRJTOU99uwwoJZ2EKruXv/iULITONatwXgnNKCLRdxRnAHi6y6l0GCLNmLRw5gu0QfXIGNzEFZO3+6Zob5eXl3kJj4mFH1cDe6NA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB2031.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:379::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 07:25:49 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0569.007; Fri, 30 Oct 2026
 07:25:48 +0000
Message-ID: <b8d8f8d6-936c-4a00-a2dc-ac820afd7c7c@gaisler.com>
Date: Fri, 30 Oct 2026 08:25:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] sparc updates for v7.4
To: Linus Torvalds <torvalds@linux-foundation.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
 <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com>
 <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
 <CAHk-=wiXTPC_jJ9o7k2JGVwA=F5_JFt4ikY2J4E69xJqYtAFGg@mail.gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <CAHk-=wiXTPC_jJ9o7k2JGVwA=F5_JFt4ikY2J4E69xJqYtAFGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0097.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::18) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:2f::5)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB2031:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e8f3c8-8af7-46bc-4690-08df3657052a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|56012099006|11063799006|4143699003|261026140227099003|261028144727099003|261026121527099003|10067099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	xGY2ou6dzbmFURgN+a6MHXreMKycluaQea3+xrBSJboE29dzmWavN58xkNNuG69+2q2vLEYaZlP92YvMMMzny6UaJ6vQvR+GUEpVDMSb2MaFE3LcU6HAIrFPFF4ZiKVLI0kufOfuziLnbkFoltABLt+WYX9fwBTNe9Q77X4VusetU9JCWm7W7BFM8yVRvDVhpIaxR6HdYlpiWH5r3OSF4+mqPgQwqxDBXnc0LUWPWv7eAgZWAM7KOao1WfM2OFlo/CAmV/QdzGVREDT3RANBlk7rrITUzSpdNq4GXO/oXgC9DHzU4QE1RiuvQI081NQBumtSPcSfoe8OWKh12Z0zohPtgSazjgx/nCbvZ1dPSuxmOO7hR2y96XWE0+49QMiOta3nR8bDMTvDIuq3qRhc3ionrqRny17Z3y1VlNrVTJG1/hDZbN1yVhQo2IeXkcYto+bMbAW6UGekmai3qsfveQlDzBhNAPt/Vjjv/AUacyUUvT4cHfLY5GkCDn4qtC8aYCJkjGtLdB9dA63Zqt6r9iU6d+Ri7PtFB8fxiMjCy/tmaLQL5XXjIY7TpuOfMEqXIsiVLP+Bj+q+uLDRuseEVJRutKK5lkl81tyeCaw9opmEYe4ptKRfv25Jt7V22VS1rRLT9OvJLvaLtKCRF/erCA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(261022105027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjhMcWlsaXoxWS9kSWRWWGtwaVI4TUNrS2M1NGxmOVBXOVFkb3BnSHk5SUkw?=
 =?utf-8?B?QUJpcUFzbWxUS1VWR09nMGtmUmVGWkF3ZTZmZUxUNEhSOUZhYmVpZ3kzOCtt?=
 =?utf-8?B?eWFRbm54WHBpMDYwKzhRd0pBanpJOFZJQlN6MEhvTlV1YlpMcDVkZnN2S1Rw?=
 =?utf-8?B?cndQZ3djeVNOSnlvemNldU12b1RHNmN4SmxMLytmdm9KQ3BrbElUelVhajF4?=
 =?utf-8?B?WG9ULzUzMmx1RDV4YnRwcUExMG4wY1ExZ0hPbkZxUjZ5K3dxZkxVS2Y1MU1I?=
 =?utf-8?B?ZllDR21PVTFYbGk3UkdJNXM5TFRuTlVnTnJVOTFUbXJEN2JHVnA1WlA3VGlR?=
 =?utf-8?B?YURkWi9wSkx5cmIxamZ0UkVlQnVZbEpYQUZjaFR6WDBlRG1BTlBpWldhT1ZP?=
 =?utf-8?B?Q1VyRXBaaUh4UEtjREdPRHdUcXdLN3BNRjgzUEdIWXBHaXpraUNybEs0NTk5?=
 =?utf-8?B?bFVURzJPNTBQY1VNdmRtUFcydXQ2eGR6VEZNOGZGVFllNUhSRWtkcTFZdDVM?=
 =?utf-8?B?T1VrKzV6S2JsbmpIblZKSVRpRkIxZDdHa3Mwdm5HV0dIRk12U1A3Sy83NGF4?=
 =?utf-8?B?Rm1vVnUxaFdzNWloSkxiYWpuSU00K3hWWUNKR1MrbXlJcGVlVERtenRxOTNN?=
 =?utf-8?B?dVQ4SUxQMlV2ZXRiNCt4Ym5mcDR4ZXc2NGNMb1VjRUVkRTVUQy9jbUV0THoz?=
 =?utf-8?B?S2lIZWJEZnNJR2J3UTB3dnNIYzc5T0RsTHRkbityVzVTbVdVbEJWREpTY0or?=
 =?utf-8?B?a3h6cTFPZVZOMjNwanJFcVQrb09tbFlJcEhKVENZdExjWlExdW5DUFFud2RP?=
 =?utf-8?B?Yjc3elErTVZ6am5mMUJUZE5BLzhEcHJPNVRaUWxQUWNRRTRsYXVVd2IxajZi?=
 =?utf-8?B?SGFzbnVTM3A2QnNQTnpMNlJoMDYxeDVia3lwY1N3S0pEWjN6TmlSMGIyZzNL?=
 =?utf-8?B?NlNxRzNFUW9aMEdjYnd3N202Qzd6RUpxazA2bGNCZ0p3RVBLejdZZ243cnlu?=
 =?utf-8?B?bUtNUEltc1RRbnRyWlV1bjVsaCtuVCtNNmtPTUFIL1AvSEhKLzRURXFHTGhz?=
 =?utf-8?B?d1BMNSt3R3h4R25QM0xSbG8xSHhGYTM2OGNyL2FXOXpHTmErRlVjd1lWcEgy?=
 =?utf-8?B?OXBzREIzRGtBWkZJakRBanFuVDVaN1FydFU5R0hqQkozV2Zvb0V2TE1sSStw?=
 =?utf-8?B?V0JYMHQrK3NBM3ppdTN3eXhTR1g4TitMaCtHakgzcjJBN3RHV3JLbmhkbUpl?=
 =?utf-8?B?OGlGc3JBa3lWODdtekVLR2c1bU1XWU92ZU84YkNySVpYaDQ3eWtVa282RUVH?=
 =?utf-8?B?Um9peUVhWSt3bFhtSjBhWEVGcFlid3I4WXl3WCtNejVtT05KVEh0MUFBa09s?=
 =?utf-8?B?cjV1ODg2QUZ5MFFGeUxyUW1Qb21RSkU4c25vUEZ0Uk9id2RLelppN1ladmk2?=
 =?utf-8?B?SnphemlZTjdvZDlDWGdxZlZ0cG50REI0bERFVk43VWZXd1RqNEpqYmd6a0NR?=
 =?utf-8?B?MDcwOWxZQ2ROL0RvdExXc0tQZXlhaW5vTHVKNHN3QUhFcGtKNk4zVlRvY3dD?=
 =?utf-8?B?bFQ0Q3pwNEJtblhPclpsZ2gvVmNLVGcydE9WU2lMM01sYm81WTh2SDE4RnU5?=
 =?utf-8?B?N21OM1B5SEpsYmNFVWdLUG5yZGN3enpWbVJLV21lYWx3ZFc2aXpDZVg3SWNE?=
 =?utf-8?B?TDllbG5adWtQWUg1SEF6YTQxZWFiMk1XZXBiVXFaUjM5bEF2blZzRTFmN1Bp?=
 =?utf-8?B?Q0Q5SWw5TUxuVW1tYTh0Q3JaMUlKVEVySzByckZrb09kejgxK0E3dEJ0VXc1?=
 =?utf-8?B?Qkt4ZmpxZ3RTTEN5anRKZHJCNGVURVpqOWxhRGdZeWQzbVZtOUlmYWlkVmlZ?=
 =?utf-8?B?eDZ0c280dkpaMHdwOHB6MFlYQ2FWQ20yRnlxam83UER2Mnk3NDZVMlVpaDZu?=
 =?utf-8?B?M3NrZ0QzYUQ3RmkxWFVMVkpqVkRCTjVNRWVZSzRKWHQ4RytZNWYyWFZkdnNp?=
 =?utf-8?B?eEFJekRvUEtvVUZidm5abHBPWHU5a1lVWTJYaFBKLytHU3ZZdVB1TXhacHhv?=
 =?utf-8?B?bUdOa3pGakFVZVlheHI3czNmUG9TTXJONllPQ3hPVkVIVGZXQ3lmT2xMenh1?=
 =?utf-8?B?TWZmVmVMVWlONkhrb29TbDRlUVlYZW0wNWxvcmIzOC9tVDhBQTRuS2E1NG9z?=
 =?utf-8?B?L1RSa1BLMjhHTUEzS3kxV1JXcElMcnhzdldmc0FneFVvV3ltZkdKSFd2MHB3?=
 =?utf-8?B?Qm1WYXhPK2R3Skhaby9kdlZ5ei9hT0dGazBTcVhNS1VmSkNZZG1FQnZleGQr?=
 =?utf-8?B?N28vdWdtbmJmWVFnM1FOV1d1RzZqQVN1UkxnZ3dBa1doNmk2d1ZMWWhMaUhU?=
 =?utf-8?Q?iRmjOBjaZuBCuW0k=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e8f3c8-8af7-46bc-4690-08df3657052a
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 07:25:48.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdRvy0/B2cIBRxU8kk1UMyIZ0JkgCg2Ha46HeSHyu/Faf0LRJmvPKuEGy0WIGBL4DgHVBTp5r7kpR0yw/gGuCN8uNeYQk6QMe27O29I9jTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB2031

On 2026-10-29 23:49, Linus Torvalds wrote:
> No. The fix is to NOT REBASE POINTLESSLY.
> 
> And no, adding a "tested-by" is simply not a good enough reason to
> rebase long after-the-fact.
Understood. This was my mistake. I was trying to do the right thing and
clearly did not. Sorry about that.

Just to be clear, the followup pull request for sparc-for-7.4-tag2 I did
in this thread is for what has actually been in linux-next. Each commit
there was pushed to my for-next the same day as I committed it.

> And if you have a *major* and actual real reason to rebase (completely
> broken history that needs to be fixed), it should be mentioned and
> explained.

Understood. Sorry for the mess.

Best regards,
Andreas

