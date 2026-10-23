Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.76.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792737043;
	b=v0ulIMF1jblJkvYIdG/FOLs++ZQKPLsThr7LEH0e5lM5lGD53PJMjCXD2s4JpsrH1Q+7
	 WQi7wRQwP8OvWq4lmbF2Lt0KsE9EAEoMXm+hv+73qn112TM+Cuqpr/GEHiFB7RICOIAn2
	 NaBbDNTdRBGvImFmUrBrvS5gcW1aTPncQHSBqfqxRu83C+GjF/edb62eD0+J3M78gdrlP
	 fi6xOGUz/Ij6LlrRwe1IT5JbWJGtlOt1qHQVvGWXEleC/55EqXnIMkh/6G23tXmXiNVi4
	 I6AXizDCVStk587fP2m5zaSJpodI3h/cJMlj/BW1xTWS87IPRyX9u/aBss1tH59GLlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737043;
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
	bh=lyoR01JnsqmNmXb/+kAEDvath0V68P+0cB4RGBIoRfw=;
	b=q65UOQ4TMebbFV2xzE8cwbMyYtCTe27TSPGwW9GjNGptLWCgzoLgf+nbbkL1Y80lZeT8
	 s8vlkNubt+mRs1/J3jvHahD2Vf40+1X0GUs1ZIPIPH3PMtTQXmzM8YPAfAG72kZ3bVPuv
	 oz2V1ZCQkxuf3chQ6NutgCGG2SdwyhKLoFVALkxtZosmruQgUrNgj/5tRsFuO7BpPZVAz
	 sfHgpKECuBKBOkAxnBAyowpVIAOBIjSbEZgs255nc7jrH43Mc8SDQBfuBw/FHWYZgGE8T
	 tR9fVnFyXLg6KkPd1l8LCL4ISda0AC2iFGwVvwtf3vJaZSjTqM9oyGDv2sPQ2RmSiiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=UM9zoe9X;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.76.121
Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021121.outbound.protection.outlook.com [52.101.76.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5A3606A31D
	for <sparclinux@vger.kernel.org>; Fri, 23 Oct 2026 06:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=UM9zoe9X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w5DPMp1sQFKAS8ub+1jRJ4/w+5yBtfh1iM4K5v8z5RH8vJjIYoQf62OBx5BtIoOo5AP5YVrHxZ20gej9DROAcgjQt3FXx2+oV153JZ14hgFHbNKkbHjKPC0NUs+E8S+213px2w8bYBahuF4ZrKYGB5DNiAAqVj4qbcwNne9+1WtCS7kxe/ZP3OwPsAd0Vk/RIKbclWgV4u3tuVKSm+N5PBXLJ7r45KM6Sq4zJiaup7/KCXG66zFpxM+hcbh0f6Shm4rx+Ha4sS1lLYlxtSdSgd65quEeeD3QMc6dUck77urT5nNaQXeMKA4+906kvJ9jnKcrh7VZxg82FaRcH7qkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyoR01JnsqmNmXb/+kAEDvath0V68P+0cB4RGBIoRfw=;
 b=PPeDwYJC8TBbaVBFlP1xLaCwIKd7fIAz+wOYPmC3SQF28jlA7Z0bLQExS/tOxd4mhcByFSge2j2BHqh0ZaC/oufx2qyXnGTPY2ohagCdGCpFUrxkAEBCpb3Zvc2ktSANfiY1w1AbbsdxYeEXC4b5Ie4eIvuqNICB++bEZOFAiTnVtWaip1bu7+kTA2D7h61qLrEvO19JmFkeZhSrfMbckJ5iKH0nUcnDbgilLt+28o4qsDmuor6vjNb4JDHc5uBJyhpJEdZNGE6W7Bi8EW8pRshcSvTWH8rWtpBqd1E8+t0c/20WvYQIzq0qkpp9mksJxeLKneCQ//s2ya2+h7Sa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyoR01JnsqmNmXb/+kAEDvath0V68P+0cB4RGBIoRfw=;
 b=UM9zoe9X0Ei34akcu8lTGIZjovQxkeZ6BAyI6Q6DxYAujw7cqhCqhYgl4IjfVilEq7wJm+9tGbKIXpgQAbtK3J4d9DmMrT5whYNAEuSpFQfzwXGtNRvVaDLAwyFhJ2LoE44Z4zVtBuk+gkGgTL2TxNZ0O8TausW1TeBdT0o6VrNhlaBfCLA8MTo1oMjFE1CSQHDo/dANpl/5aCAUK10YYjo2NFUcdBDPiowu/OOaO/nPbtYdZQQqHgA77tJHFm900b+TvSwQX7sFYv4/5rNQGQK7HfDkr/k09orr1D7mILN9sGsnQkdjj9AjQs4+l5oCE6q1p4T72N4Pn/BvhzFhdA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by MM0P280MB2199.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 06:30:37 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 06:30:36 +0000
Message-ID: <71ae9abe-c0e2-40e4-a03f-3daec311151c@gaisler.com>
Date: Fri, 23 Oct 2026 08:30:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Enabling Sashiko reviews for sparclinux mailing list
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: sashiko@lists.linux.dev, sparclinux@vger.kernel.org
References: <a08430ed-9e39-456d-8863-3fa478368134@gaisler.com>
 <7ia433txrb0r.fsf@castle.c.googlers.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <7ia433txrb0r.fsf@castle.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::20) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|MM0P280MB2199:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a2633ea-715a-4382-f27e-08df30cf2634
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|261022105027099003|56012099006|261022075727099003|11063799006|4143699003|261009223027099003|10067099003|18002099003|22082099003|261021121427099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	14odDPrvS6W/ZLxmMC+DnwHAxjwgtVIcW0py9euEWNaTqyuPCVIKx86r3B7eT1pdUrVg8vge323+kWKPg6GIHz3Dkq0o+rJ2q6VgReFrZnGi0K+mxxJ9nm8d/gx7mrjL205g7M+BkjOpRwSfYJ9cYpNl6098oZoP8HlVzd0vRZH58JQrjfbzZc06QyiWTPATFBoxnaottNxJZ1ZuNcLoFYDEAxor5ekwy5tkZTVKeEWjmpBno2aGdfkkCDe2PBwNog1GXNk5+z1iaV0S1blV7ZeQuwzyuajlp55DNbC2242Ws691sHxVckZZtVEAntZLrCUK/1+VsL5VOF/sd1RCD5zGbvb8R4P4FgwGNMiVsU2hp7rGL7oNDkQn9Ow1ezHAEdabAgqA16BmEAROZ0JkVLP3DdZMQ1X8N8VXudKo24CKoGbWHGIqdrzm8BtjvMDgFhum7gG0WlqoKLe7xgEATCU74wXQR/UHmrH2LRDotldPebxjBIUC/Qwq6ODLVYpJYqP+wG3kw5OTxcBLJ31E3fjyS+InwUNFu6+GrZC2FZG+XtLmNs9pxXs/QiBMzJJSLBAqiIAyaDh/tbNT8ct6iNIiY73u16R/YiS9k7OEYoIgCqO6RFVapdLUyr7OXVvWZP0ZLtIoZAMxRN6IeZyu3gR09FCNC0xZiE0sTBlml1k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(261022105027099003)(56012099006)(261022075727099003)(11063799006)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(261021121427099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnpVNUMyaUpJZTdKVTU2WHB2Q2pYbFM0cGZLUGUreXlKUjk5QjhWS3NrYzg3?=
 =?utf-8?B?a3JKTURRMk4vbjdUTU1kNllCQ3BiVDFGcWwvdzNCSWd5VWlyT08xMnpoUWlj?=
 =?utf-8?B?TzluTDVqUlA3ZkdrNmFJb0QrMURvSjR0bzYyRGI4Z1IrYmRFSExPbDBCRTVw?=
 =?utf-8?B?cVpvaUQvNHZMNm41bXVPdFdGU1pvMkZCWEdqU1lJZktmdmhEcXNMcW5naUpW?=
 =?utf-8?B?d1oyR3kyNGxzWjhBN3hNbE54M2l4eUZqOWhac1ErSnlUUmJUMmg4VFVlV1la?=
 =?utf-8?B?QUwxRURrbDRHVHB2NkF1Q1oyeFI4VVp3Z3E0V0ZrR3dORFVBbkxOMVdkbytM?=
 =?utf-8?B?OTJpdHAxaG5UZERQdElCTms1bC9Dbnc3RXJlbzV1eWVqa2xQSno4cWN0U2JS?=
 =?utf-8?B?RUJBaUVJUFZ4Qm8xbU1ualBuL1dWbWR5T1h5NnhMQTdpTlZNSDZOTkpQUU85?=
 =?utf-8?B?TStCSDlSYnZYT0hFaHF1MndvYUU0MHRIVFUrczZ6RFNNMVdMREVqV1hiaVQw?=
 =?utf-8?B?Q1FFWi9rMkNCYTFCMkIyV0tGd3c2RXhlN0xFVEZXUWpKci9hRThaQWplUDFV?=
 =?utf-8?B?Q004UnhQcjZtWlFKbUM5cDVlVVFaeElCazJudkRzQk9TNWJTcytHTmo2YkNv?=
 =?utf-8?B?aDFPTGNmUEhWNUdwRUlrVUM2Smx3T2g3cmNPcHc1Z3hZeGxwN1FzczhOQTZN?=
 =?utf-8?B?NmhTNGRQOC84Q2ZiQVVLM2pBQ20wYUNza25CMnJlWVl6NUx4alFXaThHUDFs?=
 =?utf-8?B?dnZKSEdzd2I5S2VseEIxdmZIYUczU2VmdHF1Y0R3R29YUU9CZzIyOE04UTZ0?=
 =?utf-8?B?RVk2WmRVelNFaXE4NnpRZWVEWlI5aWg3YTQ0dTY1d3daZklabXM1MlVXS0wy?=
 =?utf-8?B?Q1c1NUVLNlNxRFBGdGgyL29RTCswaUNpWWdTQnB5L1RUa245ejJpRW51WWYr?=
 =?utf-8?B?RDhRWkVTMWRjSzlzK0pJTGtQZ01EV3I5ZHp3Sjd5VmNEQ3huVUNPZXlLT05R?=
 =?utf-8?B?MnVWM1VjdHFJc21BNi9wN3FMUy9DYWRUMWFidjNNM1N5S3c1MG5NZVNRVXJQ?=
 =?utf-8?B?YjdRT2VsTGN0b2diMVFoeDZ4eURLT0VibmJoeUZObFl4RnIwMklWMEtHeU9U?=
 =?utf-8?B?YWpXRWJFQ0MyQ0c5MnZTOW1xMEJWMGgwMnFrUndTczJnaHlwUWZPRFA3aGFB?=
 =?utf-8?B?cVZhMng2Ty9vdXNGNjlqb2RTRFpYRERobFZkVEtVV0pwazhNTlYreTNKVWFI?=
 =?utf-8?B?TnU4akVqNytGa0hKZll6aUdRa3J3UGhEcEJ0NGUwcks1dGwwbENwSXk0cWI1?=
 =?utf-8?B?S3dpNWJ6RTNUNTlRUjVZVEM4ZDFmY2VjZlFrNVhUSU4rczVDWStVWnFOU09a?=
 =?utf-8?B?UGc0YWpVNFhKcm5qd2xCUzRCTlhUdUI5K2dVY3I5TzY0ZGN5WEtiQVdCMUxJ?=
 =?utf-8?B?NUNKUG5iVU9VOW9Hb3dtbUhPWlRJYWt6QVRnRE5Bb0hGU0JnemNxTEtqblZJ?=
 =?utf-8?B?SlRCZ0UzZURiV1ZDWGpGaTNDUUxBRHJuMDBpNUlKOGVjQ1k3cEQ2YW9lTnJF?=
 =?utf-8?B?WmxXQXNTS2ZMcVpMOG82dnp1NHJVUmhlTHhUc1lTVEJ0ald0d0M3RWFiL1Ju?=
 =?utf-8?B?UjZYZ0ZLMnZhVjhQNTZGT2JCS0NGcXlLOWYvVm1Yc1Q2VU01dkF4VHZIRk5S?=
 =?utf-8?B?aCtESC9rdDA2cUE2NTVzdkdEWG5xajJUWTBRUm9JWG9mTTgwRnpadFpLTkd5?=
 =?utf-8?B?S1gvQjJ5VkUvaGpjSVhmeWVSSW1UMnpuYnJzeSt1RWs5VXNoNzFqb0hZNWdY?=
 =?utf-8?B?OU1nUGsvWTBidTlTN1hRekhibXRrcUZVbTdJL1VUTHQ3WU9tNnU0ZEhZZENz?=
 =?utf-8?B?L0dmbkR4eVV0YnQ1Mk5VY0c0R1h4T3lkRCsyMUZNNmdleDdqZVBsMVVaWUpi?=
 =?utf-8?B?SkVxb0JJekNlNldGTUF0RGpiZmNlOXR1SzF6ZU44U1A3T3A4cjZoMnA3OVVT?=
 =?utf-8?B?bzNldHlTckRWalNmcmtHYzU5MjdsTXBKekIyVGVyS1E1aVdRYko4eVp2aUtj?=
 =?utf-8?B?Sm50cUZRRk5GbVNCM0RRUGNpdWNVWGdXM2FsZzFCNzVCaVV0anNNNUNQU0RM?=
 =?utf-8?B?SUZERWl1RmNITGdrNUdST1FENTZNMGk0dklIYWNqTC9lRXBBRDREalZNUTFl?=
 =?utf-8?B?VlgxV0FyYU5vNVZ3YUxDeGprR1ZhYWRpSm9kNXRTZmFGZHU0UEtkR0VaSWRz?=
 =?utf-8?B?VTJhb2hFWmxXazYzWStFWlFRYkpSRHhpeTZybCtnbFRuYk4rM0tnZWY2TlZM?=
 =?utf-8?B?QTJDOXNJK3c0VVVaR3N2NS9BYzRSdkJiNkJ4cEZPL09EaG9lR1ZPaGd2VlJo?=
 =?utf-8?Q?HstfYTi/TxlcrTwg=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2633ea-715a-4382-f27e-08df30cf2634
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 06:30:36.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gY0NsOM3gUhnEglBAG3IjbJYrgb3tRPVsrzS4x06el8yh7bR7+yjVh6aTHVNu864mu3ASPtk5bDHg6sm8DKz/yDV94O4NoT+linEmRcYJlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MM0P280MB2199

On 2026-10-22 17:49, Roman Gushchin wrote:
> Andreas Larsson <andreas@gaisler.com> writes:
> 
>> Hi Roman,
>>
>> Could you enable Sashiko reviews for sparclinux@vger.kernel.org?
>> Preferred configuration:
>>
>> reply_to = ["author", "list"]
> 
> Hi Andreas,
> 
> Added:
> https://github.com/sashiko-dev/sashiko/commit/bbb84c8e441f9000de69f5a93ccf460cbd5b233d
> 
> I'll roll it out later today/tomorrow.
Thank you!

Cheers,
Andreas

