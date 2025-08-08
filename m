Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7036A17578;
	Fri,  8 Aug 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754691392; cv=fail; b=pIcqDbN1y5dMGvGThx/UvyFZVjXdaswZ2pfYBDxF3d8YNea3lnewF2LaJ+jqxmK2pKEc1kSEyR8qmHgG5+ibdYCCzzLPyLr3uQ00PmRUKEEReG42ah7OlXcncrbGDI8EF3ms6pbsOAFhMI1emsIKshM30hX4jREjHpDE6ydH0KE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754691392; c=relaxed/simple;
	bh=EzisbhdSjjm/wiwd1r3JhEof9ysaf87OhVr/8UnBzhQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GUsOUKdx++iOapGW60+6+xYgmZm6tg+LyFj1nlR1/hOVPkU8eJbfRCSabVQN3QAnixifSg7QJNOOG8gajKnBM8f35NE4BKOvpg19r2ybxzs1ZKwl2nw7jEzvEIUg7x2csuDaGizH6ggQ/cK4Os9vsS9elj0TmaxBfuvbXpFrjnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=be9K47mo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RxqAq7ob; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="be9K47mo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RxqAq7ob"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578I0wRG007457;
	Fri, 8 Aug 2025 22:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=02t5IAMRPvn0JOXwWQdqXD13qyZLgjBieq5ziZmQRNE=; b=
	be9K47moTqElsSBapDqu16L/0DD6rwz/OupVeL/DFx9FW76Gw3kOLuASjwqyTEEG
	Nsc/5UCfRJBNltEEBjj5kRkOiC1A3ZGSIKWdsbIMxk1t9MB/QxjGE7kUrwyhoqa/
	kbsxfagysLBmwrRIUhr/RdrejHUR77WRTFQrece9hXXY8ClAIVFs6PC4aNSNE6cb
	ywup6cv+xHQtV3LXNBjmqqpr0u+5vPKtQm/QJKy7T/puVB8UB3CIGvrkVJ89DTV3
	+yj/4HHXEM/mZg6tV2UKX+EGgg0xjl7dTsx/rs59JzRc0hMiJxfcqf86IDF/oWCp
	Vytq0AHsVL7sDSgf3pHb5g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvjya45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 22:16:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 578M15ui018372;
	Fri, 8 Aug 2025 22:15:54 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwuabxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Aug 2025 22:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWTnDvXrJ4QNMt1lnxMxLT0Uzd6hrVu7O8YoF7q5Xe9u1sVCJ7PlbPXOLtlhsR+fQJY4wcN3Jfrb+QzhhTUfPGKfjXyOziMg2YTXzUKFXyiP1YVYMh/UXIsTViKs25V6hlIozO1VyZtWfbK3SEhA+g91/3joomU2hcQSkuiX9Mk8oOUbgkVW52bgzkaYpq28vNm84m+jDihVM3FYrkQU1xNQ59QBK3UIE8E4t3tKYJqKPmt3otdlGqYzkqMM0IpZInsStdKgwbT391MfjAovcvsbjwXtnqMXNFD2yT7hnh5ARtEcD1kW4+eYKvP2nLcOneJV/jvzGo4kDgdY/dfTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02t5IAMRPvn0JOXwWQdqXD13qyZLgjBieq5ziZmQRNE=;
 b=EJFUd8Idg3tyHV4BMG+Bbgkt6WSdfXuOiiAze5jxiLRbKh7RdsPSytRArihsj+hcE4pBsi7EKmA7chVYMud+h/QigxWd8zjm4pMHYir63GoLTFHjyC0yetI85L72wCH4xTK3xNL05Jvi8dLTIcvUbLTtHkI/7Xs/gbCAxs7Y93bz6aFOcbF2qDwCIMVZI6S7YQVrlXV5OSIvpdk3tQ/6PmjiYcSnXpO82GoIXe/oBsvecDkD6E/pJVjJ4vaTNmulOSkf4W5/C5cFilikMMbBW+zvg9BeMwYXecRWpYXcNUG9u5aPch/Y0/mQhjZRLy7usAnsbKSrYqBDD1dsFfgLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02t5IAMRPvn0JOXwWQdqXD13qyZLgjBieq5ziZmQRNE=;
 b=RxqAq7obxM83GqHYDgIVfYAxScbvUAL2ecttHj/zGBIbW1CYTSOtciQUUuHt68OtbkKOqx8sQy1fB8XOiF3ghl4dYeEVOv/8oCb2tgR37k6jIhfg21KngtGF8Lk4nXG0+UCp8NdcJetff3gayiR/U4+JUYj0aeMGmm1v3qaMXmw=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SJ2PR10MB7705.namprd10.prod.outlook.com (2603:10b6:a03:57b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 22:15:50 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 22:15:50 +0000
Message-ID: <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
Date: Fri, 8 Aug 2025 15:15:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        sparclinux@vger.kernel.org, davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org,
        ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:36e::26) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SJ2PR10MB7705:EE_
