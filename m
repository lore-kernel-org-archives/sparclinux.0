Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E37EC8743
	for <sparclinux@archiver.kernel.org>; Thu,  7 Sep 2023 17:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242935AbjIGRUv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjIGRUo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 7 Sep 2023 13:20:44 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD3B2;
        Thu,  7 Sep 2023 10:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=tCMvBL3/HLEl/hDYIS/50Mz/xVJ11wiyoDOxpmEOOTE=; b=MHOsHcq7iCZBeagaOt/9p6KbOa
        YKkA2BhrzTW+y4ej51qW/gq5s6MlIb/FlZ+kKseG7M64ezsmXG07vO2+wn5ClfMeBo+ABYa/ErcfG
        L/SaJG2Bl+iD754JDs2ADc2YHDzpa/VX9XbQa6mKXT8j62o+NmP/kJ8OCoWf4fCI/FsM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:51382 helo=asus64.hugovil.com)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qeF6i-0004I6-Nr; Thu, 07 Sep 2023 09:31:42 -0400
Date:   Thu, 7 Sep 2023 09:31:40 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     "yiyang (D)" <yiyang13@huawei.com>
Cc:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <jag.raman@oracle.com>,
        <sparclinux@vger.kernel.org>, <linux-serial@vger.kernel.org>
Message-Id: <20230907093140.99e03b927705dabe6def7e00@hugovil.com>
In-Reply-To: <03cb09e9-5435-b464-b067-cf2c3f97660c@huawei.com>
References: <20230904035220.48164-1-yiyang13@huawei.com>
        <20230905101938.7cf68e477b946e1a066de17f@hugovil.com>
        <03cb09e9-5435-b464-b067-cf2c3f97660c@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH V2] tty: vcc: Add check for kstrdup() in vcc_probe()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, 7 Sep 2023 09:25:12 +0800
"yiyang (D)" <yiyang13@huawei.com> wrote:

> On 2023/9/5 22:19, Hugo Villeneuve wrote:
> > On Mon, 4 Sep 2023 11:52:20 +0800
> > Yi Yang <yiyang13@huawei.com> wrote:
> > 
> >> Add check for the return value of kstrdup() and return the error, if it
> >> fails in order to avoid NULL pointer dereference.
> >>
> >> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
> >> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> >> ---
> >> V2: Add goto target for error paths.
> >> ---
> >>   drivers/tty/vcc.c | 16 +++++++++++++---
> >>   1 file changed, 13 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> >> index a39ed981bfd3..5b625f20233b 100644
> >> --- a/drivers/tty/vcc.c
> >> +++ b/drivers/tty/vcc.c
> >> @@ -579,18 +579,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
> >>   		return -ENOMEM;
> >>   
> >>   	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
> >> +	if (!name) {
> >> +		rv = -ENOMEM;
> >> +		goto free_port;
> > 
> > Hi,
> > at this point, the port is not yet allocated, so you should not jump to
> > free_port. You should simply return with -ENOMEM.
> > 
> The port was already allocated by kzalloc(), and should be free before 
> return -ENOMEM.

You are right, dismiss all my comments.

Hugo.


> > 
> >> +	}
> >>   
> >>   	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
> >>   			     ARRAY_SIZE(vcc_versions), NULL, name);
> >>   	if (rv)
> >> -		goto free_port;
> >> +		goto free_name;
> >>   
> >>   	port->vio.debug = vcc_dbg_vio;
> >>   	vcc_ldc_cfg.debug = vcc_dbg_ldc;
> >>   
> >>   	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
> >>   	if (rv)
> >> -		goto free_port;
> >> +		goto free_name;
> > 
> > You should still jump to free_port, not free_name, after seeing my
> > comments below
> > 
> > 
> >>   
> >>   	spin_lock_init(&port->lock);
> >>   
> >> @@ -624,6 +628,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
> >>   		goto unreg_tty;
> >>   	}
> >>   	port->domain = kstrdup(domain, GFP_KERNEL);
> >> +	if (!port->domain) {
> >> +		rv = -ENOMEM;
> >> +		goto unreg_tty;
> >> +	}
> >> +
> >>   and should be free before return -ENOMEM.
> >>   	mdesc_release(hp);
> >>   
> >> @@ -653,8 +662,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
> >>   	vcc_table_remove(port->index);
> >>   free_ldc:
> >>   	vio_ldc_free(&port->vio);
> >> -free_port:
> >> +free_name:
> >>   	kfree(name);
> >> +free_port:
> >>   	kfree(port);
> > 
> > free_name should come after free_port...
> > 
> > Hugo.
> The release process should be in reverse order.
> 
> --
> Yi Yang
> > 
> > 
> >>   
> >>   	return rv;
> >> -- 
> >> 2.17.1
> >>
> > 
> > .
> > 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
