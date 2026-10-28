Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.81.83
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793195875;
	b=Lj6p1wQ7i2ctdt56jrfaIgfbWr8IlJjO0tY8/hd+fgslgnzb3AMlKOnqbcv4fNEf11ae
	 n72FePj/5mVNksxHhIsZSvJC+ZCy8vaI1XYga56Zc9v3SjNjFs0S+cqYidB4Pc0DNf7DY
	 sEML7Esy0mSYtDotwcIXtO2yPalLJtZ2cI0j/n7D9fWICR6Bauymjk3dfNnYAuQfpkBPB
	 y5fSFiuTEbzvKfq6snNoJnoKw2sDsC8q2bWF4QDNSdJiU1i3hTc3E1XvnUfVqOHDSMLwF
	 J4MCCMQjqI0j4aG5lvS7/X9WqZNU0bDT1su3RsXZVzoBJ9nMxsV/70MFwqoZddgEqEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195875;
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
	bh=72OYvPkFZEiBXA3gv1T9FkftvGaDvZswkoPPxva4QR8=;
	b=BP661q4/B6QxkCOV4t5yrskhR6tiiegK+syLNF0nJ/Ck0bZB3ohvCUR8swqM3IYP10/m
	 TEYzq8egshgdn9Q8ZZHT3Wb1GwP5gQwlJyc0s1lauHZsBuxn/N4uN0x78dSDlZP1rgEfY
	 2hDAzXX7MqssEbzWqx/FN3R17EFEaBX0Vq5zlWkkm6nJoP04cLClp9uV1XpKDrfGJpy8a
	 +hwfIp0T9FGx6hsJ+WwXBE+h9+ZRadmXYJvZWyBanO3/dK1U6KsH4Kw2f7WCfJEDPvYXd
	 U00H0Ub4/LMocjzK6NDhnmT/89RVr3VWk9O4JuLUlRJ49/qJoMBwnKavcCLQYZMWDXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b="uCYVLo/X";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.81.83
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11021083.outbound.protection.outlook.com [52.101.81.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFAA606A32C;
	Wed, 28 Oct 2026 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=uCYVLo/X
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgpLvpYDCdsoQwua6fwZoyxbUcoMMbkY9QBfLL6toFYN5V6a2NHHhAFzYC3pPXPWfa1MPR1cToKwFBmMUtn420oCyh4N0h/GoCGAEdahJeucdkz1k9NfYN2yT8FtF69PhhAOtwPOrboeSkx5GcACIVoi+pejqYNGEtyz+KebLTlE0WxX5GhcXHLoKS6/Cosu8N3PYF96+JbL/dk1OynOQJmNijG1hAvUyuoMTdkfZZI9tK61bUTncAr+9EIYwywkChnXlERQf0Zhi7qmwWSVud+0C+tHSJhsKDOAgG2VOi98wPQGVwGRGeiN4zI1wXjHENJHL19a8n9Y4c2EVCSuhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72OYvPkFZEiBXA3gv1T9FkftvGaDvZswkoPPxva4QR8=;
 b=C6oXw0lXQVnvdn+Zg2UxjC3EEdo74t8oU3qDte4uWo31BZCdIvAv4PDrXNF2f/TdpJBHTz8PSMh4tB0FosuXedVVYEEohOwjaj3GD7k46TpQWqfIbr5gErjVXLOOhwwc5LB7M/Hxtw8E4Kq8TVneKOu1gu41+tQ+emrMLkFKWVuXc4sl1nzizDQDPwwLcahvSbg9pYy8sW0P6FslQZ0Q3UxZQGVFWdu3englL9fFeJhmbkR2sbpuh1vkBnZcIJlCGbj911hxzcgnN7kQIcVo/AZBQ5TCHzNovP24WcFzBSaUR4pZOB3y95TiWVU+tGiSSeBq/g6OVtrhaW61nFMnlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72OYvPkFZEiBXA3gv1T9FkftvGaDvZswkoPPxva4QR8=;
 b=uCYVLo/XQWpRLDe/ci1BAEOsNx1zaJ51WNGbbYDje79WTUkL7YgH9By3avczn+CeWcx4B7FPi3vhaZMPlfWcefSdtQURNoU5HZkH7h3QsBjlDpazt0CQwfA2tXyBLHvBCd4qeQB1dEoIwg7+5Tp1+mE9jPh/k2QTvnZdt77jLZoIw5bhdPSGYTsBch4NjgpoTcL6CSlnJ1DMgRs/U8qsi0ESI1Yod4ktY+q9epEixIbJwB3gBs7q3KER7SeU+jA1Mcqka4pWR427wLU+5F5s6Qh2WVyYBgwXZDf/n3SuRQr1YjNlDDz4DaoKxQ09qnmcJ3euUZf6QKqKTHgKtNpRvw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB1845.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:247::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.23; Wed, 28 Oct
 2026 13:57:47 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:57:47 +0000
Message-ID: <4fba060e-c4f4-4d73-8efe-dbed0b5a7bc3@gaisler.com>
Date: Wed, 28 Oct 2026 14:57:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: pass the number of PTEs to move_pte()
To: Imre Kaloz <kaloz@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Magnus Lindholm <linmag7@gmail.com>
References: <cover.1792609488.git.kaloz@kernel.org>
 <2bc50d2a6829b49ee909e5bb943244859661a40b.1792609488.git.kaloz@kernel.org>
 <409079fe-ab52-4389-9fe0-d7246eb27bad@kernel.org>
 <20261027212610.6798-1-kaloz@kernel.org>
 <dfe06aef-540a-4450-88ba-300a460007b7@kernel.org>
 <20261028091631.8072-1-kaloz@kernel.org>
 <25f5cbed-9126-4870-a81e-65099155bc9d@kernel.org>
 <20261028101719.11918-1-kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20261028101719.11918-1-kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0092.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::13) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB1845:EE_