X-MS-Office365-Filtering-Correlation-Id: f641ddcf-b7fd-48f8-c4a1-08ddd6c921a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGlhMVhRVnJnYUZUc2UwUDBXZG90amRMWTU1WEQycS9lOXdudHBlVVlreUFk?=
 =?utf-8?B?cFBWb0tDVEZjTkFxRE5WS045eVBLTHFUTERUcjdlRUdYeStnWW0wMTNxemd6?=
 =?utf-8?B?VGlCRDI4UmZJcFhmSU5XOFFOTWljVkFMb0Vjais3SDJFVmNTYTZXZmlRSlAz?=
 =?utf-8?B?Z3JMS0x1TG83K2JNWlY0OWc4NlpxcVBhOENoRkVtdjQ4U3VYaDdIeXREbHY1?=
 =?utf-8?B?ek5UNFRkWlIwRjgwenNFOWluaXhBMGkveTBXTFZJdUIzZ0xvSkEvaGRoTmFk?=
 =?utf-8?B?SGlWaVlibFlXMkY1aEhLNkdiazl2aDFGSlJROUtxbUI2bFBieEliemFtcElx?=
 =?utf-8?B?RFpSYjlKMGthLzU2YnYyMGVSL2dXaVZMU1RHemEwODdGMEU1RjRuMnhBMWxU?=
 =?utf-8?B?bllwWXVMTk5id1liSWZ1aWc4UHhPMzUzN1BLU2U5YVkvNlMvOFZacUcxM0Vv?=
 =?utf-8?B?U3JKZ2VUZ0syUklKbDRPS2F3RlRqbHBEZVJOUlZDY2dFK0c5QTBnQ1dPYjB1?=
 =?utf-8?B?ejNzRXluZUlHb2VKNU56SllSQmM4N3NacTNFM2VlOGxxQk00aWdJSFR3M1Ux?=
 =?utf-8?B?RHZDUnpwME1HVDhZbHU2Nm4xL1NibldQck1uVmIzTlBGUFViUkZVNEN3eDdp?=
 =?utf-8?B?Vmo5OThPVWVsUkdYeTM3azFpajc4V1hiZ3crLy90NUgyNEVheXExRE5FSnZ6?=
 =?utf-8?B?a0VOb1lrUlU5Q2NFdHRQdGpxVnZNRi9VV3A3M0JlcUZ2NFFCNGs5S1l1Mm90?=
 =?utf-8?B?cUxNUW9WaHJrSkJGM3BMVXFiWS9ZNEt4N1RabjBucmRrNTF2Qjc0Wm0rTTlF?=
 =?utf-8?B?ZUVqVm5tQmlxdWtIL2VkcTFyUEM1alhmOXdqTTZsR0FhS3BOTzZJcnhhTHdq?=
 =?utf-8?B?NjJvTW5tQ3FjRTBMdGluTjZVSzVYb0U5clRpRzUrVndZQTVEWnlsZlUxNmZr?=
 =?utf-8?B?dUJKRlUxMTZjMFJPMTMwZGx0U3hEUTJQSU5ocHpIU1dlNlNUb2NVbmVYSFRk?=
 =?utf-8?B?ckY5czdXaHBoQnJMZC9kKzhxckp6U05uSFRNTzNENUFHU3V3WlpsSHVlb01M?=
 =?utf-8?B?R0NYMGlucytwSHVUTlk4Q1d0ZzhLOEtIbHJFaURpR1pMeXNzcnIrenhqV2FZ?=
 =?utf-8?B?YmhYL09TV2RNMlpNQ0lSMW9ScWNhMlU2ckN0NHg4ZDBnNCtYNW9iMklsNks3?=
 =?utf-8?B?aEJZRkNwZVcydkdscDh2YlpDTUhuUjNLZUVpajhXV3dubFRXaFYwRm5ZdzYy?=
 =?utf-8?B?T0llM0RyM1gxSnNMbnNQcy9DMzkrL290OXJZTGxqbUNaNmszQXJnV1lQZlh3?=
 =?utf-8?B?d0EwUUk5UjBLRXlXNTJGQXliY0pobXB4c253eVg4SHg0WGJDR3gwakIrR0tE?=
 =?utf-8?B?NzlhRGpLL1FXMGhrSUpiWWNDMjNSVVhIVFBYMkRleFNlTTJJbHllbHRrQVRF?=
 =?utf-8?B?ZEJTM1I5SkM1S29sV25IL25WZ2lLQ2FublpZbFJJMGhCR0tXcmdHUTBUZWFV?=
 =?utf-8?B?bFlmOU5NOVlsVkVza05PSXUyeUZhQ2g4OGhHVFllTjZXaktONzcrVGVGTzNE?=
 =?utf-8?B?OUY1UjluRko2Z3M2UzdrbzJuS2cxNDdteGk1V2Fnd1FhV0hldnR6Zy85Nzlr?=
 =?utf-8?B?TVlPNnNxZTZPM3hFQUVpYmVYQkR3dzFlUWx1TzVmdW4wYjIrNmtnWitPaVFx?=
 =?utf-8?B?eXBFRGVGdHRVQm02WENGbkhNZ1dyU3Bpdk5WZTNZdWFFdDlLOXU5VlUyL29B?=
 =?utf-8?B?bWVVbUZZN0EvSFlHc2V2cWxYM1YwVTFrdk5vSnhwc0FiK0tBMVBTVm9IVTNj?=
 =?utf-8?B?dndiVjQ1NUFnRHB4eFRnenFRdWlLYW51ckhvSVJnQnR0Y1BZcVB4RXNvZW9q?=
 =?utf-8?B?TnhvOHkzSEFLdUhFdHFQb2kyUXNiVFY5R0MvVG9IWnBJVVd6Sk5CMXlOUkJT?=
 =?utf-8?Q?RlKZXqvS/wo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1VNQU1BQjdGMkVHVDZIaG5XRHk2UFNQVGRIVmNvaGZzWDBKSDlkZWhqc2ZW?=
 =?utf-8?B?YjNUOE9NOC9qcFd0ek1NKzdyajNmNTRabTY2ZE4rUnFBQW9CTGp1S0tZTFd2?=
 =?utf-8?B?SzQxY2ZseFF0WUh5S1ZVejZsaVh1RWJ6eXVqTDJRZ0V6emk0dFJOUWs4TzJt?=
 =?utf-8?B?aDl4N2w0QXJFL28yVS9zMWVteUNhYnFzZUZUNVBVbFFpeGl0K1ZaUThFaWI5?=
 =?utf-8?B?TS9KSHZkK1NGSWZpREpwYjMzUGtFMWl4WDRXMFRMdlg0QUxVdE4wRlhMZHR1?=
 =?utf-8?B?clo5Nk9Xc3FlZnNhekw1SFl6MHh1VFI4dGEwblRIaHhpYm5GK25jTHUvbXpW?=
 =?utf-8?B?a252TUoxL3lDNCtCaEd3akRQYzUvRmVnYVlRU2ZuZy96UmNiS1JvaXlOanc2?=
 =?utf-8?B?dythNXZKQUpVRWxyZC93cEorT09BY1RyWFlJSHBGUEU3QmVMV1pDNFhPS2tQ?=
 =?utf-8?B?TUZJNU0yaXc4QmM0M2EzbEcrdXpuWUYyT01IcnR3UEJzeE11dTZSRm9SY3ph?=
 =?utf-8?B?L3JRZjRaRDM3R1JIa25jQ3F2SFFWTHBOMWgvbE9lc3JiRkx0NmhOOUZnaTRy?=
 =?utf-8?B?ampyYTFnSUJDdWZOcCs4T2FRWVhtN25uVzAzUWt1NzJUa0locDgwOWJZMVFl?=
 =?utf-8?B?VEdiVm8rZGJvSFpSbHhJN0lpWGV5c2EzQm8rSWl0aW54MFNyQ20vQmoyZFI2?=
 =?utf-8?B?dXVBWTk3VUlVcUd4UXFOSkF2V2hGdllIT0tsYTBORUdmYXZ4MVc5Smg3eGJP?=
 =?utf-8?B?QmJ0ZnBEV2VZNjVjNkZXb3F2VVJobHl6MUFWSW5HL0NORlVIRFdTaDhVWTVk?=
 =?utf-8?B?VGlrbzQ4T3BrejU0cXZFVnZQbm9nZFU1THFCNmhRNzZrU2hSblZsaHRDN3c4?=
 =?utf-8?B?WTluaVNpN1IvWXJjaHRWUTlWeUtvK1hsaXdIbk44bGYwUy9GamUrMVYrb2d4?=
 =?utf-8?B?VkdlbnQ3WExHeC9RS3FHTTlkSUxXa0Vpek1uSVdER29QbUUyVHdiRVROS3JY?=
 =?utf-8?B?TmxvNSsrWmpCTHg5VEhVZTl1WEswM0tHUCsxQUJ1dzJWSzE3RUVWbklPbWoz?=
 =?utf-8?B?K0tmeHFhSmFNOElLWDQzM1JabFdFSzhJZFpRbGFDblVUL054QUNmdFlCd3pP?=
 =?utf-8?B?L3VVQjZQYzBzRnRsMm52bjJWdEo4Zk1lVWFZK2lEZ29YZk04YVlyOEl3WW44?=
 =?utf-8?B?UlE4K0JzeW9EeXRURXJpenc1VGJPZ1llamF0dENyU0ZzdzlvdE5IMGsxcGJV?=
 =?utf-8?B?OGJDZU1DWGk4N2VPTXM4MEVMT0tnZ0ZoaEFHcnU5K29EalB0ZlQzV3BDNVRv?=
 =?utf-8?B?ekJpZkErVVRCU2ZGV3J4ZDcxbUFuMmVzdWJOZkF5K2Q5U1o3dkk5NUlXa3ZS?=
 =?utf-8?B?K0cxUGpnZDRocDR1dnVDd0RHZnVYVE1EVWZLTi9uNlhaM1JZaDNqNVRpTlZl?=
 =?utf-8?B?Mks0SllyK3RFem9XWlIvZ0NhMG91QnhOYmduRExvbkRBS2hDUUlvcFQxS2Zk?=
 =?utf-8?B?QS9manZQbVNqaWFCVDhSRER6UE1KV09QblZ4R1REdXFiZXc0WnVBVndKWXkx?=
 =?utf-8?B?Q2h5OGw0aXIwY1RlVy9nNXpJQ1JCMlovb1VHOTlRQU96MkFxcXhjZndRYmVn?=
 =?utf-8?B?b3lCL2huVjE4RzZlUHdJZm9MZjFrVWRxRFZmWld0ZS9WQ1kxVmYwMzBnVTJm?=
 =?utf-8?B?anNDcW1IL3ZHdThsZ2l3d3ltYW5Sdm9QYk03OE9pa1h3Y0Y4TGRoRUE0c0M5?=
 =?utf-8?B?Z0hXZDVNYkNCeGxWeVl3VytaKytLaDljRis2WlZaZEpGUGJ6TWdPK056cUI0?=
 =?utf-8?B?aDgwNVhnQktRQjVNZENERDREbDVxNXFtZENIeGp6Vm1FVnBDdnhqbjlMaDJk?=
 =?utf-8?B?T1AyWDNiOXEyS3BXTCthQWNBVkNDM2VyNkdwRVlLVy9sWktNcndtblQzcllq?=
 =?utf-8?B?OXNqR0dsc1lIUW5UbExSQmRRVUhlT2JUcjh5VmswbG1BaVZVcnU1K3FFdVMz?=
 =?utf-8?B?SVhWdlAvL2NJcXIvQW9tUElRc2o0MWpabzEzZXRaL3h5QVZIbXlZN1R4KzFN?=
 =?utf-8?B?a2NoYW5BSmNuNHpHSDFJb05GOVhJTVEvOFpETUpaeUN1RFpWcjhhQ0tSMEQx?=
 =?utf-8?B?Zjg2bUZpaFpYa2o3OWVtQURleUIxM1JQWnVVQm82dmVOeE1lbHhNK3JJNWxO?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EDHISpARUDXDtre0+RvHZiHKYZTt9C16Loux7+bBkJC2TQDPzlrWL+Fikf+wm1D8SPXtyVutAtW8HdrSTXDrgZpD32YfU1s+qbsFW6CvXIAyyFxWmtmlC3mrcRYzXOvscup744LzVKX9yAui3wZ8jI1A+XhVDLjZTy/p6wsVQQIFqX9r25TVMYy6NMsXgHztWgROkjVr6li4rVbiBR5vFH+u1ZRDmpjpHEG99K9siGiQTGa+X0NGGxzc6M1nucrjGAWXipWAb9UDb6MptHCV2XNe1lxcRhk36M11meA97B5fIUnXdWryXZ8p3sZWc4Hvxy3UTkMLi6AnUvp/p2Q6HHO0z0IHDQ0eDdDcPK9QsnkEzTImogKf0lpJtwFE8eAoX2DcHCPC1ByrtXUyNpKd+eHyfQ/vniswxUtP4PMj430AybCyTEPUtmZ7V0Yz1qsw6CPj/OKv8RJuQJd13l6rFMzDJrfaMZUDbFY8lVupQ0XA0aL66uu8jAyuFxfc5h+xP9/QfFRyjNvv0iK8OpV7wBtw5o3rYFFL6bwiWiz64vtljGzVapEuK38hH8DT5uqdOoh5VBqbM6CjYU696psuDs/529jL1wLxmYoqYYl2PFw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f641ddcf-b7fd-48f8-c4a1-08ddd6c921a8
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 22:15:49.9963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YSvb4KbuHH/lT/LsmZGClAqCp7r9x9MZMbMXWajQzc4GdCticgSWx4NLQ5XIzXDjCZCTkuc8jnjG1EL+sks+TMJi4DGvq1YgSC18eRvxSRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_07,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508080179
X-Proofpoint-ORIG-GUID: dqnh19Tftsa_TVEp7BjzbxSVNz6EylVv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDE3OSBTYWx0ZWRfX7ZxB8snYztkO
 lLOqt22Qxir13ptdKAsb6Uit1z+mdDLNL2zoZS/4hjtBWJg5tQgutQMyd9RKqYdehsF9pB/xSWq
 Nur82FjAhET23JNG/INYZ0g5zLgXTwho66u8TsR0OJEvea5AGJsE0e/j9Eil/QjPVjswyg+mWnl
 NfCHBUtJeXd7ucOvUZwU+Bfq+qkAfrYuEGW9BxBUZ57o/QTvIkXxskLRNSRZXtkQJYa8gyuskJc
 3A92UM68g6qZEvXer6B+7a1GHm6NHKJDIh0Ruo67bqMVh86iSlVNunhJkNym4UDTS7Fq9MzV0Z7
 Z8v8yc7WBv1y7l59y2abEK/9EyDTSdgGYogoNozYtSdApGIgAhMh2F43aBxNIXHiXobZ/x8qzIp
 yPzz3VlAL2olcBo/wpYVIbAZ9JUuOCmsY2xXd1uwab2gPldjn/C5BA1qXTW840NvH4hcA43O
