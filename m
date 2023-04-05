Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F7C77B6C
	for <sparclinux@archiver.kernel.org>; Wed,  5 Apr 2023 16:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjDEQHg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 5 Apr 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDEQHf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 5 Apr 2023 12:07:35 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E395278
        for <sparclinux@vger.kernel.org>; Wed,  5 Apr 2023 09:07:32 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5005c57f95cso76627a12.1
        for <sparclinux@vger.kernel.org>; Wed, 05 Apr 2023 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1680710851; x=1683302851;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ir3s/Lf5lvCAlrm1TfcesrDtB2jAmtZCISN/6dp3hBc=;
        b=VNUObGKko6sqyyipxJHZOjjD7Vgl2nINPanPLg9CF5dNFM42M+zPkinw5lJovFp5IT
         KgryiwfHZwGoUCHvFhE9cgxsLTI65w6qpIN9bd0/wPOfFcL5qWWLKMUORCChrg/EDytj
         /mEZ5jrCc5FzC1si2MslaSmste3VoXKbRjv7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680710851; x=1683302851;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ir3s/Lf5lvCAlrm1TfcesrDtB2jAmtZCISN/6dp3hBc=;
        b=LSZkN5sLafBCptfJCBopXDkYuVzdcZC3yRX8iAA5fyO/p03nbYRoPNPM4n0ufJWMY4
         9kaUKMDsSmIvHK6TVbjEMkwmPHixuXgHt6bV/u2hCKvBJjK6HaiU0AOy7CKgw1kPn2JL
         2sBAGq3aRjq7xhrfy8LOct17kVNXqFqFP9PmEfqCVToUgh63JHvTotVvpah1h1EGCHBy
         zEQjNYz58JZVqG8fG+oLj7Rszz1ZAXcR4XsYIc+nWFU5ZN+6s1qe/Mqx403kgH7mW9Ao
         RBiUyVm8i4phtPKYlXQCYFm307/Qf6Gnnq+1VzxDO1lSG40TZgfPEER9sl70GHCh9OAN
         uSMg==
X-Gm-Message-State: AAQBX9fvnWTQxXpB46giaQWt+fw6pIxi6fvtKFY+7Qa/kTpIz6ym4/0x
        6h2/XgL8GHbvjfb/dqWyx0jKXw==
X-Google-Smtp-Source: AKy350aQMCCIGd+ttlIn6lmvnbNQhhwBJ1Oi0jxEBwn9z6WIX2aUYNMX4MoVCA82q+F4FspzQF+uZA==
X-Received: by 2002:a17:906:10c9:b0:931:4285:ea16 with SMTP id v9-20020a17090610c900b009314285ea16mr2360239ejv.7.1680710851411;
        Wed, 05 Apr 2023 09:07:31 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id a23-20020a170906369700b0092a59ee224csm7492153ejc.185.2023.04.05.09.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:07:31 -0700 (PDT)
Date:   Wed, 5 Apr 2023 18:07:28 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 01/18] fbdev: Prepare generic architecture helpers
Message-ID: <ZC2cwIJJlyDWge+B@phenom.ffwll.local>
Mail-Followup-To: Arnd Bergmann <arnd@arndb.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org
References: <20230405150554.30540-1-tzimmermann@suse.de>
 <20230405150554.30540-2-tzimmermann@suse.de>
 <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92fe3838-41f0-4e27-8467-161553ff724f@app.fastmail.com>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Apr 05, 2023 at 05:53:03PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 5, 2023, at 17:05, Thomas Zimmermann wrote:
> > Generic implementations of fb_pgprotect() and fb_is_primary_device()
> > have been in the source code for a long time. Prepare the header file
> > to make use of them.
> >
> > Improve the code by using an inline function for fb_pgprotect() and
> > by removing include statements.
> >
> > Symbols are protected by preprocessor guards. Architectures that
> > provide a symbol need to define a preprocessor token of the same
> > name and value. Otherwise the header file will provide a generic
> > implementation. This pattern has been taken from <asm/io.h>.
> >
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Moving this into generic code is good, but I'm not sure
> about the default for fb_pgprotect():
> 
> > +
> > +#ifndef fb_pgprotect
> > +#define fb_pgprotect fb_pgprotect
> > +static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
> > +				unsigned long off)
> > +{ }
> > +#endif
> 
> I think most architectures will want the version we have on
> arc, arm, arm64, loongarch, and sh already:
> 
> static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
>                                 unsigned long off)
> {
>        vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
> }
> 
> so I'd suggest making that version the default, and treating the
> empty ones (m68knommu, sparc32) as architecture specific
> workarounds.

Yeah I was about to type the same suggestion :-)
-Daniel

 
> I see that sparc64 and parisc use pgprot_uncached here, but as
> they don't define a custom pgprot_writecombine, this ends up being
> the same, and they can use the above definition as well.
> 
> mips defines pgprot_writecombine but uses pgprot_noncached
> in fb_pgprotect(), which is probably a mistake and should have
> been updated as part of commit 4b050ba7a66c ("MIPS: pgtable.h:
> Implement the pgprot_writecombine function for MIPS").
> 
>     Arnd

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
