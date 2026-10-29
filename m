Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.81.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793267422;
	b=hbRU+qcyNcTeZchHCJC1qwc8aEx7DmaJMbjSqEeNMOR6ZZD5IzqPIq45ttXL6b0QdmdJ
	 XOIxHpUwaKQHwm23ongg+ulBXT9jXohumEVJnxGKKD4SPw19TeicUM8tWOAya/9wKrdCn
	 lhInmqhk1pce4s+sjzYhiBh/CB78eTVWe/FEzzi2seHKnUYXC5lW7ea04CH3OJFkKFcoE
	 +ELkzzbyaGdJqUULLKxNhx4d0qPBRKFFS2VgI/ff+Ff6nmrjDsMixoJL11d681z7H/eIC
	 qOAeGSYQ+I8mIbMQcRPw9NECkz29XS2iE4/gMoNI+3Ng+mKEPkBORrsVVLMSHd0s1Pw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267422;
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
	bh=Ewft9o9cieV80iEeL7ucfCXiIk1nmyvrcj96ULYeWQY=;
	b=OItailw230u1Kd9kwmdMYdDwbuAUr2zRX+92PFQF5yI7dcQhL26iUhF5ln+zsJRdtXO4
	 F59Fu/qdjxU3a/dqgVnbVSndOA5Vccaj8e7nM8VyVsyTJlPd2Q7fstTqSbAYZki5OSirb
	 gHv7nCSq/GseU+9CpUEu26GahXng9ga5KgnkBFO/cD/c5UASc+AZGNZ4BnHJ7knqxbDA3
	 rro3EJDWrha+spNQLo0KsZOAt5j10TH/K83p53Atj1JMCB+g6Rz4VHufDbw1LWtX0rENK
	 HQpEJLZz5/2NZyXRaypdLBFrg4c5KbSinIEbqle/q+oyVrJPlJdsSW6C9b5qw2BYBlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=SVkENcn2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.81.142
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11021142.outbound.protection.outlook.com [52.101.81.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56744606A31E;
	Thu, 29 Oct 2026 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=SVkENcn2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1rbFes661xRKwL9LtDsoTSMMa0gK+8plw1rPpf+8MP/hyJuVygoOUwL93iUI4IRwIJijGuzagTaeeVEtTsSjdKchcTnNrzozwjmZRUiiuX5pM0dag0ukU8QeDMnG+/Gc0v2HOLb5FpMLIeKhR4OuBR+LSo8Ipqd/bfw2ltP6vkJTcLk6rgbOpfXWHM4sZEIuj8US4RoVgHOAhujA68JClXqoq+QX4KgMuXSJOdNMflP5v1R2gYKOV9geRc9U/6BvWxo6IxrZYbPwY2tFrNafm7efxYz8rTgwfn52dCTjNGXZa+EOCjmm7cQV/VNbw84PtZIIHyo7lnDUozzg5FGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ewft9o9cieV80iEeL7ucfCXiIk1nmyvrcj96ULYeWQY=;
 b=g0ZD947GDpdeAoXKHZsaP24s9+V/fJ3RzjhNMWjkKJP+qaJ1gA8cQ8T4sNISuwn9eg2rXLA42h5BtSwBIGFt2o2mQTB0ySpBvGp1u4e64yI5u0YKzi79Atu8jP4zeMtv7zmz9rIVfVyKLruYWojpvGUA0OyYNgHixDZ+fN+zsabY9Gx/Le/spkCh2kpDsAHqRd1lvPMSjd0h9yhHs+AUn1xbsuUtG2V8WxDyqlhG2otPqcKlbtN6F81PyLT7b3sHIgRzMbDsxzSXwBngSgKpuPJla8nm53H70LGSWX6Pn5GGemHqaA1r5qAbT98ehYB3ZHTpZKa2GAmrYosz2HTdKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ewft9o9cieV80iEeL7ucfCXiIk1nmyvrcj96ULYeWQY=;
 b=SVkENcn2HJGEmOWnhSdadMoKjNLypAKHwUnLTe0cOo5MDu3lRCx7MC8ZwzHRbggnu/Ao6vwOc1kTSyS/HWN/zjiGeGXqEXNoSUEbB01JoXn3FsFOrRvpcO/klAtD+JNCoT3sHKQJX7gpBgfZHUwR/Wm3xpXVFi1ihl5WMt0No5d6T1ATNYnwmxNPxXFwmfmfkfuTuPVcIiKzHzJSdlZFmO8Y4QpMWH97S3rox1ZpUku/AOwvzrG4c6H1LxCUOxqktcbOqog/FvrL7MA95Iofus8EB7fFaiH4nt0Acrpe7P1R3XDP/PH1OnA3ANKuRaetayv9h6lxX8aH2cAzyZYpew==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB1015.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 09:50:13 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 09:50:13 +0000
Message-ID: <69d7b329-4e67-4948-891b-1138d26db6d2@gaisler.com>
Date: Thu, 29 Oct 2026 10:50:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] sparc updates for v7.4
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
 <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com>
 <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0137.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::7) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB1015:EE_
