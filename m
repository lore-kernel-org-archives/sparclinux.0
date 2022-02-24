Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0880BC433F5
	for <sparclinux@archiver.kernel.org>; Thu, 24 Feb 2022 07:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiBXHIM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 24 Feb 2022 02:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiBXHIJ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 24 Feb 2022 02:08:09 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B874129B9A;
        Wed, 23 Feb 2022 23:07:37 -0800 (PST)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MxUjv-1oBfXN0Tcn-00xqgA; Thu, 24 Feb 2022 08:07:36 +0100
Received: by mail-wr1-f42.google.com with SMTP id p9so1435973wra.12;
        Wed, 23 Feb 2022 23:07:35 -0800 (PST)
X-Gm-Message-State: AOAM532EpxCpwWjKfZVO60UsPuZ8Wv6zCAHCNVaTbsH4S6A6NhRzx/Oz
        TXaCCl9owcnbxk5pTojWFNHy8dt8v+HlZyDQblA=
X-Google-Smtp-Source: ABdhPJwEtLpX8E/vTN5J2WTCdVQZctqam7R0+5lnIigKmPPrPVDBdQ8fk8Xp/V3xYVy+7XSB18aLEhGa4luiP7dRyR0=
X-Received: by 2002:adf:a446:0:b0:1ed:c41b:cf13 with SMTP id
 e6-20020adfa446000000b001edc41bcf13mr1081355wra.407.1645686455629; Wed, 23
 Feb 2022 23:07:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
 <YhXmQwvjMFPQFPUr@infradead.org> <ddf6010e-417d-8da7-8e11-1b4a55f92fff@wanadoo.fr>
 <YhckzJp5/x9zW4uQ@infradead.org>
In-Reply-To: <YhckzJp5/x9zW4uQ@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 24 Feb 2022 08:07:19 +0100
X-Gmail-Original-Message-ID: <CAK8P3a23Pjm1Btc=mXX=vU4hkNiPqz3+o4=j0FuYKHB7KuMtPg@mail.gmail.com>
Message-ID: <CAK8P3a23Pjm1Btc=mXX=vU4hkNiPqz3+o4=j0FuYKHB7KuMtPg@mail.gmail.com>
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h" API
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        David Miller <davem@davemloft.net>,
        David Airlie <airlied@linux.ie>, Vinod Koul <vkoul@kernel.org>,
        hao.wu@intel.com, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Alex Bounine <alex.bou9@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        dmaengine@vger.kernel.org, linux-fpga@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:G+proiRNKst5hya+6hR+BYBd4VRS3n2DE6IeNAozttEzt7d4cvK
 f2mKBt5y9GjYdgZl32tJLtCozayM+b+0iu0mb+a1Jy2ATjYQYdM39CF3Ix2QNs8gajVrziT
 JrSs4NPIV+pYHoSzDtBDVmlKKYey23olqCofiIVZkhYIozH6Jh7hTUOh9MPFZiyiNMVlz3s
 QjJN+PIRYwIUNErT7Po/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:x/RKlK4Gtsw=:DxD5FQXChtJYZM29WJUTEv
 /u//N6l9VsNFpbUyxfyeSceaemR8+pxZMtp6+TZhAuN7yzzhYCbdQrsE3iLQNH2q7Eqv66dVL
 BIocWy1Xrz/TVzq1eQy1foxYfvNq51D4FyPAwrhlxQ7n1P1jjkKSaYuyO09HEbYUy64LQexxQ
 G6kuo17wTIzGcKwZ1LcST0Szo99VpmP4Zu6Q55JZxhn4N/5he+sKpmgOrBwAMWYH92bxQsRaj
 P2B1GkgAF1DcabAozbEMu+AtALAChe4hlSx0SqsnXXzKldWu1/2tZAXPrTjR9BSCdIvo7cYJD
 SVTGLD5sUwLqZT1yesvEqX/EioLCSjKxqUBxOz7SF5Z2/A/HV3Ut9oMS/sLe3FdEJxyC+SoHk
 sbttjyhRvVA6wF1MPxhCKqQB+KFAhVw4QxYgyCg44YdZxPiuZPY1XY0eHQCEb01xlIAEHPifI
 Pw2mBpdh3VO1+KRDlIbJHpHF+SozhScmElpTpFrqP7zxAjhWahQIYtDf03CWAtmM3GBc7DB6L
 4xCf6s2bb/VnWKR0HoK8hzxheK6BI131RGgy/uki5fPplK0mj333TDRagKYYObZ6jxhpeH3dM
 Hd73yt5NjKkxlkbhDTwPTNTB9c9EipTXuwmSQT/OkxnxmknsKbqgcP2ZHW5eKG+uXWz5xwUtC
 363VvATnqBr+TO/LiLRl/g9f8wKVgAk82UsmT2asW6JlfrVA8EAzq3vAyzfapD9MMWFpDXUCY
 WvX1Rhogy+fn+hvH0nGzqqzZ9PoXQgiBURJbnJbJdAnWCE7iYwr1C354AxzeUVI1opcG8TG/Y
 lRp7LlMz1Vx9HVXJFvgTNXNpPdjS7RYiu21OCZUzItky+MQb7k=
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Feb 24, 2022 at 7:25 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Feb 23, 2022 at 09:26:56PM +0100, Christophe JAILLET wrote:
> > Patch 01, 04, 05, 06, 08, 09 have not reached -next yet.
> > They all still apply cleanly.
> >
> > 04 has been picked it up for inclusion in the media subsystem for 5.18.
> > The other ones all have 1 or more Reviewed-by:/Acked-by: tags.
> >
> > Patch 16 must be resubmitted to add "#include <linux/dma-mapping.h>" in
> > order not to break builds.
>
> So how about this:  I'll pick up 1, 5,6,8 and 9 for the dma-mapping
> tree.  After -rc1 when presumably all other patches have reached
> mainline your resubmit one with the added include and we finish this
> off?

Sounds good to me as well.

       Arnd