X-Authority-Analysis: v=2.4 cv=dobbC0g4 c=1 sm=1 tr=0 ts=68967729 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=kXnBq3QhCCUiL6BQLXsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-GUID: dqnh19Tftsa_TVEp7BjzbxSVNz6EylVv

Hi Adrian,

On 8/8/25 2:31 PM, John Paul Adrian Glaubitz wrote:
> Hi Anthony,
> 
> On Tue, 2025-07-15 at 18:24 -0700, Anthony Yznaga wrote:
>> An attempt to exercise sparc hugetlb code in a sun4u-based guest
>> running under qemu results in the guest hanging due to being stuck
>> in a trap loop. This is due to invalid hugetlb TTEs being installed
>> that do not have the expected _PAGE_PMD_HUGE and page size bits set.
>> Although the breakage has gone apparently unnoticed for several years,
>> fix it now so there is the option to exercise sparc hugetlb code under
>> qemu. This can be useful because sun4v support in qemu does not support
>> linux guests currently and sun4v-based hardware resources may not be
>> readily available.
>>
>> Fix tested with a 6.15.2 and 6.16-rc6 kernels by running libhugetlbfs
>> tests on a qemu guest running Debian 13.
>>
>> Fixes: c7d9f77d33a7 ("sparc64: Multi-page size support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   arch/sparc/mm/hugetlbpage.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
>> index 80504148d8a5..2048b5c42ca8 100644
>> --- a/arch/sparc/mm/hugetlbpage.c
>> +++ b/arch/sparc/mm/hugetlbpage.c
>> @@ -22,6 +22,26 @@
>>   
>>   static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift)
>>   {
>> +	unsigned long hugepage_size = _PAGE_SZ4MB_4U;
>> +
>> +	pte_val(entry) = pte_val(entry) & ~_PAGE_SZALL_4U;
>> +
>> +	switch (shift) {
>> +	case HPAGE_256MB_SHIFT:
>> +		hugepage_size = _PAGE_SZ256MB_4U;
>> +		pte_val(entry) |= _PAGE_PMD_HUGE;
>> +		break;
>> +	case HPAGE_SHIFT:
>> +		pte_val(entry) |= _PAGE_PMD_HUGE;
>> +		break;
>> +	case HPAGE_64K_SHIFT:
>> +		hugepage_size = _PAGE_SZ64K_4U;
>> +		break;
>> +	default:
>> +		WARN_ONCE(1, "unsupported hugepage shift=%u\n", shift);
>> +	}
>> +
>> +	pte_val(entry) = pte_val(entry) | hugepage_size;
>>   	return entry;
>>   }
>>   
> 
> So, I have to admit that I'm not an expert on Linux kernel memory management and
> don't exactly know what the difference between HugeTLB and Transparent Huge Pages
> is. Could someone enlighten me?

