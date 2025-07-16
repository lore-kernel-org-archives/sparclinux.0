Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A982B274B4F;
	Wed, 16 Jul 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684465; cv=fail; b=tCUJevOR1Bauny3KVVYKeIUQEBmi3tphTn1YfpVIUjAQVW0LLhCy1Ovq5FX0JwOmxBgAX0MH8EpsWi5Ql50dTTVuOAUBjcTw+wnanZIXUNa/eLzAKp38UkXAsiNWKDFc3ETdZX7bB7+HnxUuoZlTAl4HH7FhxjcIWkNAa39EctU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684465; c=relaxed/simple;
	bh=v2ZaVuqxxOi/zNFiNn6TRdxa+29Y4zey8C7lcIwUqZI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZOOLWbKpzH4XrbGJK5lPMN+0WJwZh/7+dY8O3nBudZDTazdF2yfwSqHsxNazuGqEdDcixlWmrpypP4ueBcRgaimc+rp8fJedIxisrTOGVY8spe9FSd+MGUuQ7tlELV3YhDH7dOaWAYrVxsDoQ6lxdJ8xRjsonn/zVPv/AKpQyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TZRbkEJj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EPbrIMpG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZRbkEJj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EPbrIMpG"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqRvt021872;
	Wed, 16 Jul 2025 16:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=eCRCfS88jfEwBVssQ+DSURcxw0brNiNlclHgWpqUPqE=; b=
	TZRbkEJjsjZoDufilNIFddIWUjaM6oTNyKYtNxDQ2pfJaCW2yv0IrZMVQmYzV5c+
	C/4NvJERSHIgT2QXQLWvynY7YRYVD0z0CqA63cvsBpNGKCpOl9OvAXqRtiNXVKf5
	3ZVRi7l9rMTU0G7tGZbWo5Vz2lF2JgQb/Qr1WPClir4Q10fwFa8sXhTcRcGCMueR
	OATbua5wULctpm34pWvbqgH+wiN42XRsuHSSo1teGFHk7a1W8s3GPFT9SpbDjc7t
	F7IJj1DQViELro8AnSOdD7yHI9gH1/5YzIcBDinVHV5IrPJIrSOK6FMazLCvJd8m
	2v00xasWsMZTZfC5Va9JAg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk8g1djg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 16:47:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GG9Vl6013701;
	Wed, 16 Jul 2025 16:47:16 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5b3ear-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 16:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erVrPDfRNGYgKgzlm45zvsNPefwDyVrmQN2P0QXap+onAeHPKkf2+Ji3wcadvNNIw/0dqz1O1gYNmirTXXA7/m+8YVFzBF/HxkRZHUGXmZiqUa78F1cypwZbbzmPvmNcUq9WC7nypl0fbErbrKrelIh3aFRP1XXiHPWYtjXfOauWMMNqZ7OCROHZ/E2t3l1mSpCp4S3jOZXUHUsPIohwLRrf9WDjTSQSL6O2kSP90/ccNRahHuQuIP6ybilpIG0y3B4rxcOmga3x/HmxfmadQeP9tiwdTspRQVdCf9Jly0CHHaLQtmV1i2qIll6H+YmSOYSrR+fA4jKVJw2RviJ/PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCRCfS88jfEwBVssQ+DSURcxw0brNiNlclHgWpqUPqE=;
 b=ru3J106WEVxLzHifJD22ie7weXHBs8ExPHCaro//r2dzz7WKQtICR1wwsLBpYJhyjVNPAKkTuWsvdL6sVcWb8QwK04jVuy37WGes4LpWV3eAzGVACCU4BUO2ArQxxBEVbYZOoGkzmkGJnkeA06FIkjco6nzlDsS2qV78xwyVzpL0meEcHv+hhdxZw6i6QoT7EiIoiNXMbza45gVw2/AUoeXc2Dsrp/G2Nc3uDekGNT7SGm0m005uQUqgtBfvJkpWtadNBoW/4tDf5XVYKI5khlO0n1sG/P4OiSi6SG3h3gknDDQFn4QyMoQblQ9nZ34nqT4qux8hurhHDaQoV3Q+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCRCfS88jfEwBVssQ+DSURcxw0brNiNlclHgWpqUPqE=;
 b=EPbrIMpGc52sDb4uuAuwv9cKKNgpXXn1H0J6tMofqktV2QpT2Tl8T6Gd4P9AG64yfEpA+Li08/ricQJaFBH/MfHWGiREtv4073I8Zb89Un1+8NfN85WSbu85eODZoOceAG+ZdM/5osL+WESCwn4NgQIgOjNPCeiPw0RiQJvgsw8=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DS7PR10MB6000.namprd10.prod.outlook.com (2603:10b6:8:9c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.37; Wed, 16 Jul
 2025 16:47:14 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 16:47:13 +0000
Message-ID: <04cf759e-9d99-4826-997b-06ede4e7dbd9@oracle.com>
Date: Wed, 16 Jul 2025 09:47:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
        ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
 <7531c897d8a4dc874bc226f5cb724eb66ee17974.camel@physik.fu-berlin.de>
 <1821f2fc2e339fbb4bc6a4af1748a3462f501392.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <1821f2fc2e339fbb4bc6a4af1748a3462f501392.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P222CA0024.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::14) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DS7PR10MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: d7aaa1aa-238f-4d63-fffd-08ddc4886a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d1VoTHZtWUNTRHAyWlMrUFd1TGp6clU4emtNR2VXSmY3TTlDbXZ2S3drWE1P?=
 =?utf-8?B?RW1KNnFEQVVScjMvUThZR1p2a0VyVElLamlaZXkrNlFob3JIMkFKYmZpTy9R?=
 =?utf-8?B?VHlEWGN1bWpGM2gySHVzNmpMY3QwVVhUUDlaZUF5REZoT29QakpicnQ0YlZE?=
 =?utf-8?B?Zm5GdkRsME9WQUdadWVLTTZNM2FoaGFLbzJoNkJZeHVKZEgyVnZMaGpoMVov?=
 =?utf-8?B?bUY4dFB0TUtDZ0s3M3hDeXVOOWNQYThqUmVDVngxOHoxVmdWc0kzRTRmMThP?=
 =?utf-8?B?UDI4SnUwODRNdVF6WDBNelJ2alFidHFXMm1zYlR0ZGZpVTRTSWVmZkx2NHUv?=
 =?utf-8?B?U2wwL3pYUEpVKzIrSmxkMDJyUFhrM3RiYWt1bjYrYUVZck1QT2QvY3ovb2pF?=
 =?utf-8?B?U0VuNjZmak9ZelRMWm9uUmNOWm9Ma3IxTHltUVFZdUczanRGVS81RnVWNFov?=
 =?utf-8?B?N1hlcXA0VWxWbllVSWg1Qis1bWUxME1jOExpZzgyZUN1ZmRYanNES3NMemRW?=
 =?utf-8?B?cWMyUjJsMTZXWkFnbmxHaWtldmF2dklFZHlrZTgvek5zZFFGNk9RVjd0U2I5?=
 =?utf-8?B?VjcxMjRnTndyVzN5eVFvL0xTZURxYTVLdnpleFBrNDY2RTR4cHEvK2FhQXJt?=
 =?utf-8?B?K2RqKzE2N3YzK0tMVk5FOE03RHQ0aUNQNnUveEdOQmUyV1Qzd3JZRk11enkv?=
 =?utf-8?B?d2lQeUk2VHhYWmg5SkdQSmRQT082Z01jaUhkUXp5TEM0Q2lja1VlN21nSWtx?=
 =?utf-8?B?L1cvZ2dJYmdFZjdOSUgrODVUcnZ5dzFMOXM0VVF3Z3FwWjI5RG5uVWt0bkZQ?=
 =?utf-8?B?OTRDakZVVGkyY2plNGF6dmkwcU5CVGJHN1ZRSVJrQ3p4aFl5Y1JDcUNGeFJW?=
 =?utf-8?B?YmpOY25GcXg2Q1B4bnRzS3NMbytISmk4MTlPWUViMTd5VGpTZjBDVC81MGU0?=
 =?utf-8?B?elNVaTJLSzcwV2pkaDk1NmV6OENweGpFNlhEQmFuWlJqK3U0Q1VESTZINmgx?=
 =?utf-8?B?SytmczF0NnhOYVQvU1ZHYk1BV08wZDlrYlhJZDRQa3U5VHQ0N25VM1dUZjdr?=
 =?utf-8?B?NUJXMFo4aC94SkxHTlFYY0VoQTFzWkwyNjRoRlljanl5Um5xRGVjSE80Sk1E?=
 =?utf-8?B?dkVia2xiTUpNTFBUeWtoSzZ0L2tkZTJaQW50VmVTWVZBMmUvVi9HOWRYSm9N?=
 =?utf-8?B?anJtUHMxVWtkWHhKbktrYi9zODJYRlpPOENiVkZPc1pERHo4d3ZZZGJjMWdV?=
 =?utf-8?B?QXVXdmo0M1RMSDhKcFRXTFRsZXQyN3BVekIxNlhCUHgzbXZsS0hCdzZVa3I3?=
 =?utf-8?B?clY3THpubUswdXZDb1oxclFrR25keUdlQURzS2VQWXl5N1RYWWJMZ0RLRmlV?=
 =?utf-8?B?ckc3WkZrZTloUXZBN05ZUmNhcDFFNy9jeUR3SVhlK0N5VEZVaVlxemVXclds?=
 =?utf-8?B?VkttK0p3Z2dKcjNPRklqblBMOSt2KzNtVGV4aFV5TUtVOFJvSUcrcVZkWnhL?=
 =?utf-8?B?UmNSRCt5MEZNYmdkN1EwUVpySjZZcXVkaUhYTDU1REdNNHAxZHNudjBYaXFE?=
 =?utf-8?B?aHR2RGdGMnR4Q2t5NzQ2c245MFZORC92ZFIxZUdaTFZEbnk0ZTlySWlTQU8v?=
 =?utf-8?B?V3FQVElIZStjVG85TUtJREZyWktFdVM2RkRZSkpvNGF6MDBoQ2svSFppMEZT?=
 =?utf-8?B?QTF2aGIrajV0Q3RhWHM5dGdEUjNWcitLWkZSMmZZMWFud0xNVkJGclVjKyt3?=
 =?utf-8?B?Yy9EYXozNzN0QnkxcGVjZ3Q3clFXeUhyZGFZcWU5UlA4TlBWZ1pSdnA5V1dp?=
 =?utf-8?B?VDlEVVBlbkY3N0NKRk11TkxWamhqZ2ZPcVFCQzMxQm5IRVFtNVd3RWl0ejdP?=
 =?utf-8?B?Y1V6dEpVam1qOUhLRnp0d2VyODUvSUdlUmkvVUJYbWR5Y1hZejYwR2ovdzJs?=
 =?utf-8?Q?13dvJU0gGp8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVhxQWxpSldkYlFPck1TVnlmaUdUdDdQejMxenYzclRqbTFJTWwwekNFZy95?=
 =?utf-8?B?SGlZS2VVaWhIWm50dnpuM3IrWlJsVnhxRHppT1Q4dnk4VzF2QTUvNmFQbFBB?=
 =?utf-8?B?bmZQaEowWnJCZm1WM0E5bzR3VnNJK3VwY2tkREdmQVlER1FVMys0Z0VxZFZU?=
 =?utf-8?B?R2JJWklkMEtLblVOTlJ4RkZoRVUzSEtyZ2ZvQ0s1ZmR4dEJYMVYvOG9tK2xG?=
 =?utf-8?B?YXhnUjlocCtDOGIyUkRXZllVd1hUbGR1S3ozSU5paFB5NjhCbkRNNUtxa01T?=
 =?utf-8?B?Zmh3MWRpTWJpbDNUZG9KeFZnUDBtU1hQL1dYQ2l4a0dWSG4zN3F4cmhPclJi?=
 =?utf-8?B?MWVJN0ZaNEhBQnpReUdnWFJPNFJPMWpRb3JYZHRma1Q2VmttQmszd3F4ZXQ5?=
 =?utf-8?B?V1ZlZ3V0NlZBSlVCYUZUR3hMUWc0bkxWTmJGM0lJREZYUS9sOTBZZHA3SUVj?=
 =?utf-8?B?dXR0akNMdmRoM2ZUTWdUQitBKzVpUUF2UzZ5b0VKNGtkSStJYzFYQ3hCM2VT?=
 =?utf-8?B?L094Mkl3b09sOHdRZ0FiblM2Lzk3MzdlblFIYUdwOUVBU3BlRkVXR2VWNkQ0?=
 =?utf-8?B?aTlOU0xvUTNpaE9ac2U1ZUJHV25BWmxyb29FMTUrMDJiKy8rdHgvR2cxRkVQ?=
 =?utf-8?B?dUtnU1pWRHkyQmpHbkNiOHdiT0FMME8wSloxRCtZN0R1dFZZSTg3Qmh0YmVD?=
 =?utf-8?B?UC9BRGMwbUc0ZjlkN0pDamNXbkdiZ3FBVXN0MkhHK2lYSzkvUTVTeDlSVUR5?=
 =?utf-8?B?VmpuRFAzaXZXd3NVMmN3VDE5eXE5TU9aZUxwRDk5dGRyMEpQVnBFWCtDdGhT?=
 =?utf-8?B?YVJYMkY3ekVMc242bDNRUWUxcDZpR2VyRFRMemZwdDl6L1NWN2hjSlRRWFRQ?=
 =?utf-8?B?cGdpY3Z0bks4RjZ1T0ZuRUlsZUIzczRMZG5VOVJxVFhxU3MxNUZXeTBEK2ZU?=
 =?utf-8?B?aFlSeWhvTDVmOWpTM1hWM3hsbXlFNURDQW1WOTh1UktkY09LTnV4OGF0YnNU?=
 =?utf-8?B?Y2hncnBkTEt6TGllaGxXMVBFaWhQQm0wL2d5cmVGcjlKTHBQRzIxbmo0NTJj?=
 =?utf-8?B?dEpjeTcrWjV4NHZyc1ZMNzRaVUQ1ZDNibEQ5TnJ2Q2UrNmdNQ3R0WjdiL3lr?=
 =?utf-8?B?QmNRY0NhOHpVZlBwa2RCbzZlWjg4Y3dzMTFPTFVReGdwMXhlWGVKYnEzTjdJ?=
 =?utf-8?B?VytaR3NYWE5qeVdSQUVTb2o4Z0p2b0dZV2N1dmVTSkN4eko2OTZMeWljdURo?=
 =?utf-8?B?SzVta08yTVVDUnkwbHk4RjgxOE0yNWtqZmpUa21ZZ1RrTFl0Q3BoZkJSbHhU?=
 =?utf-8?B?UytIK0xJd0pTMjdtSFJOSldKRG9keGVrajcvY3AxcHYwMyt0SHBhNWdLWGI3?=
 =?utf-8?B?RGZqL293SkpGZHlPMDBBNEVYbzM3STgwdURSTTByOTJ6Nms5V1gybzlkcSs0?=
 =?utf-8?B?R0luaTdzeEtjM05ydGlIY2xwRUkvTGdOYXhOektpV1RyMExNZmFQKzJZMXJv?=
 =?utf-8?B?aHJqOEZPWWQzUW9yV0xpZmtyQ2grQjVBemEvNFpMME43UXI2MDI0TEV3NEFl?=
 =?utf-8?B?OE1IOHpkMWNDQUR1VmpPaElNbkJ3Q0JJa0UrY2tQd2ZBRnhReEptMHhGMCsr?=
 =?utf-8?B?Q1dDaG5aSEhwVW9rOUdsbElYNzBqZWNCRXAyZmgvaEtGSlpRVFhZZWVKM3F4?=
 =?utf-8?B?ZWxpVkJYWTNDTTBRaVBpa0gwdGlHQzhPSE5Odmg2UVVyWk1yZ0h6dEI2Y3Mr?=
 =?utf-8?B?ZzczZjB0MEZoSFBpdEk1L05LbWdnWWVkY1RyY0pvd3hwQ0tTRVFhWUhFNWZa?=
 =?utf-8?B?Q1lWdnFUQ01SMy9XaXhHSVpDMEpBL2VhOGt1dnpVVUR6Ri9sb2xWMkwrc3ly?=
 =?utf-8?B?R1pFSDVrY0dGT2VjQXdINFdNMmd6UjNzU3BXa1pKdk1icDZYS2RFSmVURS9k?=
 =?utf-8?B?V2hjVFplTXJEemZ0WU55QWNlTWxaSzlnOVl5MklVSnEvdWV4a0VoWVBjS0dQ?=
 =?utf-8?B?NzRycjZsb1RDY0V4QjY3M1pxd3FPR1hDcC9UdUxWSDNVeUhHV2p3cDhteWxx?=
 =?utf-8?B?TjgzaGVOeU9aZ2d2T3ErZXVUdmV2WDBXWnUxeUF5VFcxNTNjZGY0UW1rVE1i?=
 =?utf-8?B?QkU2cHcxNGFKbU85L3A2M0xuVlFqcmNwYTg3K0lPV28wTUVxS0hySUVuNXQ2?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i2OYiNU5dK+1S/Kw/iYo3Pc6EOoFUHk6wYbSnXwLEiQHP83hpf78mGlmb7wKxMXhSTvdXlVvgh2a9G5weCOQfZP7TozM7mzEgCHThv6/CoCcpCDjRGApz/8+OtDUfd2WmlovKvFvTO/d5aFcpB9YtXSu1NnVUnn8aXc5IJiI4b4iKe9lvYG/Nd1tn6pN15UqyUR5zY9qLrR8N1Y85hI19IvAvQnLflMgDAph1q6tVYeENDGj5Y+mtxGEalF6QNPKY0SRbddLaDDMEe6MDxpxeoRHGGm6RFgkWsEEQ0txtBvOo+uma/876xURm2eW1YwlurwXyJAMPR9Gz3yD4CKOHOSrMZbbakZdG2JsaI3mLWTFlnEFarR3WWz8yMUmyeZlJoOsM3HLjAE+gw2p5lHaYhieJsAZ2nL1lncUMDS93NP9591cSHdz6yg+HMwr1gw2Q0hpPI+EyI5yoEaOz0EhKXSYfo2WQoBSZh7vKZny1cSYJ67drBQxLuWHHjuzodHG9a/gvzixM9DyvLBC3GP6OeISQQyB7czG62XsrBD55xkF6uT49oaLfGXooNa6LJu+0q372d0i8YozcyjPmz+LM0OcZBvIVEZPJD+noT+mxmE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7aaa1aa-238f-4d63-fffd-08ddc4886a5a
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:47:13.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKuYIOb0KgzEV0O2yNdxeqQG0wCxuKFEvSP+T7HbUyd9G0nMWhxVS3d2bKzSt/MNPDej6vcPz5XkxaZ+BuHoMUDYorTHi68CMeXz1nWkEmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB6000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160151
X-Proofpoint-ORIG-GUID: NHql7Ft_SWHEg-rl9NneR1uQoecNLY9p
X-Authority-Analysis: v=2.4 cv=Of+YDgTY c=1 sm=1 tr=0 ts=6877d796 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=4HQWuOB28sff7wrsyJwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-GUID: NHql7Ft_SWHEg-rl9NneR1uQoecNLY9p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MSBTYWx0ZWRfX4+PCr5waE0MT vGWcVRx9SPKcGaFcS9ki8/Rc7bzPJqU3fycexoI6qA/D3RfgDMvin3GZcyanJeliPJfwJopMJCN P7a0zQazyTtgiqjivQVpyVWsdO60FSUnCSGB63KqKYimNaKQn1deC8dG3fpEMyUx4WvIZfdgDBt
 6oJf6ZxE0kSkFg5jGbPBY6+xZJH1ba30/46FOjrAV/HwuzQLgN6vxHEMyx1i0LPcCi6fLRWxCqt uWqems0v5rfrNkf8uLRzEC1RBrw4Q7sopPlL4cq+Gz/xuE1CW85cY/bczGbRtd/QFVgDi+hYD7R xnwsPVK9X+eU9yBSBwxpGaW9sB7hSQ98T5n+Rey2d1MvaF9aVhA6O3z/7VTaJJX6Ir9MG/42r4R
 Dn+o1bYE/RUnp0i0xbwE7ND+Rn1fPirm6hjYq/AjFnnC3N8fwwuSIwLPAItrgJo9ebz8VgU+



