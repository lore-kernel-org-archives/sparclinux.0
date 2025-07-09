Received: from outbound.pv.icloud.com (p-west1-cluster4-host2-snip4-8.eps.apple.com [57.103.65.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ADB2D97A6
	for <sparclinux@vger.kernel.org>; Wed,  9 Jul 2025 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.65.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064907; cv=none; b=D66mDPe+X/f4dTb5YUszH53twlTvYoORABtffz6JqacrIrLK2EclvTkVQMlLfsHPzjCwG8h1jPN5DGQc8+b8QGvbVB3T6dC+kHTLMpvRWai9T+LWDPYxd/dVrmcAHlOuT50QvO1ieFnJURxPlgpBpWqusC5Fbu/FH/b/ry9CGok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064907; c=relaxed/simple;
	bh=xWafsv6bJuaPafW76QGMh0qz8KpQi/CDLT+Vmr22K/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eC0243LjCysXp0qWtW195ONSnDn63rXcFAd33Oh1Em0rUmg/097FNH4KthYs7RXuTGcMMgjLYM2WOU7B2SLdq2LAM0Wo6T4G1iXegwAmzYYJ+vkpUZlJp6bhKVIRMQJVxFfLKxtq6lb9J3rul48x2Rxfu2mXJPfEbUaJqm2TbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=jJ+H85y0; arc=none smtp.client-ip=57.103.65.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="jJ+H85y0"
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 8B39C1800143;
	Wed,  9 Jul 2025 12:41:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=LBOWO8iANCgLx5amvQTlXQQuaGc937Mkvu8CSCHNPNI=; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:x-icloud-hme; b=jJ+H85y0cjPlyakGHPA7JPgCRaVnoNdBi+oYumJh4NWHuxbo6acQAYbxu70Qm1nQeMxLv2AJPc32aNh50Nou/ZD5cjyUMSDipVb9o9gRrSkHrV3rdILIIM0ToBAAIR24+PXCRpRYRnrreqdsQymiAVryunI4VxWR51AQLLkh/C9rVbY4Yyf3vKmH0Ca+AVpIx/kYOyOuEQnPvBXs/zwez31G0CHhj0Gkx8D7KBwAG1Roy60XSa0oKRZ1m9gf4FiWpokKPQON+mymm+U2Zadpy24V7CKHow0VdKqK1yJ6eYQIkvM3/GWMtTzcVR02tIg3KJZSaopiCr5wCGccV38//w==
Received: from [192.168.1.26] (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 2D0C0180014F;
	Wed,  9 Jul 2025 12:41:40 +0000 (UTC)
Message-ID: <961b53a1-9c30-48ad-becf-81590b27464b@icloud.com>
Date: Wed, 9 Jul 2025 20:41:36 +0800
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] char: misc: Make registering miscdevice reentry
 who wants dynamic minor
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <20250704-rfc_miscdev-v4-0-b48986112d6a@oss.qualcomm.com>
 <20250704-rfc_miscdev-v4-5-b48986112d6a@oss.qualcomm.com>
 <2025070658-brought-shakable-935e@gregkh>
Content-Language: en-US
From: Zijun Hu <zijun_hu@icloud.com>
In-Reply-To: <2025070658-brought-shakable-935e@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: JFsevCZwb50uBaWwxcOL8P66jga6BhEh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExNCBTYWx0ZWRfXykNODX6DN1kZ
 QcEcd1mZ6SmkGWCzriSRxMkDnAm/fQ9TNg6LwRNdL7zxsMpMs3Vq1AahyVH8SV5lZX1iTn9M0VV
 WGLgU1hXPhwIeCcB/vnb9I/n+gn0Z1ZIc8opWoJj9mzdiE9A2nZKWzRiud2agca1IMfhTcGJvIP
 eWqOOnr31StCQaU3H4kFxMCNshM9jgRm2c3c9T3QWVGq4+qDpirRQfz9d9SUH/W7DnJgKpYHDuX
 UenB2CDPEsDSwF5u8jQ+b0jdKKeuWen6DJRry9h9E20Wqd7gEiOj5fIomAgc9yVv0A7jcOSJA=
X-Proofpoint-GUID: JFsevCZwb50uBaWwxcOL8P66jga6BhEh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2507090114

On 2025/7/6 16:55, Greg Kroah-Hartman wrote:
>> | Invalid fixed minor 257 for miscdevice 'miscdyn_a'
>> | #miscdev_test_dynamic_reentry: ASSERTION FAILED at misc_minor_kunit.c:639
>> | Expected ret == 0, but
>> | ret == -22 (0xffffffffffffffea)
>> | [FAILED] miscdev_test_dynamic_reentry
>>
>> misc_register()/misc_deregister() are sometimes invoked by driver's
>> probe()/remove() separately, which has reentry requirement.
> What do you mean?  Why is it required that this is reentrant?  What
> in-kernel drivers require this?
> 

miscdevice APIs are sometimes used by the following way, "drv_probe()->
drv_remove()->drv_probe()" is possible, so "misc_register()->
misc_deregister()->misc_register()" is possible and considered by
previous patch's test case, which needs to register misc_dev again
without any reinitialization, namely, reentry.

actually, several in-kernel codes have such usages.

static struct miscdevice misc_dev = {
	...
		.minor = MISC_DYNAMIC_MINOR,
	...
};

int drv_probe() {
...
    // static misc_dev is not initialized before registering.
	misc_register(&misc_dev);
...
}

void drv_remove() {
	...
	misc_deregister(&misc_dev);
	...
}

struct device_driver driver = {
	.probe = drv_probe,
	.remove = drv_remove,
};

>> Fix by resetting @misc->minor to MISC_DYNAMIC_MINOR in misc_deregister()
>> as error handling of misc_register() does.
>>
>> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
>> ---
>>  drivers/char/misc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
>> index b8e66466184fa21fb66d968db7950e0b5669ac43..96ed343cf5c8509a09855020049a9af82a3ede95 100644
>> --- a/drivers/char/misc.c
>> +++ b/drivers/char/misc.c
>> @@ -288,6 +288,8 @@ void misc_deregister(struct miscdevice *misc)
>>  	list_del(&misc->list);
>>  	device_destroy(&misc_class, MKDEV(MISC_MAJOR, misc->minor));
>>  	misc_minor_free(misc->minor);
>> +	if (misc->minor > MISC_DYNAMIC_MINOR)
>> +		misc->minor = MISC_DYNAMIC_MINOR;
>>  	mutex_unlock(&misc_mtx);
> misc is being unregistered here, so why are you changing the minor
> field?  It's now invalid as it is not registered, so this value should
> never be relied on at all, neither is anything else in this structure.

reset its minor code is to register it again without re-initialization
successfully

the other members are handed by misc_deregister() properly and don't
effect re-registering.



