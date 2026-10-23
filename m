Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.77.78
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747352;
	b=NBZM5tNywMG+XIF9yU5Trg550nR8/jyry5f166TaV+FHbEvGyqm4Ff3/Y6MYa5f+rZ9N
	 ss+mbvhPbBjormsidN1W0Qvn1bIByv7g5yRekCLNcYMMq5+zQuhCtfeNUnqf1ef7QyR8U
	 nVr2AZNKzJ+WyU2QIV8ZXo1Ex3nF+EzEjvhAU3sM7anw56n1uq/7pQQ5MhKhcuKp0kGdD
	 nx3HJLjEC6VjiHB8I8+hGprTbCwStoYhybEj6m741wIok5EdFw7BtMXVzecfJ8527y900
	 d3QtYQOJeefg6Uz00dtYHv8b0JJRixY68sSetgpM6ogPa6tbpxJAEbPwxXgORJNff/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747352;
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
	bh=ZxgyOtelA43xGyCqL3z9foI6VDBnALn1MNcl+ea+qCY=;
	b=qESucO9KYXx/CjNPKvbazqf9v03lBYF+2dNJC0Z7E8HwfDpjXvdwAfa5P4q+b1km6Jnd
	 uPNj3dskn2DIpLkEEZDTSUzGDNukkbtsHOP5HFyTGEfHuo1q9RYUNIROco+XnWwr+JQEx
	 FrqrsQwpexOum1CYTP/+jl9KBwX1F2rDlk+iFds4QofSgYEakwbNRPXbwTOQ6ohqr+NEX
	 i6pYmdGp041SZGN2U9kUHVjLmqwGxKAcLdIHvojSGAFBwzSz5AzuYppuVQ/8KF3l33+Wd
	 /wou1xNExoKj6vdFgyvxi1s2CfAhTFcmQq8QKlBceri5MfVr/Ycfo6E2mue5ETMlDVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=jrLifdb0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.77.78