On 7/16/25 1:41 AM, John Paul Adrian Glaubitz wrote:
> Hi Anthony,
> 
> On Wed, 2025-07-16 at 08:18 +0200, John Paul Adrian Glaubitz wrote:
>> On Tue, 2025-07-15 at 18:24 -0700, Anthony Yznaga wrote:
>>> An attempt to exercise sparc hugetlb code in a sun4u-based guest
>>> running under qemu results in the guest hanging due to being stuck
>>> in a trap loop. This is due to invalid hugetlb TTEs being installed
>>> that do not have the expected _PAGE_PMD_HUGE and page size bits set.
>>> Although the breakage has gone apparently unnoticed for several years,
>>> fix it now so there is the option to exercise sparc hugetlb code under
>>> qemu. This can be useful because sun4v support in qemu does not support
>>> linux guests currently and sun4v-based hardware resources may not be
>>> readily available.
>>
>> It has actually been observed for a long time that newer kernels are
>> unstable on sun4u while there are no stability issues on sun4v.
> 
> Just as a heads-up: I'm currently building a Debian kernel with this patch
> and see if this fixes the stability issues we're seeing on UltraSPARC machines.

If it's the use of hugetlb that is causing problems then this patch 
should help.

> 
>> I'm not sure though whether the Debian kernel enables hugetlb by default.
> 
> We do.
> 
> I'll report back.
> 
> Adrian
> 

