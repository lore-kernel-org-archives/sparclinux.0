From: David Miller <davem@davemloft.net>
Date: Thu, 03 Aug 2017 21:57:48 +0000
Subject: Re: strace-4.18 test suite oopses sparc64 4.12 and 4.13-rc kernels
Message-Id: <20170803.145748.1255019771865320896.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170801205829.GA7496@ravnborg.org>
        <20170802213647.GA5506@ravnborg.org>
        <22915.33137.173101.458489@gargle.gargle.HOWL>
In-Reply-To: <22915.33137.173101.458489@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpelinux@gmail.com
Cc: sam@ravnborg.org, matorola@gmail.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Thu, 3 Aug 2017 22:02:57 +0200

> With that in place the kernel booted fine.
> When I then ran the `poll' strace test binary, the OOPS was replaced by:
> 
> [  140.589913] _copy_from_user(fff000123c8dfa7c,           (null), 240) res 240
> [  140.753162] _copy_from_user(fff000123c8dfa7c, 00000000f7e4a000, 8) res 8
> [  140.824155] _copy_from_user(fff000123c8dfa7c, 00000000f7e49ff8, 16) res 18442240552407530112
> 
> That last `res' doesn't look good.

Please test this patch:

diff --git a/arch/sparc/lib/U3memcpy.S b/arch/sparc/lib/U3memcpy.S
index 54f9870..5a8cb37 100644
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
 