X-MS-Office365-Filtering-Correlation-Id: 620d63b7-54c6-4bb4-c9ee-08df34fb7246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|4143699003|11063799006|56012099006|261022105027099003|261026121527099003|261026140227099003|261021121427099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lUJ9+laX4nOg00kxmrRAH3ppL37QC7T77ySVfo9IrduztyxIMARXO/ogt7AWlBNu/57dcdI6/9KxaGYwAFa9CCEkoYQvpWHaVYkLNkBxKKTVQp51P9L7MZKPskqvJD+ceoYw/pAzudVYZxNCwKrot+JoomvBaqWQ2gwswEljAstxSGuXZtdMHPJMgghjGyaRWPCwy4LwHUeh77Dw4nVZobp6JShO1p7DsGy7Fvg+epdLUloE1pFKiIgRrVFR6j9USGb5lC8dvs6jxOiMn1l8cnQhFB5B80cIzMoIA3V0RZkwiJg2/q1+8a1quD6KqkoBIVzfJzk1sHiZWQHK62DB32bARDvzjRHowhULFq9u7kVsnBaZWtVnYdranM/AzjTvVvLXimnMejgtSEgUbOaWXZrauGCwD+xcO83BsOaZAqL0rhV38b9zKmBtdUqfQGFhw1QCugk7kswxENm4g8/OsZlgaSZkDrZJaSIeWr4PsvK6C4Kf56GOLnaHHP0I6ZyVYcZKVK0xrQl9GkuTvujOcSQ/n4rXoxPjOrIOLWsq9na+5fyx/EaYd8O9jTRvt1karKIcHfqEXnLxmnpumH1RT/h9YOxHgX6ugJSDmPQkE25WRwdauCamcHSCDYRsg49v5FtmjxKq3cTBMv9EgvcSX5YhxCqk/AjSIcgW2cu41bU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXlJTENCL1RyZHdxcE5QWXhpMHoyL1BFcjYxSDgxMCtzK0ZURlBDNlRWdm42?=
 =?utf-8?B?bGc0QktMRjhYOXZKU1JiUm45eTl1L0RYMlJjelpHOExuLzl6ekwxdWo2Tlo0?=
 =?utf-8?B?cnNzZ09LZk5pQ3kzdVpOSkkzaXhSalM3eFNMV2ZKQnJETGJVaFY3L0xQQnVM?=
 =?utf-8?B?UFVycHdGS1ZhazZONXFmU2dIcWtQRHc5bkxlbHhvOU1LTkRSSzJWSVFaZyts?=
 =?utf-8?B?YWhpVDlwZG9uTFJ0YkFPTzQ1U212YnoyYVQrdHVUR0xiQVAvQ3NKWFNENEhh?=
 =?utf-8?B?VlF6U0N1ZjZkQW1ueEtRTEtTdSt6ME82Mmc1TnZOczNpK2FqalhvVlJEck5Z?=
 =?utf-8?B?cGJQUlBnZ3BNOTh5VzRqZ29DN3lidUxqZVdNL1RpUlM0UElLNGljR2hVaE8v?=
 =?utf-8?B?RFBtUUduaGVzTHo4WlFlT2NpemtXTzNiMHUwQUNFTWswZkpnb2FIeTNHM3hB?=
 =?utf-8?B?ajVLRGNJcVpLU1VKbHpQN3NYYUtHbm1JR3lDdDl1bGIxNjFjMjQzSkxwc3hL?=
 =?utf-8?B?MFU0eXFFTXRxQnp6MVB6MjlJNTBvMTh6QTcvMTV1dEtDKzZaRzZOdTRNd203?=
 =?utf-8?B?eHo3ejJoWC9lRTYvK1oxS3JnTms4T1I4Y3luY1E3WVZUSENhRDdGOEJMWGs0?=
 =?utf-8?B?c0doVFlBNUhSSlgxZS9DMUhVL2hPbG9nRGoxWmx4WlZxdXg0a1gvaHF3NnBC?=
 =?utf-8?B?STNuTnNva0RBUUZLTExZM1BWMVA3WWR4TDhrblVRd0E3eTdzTFFKbUVuYlIv?=
 =?utf-8?B?THJnYWxWRlRoNDNhM0E4cGlpYlg1NTFVWG0rNS9NbTA5amdVOVMrME0xTFdO?=
 =?utf-8?B?dk1QUUgvWElqR1dGNHpZVE5iREJXNWoyVHZ5Zmg0QlJrWURhRXdGd2c3RndU?=
 =?utf-8?B?eEF4cnhmdWsrUktIc2FtWXl5VHNlOFZSNVNxKzlYUnEzZ2pqMXR5dEN6Z1Ey?=
 =?utf-8?B?RGNkSHgyWFZmajRaN0MzRlN2MlF0aHhIM285S24rVUtHOUw0azFUTmYyaG1s?=
 =?utf-8?B?b0pFN2ZPMC9KTlMwdldxaXJHZHZKb0s3UjU2R3Zub3Q0WFlOUUZrVTg4RTlq?=
 =?utf-8?B?VXdJOFh1TjRtY0JpaThqK3VobWxIZWRSZmpVZEYxSUNJTXI1a2pSNUM3R1Nv?=
 =?utf-8?B?ZWFVa3JRQ3ROVEhjdVJMcWNmbjNqYXQvYmVENnBSTGdCbFJuM2plQTRxT043?=
 =?utf-8?B?ZVVzR2pjejB2Rnp1YUJnQ3crTzBPbXl2NmdOaXZJc0t6YXVSY0V4QjhMY2V3?=
 =?utf-8?B?YVhObmkzYTVvblptRVBRV1dtOUliY2Z0M1VPSTRXN3VPUm11SENCaEpoK2Ro?=
 =?utf-8?B?MWtSYTE0b2sxRWZPZytqVTFDMUNQNjlXSmhIbnRMdHBxTytXd2ZsQlBXaW9G?=
 =?utf-8?B?ODZuVW1wZ2NDaFlpdERnRnk2SG80ZXZKRng0SEh5UEd0eER1cElhYVk0WEM5?=
 =?utf-8?B?bFBZaDgrZTZ6YnZsMDQzVjA0L2d5QXpsOHJUdmV2cDFQY2JlQkdQemNGcDVK?=
 =?utf-8?B?YnZQQjVmWHpRUFBxaUJFWHdMV3AwNERDSnBpTGt1TTErMlVtaUwxcWswMk5R?=
 =?utf-8?B?NHRyTXlDdVFqM2U2VC94WFN2RUJ1aTVrd3hnM1h3MGlqK1k0a2dzQStrU3Vj?=
 =?utf-8?B?aHVDNjRqRnpiVHRxR0ptdHJVZGFpL2Y3RmpuZDVmWXhFVUNsU1JIVWRYOUtX?=
 =?utf-8?B?WTlScDJ1U1JXQVRROWZnRlZiUzBUWW52ZWRBUDh5THA0MVZmSEFoZDV5SEdG?=
 =?utf-8?B?UWhIVmpNLzVNSG1OT1NFUGNVSnVQMS9oTnFIQTlKTkRacmlJVWZkQ0JlMXFh?=
 =?utf-8?B?ZVZaQkdKU0lneHlkc3VkMTdaTUQxMnBaNHZ3VGJpTkppZUN2Y1NTK2s1N3o4?=
 =?utf-8?B?R0dUS0xQd21NTzNQZjROU3hvTWY4OUNZYWVBU0VmTlZSR1RsMFIwSTNiaXha?=
 =?utf-8?B?bzFSamJkSEdKbk42V1o2bEY5UVBNUThYYi9NOW91clZzd29jemdKTGM2YVZN?=
 =?utf-8?B?S2xIYVVSTWw3TllpVXVvQ3RvRGlVb05uMGN5QWVic0g4cm9WVkh3OFBEWlJE?=
 =?utf-8?B?QzZBZmg1SUNGaVpoZm8xbGJTSFdPK1pzNXdOeXVOWmhKWWM5dFZtR1NQZVdQ?=
 =?utf-8?B?SmN2ek84YkQ2NFlnRGdob2V5STcwWm9rdlNoWnFRY2FGZytyUERrKzk4Y2Z4?=
 =?utf-8?B?RVBML2p2TFVKVHg5RGJ1eHkrRXpCejUrQ3JzVExsSDJPbThEM1BGcDNzME9p?=
 =?utf-8?B?Ry9kUlRPbkN6Qld4RlowZER0enFLS2wzRDdmcjEwcDB0WFo2aVBXYXJVRVVk?=
 =?utf-8?B?THZ0V0FyTjkyUmZuMWZqWW91WkxBWlVPczZXMHl4Q0cwR0xtUTJIT2hvejNU?=
 =?utf-8?Q?oP45irVO38QEa9cI=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620d63b7-54c6-4bb4-c9ee-08df34fb7246
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:57:46.9585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYKjrkGfo2lThrEUumrs/3I1IgZ6QFE1dko722Ti4cHEV5mKW+XEJAONeZfqBwh/GSJODrz3WfBLr/obFhHiIIeoUZ4NxHZfQBMg8CZIsOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1845

On 2026-10-28 11:17, Imre Kaloz wrote:
>> The biggest problem all of us with supporting old hardware is the maintanance
>> cost. Not just core-mm, but also things like ad-hoc page table walkers you are
>> adding we (from core-mm) might have to touch at some point.
>>
>> If there is no good reason for the complexity, out it goes.
>>
>> Because otherwise people will push more and more for removing legacy support
>> completely, and that's not what you want, right?
> 
> Definitely not. Fair point, I was only looking at it from the sparc
> side, and keeping these platforms cheap to carry matters more than a
> few percent on reclaim. B it is, then; it's below the scissors, on top
> of 1/4-3/4. Thanks for taking the time to go through this!
> 
> Andreas, if David is happy with it, would you take it in place of 4/4?
I'm open to a solution like that, but it'll have to wait for the next
round as we are far too far into the merge window. Patch 3 stands on its
own legs as a bugfix in the current context. So send it as a separate
patch.

Cheers,
Andreas

