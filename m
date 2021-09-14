Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADADC433F5
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23029610FB
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 12:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhINMGG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 08:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhINMEb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 08:04:31 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F33C061574;
        Tue, 14 Sep 2021 05:03:14 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c206so27576232ybb.12;
        Tue, 14 Sep 2021 05:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pMuzqmLn8R49faYvkNEUgKWF6kt1oCNrbXKOw1AJ9/g=;
        b=DsEtZ1gvFmXGkGEiFUBeat38tAyUQbLjHQG4pLWSFt4W5aD6/4my4JQwwdQ78/VMRq
         IteK/4ej6cPcHmeTqYEs3SsJFPijWLn9nXkUQtfRwqnxSTFAaJIIUUC3BEoL2h/IAhxK
         LRUTDC/EEXseM9a3uEC9QjOCnAyyrWovRAVkXNTL6P+ho8k9Biq6JEnxJ+z6gG8Y7tOm
         rl7tjVC5Y1XnSWuSsJTToAKGLHupore67DgKm628AbFLFSfm7SG/zFcRXO2N8UBAjR43
         JBIwIJzwspQme1FN5F9mH0IvxTp0wT2sdcl1B/n/ns276RN+W9/1GYm4jXh7O/herInH
         Ulpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pMuzqmLn8R49faYvkNEUgKWF6kt1oCNrbXKOw1AJ9/g=;
        b=F4eHnIJH9IEbvY0n19uFCrbb5oQZjGI03ThHo41E+rFrc54ea2c4C1FL6kn5t4yJ1/
         VsIMibkZtq+Sxbqc4VDz6f1YSbow9vJmbUw3ImxgYtyyZSChZdR2va+HOJNDiu8RWp++
         4VRRyw5wMa78unDu/eocXSVnwViFgsyHweLEFe1eJw8Aj0txzXJSEcEZWCntuxxKAaui
         RBetB+V71iAaYPDUuEDc4XpajrkdhJKMBxddF3ERQUlCOKfmr2QVLzQ4tPVkF9rKjadl
         EtAmO4aGB8h7meQgbkhuGLf+y9+txQzhsQvPtxkkEUgqrGJsXQcCY5jMJ6FQKE1zB0jO
         rleQ==
X-Gm-Message-State: AOAM531Yj1efgYZNktzDxUZYlikeUyVX5RgJZdoe+fe6BsIJcjfK4Pzo
        ws4LNR2/cAAIJBDtHjP8z64J27SH9KRtUE7nH/c=
X-Google-Smtp-Source: ABdhPJx3Xv+ZrAwReMnF+D+nYEmGsxevtbsIcDUCvtkX3v5AmCaUQqzaGf1EAFlMzJ9aveoWhQG6Yfuw/sg+1sJSESg=
X-Received: by 2002:a05:6902:1505:: with SMTP id q5mr11829563ybu.244.1631620990398;
 Tue, 14 Sep 2021 05:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210913163712.922188-1-linux@roeck-us.net> <YT+SPIAl0IdWOAn/@ravnborg.org>
 <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
In-Reply-To: <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 14 Sep 2021 15:02:59 +0300
Message-ID: <CADxRZqwU6URhCpsUifon+B1QYHepx6gjExAFfK6SeXyu4JpF4w@mail.gmail.com>
Subject: Re: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
To:     Guenter Roeck <linux@roeck-us.net>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 14, 2021 at 3:54 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 9/13/21 11:02 AM, Sam Ravnborg wrote:
> > Hi Guenter,
> >
> > On Mon, Sep 13, 2021 at 09:37:12AM -0700, Guenter Roeck wrote:
> >> sparc64 images fail to compile with gcc 11.x, reporting the following
> >> errors.
> >>
> >> arch/sparc/kernel/mdesc.c:647:22: error:
> >>      'strcmp' reading 1 or more bytes from a region of size 0
> >> arch/sparc/kernel/mdesc.c:692:22: error:
> >>      'strcmp' reading 1 or more bytes from a region of size 0
> >> arch/sparc/kernel/mdesc.c:719:21:
> >>      error: 'strcmp' reading 1 or more bytes from a region of size 0
> >>
> >> The underlying problem is that node_block() returns a pointer beyond
> >> the end of struct mdesc_hdr. gcc 11.x detects that and reports the error.
> >> Adding an additional zero-length field to struct mdesc_hdr and pointing
> >> to that field fixes the problem.
> >>
> >> Cc: Arnd Bergmann <arnd@kernel.org>
> >> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> ---
> >> My apologies if a similar patch was submitted already; I was unable to find it.
> >> I did find the following patch:
> >>      https://git.busybox.net/buildroot/commit/?id=6e1106b4a9aee25d1556310d5cd1cb6dde2e6e3f
> >> but I failed to find it in patchwork or on lore.kernel.org, and it
> >> seems to be more expensive than the solution suggested here.
> >>
> >>   arch/sparc/kernel/mdesc.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> >> index 8e645ddac58e..c67bdcc23727 100644
> >> --- a/arch/sparc/kernel/mdesc.c
> >> +++ b/arch/sparc/kernel/mdesc.c
> >> @@ -39,6 +39,7 @@ struct mdesc_hdr {
> >>      u32     node_sz; /* node block size */
> >>      u32     name_sz; /* name block size */
> >>      u32     data_sz; /* data block size */
> >> +    char    data[0];
> >>   } __attribute__((aligned(16)));
> >
> > I do not think this will works.
> > See following comment:
> >   * mdesc_hdr and mdesc_elem describe the layout of the data structure
> >   * we get from the Hypervisor.
> >
> > With the above change you increased the size from 16 to 32 bytes,
> > and any code using sizeof(struct mdesc_hdr) will now point too far in
> > memory for the second and subsequent entries.
> >
> > I did not take any closer look, but this was from a quick analysis.
> >
>
> Sorry, I didn't realize that a field of size 0 increases the structure size
> on sparc. I had checked the size of the old and the new structure with gcc
> on x86_64 and didn't see a field size increase.
>
> Guenter
>
> ---
> Test code I had used:
>
> #include <stddef.h>
> #include <stdio.h>
>
> typedef unsigned int u32;
>
> struct mdesc_hdr {
>          u32     version; /* Transport version */
>          u32     node_sz; /* node block size */
>          u32     name_sz; /* name block size */
>          u32     data_sz; /* data block size */
> } __attribute__((aligned(16)));
>
> struct mdesc_hdr2 {
>          u32     version; /* Transport version */
>          u32     node_sz; /* node block size */
>          u32     name_sz; /* name block size */
>          u32     data_sz; /* data block size */
>          char    data[0];
> } __attribute__((aligned(16)));
>
> int main()
> {
>         printf("%ld %ld\n", sizeof(struct mdesc_hdr), sizeof(struct mdesc_hdr2));
>
>         return 0;
> }

used the code above on my sparc64 installation:

copy-paste code to 123.c file

$ gcc-11 123.c
$ ./a.out
16 16
$ uname -a
Linux ttip 5.15.0-rc1 #273 SMP Mon Sep 13 12:47:14 MSK 2021 sparc64 GNU/Linux
