Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896284964E;
	Sat, 30 Aug 2025 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756519087; cv=fail; b=lALMbQvmOx7WMWYHnzPDEmZwRsHEl65kG87JjvYvopyDwmYypvGKI40KLLWkw5+SqDfgMlXxNqKZusEl06TD7nPCNGCgGu2/Y81U9pLK9/IEMNrse4yPCpjSW8vH7w1iiZRM1FqvuvdPSqcMUNZR7gvpLoP9YVyJPt7S8YJWAAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756519087; c=relaxed/simple;
	bh=1b5YCKQv8L8GQXqiVBlXzVsRYtbY4NmQljuAH6GLXwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OVOr4qQ7uvxo1lqxCysCEqL0RilxRo1LghZh0ggBIixT8cuaZyfWYrYU2HnC5SmUBYqYpni1eo5AaDJgIqLoLJ83/H+hQ0Vft2ALPaN+KDdfvb9Trk2inXKZ4QKSx1QwBAMlqog4wpIUIOgUmnivoWhe//439FD3bihpUj0ItF0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TwOtxiPH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ce2tpX1Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TwOtxiPH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ce2tpX1Q"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57U1vmIV002116;
	Sat, 30 Aug 2025 01:57:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=sncDmxvRgXTzLEmBLLQkofVd173aX1kESW2rqPqJqcM=; b=
	TwOtxiPH3SyHWVisQgX/jMu1oZJN9XIFvsQbVqnQLQcP1WY3MuJvKDsWtZD3SPJn
	4mSMqDImRNFFNOtoFrcPlFbQdxIQLFS4eq+LoPEhYo78Jn40GA6uDPLo8q8btxRF
	bcKXxISMwkgRus0FFX6of+NKjALdExzVYa/54MNUtdLymA947Q4pZJ0KRCfMOjmZ
	mziAvOi/8ewzECLNRojpDh8RYqrZ/iztRO6UgS1xl7uZ/UmP1JQtwxpAURjJRcxR
	C0Q8Q3FP9mNp7nYX+ionKINlS9iZxsHDvmcEkpM5VZY9EYavlrKoPYsaIm3oOO+F
	Nelv3j7PrD3WqJIWBvxCvA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ur33r00c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Aug 2025 01:57:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57U1XNkZ029452;
	Sat, 30 Aug 2025 01:57:47 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr6890d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Aug 2025 01:57:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S0P3WIPAg25JDQjxksQz/37FJAZauAeJruw1I+n3Hu0XRLwOx8RjfqFASQGKavKUTWtPF04phy0cPf8+69TQMkCILcjl34g2AGEeL0bzothOAXXvdMbx8iitW5SzTuUTZ5JYXzsV197Kk2qM0kiHt37i5wopzbjcQFZDjiVi/LmShoumv2RqzsDVLwe4S3qqQUjUN4cek85c+ug8+fMJMrMqCx2CZOBaPlpqR5AtyBSZKJIMKYtCK4nuwhXWob9ci8IzyNYeBcvguVP/9ilOBAwhBKV7PUA0EW5gNtDwI3g175QAEW5taqlx875FrSpOsgNybccR97+39XFgijHB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sncDmxvRgXTzLEmBLLQkofVd173aX1kESW2rqPqJqcM=;
 b=ck1aErhsOEAWfToAMEpwJ/6I7+RMn9ZKbibvAhQoDKqEu3B4asqkg/UMsHEpA4SCrvgIsh8+bd2aJXklMy9MWh1LiAWbsLSz8Ni5HQ9w8x6E0zU89zeSNnUIk0Hv3QX94pRHyQ7zO2XfFp5CdVSCkMZkNIlNH9/WBVa/YSV29kCC2vVePCnRus6hCkeG1Seg4zccKYZ+8MbpBbsyAZPq1Jk3pkxNZZvHAz3P5iNFvlKZ3wXys8rmCxwphvnhjHYFdNSh9LXReI7rc/fUeymi8v2pH+HjvXbJ9eloaFUfCQ1fjSOUQEWClt44Qxih3G4Pec6C6uQmddH+cXPwXKqd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sncDmxvRgXTzLEmBLLQkofVd173aX1kESW2rqPqJqcM=;
 b=Ce2tpX1QVFYmVoaR9oyB0KBKyzWJZOxE3mYrSLqUxCCBeeMjCp9y1r0iUT5QaKqR3FQ2MlMWXeCpZ+Awg6r/Trg7dSGSWi8n9XAacKbmcjUsmZ7oiFIqQHs7Jx1c8VwjGF7Cg9PDn3Gc5jURwpg5lBm0w8htOtvwhwbjNirMIak=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by IA1PR10MB6709.namprd10.prod.outlook.com (2603:10b6:208:41a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Sat, 30 Aug
 2025 01:57:41 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.9073.021; Sat, 30 Aug 2025
 01:57:40 +0000
Message-ID: <528a5d4b-1e07-4379-afd6-7e58d423e713@oracle.com>
Date: Fri, 29 Aug 2025 18:57:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::33) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|IA1PR10MB6709:EE_
X-MS-Office365-Filtering-Correlation-Id: 680193bf-da00-4225-7107-08dde7689a24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enNFcUhVNGZ4NFNUeVJaWVFNbmZhSTc1b0lJbWJFL1RUSmNiNjU3N3diOGpj?=
 =?utf-8?B?MWdzR1c4R1c2blRzZGRDaGRQTkdRTUdCekJybUFnaDB4STRVQm1Sbk1BTitF?=
 =?utf-8?B?cFNxNWZXSEtJa3NqR1VQMFovbHlYUkNTMjJoWUNkWHpiMXZXU1QrZzF6K09L?=
 =?utf-8?B?bEYwYmdBYTdmY2V6VDlmcmdxQUxhY2hOVGtmLzF5SGRScjY5SnJ4alZabzZq?=
 =?utf-8?B?YVNUd1p1TzAyTGQ0ZXlVUlloQlJZclJ6MVIyZXJxaDJZdFppS2EwRlgvaGJn?=
 =?utf-8?B?dHBKWkt0LzM5b3VzUnlEN0dPU0NvYlNJb3lFblFKbWg5YlRlZlJ4WHVTQWY1?=
 =?utf-8?B?TEMwbEE1YmJ2NVFqaFlocHZHWDRRYUFTQjRLZUlrb1F2aWR0Wm8vTFRPRC9s?=
 =?utf-8?B?RW5JU3h2WVkzbFBLOGxUamtWdFphMW85U1Q4bmJiaTlNT3ZxZmkzZzBQN0Np?=
 =?utf-8?B?WUpBRGRWL3JFUk9zSXhYLzZwaTRHL2I3aXVuTGZpUDJuSUJsbEtqNyt3SDNL?=
 =?utf-8?B?bTUvNFhDZ1h4d3NmbWZmaGVOU05vaGl6Y0FBWm9uZXVTazBXN2lueHY1UW5i?=
 =?utf-8?B?c2FNdTRJa29XSDB0cVdWWi9YeWF1djBmWURyTWdCZHE0TE4ra3ZMU3YvQlc2?=
 =?utf-8?B?ZURUZHlmaXNPSEZ1eGo3U1NjZ0ozdHpLSVFVd0preEorWU1lK2Q2MDgvTHNO?=
 =?utf-8?B?QjJ0a2s3TW83OSt3SWx4SlAyemFmWFhLSUlKTjRoV1FKRkM3S2wzMGZMK1ZR?=
 =?utf-8?B?L09NakhZZFlZSWRVeVlsQlUya0I4TmJ2cFA2ejRaeWs5cUhRUElPQmU4bThD?=
 =?utf-8?B?akxJKzJhUzFQTitMaXVtVG1PRlI4c2ZlN2VoNjlJaTJLWTZySUUyanJzMWp0?=
 =?utf-8?B?dzJMNzZJbzI0S0paR2c4Q2kranBJeGpKSHNNNHBDekRpRVltMmFwZ1lkU3Va?=
 =?utf-8?B?YW9PZkl5Ly9DVE13OTBSd1FYV0l6aVEwVnQyKzY4d2RYeUsvSTlnR1JBaS9V?=
 =?utf-8?B?QmJYRmgzVUJYYnF5TFBHb3A4ZWhLNHhONmErKzdjd3FaZExKNWtZb1BFY3BL?=
 =?utf-8?B?VUFGN2RIQTFNWEZhR3ZEQ20zT1p6c3dSRkt0dXNoTzdHVWVTZW9yMDFOUDlv?=
 =?utf-8?B?eERpcVIzWlRxR0FXN1B0Z3RWWHJRRnhyVmNBUUFyNHIwTzVQc1pUbFM5cnRK?=
 =?utf-8?B?Zi81Mm54YlN5R240VlgxM1VSWVBpci8xd1gyNXBNd09BbFNTblBtS2RJeVZq?=
 =?utf-8?B?eTVtRUp6UjhTNnV6ajNoMzdNa2dDK25CQkFVbDEyb2dpMUJaNzZkNVRCME9s?=
 =?utf-8?B?VGJvTmFiNHhFOTdxNzU0V3RHYjl5VVBWNmZqWGVQS3BwVVRySnBzUEVqZTVz?=
 =?utf-8?B?akZ6dmx4VWVqMzBTeHBUU05idkdPZ2Jla09EUE8yM3BYVVhWc0VxcDVzZjVW?=
 =?utf-8?B?YzRGbGlOMHRxT29jSkRQR2ZhTzlDOE9rd2oxSEhwa2crckppSm1oU2I5aStG?=
 =?utf-8?B?cGFVcjBHS2luODRKOWtIUUNCS1ZmTUtTR28ySjhvemFINW1BUVluZG1wTTdy?=
 =?utf-8?B?OWNvaUJCZHdKejF0aXlHRHRzRW9DcWNUekVKTzJyTm9TWDBXNUM3TjNoR3dM?=
 =?utf-8?B?R0tkTzB1a3laZlp4L0RzK24vY2tHSHVUS1pHM2lXMU9iZGhabmQwK2tJTmlu?=
 =?utf-8?B?czBpbHJLWWUwcUpRR3FVN1dyWk9OdnZuRHR3Rno0c2p5b0dNSGoyei9ua2tv?=
 =?utf-8?B?bGhHSjBsMk92TmFNTzhOVDdxUnE3VytsZEZhcEx0RE8rYzVHYnloS1ZraWJV?=
 =?utf-8?B?NVRWQXBEVjlKdEg5YWVVcEplSDU4UlNKblB6S2xod05SZUhRUDFUSzkzSElL?=
 =?utf-8?B?a2RJUmNSa1VkeXdMZkFyOUhrVElyV1VOTHhmbFZDOHJzd3h2Zi9zOWZhYzZ6?=
 =?utf-8?Q?4FKojddQLsI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3U3WkhrODBWYmZ1cUtZWUR1aWVLSFprTWZWc2J0QVFlVzc5bFNoTGpqbitt?=
 =?utf-8?B?YnFHYXZHdUFEcXlQODJ5eTNsTGZhNy9sWWZTeGtnU2p2QVFwZktWdkJHV3ky?=
 =?utf-8?B?azI5aG12ckx3RG5Tdk9NbS90d3ZySlBFMGRXVGNoMlVNWEdoOU9BTWlGVGNW?=
 =?utf-8?B?emNndndBYmVjV0ZxYWFzU0huRkNwSkRyaXVqSFpsNGZHNlhjWlZ0eHVVOUpH?=
 =?utf-8?B?OXU5SGtYTFFwQlNURTYxZ04zTlVkTndLLzdoeXR5ekVkNTlZWi8xNE5IK1d6?=
 =?utf-8?B?dHVCMVFScUF3SUYyM0NWbTdIZ01qZDdxUWdwcjdlZ1BVNHZWb3IyeG92MnVE?=
 =?utf-8?B?cCtnWklHNEI4b3AzejVXL1pqWm5GZ0E5OG51dlNYR3k4bm9tQzQwQlFCWmZR?=
 =?utf-8?B?VkJXbFVXSlZBdVFoV25XODdLZ3EwWGZEcTB2dThQUTl0RHpSb3ZWUHM5ZDhE?=
 =?utf-8?B?K04rYkZKbGo1WGpqeUZwM0pqMkRTcnhxNUo0MmFncmtvYzFlV01SalR0MC9y?=
 =?utf-8?B?ZEdOWS9OQlZCV1pTQnBFWU01WHFaM1BKMzU0ZW54QWtFcVFKU0ZYSGRWZSs3?=
 =?utf-8?B?b09wc0NBaFh6NmFvKzNHQnBBQlcrVUxrTWhjUmExalpKOHhsKy9naEZzYzgz?=
 =?utf-8?B?NGYrZVYyU1h5Ym9jTnVlbkNpNmFRYlZkZnRxV0EvZWxYTUhpc2hBaEhDd1oz?=
 =?utf-8?B?MEpnRGpFT2NWYUpaQSs2cW0xQ2RBckJ4ZTZVR3FaTTFEZUE1SlpBTmxCdHo0?=
 =?utf-8?B?Q2N3SHpJaHp6a0tEbUpvZmlwUWJVWldQcDRLV3laMEVqZGdPUUQ5SWtwcmh2?=
 =?utf-8?B?djg4ZDBCb0FqR1A2RTVDS29rYjB6aXRlcTJzR3RvYWI5eUF3RGFBNzhEYXEr?=
 =?utf-8?B?SUJ4TWtSekphKzlOR1NPRjNQc3JhRFNYL3Z1ZXdOeUpBR1JmQjBQTVZHNzcr?=
 =?utf-8?B?UkFBMy9oZ3E3bC9FRFZuRmcwc011bzRDVDRYcCtZOHBSbjJ5ZmVuL3drVzY5?=
 =?utf-8?B?Ti9rMnFGOFQ5eExKK00yY0dyOHBCNStaQmNmT2VOVXFJUWJFMm5hM0YvUUxS?=
 =?utf-8?B?QjMvWEFPMGNPWEl1RmlNa0JuZVBUUkpqaW96eHordEFQNEROOEplSjlsdGhV?=
 =?utf-8?B?dVBjU284enNLcGNpTkdYSXdnM2M1c2lXa2lsSVNObHhjSlZyS09tNmwvTy94?=
 =?utf-8?B?bUNjNmJlSlNhSk96Q3NrWUR4YXU2TXU2VHRwcjE2dk5zZmUwK215akN0WWN2?=
 =?utf-8?B?K2hySFRuT1NndGUybGNxSWpWVFZ6MkQzamN4YjJxQVdhWG5HdjFBbnQ3Tm9p?=
 =?utf-8?B?S1lmeGo4TTBhZnFCVnlFYWdKV1NoSEJvUUk4Smd2V0JMYXNzeU5qRnRkT3pR?=
 =?utf-8?B?dSt2MFZhY1p1b3AyNERVM3RCN1JUNlhSWGttb2lTaERUbkRFM052M1d1dU5B?=
 =?utf-8?B?ZVJrWUlFMGhiMUxpWTlWck9Wd0ltMjM2bDNiakRiaEFSNGNvSHEzVXkwVUNJ?=
 =?utf-8?B?V0FMaDY1RkREZE50REpVcWFoRlU5cFA2MHRnenpIWUI1ZkZFSkFuVVhWZHd6?=
 =?utf-8?B?cjZyYW5iaFFUdlhqWWZwU04yZmtBOW9hT1dHbzZEVkhJL1lIQ3UvYkpvRnVS?=
 =?utf-8?B?bVZMVGVZSkRCbEpQeXZWTkpwdUd0cDk2ZUZpNGNWS1hUTTl6RnIwR2JvU0Vl?=
 =?utf-8?B?VGp6ME1tOWl3dWFkcFU1WExDbDE2WHJqSVdtQjJLNHk3aTl3TkhzSlMxSDIx?=
 =?utf-8?B?QmVhOGNidFlNeE1QUlFxK1FtWDN5dnlFVjcvZHN0T0hUV3Q1Wk9TZ0w4cmVK?=
 =?utf-8?B?VUI0dFFVRW43SitraDJSOHE2YVc5c2Y5QUcrWnZBZXUvT2RheHN0KzNFeDR5?=
 =?utf-8?B?azRCR0ZZWEoxaDZ0ektMNjJha3RVNEZEai9yWlY0bDJNek9kcnN0Y2dtTkhW?=
 =?utf-8?B?Uy9FQ2pWVW9TWnNhWjVRUGJCWEc0VDVtcjNFUU56WkRuVW50Zy9GQ3dsU0lJ?=
 =?utf-8?B?Q1AxUWt1c3J5b1RxQWdjZmlUdHUwcXVsYUo2UGhZY2REcSthOGkzelU4cEpz?=
 =?utf-8?B?RmlHRnVYakJPQmtsa3NzTmM3bmlTZVgwcFN1cWphVDRDUlFtc1IxRUZXT0V0?=
 =?utf-8?B?TzBmN0RjU3hNRldoN0xOVjdrUXhaZW5yVzFCMGZOUVN5azJIakR0d1cxeUJO?=
 =?utf-8?B?TVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OoTaXbhbSMK599UWZJS0GNn0FxwQb5wOIpVljx/pha9FFbTHgaxnwcTUgS5zgiBWYmcv3WEzQvOQUahkzWjqyPL7Oirz00YwWszSqTNnt6m2uCUv5zN1I5UFAn0WVmFBKtAKZsE1WfSeCySCVXF3wwAv2SBFj6HsC1b/s0m1LrrQw+j9g4BAfh+9pKoYEvQT7nI7FjTY4q+LtVOz323mRxxPgxPQyPyrH96QyAeI/LrGida9DzAruO1ggmK/Op8eNH3HhJAEZbJ5baz+LHGi5cqLkWmsdCLEX7A9bhauQs4bH1nwan8R6Kf6iW/ug9dFGN+fYNe2if6MChFUDhUq0FmYBkq9AudKlPqLZ9adAHmTmRoUkwmXlhfzeSSd/g13K/WTXo2jR/xvUOD8pJeGJ2rYnfcNAQUU1RB+uGrk8ezNaDRw2c30a9As/7s3AlY77IPsGhpqm8VwpqSwTqDdOtS3HqmTmFwG+OFmzn6QyEN7weJ0SihYLcSyap9GJwTKJWPYteP5WLutDKiB2rwXT7jQXgbaqXQl2SpBqrE1fIOzl5W7CGC4PITzjtw/SYxlCNAPZPN+NF0cNA1Lej4Zltj/XvoyIoA3PQ2XInqTVc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680193bf-da00-4225-7107-08dde7689a24
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2025 01:57:40.7752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCxhr+9l+5AwzXaoL8bjAaiThpgJ6E2vkx1YfdjQFGxGsNBtJTJoEt2bE1uYZf73IXux5j8agL4E2F/7MWbd/32iTr0FRqoHgkaeCTQ16BM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-30_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508300017
X-Authority-Analysis: v=2.4 cv=YsQPR5YX c=1 sm=1 tr=0 ts=68b25a9c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WUGxWMdAEao1fNspDMYA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cMAEmXLcxhtSIk_ZTQy67Fp4j0ZNFFET
X-Proofpoint-ORIG-GUID: cMAEmXLcxhtSIk_ZTQy67Fp4j0ZNFFET
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxNyBTYWx0ZWRfX6PSdReVZvihA
 Fkf6JHffZx8lDj3uPcs7XZ15wN7PyIG6zxRFmZM0wTMMv2MoALzo7Fr0DtQPotLkjQky+l5Ym0y
 Yk396xa/YmmW6MxsktVOVnQcYERK118rE9Zch+5yIq2D93OWM12Q3w3Hedfhi0H6Hy1pV7pm2HR
 Dm2pFPpTQBSK4vNZGeBv/s1mvtgruENINpLKvdZSmk5PJn/Abvg1Uicg+tUJTII2r4s1+vjMXoe
 0uag8OTIj3Ygc8ALPKZtMwnSD6IEnODZo4Nb2j7AYHPcHVOIqC0NFnEwtjUGvaPzTB0uttv/yMO
 p11nWevb7BxE0b4jEuigvgYY20MQGvgEowgGkvHC755IKGJ6HOktptys2My1JdGkjskZZFN1oHY
 9el4yAQm



