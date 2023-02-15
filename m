Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02082C636D4
	for <sparclinux@archiver.kernel.org>; Wed, 15 Feb 2023 15:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjBOPVz (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBOPVy (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Feb 2023 10:21:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93860E06A
        for <sparclinux@vger.kernel.org>; Wed, 15 Feb 2023 07:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676474466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rfv7Rycn+rNU8ZwT5IAQ8tPoQPJy80nVLPsdVlq6m/k=;
        b=DyVh59UELM43/PHiETsDzP99SIVS3Y8cZ6L5YP1VtkKQW6JBI/jGvoCUIeQuShwCc6Jd3s
        l/kTg7I17Yn6RtbOoiVTDE9VLFZcEih1wmIQdB9TiwnoqHF+m0oUM/mLcvYFHUDHbdRdy8
        F1A7yeeZyl4mym+7++yvXbgVaNhOtKc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-347-1JD-OC8IP5ab5xTujp1U8A-1; Wed, 15 Feb 2023 10:21:05 -0500
X-MC-Unique: 1JD-OC8IP5ab5xTujp1U8A-1
Received: by mail-qv1-f70.google.com with SMTP id ob12-20020a0562142f8c00b004c6c72bf1d0so10644515qvb.9
        for <sparclinux@vger.kernel.org>; Wed, 15 Feb 2023 07:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfv7Rycn+rNU8ZwT5IAQ8tPoQPJy80nVLPsdVlq6m/k=;
        b=UQL6Bm4K1cj/5Z77gdiL/54cTIqdWwqIZrCH8FDQaQsWPnyRbXvL5/aG3+1mkHNGvr
         kHS+EoKRbNRrxk1YkYHPvXO0Gojgxp4t5OqN7uNbNDJkaHNK9yi76SP/HkgvpEROHL7q
         uLmK4w0OlsvNt6VnI/KtYKhcxFV7XxfHdZzqpMKa53zFj2lbGUZOnPyOHsTjeT9PuUEY
         bw1kxl15IdOcWiPNWcOgkKiRWF1gqz+PPo6UeOn2NL3jB2/x4KSAfsg+q7acZgGVgRau
         eNIpNavrE61yZsZiDRzhoeoFBHb8vckbuLvxykib7e9kuwETuhm+cIUAy/8AP3N9V2RS
         XsEg==
X-Gm-Message-State: AO0yUKWJDFyJX8PTqxu1cKPXfbkMhrLDinBqlbKkdHX+yDcbXGtGEOAi
        lhnGbGxyQZhi3vZuC33j0pO4pSDXzdziRgGyAxRL5wmyjoKKvRt9IQq9rbyavQGbWX8oquVQuLo
        kso3H/j0dBvrfgZdTJLpzVNUHhic=
X-Received: by 2002:ac8:5f4e:0:b0:3b8:695b:aad1 with SMTP id y14-20020ac85f4e000000b003b8695baad1mr4805419qta.1.1676474464234;
        Wed, 15 Feb 2023 07:21:04 -0800 (PST)
X-Google-Smtp-Source: AK7set/bUBwJRT9nplisX7cCmXea98zUuaNhVa0ZTJCA74agqwEPC+rEotKS3qcPHLZRGk14AYlnHQ==
X-Received: by 2002:ac8:5f4e:0:b0:3b8:695b:aad1 with SMTP id y14-20020ac85f4e000000b003b8695baad1mr4805379qta.1.1676474463947;
        Wed, 15 Feb 2023 07:21:03 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id d22-20020ac86696000000b003b9a4a497a1sm13111453qtp.86.2023.02.15.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:21:03 -0800 (PST)
Date:   Wed, 15 Feb 2023 10:21:02 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: PROBLEM: sparc64 random crashes starting w/ Linux 6.1
 (regression)
Message-ID: <Y+z4XlhDzokAMTI1@x1n>
References: <CADyTPExpEqaJiMGoV+Z6xVgL50ZoMJg49B10LcZ=8eg19u34BA@mail.gmail.com>
 <Y9bvwz4FIOQ+D8c4@x1n>
 <CADyTPEzsvdRC15+Z5T3oryofwRYqHmHzwqRmJKJoHB3d7Tdayw@mail.gmail.com>
 <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91b38494-f296-d01d-3b98-6bc51406cad0@leemhuis.info>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Feb 15, 2023 at 03:49:56PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 31.01.23 02:46, Nick Bowler wrote:
> > On 2023-01-29, Peter Xu <peterx@redhat.com> wrote:
> >> On Sat, Jan 28, 2023 at 09:17:31PM -0500, Nick Bowler wrote:
> >>> Starting with Linux 6.1.y, my sparc64 (Sun Ultra 60) system is very
> >>> unstable, with userspace processes randomly crashing with all kinds of
> >>> different weird errors.  The same problem occurs on 6.2-rc5.  Linux
> >>> 6.0.y is OK.
> > [...]
> >> Could you try below patch to see whether it fixes your problem?  It should
> >> cover the last piece of possible issue with dirty bit on sparc after that
> >> patchset.  It's based on latest master branch (commit ab072681eabe1ce0).
> > 
> > Haven't seen any failures yet, so it seems this patch on top of 6.2-rc6
> > makes things much better.
> > 
> > I'll keep running this for a while to see if any other problems come up.
> 
> Nick, I assume no other problems showed up?
> 
> In that case Peter could send the patch in for merging. Or did you do
> that already?

Thanks for raising this again.  Nop, I'm just waiting for a final ack from
Nick to make sure that nothing went wrong after the longer run.

-- 
Peter Xu

