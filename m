Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4336AC6FD1D
	for <sparclinux@archiver.kernel.org>; Wed, 15 Mar 2023 06:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCOGdE (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 02:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjCOGdD (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Mar 2023 02:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32903864F
        for <sparclinux@vger.kernel.org>; Tue, 14 Mar 2023 23:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DACEA61AFA
        for <sparclinux@vger.kernel.org>; Wed, 15 Mar 2023 06:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CDCC433A0;
        Wed, 15 Mar 2023 06:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678861977;
        bh=6u1GSgm7FQ2Rl3sP+TNO/xnZhPJgFfIgxLt+RiNQWT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrALSBdYyQQZkZESqhZlgTIygpykWBe+bgMQSlhUiO1UQIkUv0bRKp1GYbIj7z9ft
         LiACRSMrzas+7SVJAwEtRMkG6UQzGryQGEZniWtGAa/SX/YAxPJPg45qyh/lLyNcBF
         yphGFyaJxxkQJ0hyi8dWMWFonL2QhRtotrulP76E=
Date:   Wed, 15 Mar 2023 07:32:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liang He <windhl@126.com>
Cc:     davem@davemloft.net, jirislaby@kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH] tty: vcc: add check for mdesc_grab()
Message-ID: <ZBFmlu/iKFPdUaPy@kroah.com>
References: <20230315061121.1741454-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315061121.1741454-1-windhl@126.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Mar 15, 2023 at 02:11:21PM +0800, Liang He wrote:
> In vcc_probe(), we should check the return value of
> mdesc_grab() as it may return NULL. While the
> vio_vdev_node() has the NULL-check, but if there
> is still a call to mdesc_release() which may cause
> a NPD bug.

Have you actually triggered this issue?  If so, how?

> Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  drivers/tty/vcc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
> index 34ba6e54789a..e3ba63d0a91f 100644
> --- a/drivers/tty/vcc.c
> +++ b/drivers/tty/vcc.c
> @@ -610,6 +610,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
>  
>  	hp = mdesc_grab();
>  
> +	if (!hp)
> +		return -ENODEV;

This change is obviously not correct and has not been tested, sorry.
Please do not make changes like this without properly validating them.

greg k-h
