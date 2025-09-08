Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC311EB5CE;
	Mon,  8 Sep 2025 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757371656; cv=fail; b=IVVRX1jpx8WIk8rb5Vk2aOjQ7VcApLkLrrEYapGYK3h2gNPNbgGvBn4MlRxoyP+qKA9mYe69Upcb4ujNzkrJEkRvkCUDiLG5DCKnzNAW5nai6iGwBNU8i461IQih/JcqmQcBp94mM92cBozB8zI6Try8NWcq7c0GQl0Rpdo4MFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757371656; c=relaxed/simple;
	bh=Li25m0OQq50QHwL4p6nozowEnnhSXeC6ANU3i1ZpWsA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WQ+0xiaoABfVUFPVfumwbIykAFMSSfxEMbzS0hWqgUGJRgdOg/vRI2kFb2+YqeH0HV5yGSMT29bXiutJsnG9zY26mfB651mSXfGPzDZzbEPvk1htbYrI462aTE+5M2GksbrYe7CEQXvQ2wziskaEk5dNVrLIZN252TRVPAQABxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=R7JfFQbI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0Ah52Y+V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="R7JfFQbI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0Ah52Y+V"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588LBhCK025906;
	Mon, 8 Sep 2025 22:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5ARRdwmOE9mB4WMmnrt4mf2H01N9fdC2yLBWPMOHoIM=; b=
	R7JfFQbIUuOgccfCjBTpzDFDhiUPX0YrAglzWxWO6iH5qjinQUzJ8h4in3SgmExJ
	8RV5qXlEHMLMG+iklwOmazNVDWvYKDi+b33SdnQE4p9FTn8Vehegn0HcojOOf35k
	7V/vgwgGO+SV97HVLaQI0CKNxMUGSmTPLDOQ9Hza4pTX9qWLBjDUsbSRfoOJ8Low
	lmoyk0eYXP5JSGrOhDz1qy/aesPWzJTkr2a5Eot8D0t6I7GZ8CPW8tSV0itDm7yp
	Zp/aTjsa+hQAF3jBYgjon8qcLiXL/2nMw2ZFNv8scb7ezzNCifzmBX+1FXu+6Ntn
	fqgoYQjCr5hjyBSB+KBwbQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2rsvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 22:47:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588L1LRv030767;
	Mon, 8 Sep 2025 22:47:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8stjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 22:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8x8Ur+qlJifBTcw8H2e5N7ARff7MgS9g+TUTzA3Gt5VAxKpet0LVap8PESbuSGZ7iCCobTn+nMkvJ8fJqzw0Z9oIyowku0FXhLo3aKZieVuCzLCO2RZxNmZ7W4M42N9baPenlPhubXCdcritUXeQwmkKhCzN3zcOpkJZkpjC4aB+v1JXssDDClhvQQe2k6g9d86Mq9S/iYI4yuA46mcuPXsvdyN52GYWKCbSl9GoLH/7F85rKIx2IkQfcmHTNavXFgdDbtdeTtM1cxy675sCYHd7Dwy0+8SeBzr6k6RRXtEug3pSsfKT50P5d3ToQIL3NpqLTBJEpEZ87JR2xitEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ARRdwmOE9mB4WMmnrt4mf2H01N9fdC2yLBWPMOHoIM=;
 b=PQ+MsWI2mktBKy5Pb258wMbZywOqobFq3LT37GhcSOKpFQHUNTEJaKkpfAfkAIPX0fMPpS8qKfirZEq8EW8Cf/ESZdg7yraWnMYgn4C03BJApjVOXjG2jMM2r49wG5l+OZ/75Q2/x6Md4zNArCP+RUf+GVZrP/xQB5TE6b6z+ZUUpYSpNpJkQzAzu3F65yTzMVYPdtJ746h2u9uENRT3YveMLFN7qye9pzbYxkkXb73Qj9NgkzJT4DJhXqTeAR+jowHQ4VPU3MtkGRMVvqHlNAG3gd8WD7zUdieZ7B3usIxRXjk5xJdw39Wi67sr6sNMPKfJPESy3g+4PyX6svLEtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ARRdwmOE9mB4WMmnrt4mf2H01N9fdC2yLBWPMOHoIM=;
 b=0Ah52Y+VFcYFclYyD1Ed2pWqaZx4MaNsZtZQJXIKVgyOXY7ibI+EwHGDs3ZCQrWwqPXZxZTLYyw2GYm7527Rkn5ALH2cBSikSfe6lciIj6BAcAVWQ8B1WCGqmI4oUxzWT0KO7ZPNFoARq8UYO5Fdlg8lqrhI+MFk1C63PE2qhnk=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by IA0PR10MB6889.namprd10.prod.outlook.com (2603:10b6:208:433::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Mon, 8 Sep
 2025 22:47:11 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 22:47:10 +0000
Message-ID: <fec617e3-8955-42c6-9cca-588e86833998@oracle.com>
Date: Mon, 8 Sep 2025 15:47:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ren=C3=A9_Rebe?= <rene@exactcode.com>
References: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
 <20250905-memcpy_series-v4-2-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
 <326c98bf3adf52da64bc606741770c638409b938.camel@physik.fu-berlin.de>
 <2fe65b101b36304369866e30f64a921591ecdd8b.camel@physik.fu-berlin.de>
 <e791dbb534aac79805389a4b754901c24991de89.camel@physik.fu-berlin.de>
 <c3e1173f99e6222ab09093e1a197d6366bcf2b95.camel@physik.fu-berlin.de>
 <03957ee5ee562b70f7e3278d0ce95b2f52cbc721.camel@physik.fu-berlin.de>
 <603f6661d99fc6c936f5a75e29f30d50650b9da8.camel@physik.fu-berlin.de>
 <a9eec6f5a51c82cd2a20a96d614cfd3095ddce88.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <a9eec6f5a51c82cd2a20a96d614cfd3095ddce88.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0388.namprd03.prod.outlook.com
 (2603:10b6:408:f7::33) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|IA0PR10MB6889:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2c15ec-96fd-443c-2fdf-08ddef29a527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R1JMckNzbWJXSHVuZTcxMnYrb3JhckYrY2lJNGRXUTNvQ2E5b1N0bkxkQ2ho?=
 =?utf-8?B?QUJ6THRFWFQ3L25VNWtUQ3haZmdKY1NLb1Z5WjRSdU1MMWp5dExsUVFsRytG?=
 =?utf-8?B?N01BVG5jaUVIRXRBSlc5MVhML09QWVlIdUYyNG93cmY0RDUzR2lncjVjNmJF?=
 =?utf-8?B?NG5CYThsUG5lRjB1YzJCRERvczJpZk5zZTRCYjhpQVZ5eFlsVXdlTWg2N3BJ?=
 =?utf-8?B?b3ZiNFo5VzJueC9MR2t6NkFSQk51QmQ5aUUzUkwzaEtLQ0EwbVFJeFlDL0U3?=
 =?utf-8?B?Vk9lT0R2OTdhQXgxU1g0WncwR25nT1BkcFI1OEFFcmhGSnlack1nL0lhendK?=
 =?utf-8?B?amV2andKYkFMa05Ib2J3VnlVeGM5NDFiWUVvNFREYjRGZUVDY3NNMm44bUpv?=
 =?utf-8?B?S1I1bjdlUHkxSy9NZHNaa3p2b2hhL2hzVC8zcWJyK2ZCeGJnUmREdFdjQWM5?=
 =?utf-8?B?UzNvQ2h1RDRtVGhjbTFxZXRjQlBZT2RCejdQNVdvZ0d2NTBBZStPSE9Lc3ZM?=
 =?utf-8?B?V0NNc0VXTFJmVHZCeVpIeGcxM2lseVo0VlBMY2tlMW5MS091eitIY2U5dnlZ?=
 =?utf-8?B?SFIxRCtmRGx0eTU5ZGF0TUJlenJXZXhwci9WZXJieFJhVFdkWjNXVUtGdU84?=
 =?utf-8?B?RjFCdUJWbEQzKy8zclBZeFJYQThjaFpHN2t3WUpkYWlybElzWFByQ0luY1VE?=
 =?utf-8?B?L0NRbnRpbWtCaWdtS0xoTzREdkR0THBQN1h2cEdxUnZmUUxSMjFlRkp1OE5p?=
 =?utf-8?B?TFFlQmdzTHB1U2dLV25yUFA5Wm53a0tpVi9FY2FFeEdQRVpqd2IzcUc4TUpH?=
 =?utf-8?B?REc3R1lCSGxTL2NyMzJjYnI4TUlEMUJQSXRMSEZQU29UYWVMUjRINkVQTHhZ?=
 =?utf-8?B?RXRQWVVEb3NyS0ZhMDFQVlRGVHhSeDRpUUtlMXR2aWxkWWFXUHp0VXdCaGty?=
 =?utf-8?B?cGcyV0VVbytjVmpUTGtZWWRnZFJ4YW84d2xCSHpDUFZRa2FFcVdJVWJaNnJW?=
 =?utf-8?B?Z2tvSEh0YmE4dHdTZ1A4WEV5emRTN3ZLVWhvdktFWEtrUE9GeGxrRE5UblV3?=
 =?utf-8?B?WEpEN2RUT0pvUFpZOElxczB4aDFyMXZmdUdXWlFNZGFERW4xa1lObHVzTkll?=
 =?utf-8?B?M052UEdBb1B0MGNDS3ZIRndkcDJHM2dNUmt3d3dPN0xiQ1hYUHE1emxURkxs?=
 =?utf-8?B?ZUsxVzEzbE9yTHl0N1dmTWZnUVJudjdLMnp2ckNETlUyS3NScEd4cW9lMFVH?=
 =?utf-8?B?MXRsYUNaZWMvcGRnaWFxaXgxUEFSS3dYK2Y5WVNEcXhvdURxa21jQkZSenp6?=
 =?utf-8?B?a2VTNURWRXRGM3UxL1RBYjdmb05UYVNtQTIvQ3RvWENndllJTGkyUUJvbWNG?=
 =?utf-8?B?dXQ4NXM0bmtXWEhnSUx5VGZVRnZwQzQ3N1puRnZrZFZIdkV4RS9vM1RpMUcy?=
 =?utf-8?B?dGE3bktqMnVpQ24rMUZwRHZ2ZDhWamVhV3BLNzd3WjJWK2ZQdTlkeGFiRGJV?=
 =?utf-8?B?cm8zWVMxMWZ1K1YyRmJEa05rc0Ezczk2UXM5REFFalFvdTBOUFNGOHJXNGtG?=
 =?utf-8?B?M29GcnNDYU1kTDB6ZFhYYTJPK3J2ZENuRU5XcGQyUU1iZ2xZRTNxNWljZ1R2?=
 =?utf-8?B?b2hrY00yYUsyc2Nia0NpRjFDRit3NGw4a2JjZjlxWDR4ZkRCUlBNeTFQSjhV?=
 =?utf-8?B?VVZnaFJjTGhVRGkwallQZm5vcThENFl4dzFqZmNZOWI4NTYya1VlbGw1VXp3?=
 =?utf-8?B?UmR6dTZzek1UM0ZlUkRuN3REYXVwNjk3a2Rtc0VLU3lzOU1TYWZ1VEVhN0FZ?=
 =?utf-8?B?R0lEMlF5N2N4K0x2akVZY2ZkTXVTb0xwYjZIYkZ2VlBZd0U3dHFMc09lb0Jr?=
 =?utf-8?Q?4lZem7A588Lm1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUJLMGZoZ0hjTEtjbHRBWTExaWV5RWRRNURlY3MxaWxDd3NtdDhheVFzSFFO?=
 =?utf-8?B?TW04bzhFa01RL3U0bnFianhOYml2eDZrWGVFaXp1Vyt6S0NuNHNHZlVvOFVa?=
 =?utf-8?B?NTNaeWdRNm80NGcwSjg3K0NjajZtZ2FKTk1Rb3JKRDNndDBWWGQ2N1J3YjF6?=
 =?utf-8?B?cEdHbGRDNDJySUEydE5TcVN3M1R0dUxyVjB6OWxqT3dwc0ZaRkNlZFZFTFg3?=
 =?utf-8?B?dFdIaXpWOGxxaTQvbWI2V2RINTh4dkNYaWZCeHpKTVJTTjRiQTVRT0NubVI4?=
 =?utf-8?B?QTJSL3o3MWxNU2w1OEIxcTgvdGVqaEZqKzFjWGlMSEdhVkdGcGlqYW9yL2Fj?=
 =?utf-8?B?ZEo3UGdseno0T0VoWFpCdFg3OHJnbmFiaGpBRVhmc0M1anppamVMZUVrbWcx?=
 =?utf-8?B?VXpmYi9TMWpEaEtuQndkTDlzY3FtNUJvUnNtMjloek5rWEFxNStYNUg2RmR4?=
 =?utf-8?B?WXVzRHBjWnpXTDFDdVRoM0JQcWNlU0xMamM2NlBwcC9ld0wwNDJ1US9HaTlj?=
 =?utf-8?B?Y3IrYzJ0VU9xU2lDVVhUVzVGSW1POTVLdi91MFNtSUhLcnNTVDdkR0NVMU83?=
 =?utf-8?B?eWF3T04vTjV0WGVOZyt6Q0NIOE9iY1ptR2FFaHBhanhPbDZOVExsaldUYkk0?=
 =?utf-8?B?akR0dVN6T0drMFZiZUgzTit1WkxhSmlaZSsveHg2OG9PZEp0Y1dEbkx6V0Vu?=
 =?utf-8?B?ZnFobnE1NWwwOTI0cXdsV3loK0lUSEVub3pIM0F1bGh3THI3aStwYjlsY1hE?=
 =?utf-8?B?UTQrVzdmOFlGUTB1VUxYQ2tsdjdnUHRLci8ra3IwZHN5UUwrZW04Tko3cGpF?=
 =?utf-8?B?M1pEbHdwWGc0SmVUd2UyeGcraWZZeTcwYmpvdElpU3FkM3dYamdqSXF2RDNs?=
 =?utf-8?B?blVUclpmMXJvRzZyZ0tuWWJXUjRtdEZVczYxUzl5clAyZmtqbFFucC9WcnZF?=
 =?utf-8?B?OWRUYUs4ck1DRkQvWDZZMjJSN2hEekdqYlRoRFI3QnJWNGx5bU5pMm9RQ0VR?=
 =?utf-8?B?ZVlsSTdzWUErVFVHOU9IU0kwUUtlS09rVFYxUVpqb3pRcTBwcGl3d3BRT2Q0?=
 =?utf-8?B?UCtQbDBpL2hOWG5IQ0dLQVBUL3d5RlBuWlpDWXVNZG52WGJ1T1NvSHhrVngy?=
 =?utf-8?B?LzB3eXM3VlRKdkFzUkdzZ1FmZDk1RW5aSldJT2Y0RXlRV1FHYUZEL0t1Y1g4?=
 =?utf-8?B?VUtZQ1orUFRNdUx0SXhDdGJDS2ZhMWtsUENzL2dmSVhZWTcwZzY0aERpN2Nz?=
 =?utf-8?B?Um5HbEU1NEtkM2h3azIxYzlJdU1TNmdQVS9NbWUzM0RhSkwxSng2VWFSWUZF?=
 =?utf-8?B?N0kvWHBvRlc1Tzlrb216YlgvVUs1Qk5abDJFcW9ESE0rcStWMks0Y09pcmMx?=
 =?utf-8?B?TmQrellnSkJBaHVDUGF0NHpuWEF2NG5GWDB6SDVid243eXZ4TmlRWllHRnAr?=
 =?utf-8?B?ckpXcE5MTHkzTGlqNitXWWlpR2RHbE95T25PeCtrTUR0QjYxVE1yUXg4NzBD?=
 =?utf-8?B?bnlNc1RIeVp2d0RKNkkzVmd6Qm1rRXV6S0JFQjVEbk1aN1MwUHQrMnlUVG02?=
 =?utf-8?B?SzdQT3BuTVZyU29qNnpoODRHNG9wVTZ5LzZ5N3d0eS9DMmV1RVNIOFFualhZ?=
 =?utf-8?B?QVovb0h4cXJ1MS8yMWlhcmhRSzRtZUN6WGU0RUNwZUtOMzZ3OFJnRmdjb2JB?=
 =?utf-8?B?d29iZkplTVBWaUdyT3lxTzdESTYwVzV4NGFBc0F4MytjSVVzT3pPNHRsUzl1?=
 =?utf-8?B?dVFQcG8yaGpTY2pGYzJtNVFTTHJXMk9WQ0liWVVFa1NSdFdxTGtGRUFPVWlt?=
 =?utf-8?B?OGFlQ0liVHU1UjF1bS9VSDBrRGh6eTluMkxRbldVZ2I2WC9oUUR5a3Z6enND?=
 =?utf-8?B?TjZuN29yRDBTbWFQTjhJbVIvTGtGZnE0U252ZE1vQVFlUFUydWFjZ3ZDTTM1?=
 =?utf-8?B?aDFTMzlqb2NTYk9KYm96aXMvcmVFdjhTNlg5d3lqSllTWHYwUDlHNnZSZnhj?=
 =?utf-8?B?S2thN0JkZnl2RUZ4L0tkQ215b1RoN3JSVGoxbWdDS3lCNnM0bXZaRldWeEVu?=
 =?utf-8?B?ZDVPWFNuaGhkUXhDeDNZWmhUR0xXQVIvTWlXRnhHbVJZMzlTTGRZSmt2bGxT?=
 =?utf-8?B?czhQR3lpeGlCWUs1VkV3M05GYTRhUGhGSzNZVEk5Uk90WkhlVDU3LzEzRXA5?=
 =?utf-8?B?Y1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	smJsw1g0XE5kz4ZEMu977Q54RRpYshOknGe9s2XCSy/x6NIc9mzpFzDDjsnG8zksRjO0MtH+ty4ZGL+BlEsNN1ks+5z9h58NigW5bw48OYDKty+vX5e49Cw8ZG5ksWMM41qB4xcdltztOGtaKM6H/pmB/uU7EYZM7Z9lPAuMXM8tD8taz0DLJyviGnfBgpvQFjjiTMlL/Yi2ppBHEOVt4jqfj1y15xDKWVbDNDEcgcxra/vkd/3lwdN5FRbBCvIj9HFu1RFPig9cQEvWAmvKq0n+uZHwLT3eENkUNr/KrmdMn+fOry0sARV9WJ/II+4yp+s3A1Nq3j4dysSR2A5jr3k7Va1q2HuGvy51vhWvHDrnpic+XX/OyIKJddsIJVuvnGHaai47/+3t2MACfmhYY1Vt6teu/ljg6BkfRDBuzlsCmYyfWLPX0AjsjWX/Hs466jPXPw0SOz3LM9Q9WIkgqB5SiVDxki8LWI8+YbOf360P/7oLXIirUkGxtyGiV2rbyNeoLjhIx6rWwoVcxKwTkOcm1z00UDq7UqPHejWTvHp9+7WWfdoPzcSsidJUh0Th5pQGBzzylH7CKgkcOvoSxQvJ+zvXTEKhDZQmsR9LrKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2c15ec-96fd-443c-2fdf-08ddef29a527
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 22:47:10.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzGwkaYPsb5Kq5mshA+dCDq8dMdIAqVUKxNDt8qllwXpgMG9EE1xaVlgCgQTROhhsTaXLgFYPr5L5z87iqYsXPL2RNG8GFSI+op1KXfIGV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080224
X-Proofpoint-GUID: AwiXt5I8XpgVdyXR3j1U8-au8HAkaHFr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX7wSFCVauezt9
 oRiK+Hv/QFiVsvNcuZx1mwPk7rppOTvh5RXZQdV3BEpMZoKYO4O7wO339pWN8ivrp3ucxIrilYi
 rkq5XDncuKqryntQK5zZY4G1flrcVxrEo+KYgHvM7DmnT5dvh1V8YC6xe8Ue2UsbVZaWrJTma8Y
 wsBK25b9zSjJSd/rBAGVbY/u5WSmq1PaDXL95Y/k66cgWegASYv8cp5YQPxN+cdj8viehhe9SGv
 BEyumcYxv9Bv3evmrFBGPdC4UQ0cOowOW8YUpxs9IbJynOvSP8xQF3kAJ6lwOL4h3bqqpP7vLNk
 DgVUMv6rDgSb/Lu7Lf49YKw9S6omVytdXARyCv6bM1LGQ6kavTBqWSpoQVrlIEaraMbWSpydaOM
 5abM2Vbt
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68bf5cf3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=NEAV23lmAAAA:8 a=P-IC7800AAAA:8
 a=bzgooDT4zvW9jtbv1nsA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: AwiXt5I8XpgVdyXR3j1U8-au8HAkaHFr



On 9/7/25 11:53 PM, John Paul Adrian Glaubitz wrote:
> On Mon, 2025-09-08 at 08:47 +0200, John Paul Adrian Glaubitz wrote:
>> Hi,
>>
>> On Mon, 2025-09-08 at 08:30 +0200, John Paul Adrian Glaubitz wrote:
>>> Hi,
>>>
>>> On Sun, 2025-09-07 at 23:31 +0200, John Paul Adrian Glaubitz wrote:
>>>> Hi,
>>>>
>>>> On Sun, 2025-09-07 at 20:33 +0200, John Paul Adrian Glaubitz wrote:
>>>>> I assume that cheetah_patch_cachetlbops has to be invoked on UltraSPARC III
>>>>> since there is other code depending on it. On the other hand, the TLB code
>>>>> on UltraSPARC III was heavily overhauled in 2016 [1] which was also followed
>>>>> by a bug fix [2].
>>>>>
>>>>> Chances are there are still bugs in the code introduced in [1].
>>>>>
>>>>>> [1] https://github.com/torvalds/linux/commit/a74ad5e660a9ee1d071665e7e8ad822784a2dc7f
>>>>>> [2] https://github.com/torvalds/linux/commit/d3c976c14ad8af421134c428b0a89ff8dd3bd8f8
>>>>
>>>> I have reverted both commits. The machine boots until it tries to start
>>>> systemd when it locks up. So, I guess if there is a bug in the TLB code
>>>> it needs to be diagnosed differently.
>>>
>>> Another test with a kernel source rebased to 6.17-rc5+, with the following patch applied
>>> by Anthony Yznaga and CONFIG_SMP disabled:
>>>
>>> diff --git a/arch/sparc/mm/ultra.S b/arch/sparc/mm/ultra.S
>>> index 70e658d107e0..b323db303de1 100644
>>> --- a/arch/sparc/mm/ultra.S
>>> +++ b/arch/sparc/mm/ultra.S
>>> @@ -347,6 +347,7 @@ __cheetah_flush_tlb_kernel_range:	/* 31 insns */
>>>    	membar		#Sync
>>>    	stxa		%g0, [%o4] ASI_IMMU_DEMAP
>>>    	membar		#Sync
>>> +	flush
>>>    	retl
>>>    	 nop
>>>    	nop
>>> @@ -355,7 +356,6 @@ __cheetah_flush_tlb_kernel_range:	/* 31 insns */
>>>    	nop
>>>    	nop
>>>    	nop
>>> -	nop
>>>
>>>    #ifdef DCACHE_ALIASING_POSSIBLE
>>>    __cheetah_flush_dcache_page: /* 11 insns */
>>>
>>> Still crashes:
>>>
>>> [  139.236744] tsk->{mm,active_mm}->context = 00000000000000ab
>>> [  139.310042] tsk->{mm,active_mm}->pgd = fff0000007db8000
>>> [  139.378747]               \|/ ____ \|/
>>> [  139.378747]               "@'/ .. \`@"
>>> [  139.378747]               /_| \__/ |_\
>>> [  139.378747]                  \__U_/
>>> [  139.572059] systemd(1): Oops [#1]
>>> [  139.615613] CPU: 0 UID: 0 PID: 1 Comm: systemd Not tainted 6.17.0-rc5+ #19 NONE
>>> [  139.712832] TSTATE: 0000004411001602 TPC: 00000000005e29e4 TNPC: 00000000005e29e8 Y: 00000000    Not tainted
>>> [  139.842076] TPC: <bpf_patch_insn_data+0x204/0x2e0>
>>> [  139.905077] g0: ffffffffffffffff g1: 0000000000000000 g2: 0000000000000065 g3: fff0000009618b28
>>> [  140.019460] g4: fff00000001f9500 g5: 0000000000657300 g6: fff000000022c000 g7: 0000000000000001
>>> [  140.133837] o0: 0000000100058000 o1: 0000000000000000 o2: 0000000000000001 o3: 0000000000000002
>>> [  140.248208] o4: fff00000045ec900 o5: 0000000000000002 sp: fff000000022f031 ret_pc: 00000000005e2998
>>> [  140.367158] RPC: <bpf_patch_insn_data+0x1b8/0x2e0>
>>> [  140.430057] l0: fff0000009618000 l1: 0000000100046048 l2: 0000000000000001 l3: 0000000100058000
>>> [  140.544437] l4: 0000000100046068 l5: 0000000000000005 l6: 0000000000000000 l7: fff000000961e128
>>> [  140.658810] i0: 0000000100046000 i1: 0000000000000004 i2: 0000000000000005 i3: 0000000000000002
>>> [  140.773189] i4: 0000000100066000 i5: fff0000009618ae8 i6: fff000000022f0e1 i7: 0000000000607a08
>>> [  140.887561] I7: <bpf_check+0x1988/0x34a0>
>>> [  140.940171] Call Trace:
>>> [  140.972191] [<0000000000607a08>] bpf_check+0x1988/0x34a0
>>> [  141.041963] [<00000000005d862c>] bpf_prog_load+0x8ec/0xc80
>>> [  141.114021] [<00000000005d9be4>] __sys_bpf+0x724/0x28a0
>>> [  141.182646] [<00000000005dc338>] sys_bpf+0x18/0x60
>>> [  141.245551] [<0000000000406174>] linux_sparc_syscall+0x34/0x44
>>> [  141.322185] Disabling lock debugging due to kernel taint
>>> [  141.391952] Caller[0000000000607a08]: bpf_check+0x1988/0x34a0
>>> [  141.467440] Caller[00000000005d862c]: bpf_prog_load+0x8ec/0xc80
>>> [  141.545212] Caller[00000000005d9be4]: __sys_bpf+0x724/0x28a0
>>> [  141.619558] Caller[00000000005dc338]: sys_bpf+0x18/0x60
>>> [  141.688179] Caller[0000000000406174]: linux_sparc_syscall+0x34/0x44
>>> [  141.770535] Caller[fff000010089b80c]: 0xfff000010089b80c
>>> [  141.840301] Instruction DUMP:
>>> [  141.840305]  326ffffa
>>> [  141.879185]  c4004000
>>> [  141.910065]  c25e2038
>>> [  141.940945] <c4006108>
>>> [  141.971827]  80a0a000
>>> [  142.002709]  04400014
>>> [  142.033589]  c25860f0
>>> [  142.064474]  8400bfff
>>> [  142.095354]  8e00606c
>>> [  142.126234]
>>> [  142.176560] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
>>> [  142.277218] Press Stop-A (L1-A) from sun keyboard or send break
>>> [  142.277218] twice on console to return to the boot prom
>>> [  142.423608] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
>>
>> Disabling support for Transparent Huge Pages (CONFIG_THP) avoids the crash.
> 
> Sorry, the option is called CONFIG_TRANSPARENT_HUGEPAGE, of course.
> 
> My suspicion is that it's related the flushing of D-Cache handling which is enabled
> for small pages only:
> 
> https://elixir.bootlin.com/linux/v6.16.5/source/arch/sparc/mm/ultra.S#L1016
> 
> and:
> 
> https://elixir.bootlin.com/linux/v6.16.5/source/arch/sparc/include/asm/page_64.h#L9
> 
> Interestingly, while running the reproducer with CONFIG_TRANSPARENT_HUGEPAGE disabled,
> I'm also getting this kernel warning, but the kernel does not crash:
> 
> [  108.733686] CPU[0]: Cheetah+ D-cache parity error at TPC[00000000005d78b4]
> [  108.824096] TPC<bpf_prog_load+0x394/0xc80>
> 
> Could it be that we need to enable the code guarded by DCACHE_ALIASING_POSSIBLE
> unconditionally?

It's already essentially enabled unconditionally. PAGE_SHIFT will always 
be 13 on sparc64 systems.

The flushing should be happening for folios of any size. See 
flush_dcache_folio(()/flush_dcache_folio_all().

You could try setting page_poison=1 on the kernel command line to see if 
the kernel detects any freed pages being used.

Is this a different Cheetah+-based system than the one I borrowed? 
Definitely some sort of memory corruption happening, but the system I 
used seemed much more stable than this.

Anthony

> 
> Adrian
> 

