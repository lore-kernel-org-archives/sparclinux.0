Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48D41C3F00;
	Thu, 23 Jan 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663814; cv=fail; b=ih6E0uWWjkuQgZ77xLen1mv9gvklBzwPEz//w5aQzjYcvyds96C+mCotZvbUNdclH5XPoEGYZxYG6xiQz9ItcjYGt6iDYcJIL6njjWgZunwKteti6Y6aHVHMmQUL9BHtm+veaz7DIxXpx4nOmngno2XIn78qdGfuLq6cliy4GqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663814; c=relaxed/simple;
	bh=+OjN3mxkElf4En+BUDHm1CKHDcfhznk9pKXolKpF2gQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gJQEv0x75XriH9QitHe07yGWJtMMTFeqoOh4ozwLgbbqayiLdpUO9kYPWgKluITlgGUEQ00NvbUYWwF+jd/EwEc7ZDcNV/EFkyed5auAhaoHkDL6ciR9/jhglQ6sLNDZopDBTZu6jDl2DTbact3/TgBcGMxOZyTn/ZJ8ldmzU2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EHcUnrIg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Sjas4DsK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EHcUnrIg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Sjas4DsK"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50NDaNT2006787;
	Thu, 23 Jan 2025 20:23:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1IwXKmghaEXpdasLzHQSdqmSMV1oA1P1VZ84zizKfwU=; b=
	EHcUnrIgh2qG1OnrniXHpICoCXpXR+hvVdSF/Df6TdHOIAWvqDI/HXKyh9uAjNMA
	CEklt251LJdSN0pVaM8FyT2UU4y9SecPKj68K8WNcZ2JPA72EtSrIkBOKdt7orOt
	D8hEaRqioohuWFge6DShHX0KZwGyzkSDXwM3TRPzEVvzkweTDpwm7Agdnzy01g1P
	ZDTbLJtR93ikqk0AEk8DAH1e3tbzFaOVeUI2+YysGJYL/ItvjsDVCWH8LNhPdauK
	NDDNyoXTMQMcN8TauXiubRaa62P4INxIE1p/j6BrTn//4gJtkH5b2WRiApc8V1Uc
	8hbZ/dPDj+HmAkDQgNN01Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44awyh3fh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 20:23:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50NJ0n1J018637;
	Thu, 23 Jan 2025 20:23:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4491c5g6nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jan 2025 20:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsA0gicZ2p0ebmsHqpby247s0pcfV9NyKXzUZ7poDzHnc9jqNie7sDfFmi0ZeG+gP3jL+TV0Pr4wEj7QHLWfn0B4bvrTsaWiDVD1SKpvyUvfju7vsAVELUabB37aGPrMeGRCMlTmvZwLFclja0/yL738omCo+bdkB8QoAX3sxx7AQW+kKdrPktRQppI4OAEtYq74gptiLaVeubU69M8GN0s+wjtdQDQc4Yp1/brUxs5imD2Yqtl83NLk2Dv5hXyLDhM6rqgd45xZ9XNCC8i2PosLM7tqdcs/lLWd6I3WPriNWPVkF2gacpMVcd3Ml1VgetQ1Z/8Iq1vwzDrEVpbEtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IwXKmghaEXpdasLzHQSdqmSMV1oA1P1VZ84zizKfwU=;
 b=hY1zco2oQO2Vn95gN5UpVwMtgQcOdNK86PKe5/tme9I7HJv1S+5hUM/8SglZaW7YaoSy+KAId8RqOLYVr4q4A8P+iixX6HY+aYAdDxA2eLOt5AzSruuEajtO25NTGbqJcHinVop35lET6QWMAEDIaaSZQEf0vCIyLDYego/z5rTse455qECNcyFrcwXKus9yrD8v0fQoa8tUo9YHlU5UEhRCBqCrmyheyInOFkWMmTJp7obQXO/vrTrVeBmYVbva+PA8DJdEr6Q2u3Abk80d8NBWHpVke3jAVu1lwgyLX7CC8Uw7JxMOvRJJc4/xQmmXpSoZytJoCSLitsLwWVy05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IwXKmghaEXpdasLzHQSdqmSMV1oA1P1VZ84zizKfwU=;
 b=Sjas4DsKKFuPE/jNvXbo+AKVrYqUruUM/nkVRVZOt7KhE2pvxVLhD2eF8hByOlvUZ+XghECHRa3y908IMOpHLfT/oyRrTJohvTIRIgc0PkD+fVTfWDoQiZmA7OMXWcN+SBF3DX/vnphn5VrMd03K0RhJ7jnWAXkDaubiRvXEl+A=
