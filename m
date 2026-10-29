Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.77.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793257395;
	b=UVrphedBR54IPTZFS9Zhg/2vQ4102bYnI0XtMaH6cSiT2GaoTNTEgcL6JZIqWBq5lbSX
	 URKZ9j5TikO/8SdDEDKojVVNcf8Kb0E4ebtw5wt6SdydmQkCiQtK2m8KjfYvfHCuW69TR
	 aWy6foXcYhssDuqoSldXEiBhL84BX2ZR4q4EtYiMcVxp9SaCHp6HoUACXyLuK+GP+3XQd
	 S8uR/heFISHVGn9Ymcd+ngjpIziNdlh0eEGRrWtKCEXMbVtj2TiTBoUoZF+HGVB5YylC+
	 bNC841qmYA5TrO9+3mH9nPUroSsDTm+CqVy1sFGH2QfwhR+13w/zUutbnvnAmot5hlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257395;
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
	bh=L4qlYw2Ti0xieIbsUiL39i8/aWrBA3ON0FEjWC5kppc=;
	b=fon0JP+8WZjaMTdQOrY22ArBz+oZ/ysP5G+NTFDYPVbAIerna9ad8eYH0WlD2WLSIdVR
	 ZzkpNm2m8jTcM0/yNw1cytn+1jfW8vpb5d5jTV79ydwOWQnrC5trbmPQ4reshlgFKjyUj
	 NO16oy3gwaMufLzKlwSUHhTSnF2dgfVLTVL9SxEIgQ/0sO18/WiZX3q4hQXzlQuFDtaV5
	 fXU5cXHNRlNQ9SCTc4Xe6pyg03j7F+aZT3aJ8wDHcDlsx2Juewk8fgFSWXmWnBlY5N1bN
	 kh03AbTMdveBjicIFkHDJmwViYFTb6+IMQvahGC9nYkao3jFR9MPnMaaGyHBUztaImA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=YlwVzHRz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.77.81
Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022081.outbound.protection.outlook.com [52.101.77.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE0606A31A;
	Thu, 29 Oct 2026 07:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=YlwVzHRz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdO9EgM+1XQYi7py0xkzoSqgawtR5BfnJHu6odcYIJFHzm/pOYyLPWsDBwQj2uPbUPT2H0o6whSCLP9Y/ZErsZrQOJPujN7DCM3QgN4a73tEcUMw2BoTWj7O2wwXgEPbJtoZlzqbIGUpVKQc6spTlUwVENxLcgIjiYnOPBk9PQtKE1QoklsHnWxHi7R/IkVI0s7VRwhIUubaQvgJuNAmKFlzcLZRv2ViH8DShw3uAyoivHyWrA4Utg3VGng1jvBi0uwFjXSa7f7f21m4Q5jIVqxUF7Qxvv8jM6Eva9MfahgXCRaBr3maYWbWDtrPR4ZZvrwVeyBTqtU1XW7BV7RVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4qlYw2Ti0xieIbsUiL39i8/aWrBA3ON0FEjWC5kppc=;
 b=tvYFz17aO2cqUW4QR2KvRA+dQWzFEZ9sxQS78m9OMPDyP0uZBbDbmLPR8lk4oUD+xtpta/HY3oNiqVu4FOG0T8Kchi1Ehpz+C/3w1DfN22thx2bxCN1n0aybIHLmB++IffKz07pLkwoqje4w6hAXbMqczg/3nIRKl0DgP1OxXd/DKDDrP4tP5DEZu3uRUmp4dHZNFw6Sd451qijCSOFW92ag5y7punYZNdJVT1bH+LZwcfTCTZY8lsTdK4SBIs6Jbhj+/8sKAPSYedh0NGu10jAKLpNadkrNB7LY+1iw5kmPP24cI1Mn2bnavDbpvJTrfFYNfG6YFz3MEVDiNm9nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L4qlYw2Ti0xieIbsUiL39i8/aWrBA3ON0FEjWC5kppc=;
 b=YlwVzHRzp6svJ56Y8i5E67ZGTfPSh9GzjCYMI+hRjfoGrxaVeQ8vO3681j0JA8gSbUHjztxscJA0XrbNtjyRtA+IkDgIMXrCBiw2llzkqx4rhjjB+K+OZD734flT+gt36DWBYCxwzn2P/ZOPyC3a/TuelpQDl8139qtwyMqRbXv9tUv7OaQZRsPfZi3F6rjR2KU5kjKUGga8XewJgEY5cK16t7eDZp/HxOZlyz9Pm3WnksBS6poIJrSom4SKwtyUf7OVCMxYuBaFIYYzduH8jlB0J5hfJ4RGKNnAvqRq2u8pPKKiQfCCgeM26z31AF7Nt0VMcLGsgzmAtpFBVvSNLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB0126.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:1b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 07:03:08 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 07:03:07 +0000
Message-ID: <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com>
Date: Thu, 29 Oct 2026 08:03:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] sparc updates for v7.4
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::17) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB0126:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a0d842-2251-4556-0bc3-08df358aaf85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|261028144727099003|11063799006|4143699003|56012099006|261009223027099003|261022115727099003|261026121527099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|10067099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	yqaqou2WaeHkpSOCfrhNxbfa1FKJFUvi8fsT/EBoVLV6+ck21MOZw/II7So44YOTKDwqW3yahpHyTPYTNQMOyHV71+4s9taDs7pNXbsFbD5k6MLMpCDRtHuZQKqJAlFQFJ3widroX7quhUew8xJyq4xGrWGuDnayKsyGbE77PedzxbODq5RUHfqgU04IHeq1a7I1pjmSteJYl1ztEcTVjQ3i4oQDinhBgl/0KeD7Epq9h9Ee6zizTCA/NSxPkougS77Ac/+9nUFFuIw/0NqH2gnophkj1fTciDC0TLaiHleI0yjCcEBOQclEe1M2A2r68NNAM4aUVRBFTxFABXbKiHoTw4AG8vnJcJ6nVZp2IDXBPUHBd3YIzbVvbMzr2+Qu3NznNFIr1nV1N54z+xNLfdppcz7nRC9MqUDxzO0/0+GcY0EkeXVPzomqoFC01/IF7W+K6U2GOyJwbzGPR+d/sqA2tfEDwuJxEk/02YphSQKs/jXxnCVA8y6QSXJ3/RkqD/PZAQu7SM/qQGbkJRRrVAmzpPrrYRzdKiCb/NH0mT5LST0wPWlOZVc+GIL0ZKU2V7ku8Sv7is387HTtpqMenLXp13r0SyAXe+W9ihsQ+AYA1x1uf9axvpryTfYbzdsSPXY10iSaGpSVdRbzblY5vmTbZgn4zG80vbrmp+Pek1k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(261028144727099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261022115727099003)(261026121527099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(10067099003)(261022075727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGh4VHVwc0Z0UmIzRnd3SDBRSEd2TlZzVC9aYzVnUHB5MXo5aTN5dHpyaDdB?=
 =?utf-8?B?VW1abWFONjQwd3pkdkhSV1ZUOVZqSDY4amYxdVFUZU1QUzl0WlM4MHE3dXl0?=
 =?utf-8?B?SUlGa1NIZFNQdERBdU1EeXdUajYzVlZJVllvTGJVNUVjeEJOTEovSjhoZzdh?=
 =?utf-8?B?OWhOUG5PaXN5aU5BSTMycWNIcHhqR1diS3VPNU5OSklySEJ4VG0zakl3RUdK?=
 =?utf-8?B?aFEyYUgwdVZkWEZkMEErK2pLYy9oZEVkZ01rNFY4a3A1NWVYaXFSQTdQSGNY?=
 =?utf-8?B?dGcvdk5nN2FLVlQ1Zzd6VEYxamg1cGNTbEhaR0VlcVFPS3lEd0lDOG44aDhO?=
 =?utf-8?B?YkQvQkJTV2laK1F6TXRQaWY4RmJ4UW0vZFcwWUJvVlYrbTN6aWFCcnF5NFdz?=
 =?utf-8?B?VDhVUXdvZjRaRHhWeHdoQ0xkdVdiV3gxdHpqVEFoVlZoWU5lUmRpS2t5ekJQ?=
 =?utf-8?B?NlNzR2hXdGNkZDJaUXEyZThXZktGbTRLVDJrK3pLdDlxZk4ycXpZc1B2cXd1?=
 =?utf-8?B?MFNHWEE1bHdCbG4rVU11ZW9zcmpOVHpFZ21abWtiTHJiS1MxV2hsZ1VvZDgx?=
 =?utf-8?B?QVpFSC9BL2wzTWoyNHFTTXlteEJnU1l0UWVvRG9COGhBbzNaMHhDVjR5a2xp?=
 =?utf-8?B?R2dXdnd5djZnOGZFaVhWNU1VcElkUmFqSVN0dHIzb1dBQ2NEdlNXNGZPYW5a?=
 =?utf-8?B?U3ZOd1p0VU45ZXJyaWQ0QWcxc2g3OVlaSlRvVm9Jdlk5T1JMOC9Qdk1tNHov?=
 =?utf-8?B?S29JU3c0bVYrNGNVM0tWb250MmUvQUtMR3dQc3ZSWU5INHZGeDZQazFLdjd6?=
 =?utf-8?B?eWRkOEFGZ2VyaDRJSnJSb1BZNjFhUDZ1KzltMU1sbFAzOHVtVGpCZi83STAw?=
 =?utf-8?B?MUs1MjI5bnV6aDFwUXBzbUVFU1FIWUJCVGk2OTlSREtDc1dzMmtyTzFzdWlS?=
 =?utf-8?B?UXVaZnV3NVpQVFljQUhtRzdiTExZTXIrYU5OSlJDbDQ3eDd0WWs1bzVGQlht?=
 =?utf-8?B?NDk1SW1GV1EwTGVjWGZ2SjhNR0l3S0VSb2piVFhEVW9Vb3p5N3NHMzJnd2Y0?=
 =?utf-8?B?Y20zdDBxc21IMmMvRjRSenFEaGFNb2JJNXdlbk9HY1IxSDZuaXhCR0JFdm1P?=
 =?utf-8?B?dDVYSTV1MlRuUmZKb0s4cGhFWmlpcVBnWWc3RUdHYSsyS050dWtXUTZ6NHFR?=
 =?utf-8?B?WDN0dlUyS1Q5dlYybjhneHVIV01XaU90bkFqU0RtZHc2TUpMV1ljYzlvZThN?=
 =?utf-8?B?dHdQVVNSRUNFZ0lqSnhWbUdVa1VXbmJhR1h2SGNYT1ZtZ1YwSm82bEoxVzJm?=
 =?utf-8?B?MTQ2cGE0VU5hdG14cUhVU2FaOG9vOFl2anFSbzBydUoxKzRVUG9yWENBajR1?=
 =?utf-8?B?dFdNKzVqaWVmaTVzQnE3Ump6aVREc3FqK3NsQjF5V3dZaHVRSXZWQWZtYUEy?=
 =?utf-8?B?SGJ2dks4Z2tnOTQ3aGhpSEs1MHljM1k3M045a0NneE5JNTRTVzhycTI3L2VK?=
 =?utf-8?B?SUwwbUNtWXFMa1FMUkVjY1daSDJYY3VGZG5RbnVzYWVCVnF6T1E0QkNNNGlG?=
 =?utf-8?B?QW1jdktBUDRYaXBlZHd4R04wTWIrc24zSmhDdEhXMkk1d1g3d1FhdmFqNzJN?=
 =?utf-8?B?cG40eHVFUGtVQ3lxRlhNT09CWXAzNzJ4VDlEQUhPTkFsbTd3SmNJUi80NEwz?=
 =?utf-8?B?TVRtZmFmZWd4Z3MwNnN0V1JHMXFHODU1MS83ZS9KMkVTY2lzSkkzdU83OXdT?=
 =?utf-8?B?dUphN1dLdXdlbTFvcVU2ZmlKYUFkUTBja1lCQStsWGl0RUNmQmFNOFRVVzY5?=
 =?utf-8?B?MnBvQk9qRUhzN29US3NPOXpsb3ZiK3JZNGVMUEQvdExUd09TSUVjM0tFY0Ni?=
 =?utf-8?B?dmd2Y3pBSytLemVHbkZVeEw1dWtaNXNKdjNpdzMyTUdiQXJReS8xYkRzb2py?=
 =?utf-8?B?THVEVFNIaGVPNkFycFNKSXdRNzlGS1FaS1ZyODh0M3hEUnZDUFJGK2dYL3pq?=
 =?utf-8?B?dzVJbWZFZVdmRWpudG5USnB5WTBxczhhTE9wQmlobmdkUUs2T2VFZ1VyV05k?=
 =?utf-8?B?ZmZWT0d1a2c1aEViUnBZNmN4SnlBQjZwa05JaTNVam9rUnYyVU9MaE9URHRa?=
 =?utf-8?B?K0VSMzlDcEg4ZWxaRzBKQi9JUE1yTUZjQTFJSWJRZXM0YWxmeC9MbytRWG9m?=
 =?utf-8?B?NEcxMGRQVFJ0ZE1GN01IdG43bE5xemVMMkh3TEVrNmdxdFovUWFEMk81eEY3?=
 =?utf-8?B?QytpWFN1ZTdOVkxYS0hUdTVSZmZHWG9NL281djF0a0w2Rjd3SGtkTExYbVM3?=
 =?utf-8?B?bk54Y1pQTmMxZUNOMWVleFplQ2QxS1VzRUQ5bzB0Y3E1UGVSUlIxSWN5NW1I?=
 =?utf-8?Q?HxH5PZ5mRrvndQAI=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a0d842-2251-4556-0bc3-08df358aaf85
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 07:03:07.7943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8vWsMCwsiw3CmzoLBp1EfBnjZ+jrnyxKzYcj19xR1h8rIeHErk2OEk7B3mPb0A+/IHZxf1cJ8VJh0nRU8ToPHFKwgpw2pMC8gnSBFSOIJQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0126

On 2026-10-28 18:03, Linus Torvalds wrote:
> On Wed, 28 Oct 2026 at 03:44, Andreas Larsson <andreas@gaisler.com> wrote:
>>
>> This includes the following changes related to sparc for v7.4:
> 
> Send them for 7.5
> 
> This is the second week, and the commits are all apparently basically
> just a couple of hours before your pull request.
> 
> The merge window is for things that were ready before the merge
> window, not for hurried last-minute updates.
Hi Linus,

I got a late Tested-by for one of the patches, "sparc64: increase kernel
thread stack size to 32K" that I picked up already 2026-09-27, that I
inserted just before preparing the pull request. Sorry about that. Apart
from that added Tested-by, all changes has been on my for-next since
2026-10-23, and most much longer than that, and with that included in
linux-next.

Below follows a pull request for my original for-next before the added
Tested-by. I hope you can take either my original pull request with my
explanation of the one below if you rather want to have commit dates
that better represents when they were picked up.


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-7.4-tag2

for you to fetch changes up to d957b367d560c4a74637d400ca4e0e63bbdfbcd1:

  sparc64: flush vmalloc ranges from the D-cache on map and unmap (2026-10-23 11:40:02 +0200)

----------------------------------------------------------------
This includes the following changes related to sparc for v7.4:

- Allow loading sparc32 kernels on Sun machines away from start of RAM

- Fix timer comparator problem for sparc64 resulting in RCU stalls

- Increase kernel thread stack size for sparc64

- Fix bug in fault handling during window fill for sparc64

- Fix bug in vmalloc fault handling for sparc32

- Fix fault address reporting bugs for both sparc32 and sparc64

- Use membanks for early memory setup, removing legacy sp_banks construction for
  sparc32

- Add seccomp filter support for sparc64 and seccomp support for sparc32

- Fix problem with nested tick interrupts and IPIs leading to stack overflow for
  sparc32

- Fix missing cache flushes as well as optimise away redundant cache flushes for
  sparc64

- Clean up dead/unnecessary code and obsolete comments

----------------------------------------------------------------
Imre Kaloz (4):
      sparc32: keep PIL raised on the SMP ticker and LEON IPI exit paths
      sparc64: skip the trap block in xcall_deliver() when there is no target
      sparc64: flush only the aliased page, not its whole folio
      sparc64: flush vmalloc ranges from the D-cache on map and unmap

Ludwig Rydberg (5):
      sparc32: Split common syscall_trace() to syscall_trace_{enter|leave}()
      sparc32: add seccomp filter support
      selftests/seccomp: add sparc32 support
      sparc32: Avoid NULL pointer dereference in fault handler
      sparc32: Fix pgd lookup in vmalloc fault handling

Magnus Lindholm (9):
      sparc32: honour phys_base in the viking cache flush routines
      sparc32: derive phys_base from the PAGE_OFFSET mapping
      sparc32: advertise relocatable kernel with HdrS 0x0300
      sparc32: use memblock when mapping the kernel
      sparc32: use memblock to find available system memory
      sparc32: populate memblock from the PROM memory map
      sparc32: drop unused valid address bitmap
      sparc32: move early memory setup to setup_arch
      sparc32: drop sp_banks

Manuel Ebner (1):
      sparc: NMI: Remove obsolete comment

Sang-Heon Jeon (1):
      sparc32: remove redundant memset in srmmu_nocache_init()

Stian Halseth (6):
      sparc64: remove dead THREAD_SIZE branches for non-8K pages
      sparc64: restore %asi in user_rtt_fill_fixup_common
      sparc64: use the fault address for si_addr on window fixup faults
      sparc64: decide the TSB huge-page window fixup before the bank switch
      sparc64: add seccomp filter support
      selftests/seccomp: add sparc64 support

Tony Rodriguez (2):
      sparc64: Fix comparator problem with timer interrupts
      sparc64: increase kernel thread stack size to 32K

 arch/sparc/Kconfig                            |   2 +-
 arch/sparc/include/asm/cacheflush_64.h        |   9 +-
 arch/sparc/include/asm/highmem.h              |   3 -
 arch/sparc/include/asm/leon.h                 |   2 +-
 arch/sparc/include/asm/page_32.h              |  16 ---
 arch/sparc/include/asm/pgtable_32.h           |   3 +-
 arch/sparc/include/asm/pgtable_64.h           |   8 +-
 arch/sparc/include/asm/pgtsrmmu.h             |   1 -
 arch/sparc/include/asm/seccomp.h              |  15 +++
 arch/sparc/include/asm/syscall.h              |  11 +-
 arch/sparc/include/asm/thread_info_32.h       |   2 +
 arch/sparc/include/asm/thread_info_64.h       |  15 +--
 arch/sparc/kernel/entry.S                     |  42 ++++---
 arch/sparc/kernel/entry.h                     |   2 +-
 arch/sparc/kernel/head_32.S                   |   2 +-
 arch/sparc/kernel/kernel.h                    |   3 +-
 arch/sparc/kernel/nmi.c                       |   2 +-
 arch/sparc/kernel/ptrace_32.c                 |  26 ++--
 arch/sparc/kernel/ptrace_64.c                 |  28 +++--
 arch/sparc/kernel/setup_32.c                  |  91 +++++++++++---
 arch/sparc/kernel/smp_64.c                    |  51 ++++++--
 arch/sparc/kernel/syscalls.S                  |  28 ++++-
 arch/sparc/kernel/time_64.c                   |   6 +-
 arch/sparc/kernel/tsb.S                       |  24 +++-
 arch/sparc/kernel/urtt_fill.S                 |  10 ++
 arch/sparc/mm/fault_32.c                      |  32 ++---
 arch/sparc/mm/fault_64.c                      |   9 ++
 arch/sparc/mm/init_32.c                       | 167 +-------------------------
 arch/sparc/mm/init_64.c                       |  65 ++++++++++
 arch/sparc/mm/leon_mm.c                       |   1 +
 arch/sparc/mm/srmmu.c                         |  70 ++++-------
 arch/sparc/mm/tlb.c                           |   2 +-
 arch/sparc/mm/ultra.S                         |  25 ++++
 arch/sparc/mm/viking.S                        |   6 +
 arch/sparc/prom/memory.c                      |  51 ++------
 tools/testing/selftests/seccomp/seccomp_bpf.c |  52 ++++++++
 36 files changed, 481 insertions(+), 401 deletions(-)

Thanks,
Andreas

