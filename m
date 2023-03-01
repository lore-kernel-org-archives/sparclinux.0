Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CD3C678D4
	for <sparclinux@archiver.kernel.org>; Wed,  1 Mar 2023 21:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCAV6C (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 1 Mar 2023 16:58:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCAV6B (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 1 Mar 2023 16:58:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1355FCA
        for <sparclinux@vger.kernel.org>; Wed,  1 Mar 2023 13:57:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1677707878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwlwUbudlcjxL0Exn7sQU50bfb3pl2pkeeoJelsAE5o=;
        b=qnk9Q665W6S983Q681cjDbewy6RS/7CFlX1qB2ZUyvlz+oPeUZo/DVVndcKxzIg4YMnnQ9
        eX52nEoM8zFT9ZQ36yN7syEUKViEQVr7uSvK+eF5bIHQehsYZoeS87vL2H+YOSllCBHfLu
        +hlJt421CFdYCazPemj0bTUL6rD7U8vIK5ZImBVjzWyfNyg1QcWXQjGN8J2TKeTys6dt+B
        xTZUz7wjFNtHOk5we9N7uNQ3u+KoCaxZem8bzipA22OM+mbODzoBe0ocTNBr1fy3egmZT4
        gqfZpycED0+m8ZBzQdKF9B4WKXHHKL/tHCMWYVExGsrnvfxKfjj5yaLQIm3g0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1677707878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TwlwUbudlcjxL0Exn7sQU50bfb3pl2pkeeoJelsAE5o=;
        b=nalCQKLpsDOv1Bg+5mGt7+sL06pxTmZfbFB4iHbrFGINkIXcxFZ3F0x2rzldZbKWtpxdUe
        El8F9s+WX3T0UKCA==
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        David Howells <dhowells@redhat.com>
Subject: Re: [ammarfaizi2-block:tglx/devel/rcuref 2/3]
 arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates
 bits from constant value (ffffffffe0000000 becomes 0)
In-Reply-To: <202303011547.O2cOhQQe-lkp@intel.com>
References: <202303011547.O2cOhQQe-lkp@intel.com>
Date:   Wed, 01 Mar 2023 22:57:57 +0100
Message-ID: <87k000kuca.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Mar 01 2023 at 15:48, kernel test robot wrote:
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303011547.O2cOhQQe-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>    lib/rcuref.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
>>> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0000000 becomes 0)

Cute. The constant value is 0xFFFF FFFF E000 0000. So how is that implicit down
cast causing it to become 0? Sparse is silly.

But that aside, the sparc64 cmpxchg() code is silly as well:

> vim +161 arch/sparc/include/asm/cmpxchg_64.h
>
> d550bbd40c0e10 David Howells 2012-03-28  155  
> d550bbd40c0e10 David Howells 2012-03-28  156  static inline unsigned long
> d550bbd40c0e10 David Howells 2012-03-28  157  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> d550bbd40c0e10 David Howells 2012-03-28  158  {
> d550bbd40c0e10 David Howells 2012-03-28  159  	switch (size) {
> a12ee2349312d7 Babu Moger    2017-05-24  160  		case 1:
> a12ee2349312d7 Babu Moger    2017-05-24 @161  			return __cmpxchg_u8(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  162  		case 4:
> d550bbd40c0e10 David Howells 2012-03-28  163  			return __cmpxchg_u32(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  164  		case 8:
> d550bbd40c0e10 David Howells 2012-03-28  165  			return __cmpxchg_u64(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  166  	}
> d550bbd40c0e10 David Howells 2012-03-28  167  	__cmpxchg_called_with_bad_pointer();
> d550bbd40c0e10 David Howells 2012-03-28  168  	return old;
> d550bbd40c0e10 David Howells 2012-03-28  169  }
> d550bbd40c0e10 David Howells 2012-03-28  170  

which gets invoked via:

#define arch_cmpxchg(ptr,o,n)						 \
  ({									 \
     __typeof__(*(ptr)) _o_ = (o);					 \
     __typeof__(*(ptr)) _n_ = (n);					 \
     (__typeof__(*(ptr))) __cmpxchg((ptr), (unsigned long)_o_,		 \
				    (unsigned long)_n_, sizeof(*(ptr))); \
  })

and then ends up in

static inline unsigned long __cmpxchg_u32(volatile int *m, int old, int new)

I'm sure a sparse build of sparc64 is full of those warnings. This just
happens to add one to the existing noise.

Oh well.

        tglx
