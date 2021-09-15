Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFFAC433F5
	for <sparclinux@archiver.kernel.org>; Wed, 15 Sep 2021 08:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07207606A5
	for <sparclinux@archiver.kernel.org>; Wed, 15 Sep 2021 08:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhIOIkG convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Sep 2021 04:40:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:46739 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhIOIkG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Wed, 15 Sep 2021 04:40:06 -0400
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-25-BtDVJylqNPuRzblVZgdvbg-1; Wed, 15 Sep 2021 09:38:45 +0100
X-MC-Unique: BtDVJylqNPuRzblVZgdvbg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Wed, 15 Sep 2021 09:38:43 +0100
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.023; Wed, 15 Sep 2021 09:38:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Guenter Roeck' <linux@roeck-us.net>,
        "David S . Miller" <davem@davemloft.net>
CC:     "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Anatoly Pugachev <matorola@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: RE: [PATCH v2] sparc: mdesc: Fix compile error seen with gcc 11.x
Thread-Topic: [PATCH v2] sparc: mdesc: Fix compile error seen with gcc 11.x
Thread-Index: AQHXqbp2jIJmxUHHFEqoOal/hP7556ukwFqw
Date:   Wed, 15 Sep 2021 08:38:43 +0000
Message-ID: <d50a68b4c2c54b7b9440cbef7fcdc642@AcuMS.aculab.com>
References: <20210914224709.601156-1-linux@roeck-us.net>
In-Reply-To: <20210914224709.601156-1-linux@roeck-us.net>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Guenter Roeck
> Sent: 14 September 2021 23:47
...
> I am not sure if there was agreement to accept this patch or not, but
> I was asked to resend it with the above change, so here it is. An open
> question was if it is acceptable to have a structure named xxx_hdr
> include an element pointing to the data following that header.

It may be a pragmatic solution to the problem.
But it isn't 'correct'.
OTOH I think gcc is broken.
It ought to at least give a sane method of getting the warning
ignored in specific cases.

> If this patch is not acceptable, the patch in buildbot may be a possible
> alternative to consider.
>     https://git.busybox.net/buildroot/commit/?id=6e1106b4a9aee25d1556310d5cd1cb6dde2e6e3f
> 
>  arch/sparc/kernel/mdesc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 8e645ddac58e..83e1f699bc32 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -39,6 +39,7 @@ struct mdesc_hdr {
>  	u32	node_sz; /* node block size */
>  	u32	name_sz; /* name block size */
>  	u32	data_sz; /* data block size */
> +	char	data[];
>  } __attribute__((aligned(16)));
> 
>  struct mdesc_elem {
> @@ -612,7 +613,7 @@ EXPORT_SYMBOL(mdesc_get_node_info);
> 
>  static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
>  {
> -	return (struct mdesc_elem *) (mdesc + 1);
> +	return (struct mdesc_elem *) (mdesc->data);
>  }

In order for gcc to consider (mdesc + 1) to have size 0
I think it must have tracked the pointer from a structure
that has another field (or structure end) following 'mdesc'.
If that is the case then it should also know that the data[]
must also be size 0.
So the warning may reappear with the next gcc version.

The busybox patch has:
+@@ -75,6 +75,7 @@ struct mdesc_handle {
+ 	refcount_t		refcnt;
+ 	unsigned int		handle_size;
+ 	struct mdesc_hdr	mdesc;
++	char			data[];
+ };


Which really ought to be more than enough.
Although the extra space could be considered to even be
outside that structure.
But the gcc folks suggested a completely brain-dead change
that requires taking the offset from the outer structure.
--	return (struct mdesc_elem *) (mdesc + 1);
++	return (struct mdesc_elem *) hp + offsetof(struct mdesc_handle, data);
which is probably missing a (char *) cast.

I wonder if it might be better to 'launder' the pointer
so that gcc can't track its size.
It may be that:
	return (struct mdesc_elem *)(ulong)(mdesc + 1);
is enough.
Otherwise it will need to be passed into an asm block.

But gcc is getting stupid for system programming.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

