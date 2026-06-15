Received: from MM0P280CU009.outbound.protection.outlook.com (mail-swedensouthazon11021128.outbound.protection.outlook.com [52.101.76.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA6F31F9BD;
	Mon, 15 Jun 2026 08:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.76.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781510473; cv=fail; b=X2gmEx+UINA7lQBbwQv/7/BI743aQB29dN+HSdPMfIEACErvvxfs0WRnFqQdxQTg7WugyKYO4m09clRARYp3ES7W8Vdm0C1dSXA1oVg8VpjAxMfJRVZLxWMh2Dvg6nvWjoKZ4QQxBOLwc7MgT4WIu4TaTdqp58XGM4Z+1ky47gQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781510473; c=relaxed/simple;
	bh=k99pZ/WObxkMjtd/AKZ8skaONdCVqcAe7R4WXDjJjnI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nuH/lKK5M6HM/36ym1equYUljU1IOBi2xiSErGg6PF/tHRzpzsyFmVZHsu17L8CE3T6CXX+fqy+8oGOG2kt5vprO0M8X2xVznja90LSd7LsIBlRcCjZia/41TZqLG6FF/Um0tachJe+yIQvIIwvqlyIc/91z6P5OtoOljQsqQD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=qoW+QdP9; arc=fail smtp.client-ip=52.101.76.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="qoW+QdP9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wW94kqOruwugzWbUJPsR56rOETv1dRw+YtlQAWBYkSQlw/8wqKaF+TLwTSkEQohITRT9iaV1hrxF0aKRbJp8r9Oe+Iwdm+l5UIXVXrsDTvL1o9QlYbfvWk/pduKZiciQoQm64CEsCzEkyHeSyNqT8gngPkmPttRrJs2A9X7T3C4RxLq2MerAqNX32CADbUfDsucEhVSwNRQ7Y6MopPCiA7eLJ4RAt+jMauhrgFzy1U2bbs3ErsAk+oNwTeBgboc01xjMfp/jEtPxZSXSJeHvNzBnljGIyromwO2G8SOyjhFcJfONT7q7YRbDZh+UX6u3x1LXxVywZimbJwK4ghtYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiL9ONWX7HKdsHTACAor4DbuwYzjCyQajpHUX4vCQrU=;
 b=p1j6bgYJB6d4Ilt+tyadI8gVugaR+lZObjTBXfIGIKHypAuOsBV2BHwuuK2ztbY7sU8ZX+OK6jExQhcgTXYXiprsPbBDHUnsKwTCneDRmL5IocPimtjeNvfGGvsurBxV9mlfvm9xzvsQY6NPdaRQYYkEjq+B6cYIp7Y383dQJc0rPZ92BKYt2gkUC/vb81yXrJ+9qBJIIW3MDlHIC0LPbqQakUQz7Psf/TZO4s5EuApnozyzv4TgBCMk0poDYqwu7zCRpRv8QYLWR99VRxrDjY91feWOW3G4JC6ETDOdKtafRofM37sg4nPK5JVWOSUvg867342erIhEsWFPG/gxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiL9ONWX7HKdsHTACAor4DbuwYzjCyQajpHUX4vCQrU=;
 b=qoW+QdP9Ldm0k0lKh2TfUXvJ4zUa5oHuHvcyTgXXYsosgu75e22BSeZ44ndWb7/C3y/jlCWZv97/lzGBHJCquJXEh2Dr8y1jY6t05lgHbGUUnPtQHVMQI2kd9B1sHPOsHYmZtRK0uDIaGuNvu2J87R3ghm8j/gwA57nuiim1ky+ax87EYV5eS1wFsK2eUu7i5TfeAw2SnE156mMe1UXO9+njT8uUOPD5YXtvVHzeEnlkdeYFk+61+SkhCmRxCamGfB5coDc+KsKpbQ4dvIpV07ftHq9q0NogFM5Y4+MyIIvwMGytxZvW28TpMA+XhbEB30jmh58ej/oJ0GL8sXfWrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVYP280MB2063.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:365::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 08:01:04 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 08:01:03 +0000
Message-ID: <a061ffed-fa21-47ec-9472-ce1812fdf460@gaisler.com>
Date: Mon, 15 Jun 2026 10:01:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] sparc: Export mcount for Clang-built modules
To: Rosen Penev <rosenp@gmail.com>, sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b"
 <llvm@lists.linux.dev>
References: <20260612181503.4509-1-rosenp@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260612181503.4509-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DC48.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2e9) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVYP280MB2063:EE_
X-MS-Office365-Filtering-Correlation-Id: 927549c7-2078-4073-4dd8-08decab43efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UN0dETG43Fp1hVh9HKq8fA5XTwLB86vYCj4p5Podc3hsZJujkGGzQ4lvkehNvxM9VXw/miv6+7XB0B/+2KepPQvTd5Z7KXORmBBi26qAoXYo8foQ7fiBsOUM45WvJG/VqUFPDzoorYUxXEwNqJ/WKia1/4QogFhWovtLNhBbxia8GJThz2c0H2vFW1ZQMO2V8BTfoTJlowsW6ylRdPjj1JLRqCtm/JP5kzcdoDNI1OGv5siaUXkG8IaF6N3msSIHzg+5sV8MCRjNS3aP/c2D1ZsT+O2A29ju4kNx5IeadrTpra4HOixU1dKqMcE6euWitwkGH0LPuR/KN19CRkeqNS/GqXvBlXZpDW6vrtT7h4R+q/hMWaTI2p91wNmjF0j8P+7k4DNC/ecBLleMYzuBsF9N9A+dBOosGTHVClSjDyDkpuM3hq57uS6hOd4UoS57tB2Zkr9gdC1Ug6aKtskeWlJwk3t3KuLTR2U3vlPz/xPBJJngtCegGLCqcWkGJ8CkYSoOLgJAluwLtyMxkcgvbVcR/Oyc4F7DPaTwhz6rfKnzhx+axxtP/icYv8j0JVubqwsMNmK7bnbxHEyE+kzImp1R2gXP6CC50xY+9Vawc9n2mj4FGJO2fYi0k/JNPoRKPFufGpJ8azUHlhlyrL/guqkdq/9I4+kXdlnUDbyNJr6pPgdm8ebGOguK1KW4k/ad
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TERRQXZXbDVkSG40b0hPRTZ4SVg3ZXZqaytPZnlDODVIRDRFZVZSZ085NUQy?=
 =?utf-8?B?N1crUERDdnp2OVord1VINEFZQTY5WitmRGV5MGpsclVQaXd2TncyTDY5ejFY?=
 =?utf-8?B?eDR6WW5JL1pjeDQwM2JEbHlPUEFldFdMbmt1L016dUdNODFja08yNjBVaDV1?=
 =?utf-8?B?eTVKU1EwNjFobVJvN0RDcENEQkJzL3ZKUmlSUWZYZmdUVnFRSy9YbnpCOUZS?=
 =?utf-8?B?Y0M2TXcrNjEwV2dCd1RWMkN4WWJLVTZ6TkhNVXdSajQ1VklhcHdvWEFZa2xX?=
 =?utf-8?B?QXFRc2FCMjdDS2xUMWNicEpmbmJNSW1UbnFlU3djUnMrdEVpTjI4bUFsRGRD?=
 =?utf-8?B?WWU2ZTRlYmJNU1EvYmIrMTRJOTltaW9GRGNJb0Ridy9JMlBiSzR4dkxQVzcv?=
 =?utf-8?B?MTVBb1JpY2t2T2hMT1pzWitSMGp5ME51S2VRSzAwSHl4OUU2a3BHTkRFalVj?=
 =?utf-8?B?bnBpS0JCYUNtbUlyRTd5RW9YVmhZeFU5Y3FZQXJ2Z2JBSm9MUmJTYXJTeWQr?=
 =?utf-8?B?dUFVVU1uYVVMTkNNM3BlbmxNUnVXZ2d5VlNYdWZiMHYrZTQ1WHJPVWc4L0V1?=
 =?utf-8?B?cFhBb2tSRXNhZFNnUHpkWVBJY0E2K1VIODZMb09JbnVSRFp2MEExK2dFVVJu?=
 =?utf-8?B?V3NyU0xobjBzTFByUGx4dGxXTHhFNHY4ZW0xT0lMek5JdXU0MVV0ZjN5WTI5?=
 =?utf-8?B?bytoS2VEcWErZGdORjRrVEdVTkMvbGIyTW4zckphSUZ6aUhQL3BCMlJBcG1i?=
 =?utf-8?B?SDZrM3ltOTRWOWFYMUQrR0NJZGZYVFc2UlE0Ylk4dnVhM1o0KzdhcGJ3MEQ5?=
 =?utf-8?B?blRvNEY1ODcxcm5NZHA5L3NEaCtiUVB3eXBOMlpLeXVVQUp3WHFwNnZXeWtD?=
 =?utf-8?B?NW9ENjNsMVgzNkp0a0xvRWNqQjh2MDltME5Uckp4aDlTUzl4U2Vpa1RWdytn?=
 =?utf-8?B?NjFUQlM3NDNNUUJWVzFldjVrYzlUVkFnR2FsV294Sm52SzExYTZLL01IYjlX?=
 =?utf-8?B?RnVoVUF5RENqY0ltTzZOMm1MSXdhWWhKSmF3ODlMYkhndzJiUmhuTEQ4VDFU?=
 =?utf-8?B?MkpkU0IwT0orSUJlWlpSVndEZzM4RGFTNytzY0pneUtmdDM0dVJMSEdkQkFP?=
 =?utf-8?B?L09nSFdaK2E3clJ2NnpFMmROemtwa0RabzhNNDBPV3FoZmltclV4Z0lpdS9w?=
 =?utf-8?B?bjA4ZFpCUVRZZ3dPVWY4b092NDJubzlhSlh6UnVuMVdNMmhwaEVIOW8rVUNW?=
 =?utf-8?B?b1VxbFZ1TXpWdFFBcjVmQXduWTBFS0N1ckJubzkwL0pBZTI0R0RFbTRsWGVT?=
 =?utf-8?B?TVc2YWFxSzkzaW8wSU5UZ2RlTnhZY1RISFAzZ0p1MEFEZ0p0VEN3ekNxODBq?=
 =?utf-8?B?cWw2dE9RY04rYmVkelMrekhtb3JCL0l0RkxtcS9vSEsrRVJFZmgxUU1jMXBr?=
 =?utf-8?B?NCtjWklkRWRQdW9RSzMyTmlackJucnFXVFlBWlJRNlJIL1h4TkcraDFIblZV?=
 =?utf-8?B?Y242eTFLRWw0clg1T0hNRmorZk1UR256cWdIemdQMmpLUWFSbkMrSzJVSWpu?=
 =?utf-8?B?by9PVnF6VkloUmtMK3ZocmFIVXY3Um1pRDFIL05GRC9iWHlmZ2JQUjJtNzdU?=
 =?utf-8?B?ZlpCTG9qbzFnRWZ2QW1ZR25vRUUyWW8xeUViNjhtdStGODNXbi82RGptQUdr?=
 =?utf-8?B?MDEzQTZDa3Fsd2pUKzhUaFpnLzJ0U1RiLzk2eHV5b25Qd3RJMkZaZW9ubWVQ?=
 =?utf-8?B?ZzhEelQ3OU9xdSszVFpvb2FkdjJ6eDhmWjVyRGdUSkFrOUlJMlJicml0NFBR?=
 =?utf-8?B?MngxVm9idk91M250ZTY5MzFlNExUVVZNdDZGdzNvVjlVdEgycEV3K2UyZ2JY?=
 =?utf-8?B?cGJEN1BqK0UyZUk3aGVEcVJBbGV2NUVGeXdNSGRzeitTWlphdnRZM2w3MmVI?=
 =?utf-8?B?ZFpmZ2FRb3BPTWVqNzBwT2RxRTNBcHFKTlhIUzJOYStTL044OW54K1lrc1c5?=
 =?utf-8?B?aXU1djJRdStkWko3blJ1eGlQaWc3a0pCTElETHlhTmU2bXBoL3Y0ZHI4K3pU?=
 =?utf-8?B?UThrRDZYZE96RUJya3F0RnByWnlLc3MySVo4dG5zQ1ZkUkhIWDJtRThZc0RM?=
 =?utf-8?B?RnlTeXBUUHF1cTdETVExandHY2lpNGw2OG5VdmhMd0theTVDTUdPOXBaVC9B?=
 =?utf-8?B?N0c5SE80R01pSjZjS3lqUVRCY3ozSWdDWFdpQjF0eUJMZnU2V25Lamc0SE44?=
 =?utf-8?B?azV0ZzJtb3I3TktEeWZTUk83TVpucWFtWUxzYStHeXVwKzh0NVA2dkU3RDY4?=
 =?utf-8?B?UzVHYXRJNlozWEF3NU5hWkoyeFkwMVZ3emZlZ3JmdmtQUW5KQm1lZ28rQlBJ?=
 =?utf-8?Q?EYEsz9AnloIK2AEY=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 927549c7-2078-4073-4dd8-08decab43efe
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 08:01:03.5653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKGEONhV7UtJnfWMpr7j7Hr5oUjBoIU1yJgWLAMfiPX0S3hfIkIDwtNIUzujTX/M1RjA5anxntZopTytFRaO80b/7t+7VzoKG2HAjdSlu1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB2063