On 8/26/25 9:03 AM, Michael Karcher wrote:
> Based on a finding by Anthony Yznaga that the UltraSPARC III copy_from_user
> returns invalid values breaking other parts of the kernel in case of a
> fault, while the generic implementation is correct.

I think there should be a little more text about the nature of the 
failure. Maybe:

He observed that a BUG_ON in ext4 code with large folios enabled 
resulted from copy_from_user() returning impossibly large values greater 
than the size to be copied. This lead to __copy_from_iter() returning 
impossible values instead of the actual number of bytes it was able to copy.

Otherwise, the fix looks good.

Reviewed-by: Anthony Yznaga <anthony.yznaga@oracle.com>


> 
> Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
>   arch/sparc/lib/U3memcpy.S | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
> index 9248d59c734c..bace3a18f836 100644
> --- a/arch/sparc/lib/U3memcpy.S
> +++ b/arch/sparc/lib/U3memcpy.S
> @@ -267,6 +267,7 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
>   	faligndata	%f10, %f12, %f26
>   	EX_LD_FP(LOAD(ldd, %o1 + 0x040, %f0), U3_retl_o2)
>   
> +	and		%o2, 0x3f, %o2
>   	subcc		GLOBAL_SPARE, 0x80, GLOBAL_SPARE
>   	add		%o1, 0x40, %o1
>   	bgu,pt		%XCC, 1f
> @@ -336,7 +337,6 @@ FUNC_NAME:	/* %o0=dst, %o1=src, %o2=len */
>   	 * Also notice how this code is careful not to perform a
>   	 * load past the end of the src buffer.
>   	 */
> -	and		%o2, 0x3f, %o2
>   	andcc		%o2, 0x38, %g2
>   	be,pn		%XCC, 2f
>   	 subcc		%g2, 0x8, %g2

