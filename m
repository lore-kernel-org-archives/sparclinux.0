Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB15EE14AA
	for <sparclinux@archiver.kernel.org>; Thu,  7 Sep 2023 01:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjIGBZU (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 21:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjIGBZU (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 6 Sep 2023 21:25:20 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA20172C;
        Wed,  6 Sep 2023 18:25:15 -0700 (PDT)
Received: from kwepemm600014.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rh1g50wJDzMlCC;
        Thu,  7 Sep 2023 09:21:53 +0800 (CST)
Received: from [10.67.110.164] (10.67.110.164) by
 kwepemm600014.china.huawei.com (7.193.23.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 09:25:13 +0800
Subject: Re: [PATCH V2] tty: vcc: Add check for kstrdup() in vcc_probe()
To:     Hugo Villeneuve <hugo@hugovil.com>
CC:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <jag.raman@oracle.com>,
        <sparclinux@vger.kernel.org>, <linux-serial@vger.kernel.org>
References: <20230904035220.48164-1-yiyang13@huawei.com>
 <20230905101938.7cf68e477b946e1a066de17f@hugovil.com>
From:   "yiyang (D)" <yiyang13@huawei.com>
Message-ID: <03cb09e9-5435-b464-b067-cf2c3f97660c@huawei.com>
Date:   Thu, 7 Sep 2023 09:25:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230905101938.7cf68e477b946e1a066de17f@hugovil.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.110.164]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 2023/9/5 22:19, Hugo Villeneuve wrote:
> On Mon, 4 Sep 2023 11:52:20 +0800
> Yi Yang <yiyang13@huawei.com> wrote:
> 
>> Add check for the return value of kstrdup() and return the error, if it
>> fails in order to avoid NULL pointer dereference.
>>
>> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
>> Signed-off-by: Yi Yang <yiyang13@huawei.com>
>> ---
>> V2: Add goto target for error paths.
>> ---
>>   drivers/tty/vcc.c | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
>> index a39ed981bfd3..5b625f20233b 100644
>> --- a/drivers/tty/vcc.c
>> +++ b/drivers/tty/vcc.c
>> @@ -579,18 +579,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>>   		return -ENOMEM;
>>   
>>   	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
>> +	if (!name) {
>> +		rv = -ENOMEM;
>> +		goto free_port;
> 
> Hi,
> at this point, the port is not yet allocated, so you should not jump to
> free_port. You should simply return with -ENOMEM.
> 
The port was already allocated by kzalloc(), and should be free before 
return -ENOMEM.
> 
>> +	}
>>   
>>   	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
>>   			     ARRAY_SIZE(vcc_versions), NULL, name);
>>   	if (rv)
>> -		goto free_port;
>> +		goto free_name;
>>   
>>   	port->vio.debug = vcc_dbg_vio;
>>   	vcc_ldc_cfg.debug = vcc_dbg_ldc;
>>   
>>   	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
>>   	if (rv)
>> -		goto free_port;
>> +		goto free_name;
> 
> You should still jump to free_port, not free_name, after seeing my
> comments below
> 
> 
>>   
>>   	spin_lock_init(&port->lock);
>>   
>> @@ -624,6 +628,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>>   		goto unreg_tty;
>>   	}
>>   	port->domain = kstrdup(domain, GFP_KERNEL);
>> +	if (!port->domain) {
>> +		rv = -ENOMEM;
>> +		goto unreg_tty;
>> +	}
>> +
>>   and should be free before return -ENOMEM.
>>   	mdesc_release(hp);
>>   
>> @@ -653,8 +662,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>>   	vcc_table_remove(port->index);
>>   free_ldc:
>>   	vio_ldc_free(&port->vio);
>> -free_port:
>> +free_name:
>>   	kfree(name);
>> +free_port:
>>   	kfree(port);
> 
> free_name should come after free_port...
> 
> Hugo.
The release process should be in reverse order.

--
Yi Yang
> 
> 
>>   
>>   	return rv;
>> -- 
>> 2.17.1
>>
> 
> .
> 
