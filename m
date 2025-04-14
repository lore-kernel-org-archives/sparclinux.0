Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4627467D;
	Mon, 14 Apr 2025 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654101; cv=fail; b=if1akZb8JVuyemrcyR7YHU7RPRWV0SN7s4YypQ8dgauCMZKIYDJgssyEt6HFuHrS5scyiKh/ciUwD9jpoCDtqxVUJKmrJM87arfviFE2JvrSYFhif+sZJ2s3+bg/8Gp6zdTzwlMfjCvWzeq1L04TIECyjky0qfV0ScYYkfrTG8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654101; c=relaxed/simple;
	bh=ig7GPW4D9ouqBlzy4LovY9jGQNjZWMtP7cIPAOXFi9Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=URpX0CPIyQ+6aRjhUTzfS48AW7wlbbu4fBdN7msdTM0/w2yU98w8F6pvgADd3hxqDKlU5pJvVEoNugbw5DqEET2bxDZDXJ0TNDdKjFF1P4FrVrtzXlGedzKqrCczJSU9ICKeaec6aa48Iy9+XwFBLO10XtKlRFLbTky/J8/32/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=II2omZJk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hBk/+EnV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="II2omZJk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hBk/+EnV"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EI1xbq007349;
	Mon, 14 Apr 2025 18:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=TaeOEvN/+1QQgqOehgcsL5IYnEOBR9BdWIE+GxlRclk=; b=
	II2omZJk/k6ysCdTZakLs7072mn2jN+ndD5MDQf+iZ1V/xFo6jhfvFnOjDf6zMLt
	B6wIDfHFMkj8B1VD7EsB8ec9DkO1bmmkWnWp649kxLHTTSC2ElMZSKYq+mTRmoZ6
	GDGoBxSH8kMd6AiB0PmdYgzDXfOtA7WZWavqXe2T4yAFML3+J+ZxA17/bSU3c05K
	akf28k929hYnohh6omRbN3Q5Xt9Bjd9hSaX1VRy/PbMPB12qvd2OaKW5Hj6PM3/v
	d/XaJQxZkeA1nObJNQTC1qQoWVpy2TqvrQvQdeLDOqQhOmRK3TDmm2MsVd5v+d+K
	ZmRyj4VVtF6fRUA0AOq9gw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46179gr0bd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:07:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53EHjhu2005663;
	Mon, 14 Apr 2025 18:07:59 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d5u3uq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 18:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TdemcVJ+eKhcZqqBwRAVP8hYh2sFR12cICMsMhMRoMojZYMQBHUDDxoHX8i/qWVOBjX/KWaJPijrEq320whPR1QJe+Bnhw6FOMli8ZP2u2HlKek99SXcX4RZQ5f+svYPtoHHmJw6bbZ4b+KBDzOzp+gyn3FXKf+HvCOGeVxDvBNi46RMtf7bDzFqGwWgc46a4h2oztF9INGKZBkYrl3vXSECbNzP8L0QZE3UF3MtqrOgdmvyNZBGrzKKkQt47hnVU0/kNz+6/ZY+8yceJOFS5bOuFOF26xwdZqC6gudpbaEChsZbvwXtVWNYnIK4336sKdXxM0f+O9nKJD2ngFUUaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TaeOEvN/+1QQgqOehgcsL5IYnEOBR9BdWIE+GxlRclk=;
 b=AtQv0akbRwoLU7ppb8qBjc8TyC7eStnHCyfFQNA0G2M5Np/tz9CuSLvWthP1XXtn/e4CtvoPNuTCa8w5QFxVL535Sr2h1xjAx1iPlp4eL1O6yfw8sJW7G3gss7wX43ICrDhPKbdOyv/vf93wU0qeRakXfW7h74O8d9EBJkGGeg5bVG+/04LKRAuyyE6t1qrPe/HafzP/GAGOWvpej8faJw8360SYkmr3f9yER2hZKtT5qDMaZGOpUHHEq/nTExpBk6VDVJqxPBIGvYgugdGeJA64nwoLfLzofyxOpLiuhUejEPYxfbPy0TDvqGQ1vGsUg6CUQ/UHkru7qdwAvL7LNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TaeOEvN/+1QQgqOehgcsL5IYnEOBR9BdWIE+GxlRclk=;
 b=hBk/+EnVGIybV3lUWnMC5MixNAXxKY3kFw1QJo0LIaWV2e3w66TcGZvo+4WTJLl67I1lx5AG1LLgq9qqW73YwEffH3jwJPtbGf5uwp2ck4XoqCGpN1ZWHjkgIRG8ZYb7a30UwrTs2HiCApFKzuY+hvFJ7kJhsrsxhZpGu5gTCRU=
