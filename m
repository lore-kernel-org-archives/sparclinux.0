From: David Miller <davem@davemloft.net>
Date: Fri, 04 Aug 2017 16:48:38 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170804.094838.2078149548154257211.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <22915.33137.173101.458489@gargle.gargle.HOWL>
        <20170803.145748.1255019771865320896.davem@davemloft.net>
        <22916.10769.43405.588851@gargle.gargle.HOWL>
In-Reply-To: <22916.10769.43405.588851@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpelinux@gmail.com
Cc: sam@ravnborg.org, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Fri, 4 Aug 2017 10:02:25 +0200

> David Miller writes:
>  > From: Mikael Pettersson <mikpelinux@gmail.com>
>  > Date: Thu, 3 Aug 2017 22:02:57 +0200
>  > 
>  > > With that in place the kernel booted fine.
>  > > When I then ran the `poll' strace test binary, the OOPS was replaced by:
>  > > 
>  > > [  140.589913] _copy_from_user(fff000123c8dfa7c,           (null), 240) res 240
>  > > [  140.753162] _copy_from_user(fff000123c8dfa7c, 00000000f7e4a000, 8) res 8
>  > > [  140.824155] _copy_from_user(fff000123c8dfa7c, 00000000f7e49ff8, 16) res 18442240552407530112
>  > > 
>  > > That last `res' doesn't look good.
>  > 
>  > Please test this patch:
>  > 
>  > diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
>  > index 54f9870..5a8cb37 100644
>  > --- a/arch/sparc/lib/U3memcpy.S
>  > +++ b/arch/sparc/lib/U3memcpy.S
>  > @@ -145,13 +145,13 @@ ENDPROC(U3_retl_o2_plus_GS_plus_0x08)
>  >  ENTRY(U3_retl_o2_and_7_plus_GS)
>  >  	and	%o2, 7, %o2
>  >  	retl
>  > -	 add	%o2, GLOBAL_SPARE, %o2
>  > +	 add	%o2, GLOBAL_SPARE, %o0
>  >  ENDPROC(U3_retl_o2_and_7_plus_GS)
>  >  ENTRY(U3_retl_o2_and_7_plus_GS_plus_8)
>  >  	add	GLOBAL_SPARE, 8, GLOBAL_SPARE
>  >  	and	%o2, 7, %o2
>  >  	retl
>  > -	 add	%o2, GLOBAL_SPARE, %o2
>  > +	 add	%o2, GLOBAL_SPARE, %o0
>  >  ENDPROC(U3_retl_o2_and_7_plus_GS_plus_8)
>  >  #endif
>  >  
> 
> Backing out my debugging patch and adding this one instead
> gave me a working kernel that doesn't OOPS.  Thanks.
> 
> Tested-by: Mikael Pettersson <mikpelinux@gmail.com>

Great, thanks for testing.

This is the final patch I committed:

==========
From 0ede1c401332173ab0693121dc6cde04a4dbf131 Mon Sep 17 00:00:00 2001
From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 4 Aug 2017 09:47:52 -0700
Subject: [PATCH] sparc64: Fix exception handling in UltraSPARC-III memcpy.

Mikael Pettersson reported that some test programs in the strace-4.18
testsuite cause an OOPS.

After some debugging it turns out that garbage values are returned
when an exception occurs, causing the fixup memset() to be run with
bogus arguments.

The problem is that two of the exception handler stubs write the
successfully copied length into the wrong register.

Fixes: ee841d0aff64 ("sparc64: Convert U3copy_{from,to}_user to accurate exception reporting.")
Reported-by: Mikael Pettersson <mikpelinux@gmail.com>
Tested-by: Mikael Pettersson <mikpelinux@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/lib/U3memcpy.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 54f98706b03b..5a8cb37f0a3b 100644
--- a/arch/sparc/lib/U3memcpy.S
+++ b/arch/sparc/lib/U3memcpy.S
@@ -145,13 +145,13 @@ ENDPROC(U3_retl_o2_plus_GS_plus_0x08)
 ENTRY(U3_retl_o2_and_7_plus_GS)
 	and	%o2, 7, %o2
 	retl
-	 add	%o2, GLOBAL_SPARE, %o2
+	 add	%o2, GLOBAL_SPARE, %o0
 ENDPROC(U3_retl_o2_and_7_plus_GS)
 ENTRY(U3_retl_o2_and_7_plus_GS_plus_8)
 	add	GLOBAL_SPARE, 8, GLOBAL_SPARE
 	and	%o2, 7, %o2
 	retl
-	 add	%o2, GLOBAL_SPARE, %o2
+	 add	%o2, GLOBAL_SPARE, %o0
 ENDPROC(U3_retl_o2_and_7_plus_GS_plus_8)
 #endif
 
-- 
2.13.3

