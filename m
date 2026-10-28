Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.81.92
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793195099;
	b=QZ4n112vumYbUf03WU/njqQFZsh4f9REV4g+eU7ixeI/3e+icLg5awL6MK1od/diXZ/j
	 Nsm89MAG5ju4HQp0C2HeD9kghnee8qEld4Nrs1K6enB6Xozpg9LGRHl0UQLOMACkp7+L6
	 bb/fAJZg8fnNZz146N7+4/PoscZ9B4et6l2lBmFWh2ycAsIekNcBjnGR/+dTPe3j01w0y
	 fta6cShgKqXhn8nuISTYIkq/JS59tECD9SY7JvV7+cXTsgWoi9ySAH2HDcvMCq5gH8dKl
	 xhUQkHTwbkefceClr/fU4WO0xajhbH9flMo+/j67xubOHiQZ9PSIt+uwIvtRWchcPzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195099;
	h=DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:
	 Content-Language:To:Cc:From:Subject:Content-Type:
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
	bh=3MvcD49bel240DKfSZA54UCGanzrr3pLjIjvNVBbKOI=;
	b=rEPwsK4qyPN2uwzblmApreaRhIjfOA2igiXgrwMVfuFgEJW0SnfeK3VB23AR3HtyuV4H
	 NWKNZ9cSDHTUNYD1aKteAfGqlMWa95suiFEE4Ilq2x7ggP14iWFReVnvgX+/3hLqq5ncu
	 dpvALWSekkenqds7lg+dgV+lNDywHOSiCGZt0OlaKS8q8cQciSUSoe/yClKXd/JnaTc3W
	 KU4qgpy2dOSaOyPXNavw+z0hlw2f7trmegSKJhClXJR+EZxkYAqB38yk9jRdBX8uk1aFt
	 QHRygnntNfGNTdPoepww1zo2FbDnvspMrFX+XicECwQT4OKzdHYgLGEAd8jUBbqUCgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=gaisler.com;
	spf=pass smtp.mailfrom=gaisler.com;
	dkim=pass header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=P3dAZntM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.81.92
Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11021092.outbound.protection.outlook.com [52.101.81.92])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CEF606A31D;
	Wed, 28 Oct 2026 13:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gaisler.com header.i=@gaisler.com header.a=rsa-sha256 header.s=selector1 header.b=P3dAZntM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=POPoLeI/8liR2pviE3O7AS55qmVVP5J4fcJle0mRgd54RChAnCdwwS7m6eyDa7XQdKVEBjAGppiY9gMnRzrUCQLVyKzu9hafcqNl2NxsBj6sMTmVjUbnJETuDbxRNEhQmrHZc2EQceVYmfXC+rltKKQ/SisQnEL7b4a/oZUfPdF/iL/KPbqtpZH5FijK1cHH3pLXrsGpL7yIn/B7e/zvRkSwHB2JchzG3p24X6Lfs53Q/QChqLYn7HlcvCW7tERhHiW26olH9QnfUxw1C2r0+ZNixLHRkQPyG4laIz/2PiEy4MJfSicVyHRqm8FY0+DW3H1NgHklZFHZH4MGPXPVJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MvcD49bel240DKfSZA54UCGanzrr3pLjIjvNVBbKOI=;
 b=AfRaJxiRaFafmqqrTMA2V8C9e1lLRo5h7aMEZC1+wPL09TtuGP5xAIVXmI3z0d2R+PHkFpxHPuCbevt0Q1bmjO9PUOgVTWSV6zTmUQGtDkRx8PwH1go4ttTSuyS1TmJ3fWMRCDCQTkO9gF+MSA+ufpHIgZBz+s57iIrnIeAGnxxMrPrDMjA7pDJe9S91muLhHEfWBjO+kV0F4LF+AfxaPRdE+bMnC24TXPlK06oqOdd0qLfIctIS8PYnuehCuQMroY1vr8x7BEHQuFt9Vmz96qukRlgMVhBzbOfhSNm4Nr7bW+1LcDk+6ZX8KwbFrTNteIwDh4Iu2jQxsQHskal16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3MvcD49bel240DKfSZA54UCGanzrr3pLjIjvNVBbKOI=;
 b=P3dAZntMxnsXCKuclgMccdQXoIBMhPuOOubwHM+pLA2xN4IOTY371LGVBIqMHrQdav8Om3d6liNCH28BHKGdW9Ubtqvo8yd0TbS61SEyYLicLrV8+npcPJtiZ82McOG+hMO9g5SLq5FyBdlrCtC+Ox99c7NMvigcp1e/Js8AcEzC833Ks4Fmx3ZmWVTdkjF4KKCJ5kQF8L8nl6ou5u3xf/Tggjfx8vg+zY27egobT3rdf9aLuXZqGjxdpfPihGLkc8+TWfYTmzpksXg+qxtEyJFHR0RQwxH4roM46QvtRTRtRBOX3Yz3qbvpgl9m43sApdbcdW8CDq5Nm7xsBqD1Qg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:2f::5)
 by GVZP280MB1712.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:23b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 13:44:51 +0000