They both use use huge pages to reduce the number of TLB misses. HugeTLB 
has to be configured and requires changes to an application to 
explicitly use it. THP works in a more automated fashion where the 
kernel manages when and where to use huge pages without requiring 
changes to the application.

> 
> The reason I am asking is because while this patch seems to fix HugeTLB support,
> we're still seeing TLB-related crashes on sun4u which are triggered when both
> CONFIG_TRANSPARENT_HUGEPAGE and CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS are set.
> 
> I previously thought that HugeTLB and THP are the same, but it seems like that's
> not the case.

Yes, my patch fixes HugeTLB only, and has no bearing on THP.

> 
> Enabling both these options leads to the following backtrace during boot:
> 
> [   29.858572] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   29.858580] rcu:     (detected by 0, t=2109 jiffies, g=-1155, q=3 ncpus=1)
> [   29.858586] rcu: All QSes seen, last rcu_sched kthread activity 2109 (4294939474-4294937365), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [   29.858595] rcu: rcu_sched kthread starved for 2109 jiffies! g-1155 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [   29.858603] rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> [   29.858606] rcu: RCU grace-period kthread stack dump:
> [   29.858609] task:rcu_sched       state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
> [   29.858626] Call Trace:
> [   29.858629] [<0000000000c0a234>] schedule+0x14/0x160
> [   29.858646] [<0000000000c11194>] schedule_timeout+0x54/0xe0
> [   29.858657] [<00000000004fbd40>] rcu_gp_fqs_loop+0x140/0x6c0
> [   29.858669] [<000000000050003c>] rcu_gp_kthread+0x23c/0x2a0
> [   29.858678] [<000000000049b788>] kthread+0xe8/0x120
> [   29.858688] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
> [   29.858700] [<0000000000000000>] 0x0
> [   29.858705] rcu: Stack dump where RCU GP kthread last ran:
> [   29.858710] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #32 VOLUNTARY
> [   29.858719] TSTATE: 0000004411001603 TPC: 00000000004db400 TNPC: 00000000004db404 Y: 0000137d    Not tainted
> [   29.858725] TPC: <console_flush_all+0x360/0x4c0>
> [   29.858738] g0: 00000000004db400 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000017fd000
> [   29.858743] g4: fff0000000180000 g5: fff000023d194000 g6: fff0000000158000 g7: 000000000000000e
> [   29.858748] o0: 00000000017fd1e0 o1: 0000000000000000 o2: 0000000000000000 o3: 00000000017fc5d0
> [   29.858752] o4: 0000000000000000 o5: 000000000185d7e8 sp: fff000000015a901 ret_pc: 00000000004db3f0
> [   29.858757] RPC: <console_flush_all+0x350/0x4c0>
> [   29.858764] l0: 00000000017fc5d0 l1: 0000000000000000 l2: 0000000000000000 l3: 000000000143b538
> [   29.858769] l4: 0000000000000000 l5: 0000000000000001 l6: 00000000015c20b0 l7: 0000000001536308
> [   29.858773] i0: 0000000000000000 i1: fff000000015b2b8 i2: fff000000015b2b3 i3: 0000000000000000
> [   29.858778] i4: 00000000017fd1e0 i5: 0000000000000001 i6: fff000000015aa01 i7: 00000000004db5e8
> [   29.858782] I7: <console_unlock+0x88/0x120>
> [   29.858790] Call Trace:
> [   29.858793] [<00000000004db5e8>] console_unlock+0x88/0x120
> [   29.858801] [<00000000004dc128>] vprintk_emit+0x1e8/0x280
> [   29.858809] [<000000000042a34c>] _printk+0x20/0x30
> [   29.858819] [<00000000004dc66c>] register_console+0x34c/0x580
> [   29.858828] [<0000000000920358>] serial_core_register_port+0x898/0x8c0
> [   29.858835] [<000000000092555c>] su_probe+0x15c/0x3e0
> [   29.858844] [<0000000000936d88>] platform_probe+0x28/0x80
> [   29.858851] [<0000000000934338>] really_probe+0xb8/0x340
> [   29.858863] [<0000000000934764>] driver_probe_device+0x24/0x120
> [   29.858872] [<0000000000934a0c>] __driver_attach+0x8c/0x1a0
> [   29.858879] [<000000000093232c>] bus_for_each_dev+0x4c/0xa0
> [   29.858887] [<0000000000933668>] bus_add_driver+0x148/0x220
> [   29.858894] [<0000000000935634>] driver_register+0x74/0x120
> [   29.858903] [<0000000001635e3c>] sunsu_init+0x180/0x1dc
> [   29.858915] [<00000000004347b0>] do_one_initcall+0x30/0x240
> [   29.858924] [<000000000160d014>] kernel_init_freeable+0x244/0x2b8
> 
> Running the apt package manager results in a minute-long hang and this backtrace:
> 
> [  112.800879] systemd-journald[154]: Time jumped backwards, rotating.
> [  123.148552] kernel BUG at fs/ext4/inode.c:1174!
> [  123.208162]               \|/ ____ \|/
> [  123.208162]               "@'/ .. \`@"
> [  123.208162]               /_| \__/ |_\
> [  123.208162]                  \__U_/
> [  123.401513] apt(881): Kernel bad sw trap 5 [#1]
> [  123.461051] CPU: 0 UID: 0 PID: 881 Comm: apt Not tainted 6.16.0+ #32 VOLUNTARY
> [  123.557129] TSTATE: 0000004411001603 TPC: 000000000075eda8 TNPC: 000000000075edac Y: 00000000    Not tainted
> [  123.686379] TPC: <ext4_block_write_begin+0x408/0x480>
> [  123.752813] g0: 0000000000000000 g1: 0000000000000001 g2: 0000000000000000 g3: 0000000000000000
> [  123.867186] g4: fff0000007eb8140 g5: fff000023d194000 g6: fff000000a130000 g7: 0000000000000001
> [  123.981565] o0: 0000000000000023 o1: 0000000000d74b28 o2: 0000000000000496 o3: 0000000000101cca
> [  124.095948] o4: 0000000001568800 o5: 0000000000000000 sp: fff000000a133161 ret_pc: 000000000075eda0
> [  124.214890] RPC: <ext4_block_write_begin+0x400/0x480>
> [  124.281219] l0: fff00000029ce828 l1: 0000000000113cca l2: fff00000029ce6c0 l3: 0000000000001000
> [  124.395608] l4: 0000000000000002 l5: 0000000000080000 l6: 0000000000012000 l7: 0000000000000001
> [  124.509978] i0: 0000000000000000 i1: 000c0000003bfa00 i2: 0000000000001fc0 i3: 0000000000680000
> [  124.624351] i4: 0000000000000000 i5: 0000000000000000 i6: fff000000a133251 i7: 0000000000762518
> [  124.738729] I7: <ext4_da_write_begin+0x158/0x300>
> [  124.800487] Call Trace:
> [  124.832506] [<0000000000762518>] ext4_da_write_begin+0x158/0x300
> [  124.911429] [<00000000005b84ac>] generic_perform_write+0x8c/0x240
> [  124.991491] [<000000000074ae30>] ext4_buffered_write_iter+0x50/0x120
> [  125.074997] [<0000000000695420>] vfs_write+0x2a0/0x400
> [  125.142468] [<00000000006956c4>] ksys_write+0x44/0xe0
> [  125.208805] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> [  125.285437] Disabling lock debugging due to kernel taint
> [  125.355205] Caller[0000000000762518]: ext4_da_write_begin+0x158/0x300
> [  125.439843] Caller[00000000005b84ac]: generic_perform_write+0x8c/0x240
> [  125.525624] Caller[000000000074ae30]: ext4_buffered_write_iter+0x50/0x120
> [  125.614836] Caller[0000000000695420]: vfs_write+0x2a0/0x400
> [  125.688035] Caller[00000000006956c4]: ksys_write+0x44/0xe0
> [  125.760093] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
> [  125.842442] Caller[0000000000000000]: 0x0
> [  125.895052] Instruction DUMP:
> [  125.895055]  110035d2
> [  125.933938]  7ff35910
> [  125.964823]  90122328
> [  125.995700] <91d02005>
> [  126.026582]  80a06000
> [  126.057466]  02480010
> [  126.088347]  d45fa7cf
> [  126.119224]  d85fa7cf
> [  126.150125]  9736a000
> [  126.181088]
> 
> After applying this patch to fix HugeTLB support on sun4u, the backtrace during boot changes to:
> 
> [   29.860234] rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
> [   29.860241] rcu:     (detected by 0, t=2109 jiffies, g=-1151, q=3 ncpus=1)
> [   29.860247] rcu: All QSes seen, last rcu_sched kthread activity 2109 (4294939474-4294937365), jiffies_till_next_fqs=1, root ->qsmask 0x0
> [   29.860256] rcu: rcu_sched kthread starved for 2109 jiffies! g-1151 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> [   29.860263] rcu:     Unless rcu_sched kthread gets sufficient CPU time, OOM is now expected behavior.
> [   29.860266] rcu: RCU grace-period kthread stack dump:
> [   29.860269] task:rcu_sched       state:R  running task     stack:0     pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x07000000
> [   29.860285] Call Trace:
> [   29.860288] [<0000000000c0a2f4>] schedule+0x14/0x160
> [   29.860305] [<0000000000c11254>] schedule_timeout+0x54/0xe0
> [   29.860317] [<00000000004fbe00>] rcu_gp_fqs_loop+0x140/0x6c0
> [   29.860329] [<00000000005000fc>] rcu_gp_kthread+0x23c/0x2a0
> [   29.860338] [<000000000049b848>] kthread+0xe8/0x120
> [   29.860347] [<00000000004060c8>] ret_from_fork+0x1c/0x2c
> [   29.860359] [<0000000000000000>] 0x0
> [   29.860364] rcu: Stack dump where RCU GP kthread last ran:
> [   29.860368] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #33 VOLUNTARY
> [   29.860378] TSTATE: 0000004411001603 TPC: 00000000004db4c0 TNPC: 00000000004db4c4 Y: 00001390    Not tainted
> [   29.860383] TPC: <console_flush_all+0x360/0x4c0>
> [   29.860397] g0: 00000000004db4c0 g1: 0000000000000000 g2: 0000000000000000 g3: 00000000017fd000
> [   29.860401] g4: fff0000000180000 g5: fff000023d194000 g6: fff0000000158000 g7: 000000000000000e
> [   29.860406] o0: 00000000017fd1e0 o1: 0000000000000000 o2: 0000000000000000 o3: 00000000017fc5d0
> [   29.860411] o4: 0000000000000000 o5: 000000000185d7e8 sp: fff000000015a901 ret_pc: 00000000004db4b0
> [   29.860415] RPC: <console_flush_all+0x350/0x4c0>
> [   29.860423] l0: 00000000017fc5d0 l1: 0000000000000000 l2: 0000000000000000 l3: 000000000143b538
> [   29.860427] l4: 0000000000000000 l5: 0000000000000001 l6: 00000000015c20b0 l7: 0000000001536308
> [   29.860432] i0: 0000000000000000 i1: fff000000015b2b8 i2: fff000000015b2b3 i3: 0000000000000000
> [   29.860436] i4: 00000000017fd1e0 i5: 0000000000000001 i6: fff000000015aa01 i7: 00000000004db6a8
> [   29.860441] I7: <console_unlock+0x88/0x120>
> [   29.860449] Call Trace:
> [   29.860451] [<00000000004db6a8>] console_unlock+0x88/0x120
> [   29.860459] [<00000000004dc1e8>] vprintk_emit+0x1e8/0x280
> [   29.860467] [<000000000042a34c>] _printk+0x20/0x30
> [   29.860477] [<00000000004dc72c>] register_console+0x34c/0x580
> [   29.860485] [<0000000000920418>] serial_core_register_port+0x898/0x8c0
> [   29.860493] [<000000000092561c>] su_probe+0x15c/0x3e0
> [   29.860502] [<0000000000936e48>] platform_probe+0x28/0x80
> [   29.860509] [<00000000009343f8>] really_probe+0xb8/0x340
> [   29.860521] [<0000000000934824>] driver_probe_device+0x24/0x120
> [   29.860529] [<0000000000934acc>] __driver_attach+0x8c/0x1a0
> [   29.860537] [<00000000009323ec>] bus_for_each_dev+0x4c/0xa0
> [   29.860544] [<0000000000933728>] bus_add_driver+0x148/0x220
> [   29.860552] [<00000000009356f4>] driver_register+0x74/0x120
> [   29.860560] [<0000000001635e3c>] sunsu_init+0x180/0x1dc
> [   29.860572] [<00000000004347b0>] do_one_initcall+0x30/0x240
> [   29.860581] [<000000000160d014>] kernel_init_freeable+0x244/0x2b
> 
> while the backtrace produced when apt hangs is:
>       
> [  337.599490] ------------[ cut here ]------------
> [  337.660412] WARNING: CPU: 0 PID: 895 at fs/ext4/extents_status.c:298 __es_find_extent_range+0x128/0x140
> [  337.784523] Modules linked in: sg sr_mod cdrom sym53c8xx tg3 libphy mdio_bus
> [  337.877302] CPU: 0 UID: 0 PID: 895 Comm: apt Not tainted 6.16.0+ #33 VOLUNTARY
> [  337.877314] Call Trace:
> [  337.877316] [<000000000047286c>] __warn+0x10c/0x120
> [  337.877326] [<0000000000472910>] warn_slowpath_fmt+0x90/0x120
> [  337.877332] [<0000000000748988>] __es_find_extent_range+0x128/0x140
> [  337.877341] [<00000000007490f0>] ext4_es_find_extent_range+0x50/0x100
> [  337.877348] [<0000000000742a1c>] ext4_ext_map_blocks+0x7fc/0x22a0
> [  337.877355] [<00000000007578d0>] ext4_map_query_blocks+0x30/0x2a0
> [  337.877366] [<00000000007596a0>] ext4_da_get_block_prep+0x380/0x640
> [  337.877375] [<000000000075ecf4>] ext4_block_write_begin+0x294/0x480
> [  337.877382] [<00000000007625d8>] ext4_da_write_begin+0x158/0x300
> [  337.877389] [<00000000005b856c>] generic_perform_write+0x8c/0x240
> [  337.877399] [<000000000074aef0>] ext4_buffered_write_iter+0x50/0x120
> [  337.877406] [<00000000006954e0>] vfs_write+0x2a0/0x400
> [  337.877415] [<0000000000695784>] ksys_write+0x44/0xe0
> [  337.877421] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> [  337.877433] ---[ end trace 0000000000000000 ]---
> [  339.153555] ------------[ cut here ]------------
> [  339.214459] WARNING: CPU: 0 PID: 895 at fs/ext4/extents_status.c:298 __es_find_extent_range+0x128/0x140
> [  339.338108] Modules linked in: sg sr_mod cdrom sym53c8xx tg3 libphy mdio_bus
> [  339.430869] CPU: 0 UID: 0 PID: 895 Comm: apt Tainted: G        W           6.16.0+ #33 VOLUNTARY
> [  339.430880] Tainted: [W]=WARN
> [  339.430883] Call Trace:
> [  339.430886] [<000000000047286c>] __warn+0x10c/0x120
> [  339.430894] [<0000000000472910>] warn_slowpath_fmt+0x90/0x120
> [  339.430900] [<0000000000748988>] __es_find_extent_range+0x128/0x140
> [  339.430907] [<00000000007490f0>] ext4_es_find_extent_range+0x50/0x100
> [  339.430915] [<0000000000742a1c>] ext4_ext_map_blocks+0x7fc/0x22a0
> [  339.430921] [<00000000007578d0>] ext4_map_query_blocks+0x30/0x2a0
> [  339.430931] [<00000000007597d4>] ext4_da_get_block_prep+0x4b4/0x640
> [  339.430940] [<000000000075ecf4>] ext4_block_write_begin+0x294/0x480
> [  339.430948] [<00000000007625d8>] ext4_da_write_begin+0x158/0x300
> [  339.430954] [<00000000005b856c>] generic_perform_write+0x8c/0x240
> [  339.430964] [<000000000074aef0>] ext4_buffered_write_iter+0x50/0x120
> [  339.430971] [<00000000006954e0>] vfs_write+0x2a0/0x400
> [  339.430979] [<0000000000695784>] ksys_write+0x44/0xe0
> [  339.430985] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> [  339.430996] ---[ end trace 0000000000000000 ]---
> 
> So, I guess while your patch may fix HugeTLB support, there is still a bug on sun4u with THP
> which needs to be addressed.

Maybe try enabling CONFIG_DEBUG_VM_IRQSOFF, CONFIG_DEBUG_VM, and perhaps 
CONFIG_DEBUG_VM_PGFLAGS. That might help detect a problem closer to the 
source. You can also try adding transparent_hugepage=never to the kernel 
boot line to see if compiling in THP support but not using it is okay.

Anthony

> 
> Adrian
> 