Received: from MM0P280CU010.outbound.protection.outlook.com (mail-swedensouthazon11022078.outbound.protection.outlook.com [52.101.77.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F274C606A31A;
	Fri, 23 Oct 2026 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=jrLifdb0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMF/nujSRtJR8eXM2vG6K+q3QB2802nqcHAI34mwuQ7lxbDuuscWO6t2vKwXY47emkbmeuOp7Dz328Y1oxOvTbsNW63gWr2+Jx/ySxfMzRrnvW0EsAyR0zr6LIdRR6T3qt5reZbs9SZj2PDk/g7WaFSdkkfUcC9xbbjsokXwB9rrqhqZsdch9inc7GamJgSO2p7h7kgGMgpGF31NwCcFF8ZC155/Jx/yuF5KJFJ7nzWITP8zLuMrsOGyepPAGty0W5zdD5uCMKN9OSjjmu+7b0OgXfxenKZ4if+ThUVi2uDIdd2r19fZyEvGRXzu0/j3XYZyF6mp9/HHiP8NLOV5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxgyOtelA43xGyCqL3z9foI6VDBnALn1MNcl+ea+qCY=;
 b=qmjHLQ1i1yIViO67z1gL3PPqzHjLQuQ6M+V3ZVhCiP0TnqhI83/eNYZltrj37g4zCexpltCiS3q77WwLK4Dhc8/pv+jAbTqGRioXYCvyKMqmwTtaoW09VYJZPD/jzo8VQhHetQAe6O+ivEoqX0MSX7ifFYCxWJf+q+jCGHBbLqzvjf0Y5hqHRSZRjKGcVZCIqLGrsMsb7L7Kq6ANqyLzC3/DSkHn4W2CywmSdKzNqisqbx7jRZE31ycwj6gjVDezSNWBK3ATWJbuvjqJ3aDpEaM/QgEy9dGJyXo3j8pkv2tZnOOdiYXNSPFVYhFWpWBwi7DSXhQrhVyuTyiKGW1XdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxgyOtelA43xGyCqL3z9foI6VDBnALn1MNcl+ea+qCY=;
 b=jrLifdb0G5VsNskyJY3lhIhZHqiRppLglhd40DHQzleMzgA/l6wxTc6JKJDtIyyiTO6DhIW2lby8o/zzX91km/e57BQaMw9/5nHvkBnw02FXZtGWvsh7jPZqJSezQlzdSiB/J4Wf2e/yxMAV2w5wq2+fjE33vCwsuQ8DsGYLV/Qnfu+PkqkWDFR1Pg8Zon8oDnc1xS/1oH/ZI06+Uaijsam8cLxtv+V2gx9PuPKofVJ2QYJV3Rd6UyJSvupahssZMZUS274xucPgGzw4nviIOVjX3ItSmRT2zlA/QW74mmcsx1euWoLWyWDXurNpJOicFKurlZ80TlRkPVaYqhz+Ow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVYP280MB2143.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:22:26 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 09:22:25 +0000
Message-ID: <87800728-48e6-4953-a705-048d38bbf9c7@gaisler.com>
Date: Fri, 23 Oct 2026 11:22:24 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] sparc64: D-cache alias flushing fixes
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1792609488.git.kaloz@kernel.org>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <cover.1792609488.git.kaloz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7c::9) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVYP280MB2143:EE_
X-MS-Office365-Filtering-Correlation-Id: 24f08e9f-84a3-469d-871a-08df30e726c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|11063799006|56012099006|261009223027099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+ovE1zeE64VlKFHBTJErLDa7ybD7Crx8f+LlmEMpcTT+EJRgwqYxvULH62L/2FJR9MfvwaDFAedYyCc9EkWjrv5BApbZieeYp6Hf3S7h9pPuaMrlC6MK7YoLLQ4J0RaCPd0+2fiOazkF8avygyJZgZ9UJTzCoXpqTmk8XHBiyopR7pNTWTAOAQgiaH3buCxt1EApKnuqgWnL40In9IVdPin3NTeu79A2EJsZHHvqDkFeb7Kq8T71VxsbRUT7T5+cWrChXnVe0vnooTOhYxxgnSwOMmv1DnJnhEX7wvHIESgLO0C1qilCE1yOEvGSWLF4ZVvDTYbORg5lv5wCJ0OPz5Ym4LPaIJoo6Ey7OmMN5rKk+TkTd4R5mdmxrR3tVR918C82AYqUPRA2FxAxUOntGOYx3hRhweZ5d8W+M/7vmEkdXGvjjGrfRB1SuVf9bS0r6NgaEFC7N4BvdSYEHwgm4LzWQ828SZM5/njP9L87tkCNENqHFQ7KJID8UM6V1Ke4fVQzKiPQOCZ30RoLx+NrVJFmCvfCk2xbVq796DMqRWgyquKYq/hRVESagsTetpS7MdKRRCyjwZg8APATPU4HZ7QJZlgKQ0pCOvSKY/kOVkVeYGpTQsIKaOH8Hl5gQ0dn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(11063799006)(56012099006)(261009223027099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDcvWStBNE1DNk5YaHR3bTUvTlZBK1duNXY3bmtJaUwrb3h2eDVENFdmVG80?=
 =?utf-8?B?QjhpS2krRGZJWU1UMldxb211bWpZdFlpWGorY2pJVkt5SjN3ekRVc3lCQm1z?=
 =?utf-8?B?RE43b3NzZkxicjdBN1g2SVRvWEZnVnc0U01yejBwV0hwbngvSjg1akN3amZq?=
 =?utf-8?B?U25NaDg3OVk5RFU3cHZkYVIvUDBiUGlKWTRCVXlaa2p5NnNKbzhHMVdPdzEr?=
 =?utf-8?B?NDJ3ZXIzd3U2RVQyZE5DMS9HM0R3VlhJbmhqQzdJQUVNdWdQMkFJUUFTZ3Qr?=
 =?utf-8?B?WGErU1R0SWI1VXphNnk3aXVlQVlZUUx5OUJaa3RETkdCeTVPdzNKVHpiS3Fo?=
 =?utf-8?B?TjF2UWpwc3huK3VyWnhhNmVOQnhmY1dlYVJFOXp0OXQ0STlERzJGM05td2E5?=
 =?utf-8?B?WGFVQm9LZTJzK1N4eStmK2ljdEx0UzhDQWlod29PeG9qVTFCUXpQMVJHWUhL?=
 =?utf-8?B?V0FwS2I0aWFBMmpXSDFqdWhqUmUxdzJCK0tGa0tTTXBja3dTYVNXVEpNR1hS?=
 =?utf-8?B?bnlBNllCWlB6RU9yTzZoRkJSODl0MCtzS2hKdy9MZS8zZmFtN3FBOWt4V3k4?=
 =?utf-8?B?WGhTNUd4bzVrUnRtVnZIUFVkQ0NNbUJzZGE2YVU0d1U5ZlUybnhLN3FJbERV?=
 =?utf-8?B?L2dubllDaFd1RXVwK3pIRngyMmtQWWZpNzhZQ200WWhqc3Y1aUYxMmpvWnN5?=
 =?utf-8?B?Umh4b0kzMDdqS1ZlcHF0c1BIM01tOTR4NlBTSTNqWXpyZkRuZVVzdlVqeUpT?=
 =?utf-8?B?LzlxdGRPa1RyeHhZeXVUSlRkYUNOZ1ptWGFSa3RYL3hVeFNBUnlrajVyMXZp?=
 =?utf-8?B?bjFIeDhPNm5DY0VBd1EvZVpqZDN4QkpQZHQvOFdoWEt4bU40azZhckQ2a2hx?=
 =?utf-8?B?RTg4TVA4amU5aGpHSG5jdFI0S1kxTlVZZ3Y5dGVBSkMzeTRFb1pZOEtxOHEw?=
 =?utf-8?B?QXZPWFY1T1A1TGhzNjFzRzRWZ3MzY0NCd3l4U0pXbkplUEh2bjd1aEFkS2ht?=
 =?utf-8?B?dHEwZURQdjVCcVdRMHRVMWlDcVRWODBIaWFENWFxTlZkbkthWG1xUmkwVGJZ?=
 =?utf-8?B?UmhUOGxxQTJPdm9icGVPYk5VeERweU10ODJyQ2ljMW9EMVRBYzVGdlg3c3Fs?=
 =?utf-8?B?bGNoMmlXeUg0S053U2I5Y25LK1NaZm5kR0dCL0hwQ3VzNjFjbGtYVTFKVm5P?=
 =?utf-8?B?YkQ3bGNINkhURmJwZ3JPYzB1ODltdk5ib2NZUVMyS0xFNlA1Q2QxZ1U4YktD?=
 =?utf-8?B?L3JrR2tYc3dXS1ZVdXNmUk5VMUxrSGUxekkvNWYvcC96S0IrQkhYenhqRlUw?=
 =?utf-8?B?QlM0cTNhNHkxVGZFdXV5NGE3NXRoM2tKSlRHUTAxbW5xUVZCUEZneG9QRGZR?=
 =?utf-8?B?VE9qNUV4UjROVU9tYkFpaG0vbkNtUkJnM1NvRG5iKzFacUt1WkRIelBwb2Nl?=
 =?utf-8?B?ZGtVaURkWUwzMTZkS3FHY0F5UmRNWjRzbVpKTi96Rmh3bDdxeGFsK1VYcDJX?=
 =?utf-8?B?SUVLRVgweUJvMitYdlllV090Z3dkVEQvNnhXai90aGRuNnNjN25ralJ2OTJH?=
 =?utf-8?B?M0J6bW52NEtDbDNFYTFrUUs5dmlybGdqa0N5UVJkcWJxQmswMzRTT1MrSEVq?=
 =?utf-8?B?eTNESHdIWi9FNU5qNjk5aTRBK2p4Z3pqc3cxK1RpYXZWSmV0NDVvb21wK2lR?=
 =?utf-8?B?MUxQMUNzYXNzYWwwYkoxSXUrQm0xOVFvdC9RbjJyckNsdnV0c3cwS3B6QUd4?=
 =?utf-8?B?eGJCdDkzYm43WW1DaDkyNGNoSjJFOVBlZ1FpbTNnN2U5WTYwcE8zak5vRkpw?=
 =?utf-8?B?UE5wOXREL2FjaGE2YUdsMWo3ek9meExCMFU3dWR3ZFR2WUkvSWJNSytTK3pF?=
 =?utf-8?B?eEljQmJNdGxFNFJpK2ZQNjlDQWp6eFA2NlBtM2ZqcmFiWnIwTXNyRGg4QUc0?=
 =?utf-8?B?aUhHa1dGR0ZjVDUwMCsxN3V0aFBoSVFNcmk2NlFHRUNHdFRaSnNHcG1sSVdO?=
 =?utf-8?B?ZWdyNGRicnR1VFdBcVVtaC83UGF2UitndVpNN3J2QVhscnIvUUE4c3RpdUU4?=
 =?utf-8?B?VE0vdUJpbU1DK0RUMnNiMXV1S3lZakZRcXMwOVdTb0h6SVVoQXJhZkRpc004?=
 =?utf-8?B?M0RXanJiaFNrTHVDd3o4cTNFWXVGaVZTRlFJbWQxeURUMXRibCtDVmFFZ1NZ?=
 =?utf-8?B?NWoxc1QvWVFzTDQ2VXV6TGErMHUycTdndGc1K0JxdmxwdnkvcjdES3BMOUpT?=
 =?utf-8?B?a0ZOYXdTM3N1V2M3Z1VnaGZoaFNqSzUxSzVwNzhkMWROS3VIVEl2T3VkT3Zj?=
 =?utf-8?B?M0Q3M0ZqYkRKZTdwd2crZUwzc0hlQWE2NUZKRHpNdFNqZDBRQlQ3aUF4MERO?=
 =?utf-8?Q?S34wxYadsTv9NAxw=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f08e9f-84a3-469d-871a-08df30e726c7
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:22:25.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSnxjoZI6nNdQQzsc1GQ6s3xFfTHXFpNWQRx1X5dnyNboBKg2prK/pYh3/UAaMxOkOxcek5wAsvSqHjEUaY3w0+Mq61i6Mwp8gp2IzLpl34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB2143

On 2026-10-22 01:33, Imre Kaloz wrote:
> These fix D-cache alias flushing on sparc64 CPUs with a virtually
> indexed L1 D-cache (Spitfire and Cheetah).
> 
> 1/4 makes xcall_deliver() bail out before it touches the trap block
> when there is no other CPU to call, so an early cross call, before
> init_IRQ() sets up the mondo blocks, can't end up writing to physical
> address 0.
> 
> 2/4 flushes only the page a PTE maps instead of its whole folio, which
> removes about a million redundant page flushes from a colour-changing
> mremap() of a large folio (7.3 s on a Sun Fire V240).
> 
> 3/4 implements flush_cache_vmap() and flush_cache_vunmap(), which have
> been no-ops. Stale vmalloc lines corrupt BPF programs and module data
> on UltraSPARC III.
> 
> 4/4 passes the number of PTEs to move_pte(), as Andreas suggested. It
> touches mm/mremap.c and include/linux/pgtable.h, so it needs an ack
> from the mm folks.
> 
> 1-3 don't depend on 4 and can go in on their own. 2 and 3 are for
> stable (3 needs 2), 1 and 4 aren't. The series is on top of the sparc
> for-next branch.
> 
> Changes in v3:
> - new 1/4 and 4/4, following Andreas' review
> - 2/4: reworded the message and the move_pte() comment, marked the
>   UP #endif
> - 3/4: reworded the message, dropped the Suggested-by (I have no
>   email address for nsafran1217, the Link credits them), noted the
>   stable dependency on 2/4
> - picked up Stian's and Adrian's Tested-by tags
> 
> v2: https://lore.kernel.org/r/20260928132102.1707-1-kaloz@kernel.org
> 
> Imre Kaloz (4):
>   sparc64: skip the trap block in xcall_deliver() when there is no
>     target
>   sparc64: flush only the aliased page, not its whole folio
>   sparc64: flush vmalloc ranges from the D-cache on map and unmap
>   mm: pass the number of PTEs to move_pte()
> 
>  arch/sparc/include/asm/cacheflush_64.h |  9 ++--
>  arch/sparc/include/asm/pgtable_64.h    | 14 ++++--
>  arch/sparc/kernel/smp_64.c             | 51 +++++++++++++++-----
>  arch/sparc/mm/init_64.c                | 65 ++++++++++++++++++++++++++
>  arch/sparc/mm/tlb.c                    |  2 +-
>  arch/sparc/mm/ultra.S                  | 25 ++++++++++
>  include/linux/pgtable.h                |  2 +-
>  mm/mremap.c                            |  2 +-
>  8 files changed, 148 insertions(+), 22 deletions(-)
> 
> 
> base-commit: 2bc58762a3d74e42de129d717ae3ba10ecf0ab96

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking patches 1-3 to my for-next. I won't pick number 4 up at this
point without confirmation from the mm folks.

Thanks,
Andreas