Received: from MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939]) by MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
 ([fe80::1f13:f10:e16b:7939%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 13:44:51 +0000
Message-ID: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
Date: Wed, 28 Oct 2026 14:44:49 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
From: Andreas Larsson <andreas@gaisler.com>
Subject: [GIT PULL] sparc updates for v7.4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0045.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::18) To MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: MM0P280MB495062:EE_|GVZP280MB1712:EE_
X-MS-Office365-Filtering-Correlation-Id: e46185fa-d0f0-4412-6de4-08df34f9a3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|261009223027099003|261022105027099003|261022115727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	O6cytKlA/FmiQ8omDMncxkY27BOdQGOlQgI/R3WRiwZjilIeRMXtBk0Kh3cdeitcsL48iixEacHDDnzO41ED7t37zqHf64Qnj3BTxvuy1COpW5jQfLw/mTx5y6NTpFti0dtsBLbRCokpD3WZLMafSJsvNVOxO/620ESxKl94/BiNyav6HnQzk5H+as9OftY3P7r21YUe+X/wHkjPxbRF5n3/znXdgKBZ+0+ViJ/oM65V6iDcN8TYfo4oSSErpDJqNSxAge16qGw5BQ7j6GSW6+B3v+HyFf8I/Om+cdIgv7gw3QwDamIDx9i4MPefnD6t5XABIdAlBZWXD349G8ZKhifvT2ZERnmJ8R8wFuoEIssAVrQYzaRL+NWv2Jy2S69YRMrD9nVcvI5PkcOeMmyoW7MjZJ0Yd52E2NjDT12iEH6f0kznTH2InfhYocrJ6QK8py9kmj7EaBznvUxQHIVNSyjPeFtoHe42qx7DVTc/KKo6F4RTN51uOQGgWD0/o+aZEfS+oVQjNbCT/6U5MKpMkRe2WpMiOUL3L32Ivin3DlK7zF3VIFjk52K/OIgTHK1QBZugZWbQZ5M5+7xKd4HIAllGFWs1cQFpucoIqOhsPgl8IGl/D/aey/f1NIXB2C7fyXPY2y/MG+Ai9vBIyu8d3QNE9TCB961vqu+lf2doC+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261022115727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NodnlpZWZiMytKSHBYZFNpWDN0VkZjMHF3Q0dMUGxvZjhHMDZkb3Jhb2hJ?=
 =?utf-8?B?c0YzSVNIVGRIWjBhSTZjMVErdFFLdXc4VVJ4aitRWlZrMXpGczJxYzNua3Mw?=
 =?utf-8?B?a3RwVGhVTjJ5OFovbllEZjJOTlBLL2o0T05WaVlsaEFyUm82cW1DcTF1M2J6?=
 =?utf-8?B?NHdTdXd1bkJTVFB0MmFDZVJiOUJDbDhtQzEyaWNJRm9SUGhoL1h1eVJNRTZS?=
 =?utf-8?B?K3pKT21MRzhxdlpWdlZ5MjNuU0Y0Q0tqYmRTY3FBS0xBb2REY2cvK0RneWQ4?=
 =?utf-8?B?YUhWNjhWVU1aZld0QVRkdzkzRWlHV3lUL2kxbTg0T0tlbE5jRmxBem0vYWZu?=
 =?utf-8?B?YWVJRXo5RmtmVDA1amFmMjRPVDI1b0pIQ1phMWQvV05Ha1RGa0FhNFErQWdR?=
 =?utf-8?B?WWZCeWNmdHUwdjM5VVZqWDlhaUUwUWQrWUk5NVd5dS9HQ0FoQkc5RUdNTkRy?=
 =?utf-8?B?NmUvaWJubW9qSTAxZ2Nrbk03R1FQaElXRks3UlpzUmt6Y2VWQ3B1T2tzQXJL?=
 =?utf-8?B?ckdMVjYyMVdrNTg3SW1yc2EvVnRKRHZwOXZRMlZSSEZKaU5OWTRQeTI4dGlo?=
 =?utf-8?B?dm85K1htKzZiQmNXa1ZjT1NlVWpMSjdWaXR6OWordWtnVjY1VTlJRlgxRytk?=
 =?utf-8?B?a0tqNFhUMEgvQXVEZnc5YkR0Z1MwdVNQSmtIUXJHNVJEMEFVU1VzMUhaNHZN?=
 =?utf-8?B?Vmg2TzhIbndmeEhkYndWMzhGRnNINHFYeXJsSG5haGdjZ0RNVTJ4Q1dwUUhE?=
 =?utf-8?B?WjRERDdlMWVzVnB3MlNuaEJBaEFJZ1FoRVhtSmUvWUtCUDY2VjZSU09Xcm9L?=
 =?utf-8?B?ZmlCSCtsZWlQajRzVG5VSjRCVEhJTkNnNFR5TWpJVEY0MWhKL3l2cXFHNjVq?=
 =?utf-8?B?bXFwOHBSemtWOU1DSCtFM3B1eWtDYTVWVnhhRUQ1cUNCNjZvZHQxU3pUeWYr?=
 =?utf-8?B?aVlvMGdHNjNLVjdocHZ1Mm1IRzVQNk43OGZWWmlKeUVsQTkxdkFpeWJTR1Uv?=
 =?utf-8?B?MFJTc1JQa0pQenNnWUVxNVVhVEJndU9ON2grbHl1YlRqZGdtRG9Zb1FzajVS?=
 =?utf-8?B?R2NsUzBuNWVJNmtlaU9kdTZaeWtQdXZTR2F5ZE9wcmIzTmNUcjFHV1dIV3hv?=
 =?utf-8?B?NStlbkFRTnFaa1pWSDlaeE1iV1hUV3ZMaUpDMGxZaDhucGc5RVNiT0VNWHM4?=
 =?utf-8?B?bGlZRVczNTVDY2dtWlI5dUduUDdJeXpiWnlIL3JlcEM3WG5oaVFLbllETjFZ?=
 =?utf-8?B?SThNWnNZT1RoVUhVRUlGNGVxNHovWGx6dHlTY0R3cFg5QXh1VGdzY3p6S1Fw?=
 =?utf-8?B?aTdLWWNKYU1rRFZzREd2TTl3ZkVNNmcyOHZGcHpLd2hucHlQbzliekZSUk5u?=
 =?utf-8?B?eEcyQUlMZ1BvRCtDSEZmNUQzMk9OTFJmdFNLa2FpNXNrODhOaWlUOS9JRmZM?=
 =?utf-8?B?OXlFT1VJU3dCU1diVk9HYU1XRWRmR1RUZCswQ0hzWW1DdHNQQmFxcThiN1J0?=
 =?utf-8?B?VTlUVlkwaEhrUjBKZjdteTd0QTdrVC9ZSDRiV1A1cjRnTDAyb2szNWR6N0Rq?=
 =?utf-8?B?cjFtaHVWdGtPUWdSZzYwS3hvZk00U2J3Sk5BUTZNQXU2Y3pGU1hoN2wrcE5X?=
 =?utf-8?B?WnNpa3FjS0x5MzQ2K1BjRUlVcU9YNHByT3JHbUQvTEtabGZuRWFQSldMOU03?=
 =?utf-8?B?bzdrMXB1TlI0QXZqV1BGbURtZGdQcmpYMCtHV1FJMWhUdzdKTXVzMVRtMWx5?=
 =?utf-8?B?Z08zZjl5NEZEMGdCZ0VKenpFbDQwZ1pCYkNNMGhGUkRQMUh2R01nQS9qL2Iw?=
 =?utf-8?B?SmJjM2NGUjZhTTVRa240UTZyWkhnb2lZb0pITGIxK3N4dy83SUtlc1cydC9u?=
 =?utf-8?B?RzZWWWJyOU83RFRFYUtJUlJ6QVV3UFlGTEk0QUZncmNTbllmb0JOdW9QVWFS?=
 =?utf-8?B?RkF2N0lhVXhzamkvWkdzNEQ4UHQyUVJJVmF1cTJ4eXBCTStGY2hrbmRQWkR2?=
 =?utf-8?B?bmtCSTVBZzZxWlNuWnR0SmJ5NEJTendMZ3hSbkljbU1mcGlIaXlvOFN6TGVh?=
 =?utf-8?B?VWlxZnhOQ05XTXVpZ2lSUkdrU1RDZlpSdWxTMXV5RkpSU3VXcGRiVG5Ma0d1?=
 =?utf-8?B?ZVk1OFBSTjlrcnhFT2V4YzBnV0Y4MjFzMEZKcHVDclVOQVpHRldvS2VsN2Vh?=
 =?utf-8?B?Y2FuVWNXOWlKaHVsNEhyUTZuNGp2dlJZSVJWcHdEVjRCWXYwcml2ZEFFTmFt?=
 =?utf-8?B?MEEraUg3Q0p1SWkweUhhZ1NzRVFGcngvVERyNHBiUlQvQ0VKelBUUVFZMHlJ?=
 =?utf-8?B?Qm84Q3Y2bFJucWluYzVWVDZtTWFXcVRMK2dsbmF3WE15WWhiZ29GaFA3K3BQ?=
 =?utf-8?Q?/LOzSCbXNuscNESs=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46185fa-d0f0-4412-6de4-08df34f9a3cf
X-MS-Exchange-CrossTenant-AuthSource: MM0P280MB495062.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 13:44:51.1033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mb4ts/9b3ubVoD4kbpzy88XNnC563185Qo2enxVxi/lK0IeV6Lg1+t34Bf6R2scHug+L//h9MpeiRkVitSwYLSgs3F/K6y2pOxzBZBDzfmQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1712

Hi Linus,

The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/alarsson/linux-sparc.git tags/sparc-for-7.4-tag1

for you to fetch changes up to 6ea75a63132d17ac3f62a37ff1b893ff7965b962:

  sparc64: flush vmalloc ranges from the D-cache on map and unmap (2026-10-28 11:02:33 +0100)

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
