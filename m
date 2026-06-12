Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022078.outbound.protection.outlook.com [52.101.82.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A994362138;
	Fri, 12 Jun 2026 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255441; cv=fail; b=JYRGpwheHNgVkPyhfxuXpNvMMDfcG2JGvK3/0I1OH+qFuIn38VQ4fihRABAAkK8/Pr8RJi7PIUlT4RCB9hJYaNgCce+XBI8sFHMAXsO/doYnkV4HRM6wNnf2tM4YbDvMZLJw23T7IfwDvP7jG3cPrFaLgBSCi6l8hj1Io85wD40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255441; c=relaxed/simple;
	bh=ceW34Hv0fdoucAp12sZ+MzBNhrSHcfkgNJUcGS3Nc/I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eVRKzj6qTlfb2N5s5v6pUelIV7KqE4BhuEIxqsXLnj+LgYkrOzOX3uKJQie2Bx9WU9aIZDBcqCMTZa0vu6Rtfjoyufzcd565R1fomnCwCweWuKIcAlnp6QxnkLQXxL555lpZJZalF6XiznGtAAcbB7rg/glbKxYu15IJo+QsyPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=fRcFJDwM; arc=fail smtp.client-ip=52.101.82.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="fRcFJDwM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lNBqcmexjE+3Ih3WI0AhoexPINqPB9ohV5ZbfSrojqkRlRUumYoeatvMlqzklLWFYsgFFoJlAsIciNmNyT7b7X0O218zjqH78rTHO8zDSd8pmCctp1nYUkUCnzW9HUWFC8wP/B3Jn4CCzS5JsfbxVbTPe+7+BxfDdzRo6vqPAW9KTDqY96p43d6Dp0gHHljFQ68azb9qC66aBRd/f7I0QaXq23eOK/sbSlSkmgkgdfS0PEg/mjafNL9PcTJBUUIl/J4qvaEgzpW7X7IMHUtdIkyRqnjC4wQp9q0iwYyVaxBxCILJb6QgckaorGtjd4eWTwvIOb9f/IoY9+2Pt1s4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+ZGSJ+Wudjl11Sz4pVP7fd6dMj/yVISt812spoU+iM=;
 b=Rsb20G//VbYimCQ5C4K9CC/cTrYuFaFOFSH7SXNtI0Miwr5XqrupGPIdu68PhvqS+BFdUqnejL14Ia0unbzmkhBsULkGfuVUIam2tWVVTIpodddUGCOxaXD0B39ukwsqCFN4UaBulPWiAIFY9FnoQ2NRulDXRyW8xf389juDYMZ7S9TOYVvPiPk01eOs+GPZTCpSEE7yT780lSI6lZw6kQsqDK0n3b8At0Jt12R8cUF80oEk1NB6opphSWP1ZBwDUiMXcAkxdvK77ksxQQ12CvBNkpnub6imo8YVYP6mM0k7Jf6984EgP+ThNurRy02asyCuksvdwWgCfen3t30N1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+ZGSJ+Wudjl11Sz4pVP7fd6dMj/yVISt812spoU+iM=;
 b=fRcFJDwMKORHsyFI0x4ymCMFjdhe5dwhS5Fa7VFMncdIFPbS2KU/fs2ZGOKkL0TL97wNUtd0h/iML0nY96rcK+oO1tVz49B6ufMrWrR6TD90CGVH4gLI+b6sb0LgMt0M7VM0M7yedK9LfKr59XL6oix6/XbfAN/rD63EKlGXlmW5PN2DU1m5UjRdAli3ZbuFNfp/KrcmoySmL19KhDkZdLVMiOOubNtyVijw4+baKEE9OTtPyt0o4L2R/zG5/LQrW4wP4vzvMBX8TmdPcBrY5bVcKSkbIa3fvqa93hJWrEmjTZo8DJpS49RqPvGeDCYDfXvKz6ogS/TQXKOprv0pbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVZP280MB1987.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:23c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:10:33 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:10:32 +0000
Message-ID: <78d9ad00-c64a-47ec-ad9b-5c2e62280112@gaisler.com>
Date: Fri, 12 Jun 2026 11:10:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: uapi: Add ucontext.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314-uapi-ucontext-sparc-v1-1-7dd5f8dd8845@weissschuh.net>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260314-uapi-ucontext-sparc-v1-1-7dd5f8dd8845@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF0004F08F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::628) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVZP280MB1987:EE_
X-MS-Office365-Filtering-Correlation-Id: 261c2ee2-9d54-413a-6be5-08dec862749b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NyrD82vS1kb8d+q4smkGCTUZv/+m36bSNeqIwjFWUw3rHkNRZo/VZWsD6Fn+4e7lh45BwWuI0ueX8tVNhchqDTjPaP8m0p4NBHdQqrlNnyhh7Vu2sOmB/YU8Sp64vg9BG6NBw7ZRC36bjoIQzT2H2ZYgWiaHnxMiZ21CWvGTzFDvbRlrviJKT2l5VkSWfGIbaAnx8/SvznWsdJniyETqpQYetLdsz4nIG8ZfMFq3h+nz550c9VDDFh+HoputnZ+8Fs7+qNCT5tChLpVj2GIQQw/OybcPs7zCVhz9Nu9l27k7c+81eC9JdGleTnczYBjceVhXUlqalaTQwvE/bw8pSlr+0kP0HgcC0kRG88TnpLyfIAz7V44QqvAH8Rg2CBPLoQ5V0ihM7UkvjNjcA5auwjydOuFx6k2J1/mbtCYx1xsxDn8cIYpL1SJa3z1jm62agf11puwG2CG74Z6vY6Wze8nPNqcjx2QWTZPaSFqC7wrJHMNeeqfIHEtqw5TdZCj6Q9EwJRR53vCRkqoULbAOnojUaqJbyNgQA0F/ETDelLTV0wU1QlgCt2gBI+uW4Z8neTo8dwSoUrbhwPF5X/FG4YjcZ5uSwa4d2if0xDiEd67cDNCikZkSoHJdMHpuCotrjfIPN7P28oklZ45YnsY/RnXGlm60Y7N7lXuZu4M5PS9VR0GI59zlYhqq7Lfq83DG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUF2aWxzRUIvVlZodHRjWlhIUEFzNE5HT244N0dabjAzYWQxcEg2SEZKRzVv?=
 =?utf-8?B?TFdobng4UnFnanl6SlNYakNnMzR6Z0MrcVArUEFHaG9EWUxySTg5Q3JHdk9N?=
 =?utf-8?B?V0VuYmtaN2FoQ2lHUUVJVG9ub1J4L3haZlBaL0FYdHUwQlVsOThISVVaRDBJ?=
 =?utf-8?B?RlFOc2Q5dFZDcmFET0xuL0pFcUFXYXpsVm9OTXdaR29IZVNXT2c4TFI2ci9I?=
 =?utf-8?B?S0FKa2gvZ1FNeHBlVjR3QzgvUVhxYnVtN0RuaEtoSm1IT0pzVE1PNGJGNEw1?=
 =?utf-8?B?d0xvdTdieENVOWdDY1dkSkxpY05ndFplOGplRENyYkpRUUN5K3M2VWRGV3RD?=
 =?utf-8?B?YTNzOWVCd3N6b1lZMkpwMGhwekcvaGpBenhja1Z3WU5wMUlYa2QzSk5VY3NW?=
 =?utf-8?B?TlY4dG9LSlRkRUczZ2NpSXhtUWZuOFl3M3k0cHBwYmFNNzVYRU43UmFYOGpi?=
 =?utf-8?B?UW9CSXNHbTNNSW90MitWOWV0bSt5TDBVeS9mNWNhdmtwcVJqTWhmcGlXVWRD?=
 =?utf-8?B?SDlvY1lsVUpCeHVZc3BZRzVSZ3Q1YXR3ZmpMcCtYOEY2Sks1Q3g0bEtacERR?=
 =?utf-8?B?ejlqa21mTnZ4Zy9jQVZhSW5ZNXJCTUVnRTZBSkdub2Q0bmtZRzNRUkVHd3JW?=
 =?utf-8?B?d21KTlc2RFI3b29NSG5yOTkxZk90aVpYMjRzY0EvZkJubk5GV3NhNTIwa1hI?=
 =?utf-8?B?MTBMc3FSdnhkbkk1RS90YnphK1pFYnk4bE1tWmlvWVZKUDBwa1pRYS95K2FD?=
 =?utf-8?B?eVhpeG9PbDNXcm1vaVRXemY0cy95dXNaYThQRFRmQmdDeEp3OVVwWjZNQS9Z?=
 =?utf-8?B?elY5TVVVU1dadVN0OUZvYW92UE1XSmNMM2R0UXBrNlhqOHpTeEdYUEI1WE5j?=
 =?utf-8?B?MVcwRXQzV2VBNVJkVUJneGhhRW80TFhReitWVmt3NzZiaURYaWNtb1d4bURE?=
 =?utf-8?B?R0hUOEFrOFE1eFZuQ2U3WlFZL0hJL2VYYm5uaHVkWnhnVnRZZHZaajZwcGYw?=
 =?utf-8?B?QmE1MGFYY2NVMHE3eWF2QitGSVJwV1M4QVlZcmgyaFd5YzB3MlduU005VFpO?=
 =?utf-8?B?UDhBR01mVGYzNXFWNERZT3A5YWZaT2lPYzIwSTBZZVV0WFcwK3hydFlZZEEy?=
 =?utf-8?B?Ymg5WHlLZ294WVNGL296TVVIRmRWTEY4Z2gxbjlQQXVReTBvRWgrbjhsZ3cz?=
 =?utf-8?B?SXpWSEZLN1Vra0plcEFudDhNc0gzZVpsTmdFRnJOdHNNYXBuN0VrKzVmWDVo?=
 =?utf-8?B?ZkZmVlEzWnYxOFQ5cUpCeHRNbEIyR1Y1MnB5VHE3Rjk2T2hDSXFyNEJza1pP?=
 =?utf-8?B?aDlDemNDb3RxTGU1ZFkrU2t6c1FIaWtsUkY4ZXJwZUptOXk5V3JDTk5xRENT?=
 =?utf-8?B?OWhuMlZCZXc1bm9neW9aa3lGbjdlc1RQcHhpNFRrN01Tb2Rwa1pjTXVFdFpn?=
 =?utf-8?B?akx4QUxkRUNWYzBSNVN3RkxPMDVadVprN3FYUGhaRFZMVUk3Ti9pbXpyOWFp?=
 =?utf-8?B?a00zVGQ1M1BBYkRoR2daQmVySk9kZzFOaG82QUlQL25XL1VnRkYwRTJUNmNZ?=
 =?utf-8?B?NmVDdmI3QUk3cHptZHZHM3VNc2c3L3M5cWQ0blRmRTNKNXVoSHdGejU1aXYy?=
 =?utf-8?B?anVZWlBoRWVPd255c3F4UDdTNXhhK2Mxa2N3T0trSVk5NmdzaDIrS2U0VjdH?=
 =?utf-8?B?QjBEODBkSjMyOUp3enpFcnBLMGVCa3BDcHhZSWRTbk1YQ0EyTE5ReE1yVFln?=
 =?utf-8?B?elJQd1VNM1NRc2s1aDNxMHN0eFNsSEJIajY1MFdlNE5sZVJUNlFQYTh6UitZ?=
 =?utf-8?B?a1lub056UUo0Wm1jZTlzdDJEaGFjckVlYlkzWVg1Q1FCZkkzbUwxM00vWUVo?=
 =?utf-8?B?OFZ5SHBIMnY3N2VodHUvT0FVVUNOU0VXUmxwdHVoWlFqbUZtR2llQmRkWmxx?=
 =?utf-8?B?d3JPTXZwZkhnV0FtMXpSdXcyTGNRckd3M0JiRXFGc3VRV1QzUGRDVWZsaTFx?=
 =?utf-8?B?V2hGZjJhMUp6OGRha1B1Q3hZVUNKZnZvblY1ZmJEbVZVYWpJNVZKR3l1WC9K?=
 =?utf-8?B?aVdVMjgvQ21OeGZtekFUR0VzcHJKZDc3eUdwTHlvQ2RYMlM4MjNGVVhmQXJU?=
 =?utf-8?B?b05ZaE1LbGZoU0hSTlJQVUo1RzlWZkdkYWdVZk9Ja3lsRTI2alFvRkRhdWdn?=
 =?utf-8?B?UC91MFVBNGNNbkVJZEhBeDFpdkhCNGRXakxQZFJuSjdiVXZTOW9pODUrUHQw?=
 =?utf-8?B?Q2FHQW9VZnRWRmRtaER1Uko4UEpMMlNEUnpVb3lzWmFRQmFzN1MvdVovWkJa?=
 =?utf-8?B?VDJSSUxUSGhnQlUyQW1UZzB3aXBYcFRRSkx2OTk4bWg3RVBmc29ldEY3UjZl?=
 =?utf-8?Q?tgcnOXmusAYQNiSE=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261c2ee2-9d54-413a-6be5-08dec862749b
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:10:32.4704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PdfV8giQXx/TvJ9aSuZYJUuQV9qQ1UdULZCVqbS0xmMhfj2tJkcfKwisg/Fr2yfOwzWp9OfUru/uLw7QF4BB5orqVgu2JSjZVBmubs7QqhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVZP280MB1987

On 2026-03-14 13:17, Thomas Weißschuh wrote:
> On SPARC the standard ucontext.h UAPI header is named 'uctx.h'.
> 
> Add an alias for the standard name.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  arch/sparc/include/uapi/asm/ucontext.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/include/uapi/asm/ucontext.h b/arch/sparc/include/uapi/asm/ucontext.h
> new file mode 100644
> index 000000000000..e9b5dbbedefb
> --- /dev/null
> +++ b/arch/sparc/include/uapi/asm/ucontext.h
> @@ -0,0 +1,3 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#include <asm/uctx.h>
> 
> ---
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> change-id: 20260314-uapi-ucontext-sparc-157814d0784a

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