Received: from CY8PR10MB7266.namprd10.prod.outlook.com (2603:10b6:930:7c::17)
 by SN7PR10MB6620.namprd10.prod.outlook.com (2603:10b6:806:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 18:07:56 +0000
Received: from CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::9714:91fc:3a27:9ec0]) by CY8PR10MB7266.namprd10.prod.outlook.com
 ([fe80::9714:91fc:3a27:9ec0%3]) with mapi id 15.20.8632.035; Mon, 14 Apr 2025
 18:07:56 +0000
Message-ID: <82791292-9caf-41b6-8d63-1190ea59e559@oracle.com>
Date: Mon, 14 Apr 2025 12:07:44 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] sparc: fix error handling in scan_one_device()
To: Ma Ke <make24@iscas.ac.cn>, davem@davemloft.net, andreas@gaisler.com,
        sam@ravnborg.org, dawei.li@shingroup.cn
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, stable@vger.kernel.org
References: <20250414111845.3084334-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Rob Gardner <rob.gardner@oracle.com>
In-Reply-To: <20250414111845.3084334-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0200.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::25) To CY8PR10MB7266.namprd10.prod.outlook.com
 (2603:10b6:930:7c::17)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7266:EE_|SN7PR10MB6620:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf6a82b-928a-4ffd-852e-08dd7b7f4880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHJOZEdSbjRaeGt5K00vb3pma1dyYXk3SjdnYXE0QW5YMEVyT3ppQWhzbHFO?=
 =?utf-8?B?QXo5N2RYcytqT2pXcHo5QmRqMnAzb3hGd1dPcWVRR0t6TWNVeG11ZEZxV2pL?=
 =?utf-8?B?SlFnWHhvZ3N3N1gxaUwycDFyeTUxSTJoUG5oWHZFRzdKRTA3QjFta0VVYW5q?=
 =?utf-8?B?K2pFVWY1cFFEZWJ1R0hJYW1jenk5SHdBMW15YXQzaFhjSkNEUW51aXpZeDBj?=
 =?utf-8?B?WjZmaE1IcHRKVXNqem41cnBjLzlIbUtJMnJwZjBDZWh2c1dYTnFJaGNRQVMx?=
 =?utf-8?B?OWpieDBXRitkdkdsYXdtWFZwOTBha2ZIeXRFamJrSEVzdCt6QmRNa3NPTGwy?=
 =?utf-8?B?TzhWcXBwdk5NNTJCVzdtbWJJTkJWajh5T1NXaUNld3ptNVl0dVBVdG91czFX?=
 =?utf-8?B?dVU1S2hPNnRzSkMvUmoyL3VDaVhtSU50c1RacXBDK2c0TThjcVl4b1dIYmw1?=
 =?utf-8?B?dDlrSWV5S21zdDBydDA2d3N1NzRHa2RyUHZydGwxSnYxVXFSR0taUXh6Vkxs?=
 =?utf-8?B?SFRBZWgxSXVkaFVGTUdDWXlJOTZiN282QjBEMFppVTdoVHlTbGw2WlRvTmto?=
 =?utf-8?B?TzU3V01QaFlvMmRmL3dlRFRUVW8xc3V2Tk1IOG4rZjRWWWpyNkhEbUJ3R29q?=
 =?utf-8?B?RW1HRWRTRytEeHpieGV3RmU2UUN4TmlGVksvZkM5T25talNDbmpnTlN2UDNm?=
 =?utf-8?B?UDhTTTNEYXk5eXdJSW5IUDErZmd5cnFYM3hIY3pnZjNBYW9EUXI5a3piMlJC?=
 =?utf-8?B?N3c5eVJkdSsxQWZ0cE4veExmYVVQOHVFRGdHR240dHZaL3FSSDA5N1ZvVTd1?=
 =?utf-8?B?V2VENEtBK0llV3ljVzliSzUrclBja0ZJOGRYdktXYUVoOWd3TnJJZXVYSDJp?=
 =?utf-8?B?UHF0U2hVUGZTZFdrYnQra3V4eEJTTmE1T0ZoMm9ZN1JmUjQyUkZGUzBnMUV5?=
 =?utf-8?B?TmUvSkZtOWFXc1IvYXVDejVEbWgwNlhzdFM0TzVseW80eHgwczlCNnhYKyt6?=
 =?utf-8?B?R3FsY3ZyLzJDQWVGVTUvV1gyMmtEeE1FazdDbVJhNU9jR0UwUmI4NHYvTlAv?=
 =?utf-8?B?cFRsMlpzbktuQU5HTzFmSzdhUHlWeXpwZFVuMVJpRUQ3KytQcmp6VE5tUi9O?=
 =?utf-8?B?ZEhlci81MGppc3ZpZnpNYXc4SklhVFFXRkREcGY1R2lBVGFBaE9rb2VGRDdP?=
 =?utf-8?B?dm1VQjlVemp5S3hPZTJkNUN0NnVGMm9tMGN2MjVkaW9DdWFoRlM3OWVPOWZQ?=
 =?utf-8?B?YlBEWUU1SStaaTRxRlgxNjY4ZDZQT2RoTEtLT1JzQ2xidkh1VjV6QTZKNit5?=
 =?utf-8?B?RU5BWHZVa0YxcUp2VVltWU9GTGdtb0cyTHN2ak9UanFzTGFVdkFwUWFsWWVh?=
 =?utf-8?B?cmI0RmcxbDArWExqQUFYK1RMV2p1NzZVMmw3ek9wOEtTdWQzdWlER3ordzNX?=
 =?utf-8?B?cUpBa0hqN05BaHZzeHN0b2txeFR5TWZwcGhUUDJWdjd4QmEzUkx1MDZxTXZ4?=
 =?utf-8?B?aXdyUFk5UGVyV1hnQzFXL0VHNWlOZWNVZFhxRk5KWWVDcWpzVUJEcWt3SWsz?=
 =?utf-8?B?bUlWNXMwMGpKNjlQZSs3QUFYbW43enovRjJzRzBrM0JWbnptODN3ZjhoM1ZV?=
 =?utf-8?B?KzkzUEFzY3Y3dEdLd1pJRjJZUVBBRjRxL1pmNUROZ2E0VjlLU0F1NXdsWXps?=
 =?utf-8?B?Zmxyb1QxK1ZEdDNrcjRVdmtmOUhOaHpXMGI0YnlVZi95VHAzQTRIOHNtcWxs?=
 =?utf-8?B?bUVoaHFBZU15TWlCRXp2TEVWbEhncXBEQXpZRVk0Rko5VFgxaG9GT1p4ZTVE?=
 =?utf-8?B?dUcrOVU3elJOWVB2aS9rZEVUMmJjTDdNSmZNa1J5eC9OZ0k0bTAyYk1sVTFR?=
 =?utf-8?B?RHpVZlVnOXlDTjZZN2dLY3dldm1wOTNJUWlkQ3ErVm5NWWJUUnVzQVFuRnVO?=
 =?utf-8?Q?nndQVN3tOrA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7266.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SWJsSlRkV2EzdGl2ZEhQblpnU0k3UGlpQ0tGVGhtd1VvQnF6UzFqU3FxYndM?=
 =?utf-8?B?c0R4S3pzNklFTzczVzZJMWIxbE4zSjRZS3crRDBTMnVIc3VXZ0VXSUhDTnhu?=
 =?utf-8?B?SFhXek93ZlAxK0lpS0xZMU0zc3QwS2x3dHN3OWpqeng3eDIramdPMis1RVov?=
 =?utf-8?B?czVaQXh1ekh2Ly82WlJMcHZ5NVVoUXFtdDRvUU01c3R5RElPbmZQUFZXYUNN?=
 =?utf-8?B?dG5BdHZHdTFvWXRCS0taMFZ3cDdOM0lReE84eDVDVW1BVEZNWEg1bU5UWlFQ?=
 =?utf-8?B?SkFZZGtxUGlTbHAydVBUbzB0QmtyTWsxMDBVVUcweXcrZjNpTWVRQUUrSys3?=
 =?utf-8?B?WklUN3dyblBtUDJ0SVF3WU4rRWFkYldON0xiendjbnhjSzJqaWkxdTdHMWZt?=
 =?utf-8?B?bGVVU1A2cE1iTHB4blRZOEhnM1Nra0RGUUJBTjdKRTVXckV0WHhsajF3aCtl?=
 =?utf-8?B?cjNJN3crdkFrNGdncE9qNHBablBXVGRoaG96MXVVSmJRN094Wk5iTW1hdzZX?=
 =?utf-8?B?djNRekdMWUM5eHpxdlp0eUp4L0NjUElqQjlYZ2JGOUMvU2NrQUJKMk9Kc3R5?=
 =?utf-8?B?YXNZbi9tTFpEQ3lXMnVzdG9XeEc2SUNVNTRTQnR4MTQ3dENFenB5OTRWMVZ6?=
 =?utf-8?B?NWtyL0I4V2J2T1hEdTd3ZG5odmVoUTBqUCtZNlpwWnZHekRLbDRubUNoMmVX?=
 =?utf-8?B?Y3E1eHpBcVJNZFlKMm5lSEFubVlQTEZBRktNR05WbW1PUG5ncGEyZS9xeGdu?=
 =?utf-8?B?N3NZN1VPa2ZZWU9ENEY4dVc0ZjlRaWZtdFMyUCtYYzVIM3N4RWsyVEl6aG10?=
 =?utf-8?B?bm9uaEFob2hVb2ZqNHZsdmo0eHpuQkpmYjRJZE1Ob0E5RDJNeGZWRlFCKzB6?=
 =?utf-8?B?SnRhTEI1VTZKdTB6Y3F0V3JXZzM0MHhGM3RMb2lPRjc4ODRWcGpmRHpMT0lF?=
 =?utf-8?B?WlhXMGJGV0JxdUM0Q0RVWm9xemVVU1h5VFRLcVFYVWJqN2ppeG9ucElzR2ll?=
 =?utf-8?B?d0VVajhHeHBQWFIrT1BROUZPSm85ZGFMYVJvOEN4bkFndWMxTHhKcXNmMHoy?=
 =?utf-8?B?Sk5qUHRITTQ1ZStIdk1qeUNHTUxadjc1OHNjdDBJY25xSnBYUGt1bGR5NnEy?=
 =?utf-8?B?ankxSGpDc3ZyMEtaQldkeUZjVDllS1ZrWWpKdEh5cnA5UWdRc1IvOFNxTnZB?=
 =?utf-8?B?Y3J0QzZwelhDbTVYd0trS2R5L1VMVklYY2VWc0NjS2tGbUlSWk80ZW40WW9n?=
 =?utf-8?B?azFkbmhYeDY0NW8xNXNhb3FlUllpeG5CRWptKzRzMjEzWUZ5U3Njcmd5a011?=
 =?utf-8?B?cy8xUGZJZGlZdFQydmZMTGlIUHRQN1NRQU5peXFwSlRsc1lUYklvcU91SStH?=
 =?utf-8?B?LzZucWFPZVdmZTNCOGVtOEdyMlZ5ZjNIL24vWldXTjlhdEVxdzlYbWRjS3Fu?=
 =?utf-8?B?SytmL1JkNUhLOUlaaGU5WmVvRGxNbENhNTFkU3RSejZFd0xtNGxqbFFVREVu?=
 =?utf-8?B?NnZ4dkh1SGlUemtBYTlEU0I3VjZ5U2lyYm1xT0N0RjNrRnBiVmNsQ2ZtZFJv?=
 =?utf-8?B?QVpDUituMTJHWVlmanI3YjMxeE55ckNYMzRBSzdObCtpc1NySXB2YjAvdTk4?=
 =?utf-8?B?SGtYZlhoZXNxNVFxemM3UUpDSEYxTFVKdy9aOEF1STNIUnZsbENJaUdZQjMy?=
 =?utf-8?B?YmUweDNCWHptT2NzVUw2QWhzT1dqN01MczZidkhBUVhzdnhKeUgwcnptcUF0?=
 =?utf-8?B?b2xDZDZ5MUM3SU9oMlhIa01DaGNJSDE1Vk41bVU3LzhxRVRyTFdHVFhZUnVT?=
 =?utf-8?B?S1R2WDJKbE9VbHd6SmdZdlJZaHJIc0IyNzJRQlJtL1NYWmJMZHYxekd4MjVX?=
 =?utf-8?B?NEZWc2hORHZlc1F2VWxFSEp5eWZpNS82MzhPSUdyMWZITmUrdlkrMjBvK2tY?=
 =?utf-8?B?WmRUNHZuYlVoR2kzbklrUjl6WnB2RUUrcW5KRTRMZUpzMi95azJ4akNBZjVG?=
 =?utf-8?B?b2Fqd1cyWENvNHorRytuZ1ZsMWNGU0U2OHNiVUNXUGpGM0RLMGkwR1ExcTVS?=
 =?utf-8?B?Q3NhRlAwbXc3Z2Z4YVZBb21GbmdrVS9OdDg0bEd1QnB0b2xFUkdSdC9PdU02?=
 =?utf-8?Q?o0HIyB2fPTF9R5kPrsQaEL60c?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	g5OWG+5zLJUtW6J1r9sHTeFWbMMpCeMEECVpU4qZ3dxWTHJ614BVTbAD/5uLpwRCD1G1woAiR9vJpcpzMTqvKNDi9OtCGfpF9t6a9tEi1LkNcU29YuTlfYqM16lqw+wfCGHupiZLwsx8JIk2YergSbBAKOCXlFqEPGeiDcO6Nao69NlQmMVDlsl74vb9kjUscJ7eBx+/gc2P5lVoHtr5021olXA1FikwrE8ubbaYS+2GPL6X1bmAv8XrxGaQ4D/6QYWW+gksptlFTAVvpH2xN78nB+ps0av7qAxf3T01MZlADS8RQRl2jrAlqUsJYsjlzHROQoB9IAnlmm8nkXfrHrWiXDvWhqPQ3aK7rNZFGeCOmOteTTZ54ziE3EEItVn1/4Qy5pSPjpU0pQPmMuv23r+m4qDkdv0/9TEyhnTrXM5t+qmbRdcm5Wo4UxVVqBlKczOL57SiV65gAJ45he2tp//PE1w1G4tzdhGcV9bLluZ9Xtmxo0dMETkkja2V4HjhJJBHbao/ghloEOYNHdvmNmNqU1+MJAZNzeV+U/OSqEk8nzijQlEVmxkrod6/QrcVizqws592GloofyCiKB80iOsUnEGFeHTgtn51doA1u6k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf6a82b-928a-4ffd-852e-08dd7b7f4880
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7266.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:07:56.5899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT1HGRC7txGcBHkG7owtM4TF0rE/HFC4gpH0EtHD4vlfWZiMrZEpqZ7jRf7X8IY1DGwbGNOeuLx+xTN+bCHg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6620
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504140131
X-Proofpoint-ORIG-GUID: aUQI_9EbNIgMNTltKUvY6k2bb1YWve_z
X-Proofpoint-GUID: aUQI_9EbNIgMNTltKUvY6k2bb1YWve_z

On 4/14/25 05:18, Ma Ke wrote:
> Once of_device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> So fix this by calling put_device(), then the name can be freed in
> kobject_cleanup().

This seems ok but it's not clear why you delete "kfree(op)" here.

scan_one_device() allocates the memory for op via kzalloc, and in the 
case where of_device_register() fails, it sets op = NULL. This 
superficially looks like you *create* a memory leak here, since I don't 
see any other obvious reference to that kzalloc'd memory after 
scan_one_device() returns. Is the "op" pointer saved somewhere quietly 
by build_device_resources()?

I think you should still free the memory (that you allocated) after the 
call to put_device(), or explain why this is not necessary.


>
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: cf44bbc26cf1 ("[SPARC]: Beginnings of generic of_device framework.")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>   arch/sparc/kernel/of_device_64.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
> index f98c2901f335..4272746d7166 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device_64.c
> @@ -677,7 +677,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
>   
>   	if (of_device_register(op)) {
>   		printk("%pOF: Could not register of device.\n", dp);
> -		kfree(op);
> +		put_device(&op->dev);
>   		op = NULL;
>   	}
>   

