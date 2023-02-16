Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B3DC61DA4
	for <sparclinux@archiver.kernel.org>; Thu, 16 Feb 2023 15:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjBPPeq (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 16 Feb 2023 10:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjBPPep (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 16 Feb 2023 10:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955E79029
        for <sparclinux@vger.kernel.org>; Thu, 16 Feb 2023 07:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676561634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeQYQxyJSAMsBVRXT+gaV/xgFEd8Rxkvo3bIKZXtNYs=;
        b=jMrgnwswRCKobX4MLWGn8wBfJNLia5RiFL8T2JXhYs6+Q3YgHA4EDt/vs1hBJcKCBaQ2oV
        ZtIa8Q0IzxgYqTKjX3vHgCSsjrn1lNlUIMBOUzTVTfJNr7Om/W1TwbMFJPxHV6Hiu0BOht
        7Klttf6yT8EMqaBWpSwZoeiuxjOwcEU=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-577-SjXGEfCrMG-aMIJf3ccrkQ-1; Thu, 16 Feb 2023 10:33:53 -0500
X-MC-Unique: SjXGEfCrMG-aMIJf3ccrkQ-1
Received: by mail-il1-f197.google.com with SMTP id i17-20020a056e020ed100b003157534461aso1454268ilk.11
        for <sparclinux@vger.kernel.org>; Thu, 16 Feb 2023 07:33:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeQYQxyJSAMsBVRXT+gaV/xgFEd8Rxkvo3bIKZXtNYs=;
        b=l5j/1qleDAvBhlLT7JYtPqtwQZLE/UQ9HzmFp6M2jATh98sXjaAPCYkw0oXlb5uxoH
         /sthTBlDQ8XlFSzt6pCCnZYn8SjsIcP5D0DidaPJFuhZX+VjvtqtoY/ufHug3Cfg7fN1
         jKW4fJE0dLWtHSwBtLizaucR9KuPRsHC5F8tQV438ACOdIdo0r/AcQMCgd9QzBCuBbhn
         qLPb3b04j03sW/GRVc/A3HHms3gWjw56t0Nq3PipbbbA3FXZXp6rLwJDBtou78ZjhITC
         cOglpGZzI6faSo5RzjqMxrOxVs36L4U8LYlsUiCVGC/sBdU4Y9u8FYvh1/ZavLYlfLVh
         zLcA==
X-Gm-Message-State: AO0yUKUToWjaraxCrQbeAwA+tG6+JjPOaN7Vw9i/NVhuWPzlKj62C7Xl
        IfoqYY1HNMmpPgG7GFV4/ShpECfDWPTieyMp8HqRvOmz57s+CwdNkIZV4AWKYe8neOZYMil2qq7
        16uVuPzZBcd0iCgkDuqQaRw==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr3727049iox.0.1676561632908;
        Thu, 16 Feb 2023 07:33:52 -0800 (PST)
X-Google-Smtp-Source: AK7set+h4rAfOjfEETcRvGoeKLhBvNlkJkZqTyazjzNPwMYB/1qXXAYupXsUtXuE7aklEhW9g2jibA==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr3727038iox.0.1676561632677;
        Thu, 16 Feb 2023 07:33:52 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id w5-20020a6bd605000000b007407ea5d07csm559095ioa.51.2023.02.16.07.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 07:33:52 -0800 (PST)
Date:   Thu, 16 Feb 2023 10:33:50 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1
 (regression)
Message-ID: <Y+5M3qezT2t0wPx+@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
 <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
 <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info>
 <Y+z4XlhDzokAMTI1@x1n>
 <CADyTPEzcJxgFgQAwopsHz3b-e+hmHJqidpjzDhow8KkkAyyo8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADyTPEzcJxgFgQAwopsHz3b-e+hmHJqidpjzDhow8KkkAyyo8g@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Feb 16, 2023 at 12:32:54AM -0500, Nick Bowler wrote:
> On 2023-02-15, Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Feb 15, 2023 at 03:49:56PM +0100, Linux regression tracking
> > (Thorsten Leemhuis) wrote:
> >> On 31.01.23 02:46, Nick Bowler wrote:
> >> > I'll keep running this for a while to see if any other problems come
> >> > up.
> >>
> >> Nick, I assume no other problems showed up?
> >>
> >> In that case Peter could send the patch in for merging. Or did you do
> >> that already?
> >
> > Thanks for raising this again.  Nop, I'm just waiting for a final ack from
> > Nick to make sure that nothing went wrong after the longer run.
> 
> Oh, yes, it wasn't so much a "run" as just continuing to use the
> computer normally.
> 
> Everything seems stable enough.

Thanks Nick.

I've just posted a formal patch with you copied.  There's a slight tweak
due to rebasing to the latest akpm tree, but I still attached your
tested-by for appreciations on the help, and I assume it should have the
same functional change.

-- 
Peter Xu