X-MS-Office365-Filtering-Correlation-Id: cddd2726-bcac-4b67-f2e3-08df35a20737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|11063799006|4143699003|56012099006|261021121427099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VLZYZ10FBQQgyG0yIwCbJewBibgCwUdkhvyBIGsPiYyt+1UYkqP+02R7ykI9nyRY967GTt3pD1a0IqtUPnf/JZ1zXGtPj0orHuddf14zpEgGpIYo933ZeN4gGXBwZPkWCqQxIyHQiaiN7neN4REOCjxVafn9iLi6SIDsJ6MTQ1tnivNfxFIUXkHRjTzxecF0ZFxxTYNLi7VMr1gCqbIbCDf+I/3qAJuuUiwoYkglrxmaznzYwkkMTN4oa+/+rHADDiDPU+5K9dLUgF7v1uTmDkaXXv8GEqk4QZ3mntXbUke1jlsACkC3qrHLskMfW/BuUG2FGX2zz1ijTttqc++EZfptLuYUU4dWnZlldxadfHTAlAKYnzPAvljO64+4O968xFAYKTxQBC3PlcxZ0LocYP/wsT7WecWXY06XRr2GEO2OF/Dt2Rko8Mky6LWX/F7E4i4S1FHtQYWgk6Nxiw/7ISbMiuciDMJiz5RfqUJFkQh9IM6G3Hhr5NjO5KpihXk8/CKJ/LinWoip93LcPMXmrU0nexbn7eYcCIRlf0ZAj5YXhdAK1DiQIhK7NCIYvH6bFb2sZgcCDGA9juhqUgfWzciYxWsI7aJ0tJPm85GUqwLHJXeH3yP7IPANFNUgdsISTzk7ZtrrCfEpm2h9ttSYt9/iI2hKKmQVZ731vZO3HmM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(11063799006)(4143699003)(56012099006)(261021121427099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpIcFNoZUFJZGhTRk50bDJ6aTFoeGQrNFM5c3dYUTNySHUzVzIydUwxR0xo?=
 =?utf-8?B?aHg3OUtmZVRlSlZSVDZON0tsSGNma2xJTmRhL1k5bmZjcW1RTTg5cjhFRUhQ?=
 =?utf-8?B?NU96SmFyc3g4SGxQenExZ1ZNemZKSnBsUjRMVldqc09zYUJLQkVMeDdsclVl?=
 =?utf-8?B?bHRqLzNJQ1ZEeERjWXZ3VkF0UHkxUEk3Z3dFUWxKamNLVFRRbW1mYXdBS1hx?=
 =?utf-8?B?YXdLaEZTSytBYm5tQitQSzcwSUh5aG0zSkEwRnZIcTNSZ3hQY3R0YnpsbEhM?=
 =?utf-8?B?ZCtIYS8yQStTVURSbWp2N3RJem5VbmkwclJnVGZLSzhFaXhHRFE2a1o0QUV6?=
 =?utf-8?B?aGl6ZkkrL2xzRGVkcXhseUxEcVNDMGcrYVF5QzVQOHBMVzYxZjI3T1R1ZDdJ?=
 =?utf-8?B?eFNwSnZPK3BQeWdmb1VjK0ZkVDJEaEtDb2xESm9BWTgrbFBra0MzenBkaDRQ?=
 =?utf-8?B?WXRZaUdUek9IWmx1bit6bTdabG1DZzFuTHA4dWhRTjQ5c3BhcVpodHZHblR4?=
 =?utf-8?B?Qk9PWG85eDdyMTlLWHJjZUJwMG9iRXNtM1dnaXh5THZvd2hQL09qVUhTbG9Q?=
 =?utf-8?B?RnNzZGw5ZzRQdmlWZHg1bWhDQ1FOMTVDRWZlQmFMY2VLQzFZOXVXaTY2dCs1?=
 =?utf-8?B?QlZwdk1yeGZ4aVNVUlNiZENYQ3pITUE0ZzRHUm0yUTlUL28wRitUU0UxcXZ3?=
 =?utf-8?B?VUVYVTdKNUNXalRHVzZBUzE0T3IrUVd5NFpDb2JaK2lxdWtoVk1ORkJVNFJz?=
 =?utf-8?B?MjBUc0NYbnVZSGw3eWlhTHNCU2dnTjlja3phYVUxZkdtb2creDlHUm5ka05U?=
 =?utf-8?B?aERSY1FxYWtLelJYQjVxcXUzR1JHNjFRTlJlc3RDRlEvNTZFRWp6QWVPVHNB?=
 =?utf-8?B?M0s3TG1QeW5ZelN2Wmt6VUhRbFRUcUJpMzRadjY4bzZveFpHSjNhUHpZdUds?=
 =?utf-8?B?dytZb2J4UE9aZkZuTzhpNFZmeHR5UXdsUEVEaG82MS9xaHNJTFBFdE9aMzho?=
 =?utf-8?B?b0xwUkRhemVYRFVlT0VsWTl0OE9pL1I1SHZYaXNWbXAzak04K2dsT200YlND?=
 =?utf-8?B?RTBjdjJuc0toWXQ5c25ZUzBVdnpNZFFXOUV3ZTZKM20rRkl6dFZuZkJyYVhJ?=
 =?utf-8?B?TlFXSXdQM00vb0dwWnJzN2Y0TGNVNkhyMGJjQVM0MHJEMGhIS1VPUU5RYWVr?=
 =?utf-8?B?Nk12aC9JbVV5L2RTSkZYLzVuWkR2WnN4TVFLRXhzeEpPRTkyNzdVTjI3M21Y?=
 =?utf-8?B?K1pvQWVHaDhLSW9HUFp1VjA1Z3RYRlZORWl2cVF0a2JERWE4M2wxa243VDBY?=
 =?utf-8?B?eWQzdFFBMzlNOGtBNHNDNmEzTndtVURSaWtKSW9CZkRXanJNY1QrVWVxbVIx?=
 =?utf-8?B?dE9jb0xQUk4xM0lhTjE0MVlPVUtCWEg4OWttY01jWGVWRjFqWVJFUU5XZWhn?=
 =?utf-8?B?V3lndWVrdWsrNngvV1BCTnU2ZXFlQzRVVFpNbWtpMjdjb1Rwcm5yK1k1cXdC?=
 =?utf-8?B?MG44Qkt0M1l1S1VNOWhqYlozK0FYQlEzVWpCYlBWNkV3QjFkV3FNUXNGcUVr?=
 =?utf-8?B?dkZHWVRWdzJFNzZsZWY4ZG9lMStvd3JaYUxPTGtHK0Rsak1SV1BPaWJRQ214?=
 =?utf-8?B?bGh4QWtlVXNmWTE4Um9MK1kwdjdjWVdPMnJtRnErTHpoR1hZaytGTGVXVUlY?=
 =?utf-8?B?VmJ2clBkVmRFeXlxYWZjVTB5cFBEZEtzUjhCV1pFZXhYNENYVUZmbGZJUWl5?=
 =?utf-8?B?ZmpFTWhWZDJzSUc2eTYxakRic3F4czFvWk0zbUVZeEhoOWtPUmhWcVZ0NGZa?=
 =?utf-8?B?QUliTDF5SkN5cks4V0h5UmlvQ001Skw2N2J0M01ZY1E0NGtXSjVkSFBlM3hx?=
 =?utf-8?B?TDhXaHRPUytiMnRCVTRNWmEvMHh0NzZXNG5RdFdvc0VtRktPRno2QXUzTUVu?=
 =?utf-8?B?ZXNJeGNENGxFdGQ3Szg1c2lhVlVjcW1oN2xuNDJkVzlTS1MwN01TT2xIbWJO?=
 =?utf-8?B?cmJjQU8weVJxenJTd29wM0NBQmlOZms1b2kvaWdWQ1NvaGYxM0dKeUMzM3lN?=
 =?utf-8?B?WC95akZ1dWlUNG85SS9tY3pSSmdDVkhaV24vNzBLclpYVW9IQVFDS2l6clJZ?=
 =?utf-8?B?VWp5VVVCUVZweXlXa044NG5XaVUvbXJXQjJPcjl5UERHeTF1dGQxcG9pcDBT?=
 =?utf-8?B?N2syc3NnUEF5dCttazAwZnJoRExFb2szMSttSGhYaUF4T0xVbC95UW5MYm54?=
 =?utf-8?B?R1pWclpWNWFpK0JQOFM5d3NXbTFQdHFkb2xhVG5Rejg5RjBlYmFXV0JZZmRD?=
 =?utf-8?B?RnhBRFZrQWNYZ2hiZVY0ekVPQnVXYnM4eHhSczlOaS9NVUNDY1pwRjJlTTk2?=
 =?utf-8?Q?Q1lFo8dxhNkmQzc0=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddd2726-bcac-4b67-f2e3-08df35a20737
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 09:50:13.3236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYcoWyVOzWYgcur8yfdneh3dBthf9xZ966KwHzOX9Ufi2TV6z0lHVOBL5mECV5F82PAOY6DOfuu4uRChmkzgTACsfW9ZWYjgDyO/iTE4O5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1015

On 2026-10-29 09:05, John Paul Adrian Glaubitz wrote:
> Hi Andreas,
> 
> On Thu, 2026-10-29 at 08:03 +0100, Andreas Larsson wrote:
>> I got a late Tested-by for one of the patches, "sparc64: increase kernel
>> thread stack size to 32K" that I picked up already 2026-09-27, that I
>> inserted just before preparing the pull request. Sorry about that. Apart
>> from that added Tested-by, all changes has been on my for-next since
>> 2026-10-23, and most much longer than that, and with that included in
>> linux-next.
> 
> If you really want to modify an old commit without touching the date, you
> can use this git rebase command:
> ...

I'm happy if my sparc-for-7.4-tag2 tag, that points to the actual commit
that has been included by linux-next, is merged as is, without the added
Tested-by. No need to complicate things with additional options at this
point I think.


>> Below follows a pull request for my original for-next before the added
>> Tested-by. I hope you can take either my original pull request with my
>> explanation of the one below if you rather want to have commit dates
>> that better represents when they were picked up.
> 
> Can you push this to your for-linus branch?

My for-next branch is back where it was, i.e. where sparc-for-7.4-tag2
is now pointing.

Cheers,
Andreas

