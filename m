Received: from GVZP280CU018.outbound.protection.outlook.com (mail-swedencentralazon11022093.outbound.protection.outlook.com [52.101.82.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F133019C8;
	Fri, 12 Jun 2026 09:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.82.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255634; cv=fail; b=BXw/q6+YhzbmiuBFthA/L3gH14pZpf2uiqIzCWynvuOwblG7qiVtMIa5SzwUx+YCzaMrSOhg4I/wt0qMhKnjA/b+5wcJsLtaeDptV16DbndzFW5bYFJCRFxyxYZjEhiJhGio6Mdl2G1/AYHR2nE/+gxgaPLmNsTvNKA23WJahmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255634; c=relaxed/simple;
	bh=bfAFFc18LnG+WxAchMdLsK0gkWLPUcrXoBSyjQc2JKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iBd3PD+lJ+e821+VTHL4xQPlr3sAm50SjlCUEVtnAHXA303PyPg0zSmfr6z1tW+LJdslK1tUb2xsGDim99NygFD1ybikB+Fiw3HDAodkuXbQOl+7C4+TO6F6E/uKnxD5RZknNPOauiwmvn6QfwpyurvRiTlSDOGbwEgMiP1x65E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=HbS+yGPL; arc=fail smtp.client-ip=52.101.82.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="HbS+yGPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YcdTPQOraB7d9Dr8QysaYi1JpQAs52ef6DIRZ7B8oS6WMA0iRSh/DrMTpjbIjiAFtclEKsEANVV+jv2+pQBKnDHahaGrdrYebHcUpxKON9T4Gy/Eo3VWZfb/I46NRMGZysZ3Lv4rioviimCJGd2eZbxDXc8yzJUikR7zOv4QsSfKT5YdQ1F8Cpm+KbqJt7Md1EFV6Qgc8fcxGFenGCd1T/IzH7/SF0zEL0wc/lQSnfa+hMc+t8vJHXmPcxuejvJKeQgZoY0pJQKjQRUAb6Meit2miprL9CMxUp73hww6tfACQznqKI737gTbRafJo0bfMoh1vOgvlezB5jYWMdLCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CT35u1SfTyctJEqcjqxxEW3DnR8jJBco87PxmAx1RK4=;
 b=cky+5VyFK/mkSvkdnsT0++2zCMMCBCoCsDO0VUFtXZi/j2paxxVLUECngqXuTviU7rRFBjSi8nBPySsNYc1sMWpqyVNfm9pvVSH4o6uGNri7jRlR4iZDXgNgGxOIk7ODSI4rHnia6ih+9f3smhYWQaOx2LZZ0HMISSFhoqZ6CQzkan1d2E5TkypBd732sOCdB//gwd3bVc0KgQqJ0SyZbM8t9nMkgdbw+aAg8itrbrUbMlxODiIHrDo+nP2gsNytPR6kaoTVPHuzeGYODRUZND1nGk8S2DhfjojvaJndJtc+ynlJfVRlyCb/BFnm6f1EbJpbvjxLdtB9z3vN2pbzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CT35u1SfTyctJEqcjqxxEW3DnR8jJBco87PxmAx1RK4=;
 b=HbS+yGPLu7uoVeVNNRtUqfbIIMK+fnhs2aA+gL8Y03sTiaj+YVJAZB2TCj51HQjdKCoNAeZNPz54cLL22AJ+v4O8pYCY6Se1Q6jL8UEYv3jsxixH7zNCYakTikk5abmLipaPnViY8iEjVl14qvRaAkBLkEtiO0aiYWDh/7afMaQ/zQ6/9gEjVnPNmSAzPheb6XEWFsRuNy6/ba0q155AiAc0nS/evfc/0yPh3CSaFJ90pfRk5r3VIsrwDdrz0c8rfo9yDNb2AjSQTDEVZOE3iHW+QsZnKTYVvKhMdQ2TymuG9EdHxmRSAsoVlpu3qbhlwB0ROdVnx1aiF12vG9EMDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GV3P280MB0759.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 09:13:50 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 09:13:50 +0000
Message-ID: <2fb1c4cb-5d0f-41f5-990e-8070adc029ad@gaisler.com>
Date: Fri, 12 Jun 2026 11:13:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: uprobes: add missing break
To: Rosen Penev <rosenp@gmail.com>, linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "David S. Miller"
 <davem@davemloft.net>, "open list:UPROBES"
 <linux-trace-kernel@vger.kernel.org>,
 "open list:SPARC + UltraSPARC (sparc/sparc64)" <sparclinux@vger.kernel.org>
References: <20260506031815.779909-1-rosenp@gmail.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260506031815.779909-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F6A1.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::129) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GV3P280MB0759:EE_
X-MS-Office365-Filtering-Correlation-Id: 9436b8b5-ad4c-47d4-b5a8-08dec862ea8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gmALivmi9LbNhKH7zVUeD3B8s0Hrxem1W7auCi6UGKEheUA1tDVnwdN/QpPdndDlcdW6fuAB2rlBElFNW0Lijc5MWi8Me8g78Cj93WwT3q0YSFoCyXH2R0DXLgttTMi0nbIOkQ/OB3N1GcmAgHWyNmQErfhsutWuUULSr4/wXygjmuhX5w7Gu/b6Tyej/bjVR1sT1gX3UWljo1uGs7S97Z/r9Z6vGtmmT/gRRPe//ggxqmiexYELARaYdGyXA85VcgtQLQ8M36E0IJuyVdR/WXiv7oE9swlsifKWXuV3il17KLRdv7yms5zaZUcEU8bFb6dvDPdmr+1e4w27wbDW0kHSn4gfclZFKAuJ+Wr+F3GGmUoPOdvXdRjUKNekHd+/c38aTBQcl48WNJjnYzFVbe5kZp5kqAJXANEzZSnrTqOqiEjnSbHlk/8GX6hbtcV8Tli4nMRzvlzQXpOf4Kg5EZsIjZ6/aKV+9XNmRRjVu+gzmuHbH5s30+Ng0K1yFQN0GWkXjrMmSHVloNYKzLtarB7HlG3yV/rgGxlFcW1eC7gddI8NaNwG61vWznfmsQiJ+w4okR6OIfylWqrkMKl71CnE5TzZZXBgSe/Up44dkjJeUAOq43XXf45YaSt7JkrRKdV8mSiBZitKkXWOTKPKFNuVENn8UFonH9OGeaF8iurbBIzRWLnsYkQ+MzKKUCaP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUtJVDNZdnA1Mmk1TkpUR3ladXBaajFDZGdwNXlHUjYzZDFHRVRpbDNxYllF?=
 =?utf-8?B?RlpRczViUnBMTW1pOUNwVXlmbVBDdS9nbjZJZndzczJXZFo0Vml2dm43Rkh5?=
 =?utf-8?B?SGF2MDdRbEpIeU1RZWhFSmY2TkRaMUxrSWVLVTd3ZGhocTlpOEx5ZGwvVVRj?=
 =?utf-8?B?T2VxNjhGTXUvSU8zeWNpT3MzenBEUURFV2R6Ulk1RG9aWXZTSk50b0hxQXJw?=
 =?utf-8?B?ZlZ0cXJZT1hYbXpjY1FkSTlLdm11ZHBhY2ZHT0NhUmFzWUM2SzVJaEhlYWlp?=
 =?utf-8?B?RkExRUljeG5JNTBIOGRhTDllQVExbjhpb1NRWFhuaE4vdEdNSFZUWTR2cVNp?=
 =?utf-8?B?OENKWnNHTTQwK0p3NUdjdUx4c1A2WksrRWFlRkhYZkdZQU9oOC9DaWtGNUtL?=
 =?utf-8?B?S21QNkIrNU84WS9aelQycE5xb1d2d2dsWmc5Nk0wWDBzVlBaV3pxUDNlVmg0?=
 =?utf-8?B?Qm04clVwQjhPV2E5UWlXWXdmdXZxenBabWc1S21XNWREV25CNWhjL2MxRllh?=
 =?utf-8?B?b2pvN2RRelBoVlBGeFIwdkxzNzNOMEN4a1htZFN2MVVDcFFGeE51Y2JXcy9y?=
 =?utf-8?B?SW00YlVRS0phTUxrcEp2ZXpGWlJTMFQ1clZyTTYwUU1wb3dQb2x3SHFLUTZx?=
 =?utf-8?B?ZVVBS29DUmFYeEJDeVpuUVd3M3Rudk1NalZRdEo5NnU3OGpIUVpZcUFvVk1h?=
 =?utf-8?B?azcvM01PR2dtVkkrR3NzQXAzYyszaW5TNjR3RWNBdHR0RlhxZ3ZlaHdic0Jr?=
 =?utf-8?B?SThmWWpSOWhaZXNXMmdoRG9Dei8rRzJQSnhmVjN3ZGlKNFFlb01PS3c3ZUtL?=
 =?utf-8?B?U3VkOHFSVjBwdVJnQmxMN1lJQkVWeUtsbVV5TEtlTXF0eW9uT3VHTXovUHIr?=
 =?utf-8?B?U3J2ZmJHaWVGTjU3T25TenZDUmZwczdLQXZJVU90UDF5akNsOUxzZE9nRlY2?=
 =?utf-8?B?WXZpNmk0bUFnM3FubVJTd1dJUWtIMTl6OWE1TWRoczRWaFNOb0RHd0RnUVdJ?=
 =?utf-8?B?TDhaSXdIZDFoNWFnd0NLcmpneEhkRmRZNTFQK0Q0WGJBa1FyVzlsUjY4Szhn?=
 =?utf-8?B?QzdiVlBxMHR0czl1UmJkdzRTZzdjK3JRbHBNZmpFWHZUV09OVkt0RnFobTFK?=
 =?utf-8?B?TityWjMyK1JrM2ErL3RBQVlaY2MvWGZhZEdIdEdxM0hqUkdTOW8yYVMwM2Jw?=
 =?utf-8?B?QjRwMGRrKzJMWUZFSEVxQk52dTdqM3hZUEVLL3ZCZmtidkJqd0FQZnJEMGcw?=
 =?utf-8?B?YS8vb001Q1RvOFIrM3JQa3dteFQ4cS9zYmk4UWRwZUFPVDB0UERPWkd5a1pX?=
 =?utf-8?B?UmQvMGtrYmpUYURwVzRzeStiM3NOVm9nSmFxdDd6cjhIaFNWN1pFRy9jdm5Z?=
 =?utf-8?B?bDE4UmVHWTVQUFpheDdCZ2tKRUVnSGVGTk84NnFxd2tHaXBzTkdTVDlHNi9p?=
 =?utf-8?B?ZEVIVnRPL2RwdGRWcmFKdno4d3pvdlhWL01EN0hmL2VjL0ZxMjZwWldVZXd2?=
 =?utf-8?B?eCtySzZXTXhzL3dsTnRSL0tyZVFJbDIzcktxb1BzT3F5dXByL0o0dkJHWHZi?=
 =?utf-8?B?eDZxUjNod0VVZndBVWZibFpaeUhMeEVVRHhKSHdnMHpnaWpzOG5nbDBjMS9P?=
 =?utf-8?B?S2JEMDNlNnB0WGZnckRlZzE4MTlqT29ZR0x4TlQ1ZUlMUXpENUNsQllOdGt0?=
 =?utf-8?B?R0c1LzBqOTh1ZUtwNHlieHBXTURJb3NQWWdudG1OT1M1eGR2SlVQRFZJQ1Z2?=
 =?utf-8?B?UVVZZG50THdobUJNSGYwQUoxdkJDVmZ0eUs0Wjlhak1tM2U1eDdEL3o4NjAw?=
 =?utf-8?B?NGZ3bWxDd2JBblpCR3JjLy9tTzlDS3FITHJjYUFnWWVSRFFtcTMxMVdET0RY?=
 =?utf-8?B?aEpXczdVR0NEb0pFSE5FZkkxSlphcVJYeVhIdTE2K1Z0aDhKMVlVbHVlZkJs?=
 =?utf-8?B?bGFRcG1jK0tXU2VyaFdJWUkwMlhMQjJRaXkzOXZXdC80YS9zRXJVc0d4Mm45?=
 =?utf-8?B?UXhLUm94NzBvUHVva0tYTTdDNE9zY09iemIrbjdFL3l5eHhuUHRtQzhRa2lT?=
 =?utf-8?B?T1RORXRPRFdnYlpaZlhBWng4QjE3aVM3UVZ5UTkrN2V4TWJ1S3h6QkdHZE4y?=
 =?utf-8?B?Q2k1NEpEYUZSQWpwOWJ5eWRsZUk0OFZWcEJDN2hXMXMycjFpdXZoaHdVU1l0?=
 =?utf-8?B?cGFzN2dmdFA3aHZ5Um02ZnBta3VpdXRCNTlrRzlRT2VadVhkcFpHTzJZMHNa?=
 =?utf-8?B?aHJ6eVpWOTJlendYWWhsT29FVUFaRGNnWlJNWVlxakNCbUs4YkI4V2UzT3J5?=
 =?utf-8?B?SGVkaEw5NXZ4S1l0K2t4YmhzMHNjcUl5MTgvdy8wR3JqUEd5QUozUllYZWlW?=
 =?utf-8?Q?E/7TQyg5qlWdxDqU=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9436b8b5-ad4c-47d4-b5a8-08dec862ea8f
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 09:13:50.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11PFZzQ210/BvAdoK9Ucu01QHqswr8OU4/2XLxdJX16Yi5AJVJuN+5XIPTcGSS2bZwz2ZvCTJkSHqD6rVh5bMKIOGZRXvKvJq5w+OEvGurg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV3P280MB0759

On 2026-05-06 05:18, Rosen Penev wrote:
> Missing fallthrough causes failure with newer compilers:
> 
> arch/sparc/kernel/uprobes.c:284:2: error: unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
>   284 |         default:
>       |         ^
> arch/sparc/kernel/uprobes.c:284:2: note: insert 'break;' to avoid fall-through
>   284 |         default:
>       |         ^
>       |         break;
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  arch/sparc/kernel/uprobes.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
> index 305017bec164..c8cac64e9988 100644
> --- a/arch/sparc/kernel/uprobes.c
> +++ b/arch/sparc/kernel/uprobes.c
> @@ -280,6 +280,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
>  	case DIE_SSTEP:
>  		if (uprobe_post_sstep_notifier(args->regs))
>  			ret = NOTIFY_STOP;
> +		break;
>  
>  	default:
>  		break;

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

