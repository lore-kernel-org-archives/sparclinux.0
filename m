From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jun 2006 04:32:46 +0000
Subject: Re: Checksum problem on sparc64
Message-Id: <20060604.213246.92583632.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060323223510.GA7683@sceen.net>
In-Reply-To: <20060323223510.GA7683@sceen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2006 21:05:14 -0700 (PDT)

> Let me know if it works for you.

It turns out the checksum+copy code had the same exact problem,
so let's kill that bug too.

Here is the current patch:

diff-tree ae5de0ff0bc24664a053109c6caa782ba2ad7c53 (from 672c6108a51bf559d19595d9f8193dfd81f0f752)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sun Jun 4 21:32:01 2006 -0700

    [SPARC64]: Fix missing fold at end of checksums.
    
    Both csum_partial() and the csum_partial_copy*() family of routines
    forget to do a final fold on the computed checksum value on sparc64.
    So do the standard Sparc "add + set condition codes, add carry"
    sequence, then make sure the high 32-bits of the return value are
    clear.
    
    Based upon some excellent detective work and debugging done by
    Richard Braun and Samuel Thibault.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/lib/checksum.S b/arch/sparc64/lib/checksum.S
index ba9cd3c..1d230f6 100644
--- a/arch/sparc64/lib/checksum.S
+++ b/arch/sparc64/lib/checksum.S
@@ -165,8 +165,9 @@ csum_partial_end_cruft:
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
 
-1:	add		%o2, %o4, %o2
+1:	addcc		%o2, %o4, %o2
+	addc		%g0, %o2, %o2
 
 csum_partial_finish:
 	retl
-	 mov		%o2, %o0
+	 srl		%o2, 0, %o0
diff --git a/arch/sparc64/lib/csum_copy.S b/arch/sparc64/lib/csum_copy.S
index 71af488..e566c77 100644
--- a/arch/sparc64/lib/csum_copy.S
+++ b/arch/sparc64/lib/csum_copy.S
@@ -221,11 +221,12 @@ FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len
 	sll		%g1, 8, %g1
 	or		%o5, %g1, %o4
 
-1:	add		%o3, %o4, %o3
+1:	addcc		%o3, %o4, %o3
+	addc		%g0, %o3, %o3
 
 70:
 	retl
-	 mov		%o3, %o0
+	 srl		%o3, 0, %o0
 
 95:	mov		0, GLOBAL_SPARE
 	brlez,pn	%o2, 4f
