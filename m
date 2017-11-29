From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 19:37:32 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <20171129.143732.1669543874949934043.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 14:26:44 -0500 (EST)

>> mator@ttip:~/sparc$ git bisect good
>> 46ad8d2d22c17e2b577adec55ae87161666a3267 is the first bad commit
>> commit 46ad8d2d22c17e2b577adec55ae87161666a3267
>> Author: Vijay Kumar <vijay.ac.kumar@oracle.com>
>> Date:   Wed Oct 11 12:50:06 2017 -0600
>> 
>>     sparc64: Use sparc optimized fls and __fls for T4 and above
> 
> Thanks for bisecting, I'll take a look.

The problem is that the distance between the generic sparc64 fls/__fls
symbols and the NG4 optimized ones are too large for the branch patch.
It needs to fit in a 19-bit displacement field.

When there are library routines and patching, you have to group them
near eachother.  This means if the generic routine is "lib-y" you
have to make the patch code "lib-y" too.

In this case, the NG4fls.o object is placed into "obj-y" which is
too far from the "lib-y" code to fit into the disp19 relocation
of the patch branch.

Vijay, why did you put the NG4fls.o into obj-y?

Anatoly, please try this patch:

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 0f0f76b..063556f 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -19,7 +19,7 @@ lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
 lib-$(CONFIG_SPARC64) += multi3.o
 lib-$(CONFIG_SPARC64) += fls.o
 lib-$(CONFIG_SPARC64) += fls64.o
-obj-$(CONFIG_SPARC64) += NG4fls.o
+lib-$(CONFIG_SPARC64) += NG4fls.o
 
 lib-$(CONFIG_SPARC64) += copy_page.o clear_page.o bzero.o
 lib-$(CONFIG_SPARC64) += csum_copy.o csum_copy_from_user.o csum_copy_to_user.o
