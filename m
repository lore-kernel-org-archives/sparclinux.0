Received: from outbound.pv.icloud.com (p-west1-cluster6-host3-snip4-5.eps.apple.com [57.103.67.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01E11F948
	for <sparclinux@vger.kernel.org>; Wed,  9 Jul 2025 12:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065198; cv=none; b=izVJNk+UrcAvnaATnGvh0fthQNir6Qj6hv6XjOu9eboJfZKDnr6x6kSLNRnVruMtJka8lm6wpcDaeQOIDRgP1ab3X3vv0TLxLeRkEXeyW1RLbU60reJEsKyB+cq7ylg5ifjKj9nJyJuS5977gSyF4EfOkN56hF9S5CJTqFcgjsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065198; c=relaxed/simple;
	bh=4+xGT3Syl7A8thGXdvanzH2hDRg6EZ+Z5UuHv/Cd/hQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DwndYyYFdprMEojcQeubuSrEae2RseId08pimBybrLIcVWp31uvBddNfWK2hTQSQfgRN5KS5WEXzG02CTwQ4QExJy7SiLpS6uua7feTpGbtxkPuadZ4XYtFAIyqs7671Umm7VM3oyjmTcBY55v5N+bNv06NzIByKTNL4SAWbF0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=dfvTtYuz; arc=none smtp.client-ip=57.103.67.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="dfvTtYuz"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id AD5E7180052C;
	Wed,  9 Jul 2025 12:46:33 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=ZsQz9LKxuDXqFHNC93usmD6ksUfXLXjZxZG664JNhtw=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=dfvTtYuzrGnfWT+nNCQIVkVjV00euZzhSI/lmnqPE5Mbvyl9i1iroIwlCpAEzkXRbtqRtvem0TdJ6e1tqtfW6G9qeT87JqjPBxoXISxx1EwXHy29KoXom6DsuauGz4YFLV27nHXC0kopakv1KpyI67cgQKTv+VYVrvadQPkqkIXdfeLfS1Q/0/oWMDAQ/97ClBnJoX+FckRn3E9VZA0cCf9u7KX7oVS1OjxREiSU+8VJojhB2ObX2C+uiiTTG2croyKCKm5T6gp1VE4Z4rmtu7mM9CyFPlNWbIEb8GO7eme0dlfBIJmTsNkqe00lYU+m2MFBTPvE6950bs6tnmTf2A==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 1860E18002E2;
	Wed,  9 Jul 2025 12:46:29 +0000 (UTC)
Message-ID: <dabb7247-1b76-407f-b22f-c1ebd9ab9dd5@icloud.com>
Date: Wed, 9 Jul 2025 20:46:26 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] char: misc: Does not request module for miscdevice
 with dynamic minor
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-6-b48986112d6a@oss.qualcomm.com>
 <2025070625-voice-stuffing-e2fa@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025070625-voice-stuffing-e2fa@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExNCBTYWx0ZWRfX0zpO44pEjlU7
 NhY0P5UmCq2PDtNsnGXXOQy5TfD4oWukksNfVSj/Pjm/4ZvIahwyZRCmaqU0J+3MzsVeFz9XiXA
 IjPzLTui4NLLQxOS73TKxUk/eMP7gIWa5zsE1SJoeLWcm17GNApm2lJZb9O4bHg/e4OOrrV8qpf
 o9Fg52JAA82W1LNnVErxuH9lmkDgAmC3SUP1cJdB3+NCLpzQeyB/0mlT/SdD3YhH2N3Yn2mvxs6
 Frz3wJRoXC5uBh2k7mgkZ9bFHw3co9Mow7b5+c3wdJhXyPKQJEyTiNUzatoeaA+ortzNVvWSw=
X-Proofpoint-GUID: 3COIk4PnPhDUNc41H6Qlada9qshWAFqe
X-Proofpoint-ORIG-GUID: 3COIk4PnPhDUNc41H6Qlada9qshWAFqe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=745 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506060001 definitions=main-2507090114

On 2025/7/6 16:55, Greg Kroah-Hartman wrote:
>> -		if (!new_fops)
>> -			goto fail;
>>  	}
>>  
>> +	if (!new_fops)
>> +		goto fail;
>> +
> This is fine, but is it going to break any existing users that happened
> to rely on this behaviour?

no since there are no kernel users who register miscdevice with minor > 255.

