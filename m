Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48D1647;
	Mon, 27 Jan 2025 04:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737953084; cv=fail; b=IXSOWXhmB8cUjfIWS4ryGWakHDlh7iOLi9f4uoR5tF6qg96jgRI9B03Kmmsss3VBnnZqrt8jqsLVfs45jxpYrE/u3x91Ryc0fArMFbVF809n62g6BJhrC3BYZ8zdpmPDOy5MsTPkil1X6DFhPUukHGcPY6Z5pC6q4RqAxGLr51k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737953084; c=relaxed/simple;
	bh=EDsgP0MbrX5FhpRCzrhFSDLYor+JaBEj4e9Cc7VJOvw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V+2TqK2zHrPkpDL6b0uSGWLAHcI14Oj4U0p3YSLYuqE85jJF61U2KimbIb+XI2fZ548S5gYGyo3ZFRmpypFizCLoPs2HfN4ZZf8R2O5H3HVqiz6HYg4JvIwJfyblc3SlRCA3GAfK4eD1OKjjSTL+IrRSNqC/wcvuxD1cQTWd4KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hT++iAra; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cZQNcoBG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hT++iAra";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cZQNcoBG"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R1fJZR005127;
	Mon, 27 Jan 2025 04:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=VAULhEB9G123yCahPm5RnTOYI/0wWvysMcrknUItUBE=; b=
	hT++iArags7N9Lkavv/dfXCPBc5SCtlWW9yaXDtA131ovHHEnU1YIRbkWKcvTjt8
	ww7hUB8aA3JqVeaELQHzbS5G7KVyDoFv0cNdjao5ZlGAMwXDTXlswb6BOk8QY5OD
	3ZtlsMsDq/2aBtEVw5JZSHGMs8QsMHd14iRpLDnYRy4TFsNsZnLxySF2I5qnkNxG
	sFbBEHw1JStQdlZh6XhYffbcXHIFfDYWKHGWYQ8Ve+nBCfYEs7HwtoxHD3vMZErb
	tkhr/ogZ7F9IjjrTEDjgfCt8guEqcdOHJrQ17UX1NBgG4k752CkrGDhN69Et9cbq
	I0oCdxoVGA01czTOPijNAA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44cqjshrm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 04:44:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50R4gqHe016404;
	Mon, 27 Jan 2025 04:44:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd68bgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 04:44:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuleAEBZhT2TDGWCBObFXVGArjjrQsYh7HWSH0h4od4gg0jfCJaTmzk0VB50Bqe3tqGoUnjc08qnMrdkCy2HlyibsV3e8VgIUs7DpvXiEgAouS1ZTyqkIgkNj4ST1rm2cnwiN8hRKx98OSZp4xDORu5/BUIZ1pOwLnnMqftJNcaFeCZE9ea3h8d4kT9+51HgsSW5eRyW/w+Ahfxcc5CkPiPN+yVce0E8xH6WBCnrO85HpnmGWQ16X6eGDwYEEJvjCZwWi5YiUExUKjb+Q7+2cx73ts/WscJCTRyOw7c4joxNwDbFNXf9PzdZ+UsmVS6pjJ+0sKY4AeqTvU0swClLUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VAULhEB9G123yCahPm5RnTOYI/0wWvysMcrknUItUBE=;
 b=U8Jv29HeLRZa7V7fIlhCYAfCbZI1IKaUlT4wvKmw2AobGQtr/bOLCxo7CZoLQBzEyVNJJgPAet8jKmFUStigGGXqCAq+AS2HoCKfH/eoB+lvQASHilo8DmQYLiIg12TCY3RylA05RQwJYY2DXgfUSTJ4jckzTWgCdx7KfQeJ0/wy5waoCcNwfitdYWB8tvI5qxQpxy8IP67Zi2xrb/ZIp+xlk30hNeawVjCJHoUCHaLshqjWnNrMkvZFl3VPij3TL2vPYI90cEnB3YZPoZA6YmGCJD+YHn3RGRf5BbAjaaiBqJ+mhpotkv8F5C4mg9g+SiHOgOHg/k1QQzd9Lp1gKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VAULhEB9G123yCahPm5RnTOYI/0wWvysMcrknUItUBE=;
 b=cZQNcoBGUNaL6MPOxfv14Xi9mm8eKYBpCeavE4Uprqfrrg4kc55beEEJuPD/G/bBGLALG1ukEnGKHfSwDoL2Ufw9RJ60j87q5+C0Qa6UnLDLZbZhs/g1r3eo5MiRl/gqxDGnHqUoXYTJ0fAl5BtV4so2dIRbltL4bD3ZJY4mddI=