Received: from CY8PR10MB7266.namprd10.prod.outlook.com (2603:10b6:930:7c::17)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.19; Thu, 23 Jan
 2025 20:23:23 +0000
Received: from CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::9714:91fc:3a27:9ec0]) by CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::9714:91fc:3a27:9ec0%4]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 20:23:23 +0000
Message-ID: <cbabbe58-8b11-4bf8-bacb-5d4154b8a571@oracle.com>
Date: Thu, 23 Jan 2025 13:23:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] oradax: fix typo in dax_dbg message
To: Andrew Kreimer <algonell@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20250123201909.15469-1-algonell@gmail.com>
Content-Language: en-US
From: Rob Gardner <rob.gardner@oracle.com>
In-Reply-To: <20250123201909.15469-1-algonell@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:52d::22) To CY8PR10MB7266.namprd10.prod.outlook.com
 (2603:10b6:930:7c::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7266:EE_|CH0PR10MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: bafae5cc-00d3-4261-a63c-08dd3bebc928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHJYNUhIb0RlWjNMcEFIeUgxSW9YeGU4QkthRWpGL0lLM0d3V1BLZ0l4UENI?=
 =?utf-8?B?djhCNVBlMDA5RmxiMklIcThURzRnOW9WMUMxK0QvSEQ5OHA5bEpGeFNERzE1?=
 =?utf-8?B?Q2ZiVmpwdklNaHdvMkVIMXpVSW04NHRaSU5vN1hJb2VPNW9YQ0c3MTZKTVlG?=
 =?utf-8?B?N2xSdTNEWm8xNUsybW8zS0VHbG5ML0I4K3hNNWI5Q0VjaFBudmFuZ0dkQ21S?=
 =?utf-8?B?cVo1MU0wK01pRzllWWZkUHcxUGhPZWRzQmp5T0U3L0hVT2dsTnBqWFZqS2p2?=
 =?utf-8?B?cE93OXJoQnB4c1R3T1ZZRTBUWmJEZ1ErK2Y5M3hnNWJqOTg2Q2c0bGV5ZW9L?=
 =?utf-8?B?ei9naHJtTm80YlpPbDdBbkZEUHNPMUNkVDh2cUZtcE1IRWNpOURiTDQ1czZL?=
 =?utf-8?B?SWNxS0VjQkluakc3Q2VIT1Vmak90UCtuc24rRnI4RkNkU1pYL2lIeis1NEN2?=
 =?utf-8?B?dE9qQmlrMm16a2ZlQ3h6a0tKb0xoMEJ6VFBFYjJaQnRKYmZGaEZOQWlpbjVi?=
 =?utf-8?B?ZUUza3JseU81TkJkdzByOCt4QTM5SjNTMTF0YkpEMklTdHFtYmI0TjEzR25i?=
 =?utf-8?B?QlQva1dOdDIzNzQ5ODQ1OUZUeFh6bkpkV3ppOWNJUk1UVzBuMUN6SVVLSWhP?=
 =?utf-8?B?TTFLMnlBK1ZPZVdqL3VkQkl1eEwyeEtqQVhjd1ZwY3R5bUlkQ0krb0tQWk1j?=
 =?utf-8?B?dFBJcnNCS3d4cU5KVXpBRXk5YjZvTUgrVWtBQzFwOU5qaHkrL2NrRGpxQ0s4?=
 =?utf-8?B?aVBtTHd4T1g3RjRYYkhVR045WTlhS2ZkdkhORUozRFcwc1Y3akNzVXRwL3Az?=
 =?utf-8?B?bm56VVpTYkJrK3MxS1RqUFQvdFl6SG81ZlBJVkpOL2h4Mjc0QnRsZUVTc1dW?=
 =?utf-8?B?bDVwcUdQSGNoSlFneVp3VWc1REFPSzYyanozNWtRSHcvOXN5RUNYTDZxNWN4?=
 =?utf-8?B?Y3l1K2lYZy9SZVhPamkxNUgwNGJmMWo0NWhiS0tnTnhXV1Q1dElTM29tMzhw?=
 =?utf-8?B?UUNjcXlhU0VnWlVLNnA4bUJHQ0NJdTN2L0pGVHp1cXU2QlVZL2dDT1NGTWFS?=
 =?utf-8?B?UkhjaE5SQnlzNktoUHBERi81bWNZMWVzbTdXM3Npd0Y2Myt0a0lUT1BZMGxM?=
 =?utf-8?B?ODVlK28zZ3kvMlJQTEZXVjRNUFdmTmY5ODFBaG5QV3ovU0dReWF5OGhLWnB0?=
 =?utf-8?B?a2QyYWJpV2p2ZnN3UWJqT2pqc3hncS9PbVRHQmgvaGNJVFBrZFNwTXpqaFpk?=
 =?utf-8?B?YStkeGRPcWp3U1BLWlZ0WFQ1a09mR0lIekxBN0hxV2xVdWQxbmxDN0pkRlZv?=
 =?utf-8?B?c3FDY25UVGZ1UEZFSjduM09PNmxOOUI2WWRvZnB4ODF6Ym92S0pLVVQzUHBH?=
 =?utf-8?B?RUxldGJoQmNtSkJGTW85REIrMW1qWnl0T2R1a2VRN2swVi9wdHhENFlCc1Jv?=
 =?utf-8?B?MUt1cHhIT0psTmNZNXZQalJWWmVYa1pHK3diM2tzTHh2OWlhS0dtMVFCVGdU?=
 =?utf-8?B?eTRaZnI0dFRuaitGWHhQQW41NVFhSG1uMXBDL1I5QnU4L0hmYjE4UG0xN2du?=
 =?utf-8?B?Z2hyWTk1VEkvN1o5R0xCejFiTUM5R2F0R000YTdCdy9xcFZ6aElhV2FEWVNo?=
 =?utf-8?B?ZU1qMTRTOGc2WmhiaCtPOG5oaWFSbDUzOENEalYyM2lmYVhxWkxHeEZ3VHBj?=
 =?utf-8?B?aVZHNUV0YytqOHNnRUVQRm8vMkZHQUQzL21vVWd2cnI4Z3Izdjgvalh4Uzlx?=
 =?utf-8?B?UG9HV2pYdERNUVN2cXUxb0FwazdhYzlWd3pvR2hDMVhpaUJPdUVRV2MydVJO?=
 =?utf-8?B?WjJpQWdibDVDQVhCcXlhV2xlV21qRTE0d2lKNHZGNTZhRlR6OGo2OSt5cjlr?=
 =?utf-8?Q?HGHxoLLnPGFVZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7266.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGRYQWVMSDNmMjdWeEpLWWtTUGV2R2tKdGRRQVF4dFVUOGJ1cS93MGFtdCsw?=
 =?utf-8?B?T0dpSDlBSHpFaWtzR0ZEMGNvSHFhS2JKYUNvZzgrWFBwcHoxUVh6KzhjcE5r?=
 =?utf-8?B?OEY1clpzbTRYb3g0U21jZjVvTnQxL1l3cmlXQjZPSWFqYmVxRU0zYzl4R1BS?=
 =?utf-8?B?NlU3ZlpFQUhaWmdOdUN0enpFaUlwTCtDMDV3U2txVDRIUlE4Z3pRYjRpdEMr?=
 =?utf-8?B?U1k2TXZYQ0E5OG1WN1NhcnRNakJSWm1vbHdjdFFqaEtjUlIrZlpycmU2aEFG?=
 =?utf-8?B?aStlQjE1T2pMNVRZQ0h0eXJpeWlpb09TYlZwNTlsV09Ya0huSUlkWmpQYmJD?=
 =?utf-8?B?MnZpWWRWTUs0Y0hsOXpnQjZocWpkcGp5bGsvb0tXemltZVlkcUl4YlBBbk1N?=
 =?utf-8?B?alZRNzc5QVFqK3pCcndNalBJRWVzbjNoT1RBTGQreXNtMVFKdngwMWt3MHZJ?=
 =?utf-8?B?QXBEdElGcitlWWszd05jTmUvYVBjQ0hOTC9FKzdlY0NBWVBQcVROWEtmYTdO?=
 =?utf-8?B?NUR4ZFZPcFVtbUIzOU12T2E4aEk0U2xRUjhmbmFWY09zR0QyZ3RkWXR0M01B?=
 =?utf-8?B?TEQrNzY3RWpDdHF5Z0ZXRFExdGpNb2ZVM0ZzdVl3bGo4YXZ3QWpKVEFTNDZ6?=
 =?utf-8?B?cTNnUWNNd0tJRXZHcVVpS1VXM2QxVERpN2NyMGN3OHFkbmpPczIwTlY2eUl1?=
 =?utf-8?B?dXVtMXRya2xjMWRoY1piMHl4dHpNV042MWQyeVgvREtBb0szdVd1K29RTm1s?=
 =?utf-8?B?Tjc4Nyt3WU5LdzBUdjcwQmJhdDc0cXJzaWxPQngzVkhzT3NLaWE5UU9sUktF?=
 =?utf-8?B?NkVteGo1OXE3MjJDTHhTVGxXZ21zYWttZURseDNSTGdxUmJpZmdmR1dpejVo?=
 =?utf-8?B?SnppS0VrRDJuNXB3WXdBODUybFVCZG9oTTh5NjkzSzBtRnpidnQwb0ZPQkx6?=
 =?utf-8?B?dDZkcWpFS3FNbU12MDYxbEpDak0ycUJnVDBDcVQ2enJPZkNXN0pwTk1sT1I4?=
 =?utf-8?B?SlpsTFFwZVl4ekZHSUlGQitwT2xQNzA2NDlTWDZOQVkvVEFpWkpQd2VhQVA1?=
 =?utf-8?B?SlA5N1hKZXZmVy9Hc041d1VWOVJYanY5Y2RIelVCZ0QwSHZPdjVlVGl1ZCtI?=
 =?utf-8?B?dnNzcXg4dUJhTkFWSG9sMnhDNFNHU3plL2N3TTV6NDNvekxCbTB4b3k3cFV3?=
 =?utf-8?B?STdrMit2RlhnSERYREFZbURwMkRTSC8zMWpPL3pvcHlDR3ZaNnNEa1dzM00y?=
 =?utf-8?B?b0p5Qmx1eTJFU2JUTUdYZXZIM3ZwL1l6cGQ1RjZ0L0o4Z1EyeDNSTkxicEhH?=
 =?utf-8?B?SHVidVRMNDk3dHkyYWxpMGx5NmJTNVN2aFlxQ2NRbjh2Q0pWYnEzVHpNNE5n?=
 =?utf-8?B?aXBNWUhRRTMycDcxZkRnNDZBMUQ4Nk5laHZoVUFCMVYycDBHajFzWUI5LzRF?=
 =?utf-8?B?YlVhN3FTYXVteXFRMEhoc1Z1c01Qb1JOKzh3S2VqWmNjSHBleHZpZnc5RzJM?=
 =?utf-8?B?TnRFaGxvZG9NS1g5R0FnUkhuSTlNOUw2YlZXSURWWDFtY2lSMnkrbi9wTjI4?=
 =?utf-8?B?SlZ3RkhjOXhPUTNRNnRmTWx1Ym5pc2xsbEZEbWtha2R4aVgzcWh6a2JkVHRw?=
 =?utf-8?B?NXgwT2swTndwdGYyMll3MkRDR0JBRFlxS2VZRmFZdVp0SjlTa2ZMcTZVRmxU?=
 =?utf-8?B?Mll3MzVvYXlNazV0OEczbmgvRG1GQmtMMnM4SGhtbVBnY3NYOVlGNm5vVVVQ?=
 =?utf-8?B?bTkrakMxeVI2bWkyWEFEUkN1YzNuN1NWV3dnQS83anRpMDYzdWl4RGUrNlpa?=
 =?utf-8?B?RUk0ZWlQUEdmd3Buc3dBZDhIeFQ5QU0vNHdRbjJzNmc3cDBFWSs4OTJwUmJO?=
 =?utf-8?B?anQzcWM4anowcGIxTUZvWUVVc3hzNk14alBYSTdDOHJFNVNYeWNYc1lFblBZ?=
 =?utf-8?B?QlhCN09XbGs1NGg5K0tUL0NQOStCL2F3K040SGcwaUNuZ2Ria242RzJodTBO?=
 =?utf-8?B?bCt2cytuRFZhN0JUYnNjZzVPWEQwdmVVOExadUQzTko2dnh4Q2Z0VFU5VHE4?=
 =?utf-8?B?VXcrTFpGVzdNOUhZV0VMMHFYeTMraDl1bTE4VndnaXhSa3loazRFQzJLY2pI?=
 =?utf-8?Q?ARuUem9eKsFY7U4LiHknIeW8P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aZErGG1zHVel+yWaw9dVVaZAfhe4KD2uS7lsFzY0GdRk1yE1DSjl27h8RVMrNd3pWoey48bVzueLylbTYrJksM/mYlhpASLkY/YAf4NvjOdyXcQd4fGc709ifgA/9btjM2mIJy8VGYr55E6nULaNUBB0QrEDDMn7uwqdoQy0Ut7P+M9O01z/jHkGDxA/xbSqr6/yi4YCPSNZoYBOL53haxk36i+iRWgliJLAYfkHn1D/JXCCP3JiJJZZWz8e3t8Sv0yiWrGzq1h55W2lmTf2BvAzcrzrQ8UJZ5wJvvbM4GsUqL8tDLpnUAhaqXkUbLM5/Z1RHcE25faJEYB2GzcGfEPMG+nBFRrckxhho8q/S2QhDjXdL4E+CCfNDtNMHLQRx7tAc5LZEdprDLq5ojAu6qaXDm5zXZi+W9/dYm79cnqmlSlqvwg6pO7RZOJyUhFHe6HaNXU+PRj96e08E2J2yDzD6UtqZc9KaOGjkCJZksEJzKS3t2FOcRBAAOq8jE0Ql3tkFsr+GiRSHGMI3rxLx4vQpbnaKxz2Y+q+FeNCip0aDQwNykKA0siKT98/hL6z9Emv46Ne5Xytr9McxlP+XNHL7nshf2cHfoQkZj23Mfg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafae5cc-00d3-4261-a63c-08dd3bebc928
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7266.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2025 20:23:23.7084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1djfC76FOSTFOWRoPtuD6jsdu2MR1xeMXVXsh2RRGJlg1Z0kp8tDDGNf8KliPwIPNhqcQbnfzp3uhhSE/XPCOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-23_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501230148
X-Proofpoint-ORIG-GUID: UKf2VPJF9gmKmeBROZfOR5tdJ37xMu5d
X-Proofpoint-GUID: UKf2VPJF9gmKmeBROZfOR5tdJ37xMu5d

That is not a typo. "Copyin" is correct as it refers to copying data in 
from user space.

Rob



On 1/23/25 13:17, Andrew Kreimer wrote:
> There is a typo in a printk message: copyin -> copying.
>
> Fix it via codespell.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>   drivers/sbus/char/oradax.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/sbus/char/oradax.c b/drivers/sbus/char/oradax.c
> index a536dd6f4f7c..3f93208b616a 100644
> --- a/drivers/sbus/char/oradax.c
> +++ b/drivers/sbus/char/oradax.c
> @@ -874,7 +874,7 @@ static int dax_ccb_exec(struct dax_ctx *ctx, const char __user *buf,
>   	 * user in between validation and submission.
>   	 */
>   	if (copy_from_user(ctx->ccb_buf, buf, count)) {
> -		dax_dbg("copyin of user CCB buffer failed");
> +		dax_dbg("copying of user CCB buffer failed");
>   		ctx->result.exec.status = DAX_SUBMIT_ERR_CCB_ARR_MMU_MISS;
>   		return 0;
>   	}