On 2026-06-12 20:15, Rosen Penev wrote:
> Clang emits calls to mcount for -pg on sparc64, while the
> existing ftrace support only exports the _mcount name. With
> FUNCTION_TRACER enabled, modules can therefore keep relocations
> against mcount and fail during modpost:
> 
>   ERROR: modpost: "mcount" [arch/sparc/kernel/chmc.ko] undefined!
> 
> _mcount and mcount are aliases in arch/sparc/lib/mcount.S. Export
> the plain mcount alias as well so Clang-built modules can resolve
> their profiling call target.
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: add declaration in asm-prototypes.h
>  arch/sparc/include/asm/asm-prototypes.h | 1 +
>  arch/sparc/lib/mcount.S                 | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/include/asm/asm-prototypes.h b/arch/sparc/include/asm/asm-prototypes.h
> index 270c51017212..a39a24c53216 100644
> --- a/arch/sparc/include/asm/asm-prototypes.h
> +++ b/arch/sparc/include/asm/asm-prototypes.h
> @@ -26,6 +26,7 @@ void *memset(void *s, int c, size_t n);
>  typedef int TItype __attribute__((mode(TI)));
>  TItype __multi3(TItype a, TItype b);
>  void _mcount(void);
> +void mcount(void);
> 
>  s64 __ashldi3(s64, int);
>  s64 __lshrdi3(s64, int);
> diff --git a/arch/sparc/lib/mcount.S b/arch/sparc/lib/mcount.S
> index f7f7910eb41e..0309ba2c4712 100644
> --- a/arch/sparc/lib/mcount.S
> +++ b/arch/sparc/lib/mcount.S
> @@ -21,6 +21,7 @@
>  	EXPORT_SYMBOL(_mcount)
>  	.globl		mcount
>  	.type		mcount,#function
> +	EXPORT_SYMBOL(mcount)
>  _mcount:
>  mcount:
>  #ifdef CONFIG_FUNCTION_TRACER
> --
> 2.54.0
> 

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