Received: from CY8PR10MB7266.namprd10.prod.outlook.com (2603:10b6:930:7c::17)
 by DM4PR10MB6790.namprd10.prod.outlook.com (2603:10b6:8:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.20; Mon, 27 Jan
 2025 04:44:28 +0000
Received: from CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::9714:91fc:3a27:9ec0]) by CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::9714:91fc:3a27:9ec0%3]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 04:44:26 +0000
Message-ID: <9eae09e8-d842-4fde-ae10-921d8d844d94@oracle.com>
Date: Sun, 26 Jan 2025 21:44:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] oradax: fix typo in dax_dbg message
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Kreimer <algonell@gmail.com>,
        "David S . Miller"
 <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20250123201909.15469-1-algonell@gmail.com>
 <cbabbe58-8b11-4bf8-bacb-5d4154b8a571@oracle.com>
 <e0de2eabd5026b1225964a272c87605052cd156c.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Gardner <rob.gardner@oracle.com>
In-Reply-To: <e0de2eabd5026b1225964a272c87605052cd156c.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0172.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::27) To CY8PR10MB7266.namprd10.prod.outlook.com
 (2603:10b6:930:7c::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7266:EE_|DM4PR10MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da2b24b-d06a-49d7-a502-08dd3e8d4760
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDVoWktKd3RtaGw3Qk9yckFOMEdoRjVoclpYVGRSZ0pFczdzaXZKRVQxSzRr?=
 =?utf-8?B?Umg4aHdZd1hrSDUyUEl1N0hrRHAya1Z3UVExS241SUlORjVWQks1R3d3YnE2?=
 =?utf-8?B?Z1BZc3JoTWVpZXlEZkdRaThUbUg4eVVIT3VLYTY1dEtDZUZSdXVuZCtvK1hi?=
 =?utf-8?B?b3ZXUWRjblVBY1RYemh1M2RkYlJYRXo5aWI3TU1ybE1LK0ZjVm01dHlOVC9h?=
 =?utf-8?B?OHdQWGdJdmV2TjBqdnl0M3lLV2ZhUDZ3WWRlWjFDRzNnM0ZaVGZBVUdFV2xG?=
 =?utf-8?B?ZzZIcGhoQ25wTmdjenNtMGpweEI5YTVxdVdlT2dFbjNTZEVHa3RCTGVoL1Zn?=
 =?utf-8?B?bUExdWh4QVVGb0lPdjFaeS9GWk93L0Z5U1AxVWhnVEJ2ZThGWFZETkRidGJl?=
 =?utf-8?B?Mmx2ZldldzVzRW1KUGYxZktrWTBOZ1pYa0ZCamFaQXlLQTAxTG9OUk5LR01W?=
 =?utf-8?B?cWxyRDRZazBrWXBQL3VJd2pmdU5oSDdibzYyZ0M4c1pLdWtQb1h5VUMvTFNZ?=
 =?utf-8?B?WG1WMUZRcXZyMnJEV3ZDYk5acXo0K0ZsbUdZSnhtYk1sMXN3d2poc1F0SWxO?=
 =?utf-8?B?ekE4QzZUV3ZoK25DVWFzcGJCNVA2NkJEWnljajVQc0k2TTNVaHNjTUFOZ2VX?=
 =?utf-8?B?VCttMGRQU1UvRWFYK0hlYVlyRHJid0pGSHVHMFNWTENLZjU2TUxQOTArUEpG?=
 =?utf-8?B?dklzUWU4N3pBVVB5WEtRTEFOYmhtTGM2N2xEcDJBNUNvMjJGcUxjZ3MzZ0gz?=
 =?utf-8?B?Rms5ckIxcURMYmRselZNUkUxbEZrQUQ0Njl0Y0RGL1BCYlFaMGU4Z1BNaVM4?=
 =?utf-8?B?U203TzFDZ3IzRFNjR1hRTmJRSlV6M3VlSkVpL0NLWjV5VTZtNGhjVHJmclNx?=
 =?utf-8?B?aGNQcy9VWG94ckVBK2psRXd2T0tYckVCMWdUZW9ROTVEVWRGTE9QTlpVUk9C?=
 =?utf-8?B?MVplRy9Td2hjbDlDcjN0TmRXbk1xV1o2djljMzg1STI4L3l4SkpySWRKeXFF?=
 =?utf-8?B?K3ovdGVPeExvWFdRTiszWlZKS0ZSMG1QTGhuclFrbzJDUkowZVdrTzl0SXp3?=
 =?utf-8?B?c0xpMHk5UVpvTE5TVFFRTkpQclB5VDZRTkVQN2d2N1plUkxvNnJBcjdFcXZo?=
 =?utf-8?B?UVRaUWVhazhCZzVyVEZydTNTSEROamxkbUF2aGcvY2M3TmhLT2tzSXJFVnNx?=
 =?utf-8?B?TFFYbDNlbDdhbERjb1VjSkU4SUczUFZaWnNlTldzSy8wY2JjQlJIWTZWUC9F?=
 =?utf-8?B?TDRVelEwY0pOWUJPQWFqOFlTZ1NRRW5ZbmlSL0h6Qjl5Q2xqdUFhOUF1UGNW?=
 =?utf-8?B?eTl4eVdEeXN5ekVpbnVmeVViaGgyU2FUbmc1VTAyeW10YmlnVkl6REQ4Rmxn?=
 =?utf-8?B?SEdVWDdZZk9LZUVjbG1RaXZTamhUcllnMjIyWFpQdFdyWXRIbFo3ZjZ2YmM0?=
 =?utf-8?B?Z01Lbld6dVhJWXVSS0xtOVBwMXRjemp0SEJJaWV0M21HRDdIL1A5QjQ0d1dI?=
 =?utf-8?B?bEdVVDhBZUhtSk41MEdoQ0JTV3ZyUE52SDhNa0M1ckxqd0MyS1lDS0dCb05F?=
 =?utf-8?B?bklyQW8wcDVXSkhGaE5obFBTYTBHdnBjVGg4VW5nWVdjZFZVVFVoV25abU0r?=
 =?utf-8?B?QVFaTHpHWWYveXYzcjJhVWVkTjgySnA0UnQyWkJFTkd2OGJYczl5eDhSeUVQ?=
 =?utf-8?B?OTU3TnVFdTFaZHNxRG1GMjJmSHJwVGFyVzgwYzBXUHpOSGZWYm1lVnFtWENx?=
 =?utf-8?B?YXFsVkhhWEs1b05wa2dFTi8yZTdMWkRuWmU1S3luNDNHVzZhU2RFNXF2SlQv?=
 =?utf-8?B?YmZZcWZDelFVQWNuU3VIb0lPUC9WcFdZUU9oWTJJMTJBSGloUk1QUVJiZUsv?=
 =?utf-8?Q?wI1UCO4OzRIf5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7266.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QmloTkZ1RHgzMDJ3aTBJV3BzeDlCdzJHb0VEWWdhd2NkUUpsM1FqcUFKdmFo?=
 =?utf-8?B?ZjJmNjJ5WU02a0dpMnNIbU9xQ284OWMyWEVYT0Fab0RIbDZYcjV0Z1E4dDdk?=
 =?utf-8?B?UWt0UnE0dHNkLzN1VXlEZVpXVjhOdmZ4Q3VHUm5YK3dqV2o2YTBqemEzaEVD?=
 =?utf-8?B?bjVGWUNmbHYzSHY1THVESFlIS05JTTNyUTkvZ0hRa0NVYnZJSmgxY1gvdHhq?=
 =?utf-8?B?OUVETFhGenUvaTUzRzRVVmhWZG56UjBDRkdmbDY0QUp1SnhUSlZNa2JKdUFk?=
 =?utf-8?B?R2xrVlhma1hWenVLSFc5NnZpeWNZc0s3Z0hYT29WbXk0U2Z6NDhyYjBybThI?=
 =?utf-8?B?ZUc4S2dtRDBGMXo0czhaZloxL2dKWDI2YWZ4NWg5bTNBNDIveGVaUTV5U2hL?=
 =?utf-8?B?WHIzdDkzc01RUm9KOUZIa1gvbEtmZ3dMU000ODV3NXBrM0xTK2tLZk5sWmRQ?=
 =?utf-8?B?T2xGSFFjUmEwTkdYQkRjUldWTXROWHhENFo4VjJmUlZWYVBLZWpIVmtJWnVn?=
 =?utf-8?B?a3l4S2MvUndZQU5FTkE4ZG1ydjhQRHJPWktEZUZReGRvSkFnOFVNdmxFa2s4?=
 =?utf-8?B?bWpEcjNZTzFzd1BrRDJCbDJkTzBoaDFOQzZjeXM2N3p0b0xGMGJTUUJVUy9i?=
 =?utf-8?B?OGNHdis0VCtYdTgxQml0UGNmamhUY08yL3lZVzFXd0pWOS9TQm1ITG5PeHRN?=
 =?utf-8?B?L1FCZ1ByUnlicVFvL2dJWENXSTVYaTZ1ekQ4Nkd5UVdBY1QrKzQvU2JnQkF0?=
 =?utf-8?B?ZDVDRXVSVGh2dEZsc2c1S0Ezd0tqUlhtNCtVMTlEVG03S3U5b2oxZS93SzIw?=
 =?utf-8?B?TUErVStwYlA1b3pDa3V2VzREQXRWblhVSUs3SjJwekJndnhEOE1VdEcrWm9R?=
 =?utf-8?B?eEdsbzRUUDI3T2V3WkVHREMxNTg2L3lLZDVXN1NNTjRDd3dOb05SU0sxVEdN?=
 =?utf-8?B?bzNqcGZqRU44TXR1bllEUURmenVaWUljcmRrUGV3N3NGa0pBcjNnZ2Y3WkRq?=
 =?utf-8?B?Mzl2QjFlcEhUNHJ0LzdPS3R5a3Y5R0hHc1NXVFZLUFY5OVZSTmtwQjRxWWdi?=
 =?utf-8?B?K2JZdWpiWWthaENBZjN4YWRtWmV0NURvKzBDSjRKT2cwc0xaamplZlpTK3lx?=
 =?utf-8?B?Sk03dk45S3Z6WXViTVM4M1A0YlZ6bTB3YmhPWmNobkprV2M2MWlPNFF4TXVG?=
 =?utf-8?B?S2dKVnN1TE9TbFBVTTNEdTN4YlJpbU02YitYSGp1Ni9lR1V2M205bGlTZmdN?=
 =?utf-8?B?bXdZOTlIdVZuN2l6MnIyNTNlczRFbDlMZnNFdHRpYmlHODRXZXZlRHNUNFUv?=
 =?utf-8?B?K1VGbzZPcm9aaXJpSFJxaHZVeXozSEpGVVQ1bGR4bmI4OEtYdVkzcFpWVGRt?=
 =?utf-8?B?cEYwWk9ZQkIxMzc2TEk2MmN5SXoyb2VNWmR2L21xYTVsWTdFZ0x4ZEZZcFJG?=
 =?utf-8?B?NnJDVHFuV2JNUFg2b242dmlJcjB0T08xbDdDMlBMS2J6ZWM5QlpLekM3Qm5a?=
 =?utf-8?B?azF3cWZUVXZvUVMzdFJ5ZFJPemJTWjdMS3lSajhHVlRzWEc2aTd6RmJreHhu?=
 =?utf-8?B?cDVycElLYVg2S0wxL2RCRUYwcjRyazVvR2dPWnlYRWdLU2RodE9JNkRnOFZO?=
 =?utf-8?B?WG83aDgwZlRreW1Cbmh5VGs4NGM1elRjTVNmV1U1eWtPb0cwanBoUHZwaDlT?=
 =?utf-8?B?eDdXTnovSzhFTU9RbjdFNDhqNHBiTzNxZlpjSlNZRitDeDVralZZN3NzalZu?=
 =?utf-8?B?M3Vkb3JZMGQzNmtqM2lqU01NQ2lWQ3EyU0RhUXJwUSsreGRSdDJjYXhOMWt2?=
 =?utf-8?B?VFpoN28vTHVCUVZkM0ZpZ0ZsMjJ3N3p2TnhGbVF6ZzdrY0pRTWc4LzhKTXBQ?=
 =?utf-8?B?blJsaHdIYUdFUFNIRkUyNzFmT2pxU252L0MvaURxdGQvQ1kweGJTaEppUjZi?=
 =?utf-8?B?bnVKaDF4dEE2S3UzS0NWVHpOczFjc3lXWExTVjRaVElUWm1SdHVKc1ZldFRl?=
 =?utf-8?B?ZEQzdjJKQXliYTlWK0x3R1ZhbnF6OTJYRDVKTUk4Y2RlZ3lYLzNmcEttK1FQ?=
 =?utf-8?B?dXZicTN5TEc4MEdYbU9UNWhUNHlmNmhOU0l2Z0I3TlQ2cnBiNS9nck5mOFhh?=
 =?utf-8?B?SzFGRG5EN3BpajR6K1gzYWxzc2d0UTBBZGwxMEVUcVlZbkMrbENjRjZVOGpa?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ty6+dN3vzJ0giVoccpHmA48JhHqmwdwVcNxl2dP8pgxx6lAX7tuNEsS5Xh5z6vS2zuLAaDN+7ZoOPL60K2TXDgQKvMfwBocRCIp/qD2vaJIYAvoXZPAQEQUzOdXU0iUJDNo9PT7ZAnLhYsmVRevIN8vI8/je9aXnaoQTqBaqR+LskKprlRQSnPCl761a5XmQVCls3ZTWyyNjc4NiDZ1nJYJAdwyJd9UpDW5hWXgzdkmPsj7fUZJphuSHtIhKvidNtPFwaDC+vJbM+JnwYSBTw8xLJVDOwwaWDhwrpMcui9DutsqsnA5xpux7sNLPDVBx9C+XZpC2I9pysEOI0poEDaFa7gHtqBgMueALPYHQ5+C7HmqmAJvWfmLywyLbRDsj047/62XwdZ5TDX4WcRV4rjknjdGeQVgWAnc8rExRJJAFIXJSNp20LdBhzFDQCHT5vPFqvuBaqZqoze9JOlHuyq6uy1GoDRrxSo2vyru46xYSIQtf1/XLPe59aYxC1STQpQEqT1lLJbNs7ju4hxtp0NVRH/VgQCP2bM53XVNEdqu0szeJqbJxhyEjuZ4C1Fz4V2Ry34/ZoG4jZ13YjqvV4eLVid3kbbrLnd0eonJ8Cvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da2b24b-d06a-49d7-a502-08dd3e8d4760
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7266.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 04:44:26.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mewXvyJTJgSR6MWTWV482yXra0I1D7tlQ47KtNPQP1sVQg9ShGDXAnleN8rSuAfubBkvP29lvfuNQtkH74HE6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_01,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=832 bulkscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501270036
X-Proofpoint-GUID: 3Y9kM4y1cv--tZSX2uX8UVdgQR6vTZ1X
X-Proofpoint-ORIG-GUID: 3Y9kM4y1cv--tZSX2uX8UVdgQR6vTZ1X

On 1/26/25 11:32, John Paul Adrian Glaubitz wrote:
> Hi Rob,
>
> On Thu, 2025-01-23 at 13:23 -0700, Rob Gardner wrote:
>> That is not a typo. "Copyin" is correct as it refers to copying data in
>> from user space.
> If it's "copying in" data from user space, it should be spelled "copy in"
> and not "copyin" unless my English grammar skills are failing me.
>

The resulting phrase "copy in of user CCB buffer" would contain two 
consecutive prepositions, which is poor English grammar. ;)

There used to be a kernel function called copyin() that was changed to 
copy_from_user() in the dim past. But I think "copyin" is still widely 
understood as an /operation/, not an English word, kind of like "ccb".

Apologies to all for cluttering up multiple lists with this trivia.

Rob





