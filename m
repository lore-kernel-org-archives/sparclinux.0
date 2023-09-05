Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47CCA0FE2
	for <sparclinux@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbjIEQVq (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354781AbjIEOUB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 5 Sep 2023 10:20:01 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C468197;
        Tue,  5 Sep 2023 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
        :Date:subject:date:message-id:reply-to;
        bh=tXlyPfpn4kN+DQURxdfJQDcnAt2vpqV+AwaY6wnwJEA=; b=Ug9IKVCSbpqEU2aPbdoNFLVXZ+
        4o/kN99/Msj21mLQlGdi2Fl+C3jSpNYiqu54FcADH9Vw+lCaIpHBXrF7De8jIKWy3LVteBjNeW3qF
        ONgU0j5zAYd0AxDSdhcDkAwxaikMbBbXsMZiGS3JhImZOxo9+xdcQ1X1p1EpVERdHuk4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:43660 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1qdWu3-0000tG-91; Tue, 05 Sep 2023 10:19:39 -0400
Date:   Tue, 5 Sep 2023 10:19:38 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Yi Yang <yiyang13@huawei.com>
Cc:     <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <jirislaby@kernel.org>, <jag.raman@oracle.com>,
        <sparclinux@vger.kernel.org>, <linux-serial@vger.kernel.org>
Message-Id: <20230905101938.7cf68e477b946e1a066de17f@hugovil.com>
In-Reply-To: <20230904035220.48164-1-yiyang13@huawei.com>
References: <20230904035220.48164-1-yiyang13@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH V2] tty: vcc: Add check for kstrdup() in vcc_probe()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, 4 Sep 2023 11:52:20 +0800
Yi Yang <yiyang13@huawei.com> wrote:

> Add check for the return value of kstrdup() and return the error, if it
> fails in order to avoid NULL pointer dereference.
> 
> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
> Signed-off-by: Yi Yang <yiyang13@huawei.com>
> ---
> V2: Add goto target for error paths.
> ---
>  drivers/tty/vcc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index a39ed981bfd3..5b625f20233b 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -579,18 +579,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  		return -ENOMEM;
>  
>  	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
> +	if (!name) {
> +		rv = -ENOMEM;
> +		goto free_port;

Hi,
at this point, the port is not yet allocated, so you should not jump to
free_port. You should simply return with -ENOMEM.


> +	}
>  
>  	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
>  			     ARRAY_SIZE(vcc_versions), NULL, name);
>  	if (rv)
> -		goto free_port;
> +		goto free_name;
>  
>  	port->vio.debug = vcc_dbg_vio;
>  	vcc_ldc_cfg.debug = vcc_dbg_ldc;
>  
>  	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
>  	if (rv)
> -		goto free_port;
> +		goto free_name;

You should still jump to free_port, not free_name, after seeing my
comments below


>  
>  	spin_lock_init(&port->lock);
>  
> @@ -624,6 +628,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  		goto unreg_tty;
>  	}
>  	port->domain = kstrdup(domain, GFP_KERNEL);
> +	if (!port->domain) {
> +		rv = -ENOMEM;
> +		goto unreg_tty;
> +	}
> +
>  
>  	mdesc_release(hp);
>  
> @@ -653,8 +662,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  	vcc_table_remove(port->index);
>  free_ldc:
>  	vio_ldc_free(&port->vio);
> -free_port:
> +free_name:
>  	kfree(name);
> +free_port:
>  	kfree(port);

free_name should come after free_port...

Hugo.


>  
>  	return rv;
> -- 
> 2.17.1
> 
