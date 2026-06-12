Received: from GV3P280CU013.outbound.protection.outlook.com (mail-swedencentralazon11020141.outbound.protection.outlook.com [52.101.75.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BC4395DAA;
	Fri, 12 Jun 2026 12:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.75.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781267000; cv=fail; b=k/7iNjotR/8AIvyyn+1GTpC797jHTOgXb2KuFOFmINoQI4nEfMu00z6cW01gpvVo8nWE+ozdQnCkiI8j6LlBSlOmgEznu2CM7b/itbnSoGVk+B7RtTyReqn8CZoaZrX6lEWUyFDdPZDTIkAI9KjXWXGCn1nSaQmu8l4CT33HYqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781267000; c=relaxed/simple;
	bh=GFfSxquETrIk/6c/L5UxsgUOL2RTeeCJb1QRFBd5DI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVJ6c5/0tZjz7Ggq8cBgxvAu2iZDqtirAAFPJk4BkEeuM7+YT8fXVy8m4n8R8kiwsDV7RPpcVN8BS59AGVCREg5juHOEOijaa+ipurH0BDmB0CSwyGrvYNqL92tdAwphbN4V6TfYzxnxJP46sUkc2Y0ppeukOjqLHHpe0+DNJW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=L3JRgL3C; arc=fail smtp.client-ip=52.101.75.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="L3JRgL3C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vy3oOaL6XGg0MRoPbcmqxQMHp27B16m6RrCASEl1+EFyu/lk98ebUwwPJfrOs7U9+FMSL5rA3g+nJZT6b5CLbWIQMLfogB/cX+4pdtlbKIPgrPghxVV6jRsm5Mpia2EAUOmo/TdIkc3U349aCM89XYQpGzwNyoOOWoz/UH9lva2pnTjZiNfCyI5YhYsmtmzwsllMFAZW07DpKLT+YKOnROys0Ieuf1jcff3jvEd/hcoEMzEQou1fJuvzJ+fBFuJsj0W5znhPvXOzsMHucFP3cgdW59yt9jQxukdR6rI5h+oE1og3xHYuML+4qY4XY8oMUKvmUekia9OpKnXMb51LGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKhLoOaQAKEmw/pitHZ7/ViDICTqUU15tS1LSIbx0Gw=;
 b=kNYjVTmtj5y+WXWix9TLTgYxDur4hQkNSCTdpjIa8WYaGbTxDR3EUFf7T77e9WkrOdchCBDI2oTbJPQKE1jJr/CBvfAV+iheVb0LSfB+3o6vz83deZeYZ3CAf4aDIWAEzY3lI4LLbN5ybmazJCs0iKiOl/hzeBjWyfxXjPyo8+z/s5aK/P7VKlJ9ICkL8Cr/zmMq6oIPOFVCDTteGs9ONGKUc7Ai7tzHjhLl9p4C+Gefxdq799MlR5lYw90FCa1PEyMLdq7x6PVsbDL5u9dogk5hNMvxaB1tMkgxOjQWAJdluMPm7td1CXBGIW5kx01TW5EH5sTSdEm20oqJd3ANyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gaisler.com; dmarc=pass action=none header.from=gaisler.com;
 dkim=pass header.d=gaisler.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKhLoOaQAKEmw/pitHZ7/ViDICTqUU15tS1LSIbx0Gw=;
 b=L3JRgL3CcRFKVtsjNdUvpGQgi1BRCgVtO5+NgNmeWdluVQEYPxO8ZX5AYuYfY8ivW4Rq1WKhGqGEaoALaP+hoAWYoUIeIiB6s1sJqgGfcUtETx6qSDYeB2btMRBeMaQax/1wt1910OB33iyi62AYIUWagUrkgWNFjNQQboG+SUgBc6Dkft74q5hQnGP1t/8enrb5Mbja2s24l9m+pl/hW3xSwGShsesDwto5ddzYseCuPxmm3MWKi7x5FFQsn6AWZC7dSEdJkjRIkiVqWFUfkeGgaNE3xUW4g2DSuZ0pfKp8lnHjRAjSmayqQMRchDVVsqu2NDfKOEr3p8uVee0atQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gaisler.com;
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:195::18)
 by GVYP280MB1069.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:23:12 +0000
Received: from GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773]) by GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 ([fe80::be76:7636:f4ac:6773%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 12:23:12 +0000
Message-ID: <c968c25b-7174-4b27-985a-9428a4ad429c@gaisler.com>
Date: Fri, 12 Jun 2026 14:23:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sparc: led: reject zero-length proc writes
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330062920.40786-1-pengpeng@iscas.ac.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20260330062920.40786-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0002399D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::196) To GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:195::18)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVYP280MB1290:EE_|GVYP280MB1069:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ce8517f-7473-4dd4-b392-08dec87d5ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	puccroWRX6cXDdV26pOLYuup79d+rlHCLpdRoG59PO6GBXcbJwY9nNVvjAgp/MizFHtxB7J0BM+t9E/K+uAatwuS/d6vxVyG6Xk8j+HuWxv+v5NA5DK26wzLHGdK/CCjyfUCOFwpTBYOp68DXSJz4qE5M8NprJ493VsllpvJnpramp/zDl2NCrcGjXoZcK+NYRcWUGFCeY3vyQPt908IAeVZ0s8CMCF9oubor8XFJf8/oRe6e5kaTWBbHKgcvl4Jkx5CTP5KKvggIEzpIQFUBERdMklFpVQS5OrhAbOerzWMa4YM6nQEAB6uGUJtPcWb9/MULzEZWLVwGT0c1WBkRtNXGMvXN0b9GSQvkkL15DZmPKwTD/c2W+QH/XHfsA++axW+WmpEi2H5UpOWMpo87ozrIzLr4a8PRpg6w1VUSklQfKh5QmDTqgWONQuDkJnnt8uWNT1H5BaGvG85vLnUMiT0napw4v9D59jQKaEB+9svJlgNwpJVVYUjKWlwwJcOEiCDlmvZrSn6kGvsdMF8Kj2OiGksBcj+GDXR9z+louxGacdrFJ+mL25LKxVnI0NpZSB6FixV+mO/iD9po1QyBgX/VmMvO/pcWzYpm5xIBwy4zmBoQx7NAfnHqm9j7WVQeiSb1cqMzLtdcWsYaJm38R4PziBayThHZoArbg9TjXn3HiqZnDamCcrhgBhPLiaK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZCtva01CZHJHN3RvekIvK3gyVElkVjhyZG0yQUx6aG9RT3F0S3NDZ1RBVm1t?=
 =?utf-8?B?V2hIczhkL2pMWWV1dXcwbjRFVStNVlNSak41Z1RQKzdSM0dYdnc0ZWx5MXll?=
 =?utf-8?B?dGtNS2MvTG93b1BadmxCQ1dUbkpqUlhJUmszdXhDMEEzQkZLTDlDejRqK25B?=
 =?utf-8?B?TnQwUVh0bHZnNVVwN2Uwem5JUmw0Y2EvYkorTDhUekNIYm1uOUZmYTJaVzVI?=
 =?utf-8?B?VEQrNEg0MVBuMjgrOWpTK1NOSzVOMTVFRmlUZU1xa0QrMG12cVB6aWRSTmM5?=
 =?utf-8?B?Uy9lZm5OemtlRmtOckUyYjVBRS9oellvVnVYbUNjcXlKU0s0R3NrZi9CV1Rq?=
 =?utf-8?B?bG9US2g2cVd0cVROWm01WWZQVEoyRnlzbUROV2VRUm11K29oSjdvK3hvRFRP?=
 =?utf-8?B?dk1QcTZnb1dOT0pqMUNSengzb09wcDdlZHRrbmFXaVVKOUFFZnFpKzhuT0s0?=
 =?utf-8?B?UUgzbnE0WUJUYWU3UmIzRzI5UEJEYVMwUWM2bFBYV3lqLzBUYUhJa2Z1NWxJ?=
 =?utf-8?B?eUJCQlNVQlJ6QTZtTE9NQzBuK0lFZXEyZ1lrcDJGbXQrY0xUSDRpWXJsazVU?=
 =?utf-8?B?cHZBZXhmSFd4bXJjY1NUUVljc1drNERaRnpwczFLa2RPdTAzRTB5ZUZoSnpV?=
 =?utf-8?B?VCszb0lYWEx6MFMwWGpsaVVGdTZLMzlXcElzMTgvaStOUytneUYzQlNTWGF6?=
 =?utf-8?B?TzVucDRWWUxCR1h2TW50VXlkOVVBeDNGU1Q5V2l0dFRoVGVRbUlrYWpIaWRy?=
 =?utf-8?B?UytNdEVRSkZWd1B5V1ZIeXpUU0QzSkR0TmZCcmxPYisySHZjL3VRZ3B3VjZL?=
 =?utf-8?B?ZDRTRWU5TW90czUvOVdJeEozdWJ2YkRjNHEvamFwcXhWOUd0aEhKNEY1Z2JY?=
 =?utf-8?B?MW90RkNvZUJFdmxPc1VTa1F3ekZ2SGtMWVppK0ZkTjgySkxoV0lteTI1bGt5?=
 =?utf-8?B?OXo1RlJVc3NsVlNMTy8vVGcvVzZTTlVsc2JPbC83NlZMUVlqOTF3dEZSMnd4?=
 =?utf-8?B?dWNDZEdtemhwVkdQdTZReGhmZVU2ZklsWW4yRHpDbVpJNnpORENFWHlhci9K?=
 =?utf-8?B?N1ZGUlVPUXBpeC9rZjdRMytFOGlPK2V2a0p2TnFlTlp2SnFTc3ZRY296Wk5N?=
 =?utf-8?B?WUtNaUFvV2F0alM0eGZHcHFQcER5dHlQSlY3L1FwYVhMbnIxRFhNTEcxRlh1?=
 =?utf-8?B?RkRtWXB2MHVSVHRYKzZ5RFh2TEVlVkdWQS9UWWZTd0dBMEhGcVdIS3htTDMw?=
 =?utf-8?B?WWNnMmZYMTh2aWU2ZU1CZDVHTXRybHZwdnVQaHhvNlVmOWpiM2xkTDlyL0RN?=
 =?utf-8?B?cGQrSFZXMXdSTFRPZ2R6eUNKZjhJeEs5ZGxkSXVsZUNVYSttSkQ3TzFrZ1Zr?=
 =?utf-8?B?NUJUc1c2ZE1FTEQycjl6WUh5dXp4RkYvZmRXMmhBY2gxYjM1TkczNVRPNVda?=
 =?utf-8?B?SWx1Q3lrQXp5dmZKbE56cnhwMDVnNXV6OFJYcVdpdEdhZDRTV296UnIzN1hV?=
 =?utf-8?B?TXJnZnJ1VGpIbU55eTVxWitSU3BsTUdkK04yRDR0TnhYWVFZQVBhOS94UDRH?=
 =?utf-8?B?c0Z3U3RZTHd6bUVIZ1cxeW5SVVFFVzJhMno0QytNbjFYOFdzeWlJRnFMVjY1?=
 =?utf-8?B?aGV0MVNWU2lzc0svSks3TGxvdHVvYTZRTnN5Z01DaVhJM3lXbCtvNXI0ZlE5?=
 =?utf-8?B?VUFCYXUrc0t2YVNHL2FuYjc4UjlQZGVTTE81eGIyUlFYdnFzSURJbTdhc25u?=
 =?utf-8?B?M2FFTWtQQU1FaUx3ZFlKODAxY1QxNFhnZjJQOGxqWHozY0lIOFY3eHJyZmQy?=
 =?utf-8?B?T1BHVE02eExUSGQ2blc1TlQvam9odFFPM3Mwb2k4UXBJZSt4Zk5UTG1yM2xm?=
 =?utf-8?B?WWZESVlYdDdNU0pqVHRBWXc2N1ZRbDVMSTJoc1ppR09RblVyejhxNnFiemhS?=
 =?utf-8?B?ZHpPL1lSMW5KNmhiSzdwaXVrd1BUTnN3MnhWQ1BVcW1TQjVML1RxcWNOajVR?=
 =?utf-8?B?QXNGdHQ3UStjTDRMVVRnd3B2M090SkdST1NOTFhhd3UrbFRVcW1EcjRWYnBF?=
 =?utf-8?B?WThyc1NJaWo4M3FIT3hwMUJqZnZBYU04M3cybTltMEpWd3ZBTUpnd29tQ0FQ?=
 =?utf-8?B?bCsrMFJJYmFrSlFhS2dEamx2cU1wK2pwWE5vdWhkaG5hYmJyTndiaWEwaUJr?=
 =?utf-8?B?ekwzM3o0SzFqQ05UMktCeGRmMEphSk82U2hTbi9BMGRBNUxGdmdMY3JXK0Zn?=
 =?utf-8?B?NFJ2bExxWUlXd3p1M3kvQXBmcnlDUEhhM2szTkIwVURGWWRFU3ROcGp6NFN6?=
 =?utf-8?B?UXRLYTRwMkRsRkVaOURIVC9MRWErZjVoTHJQUFFsRFBzYVk5YWp2YzBkTkIy?=
 =?utf-8?Q?KjTP06N7UsMsfkbk=3D?=
