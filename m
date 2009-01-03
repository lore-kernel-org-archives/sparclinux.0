From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 03:42:58 +0000
Subject: Re: [PATCH 1/7] sparc: unify ptrace.h
Message-Id: <20090102.194258.160018133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1230840190-31884-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1230840190-31884-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu,  1 Jan 2009 21:03:04 +0100

> The two ptrace.h implementations are very alike but
> the small differences required two set of ifdef/else/endif pairs.
> 
> The definition of reg_window32 could have been shared but
> that would have required several updates in sparc32 code as
> all printk formatting for example assume it is longs.
> 
> sparc_stackf looked like anohter candidate to share if the 32
> bit was renamed to sparc_stackf32.
> But it contains two pointers in the sparc32 version which would
> have been 64 bit in the sparc64 version so it was non-trivial.
> Using a set of accessor macros could do the trick if pursued later.
> 
> The sparc64 specific definitions are not protected by
> ifdef - as it should not be required to do so.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

I caught the fact that this is a fixed up version of patch
11 from the previous series.  So don't worry I correctly
used this patch instead of the previous one.

:-)