X-OriginatorOrg: gaisler.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce8517f-7473-4dd4-b392-08dec87d5ee5
X-MS-Exchange-CrossTenant-AuthSource: GVYP280MB1290.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:23:12.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 91fa4a59-2167-458a-8318-e45d80469d7e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00fWSsizEo8rj2Vr05W9thVUclkWmbi9e7h/xMIwI8NOgk7fJdyWpbH5958WiUdNTBhuef7sKmAcXVOoZLlbaemauuE0SK8lQScCELfxltQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB1069

On 2026-03-30 08:29, Pengpeng Hou wrote:
> led_proc_write() passes count straight through memdup_user_nul() and then
> unconditionally inspects buf[count - 1] to strip a trailing newline. A
> zero-length write therefore dereferences one byte before the allocated
> buffer.
> 
> Reject empty writes before touching buf[count - 1].
> 
> Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  arch/sparc/kernel/led.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
> index f4fb82b019bb..b9758fdbc054 100644
> --- a/arch/sparc/kernel/led.c
> +++ b/arch/sparc/kernel/led.c
> @@ -70,6 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
>  {
>  	char *buf = NULL;
>  
> +	if (!count)
> +		return -EINVAL;
> +
>  	if (count > LED_MAX_LENGTH)
>  		count = LED_MAX_LENGTH;
>  

I see no need to fail on the empty string in particular when further
down we have a default case:

	} else {
		auxio_set_led(AUXIO_LED_OFF);
	}

for any string not matching particular cases.

Instead, please stop the incorrect buffer access with something like:

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index f4fb82b019bb9..9b53ac1fe533d 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -78,7 +78,7 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
                return PTR_ERR(buf);
 
        /* work around \n when echo'ing into proc */
-       if (buf[count - 1] == '\n')
+       if (count > 0 && buf[count - 1] == '\n')
                buf[count - 1] = '\0';
 
        /* before we change anything we want to stop any running timers,

Thanks,
Andreas

