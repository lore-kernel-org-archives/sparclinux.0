From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 08 Dec 2020 00:42:27 +0000
Subject: Re: [sparc64] current git kernel networking is broken
Message-Id: <20201208004227.GF3579531@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
In-Reply-To: <CADxRZqwn0uUi+J3bN=uLYMpXYhcYpkQb68Vkgmg70Tn87mhzOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, debian-sparc <debian-sparc@lists.debian.org>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Tue, Dec 08, 2020 at 03:09:47AM +0300, Anatoly Pugachev wrote:
> Hello!
> 
> Sorry for the late report, being 5.10-rc7 is out, but current git
> kernel (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
> is broken with the networking. It affects my openvpn tunnel and even
> internet networking.
> 
> ping to a local ethernet network (i.e. gateway ping) works, but i
> cannot download files from the internet.
> openvpn tunnel does not work.

<eyes commit in question>
<swears>
Could you check if the following typo fix is sufficient for your
reproducer?

diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 0c0268e77155..d839956407a7 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -71,7 +71,7 @@
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
 	xor		%o0, %o1, %g1
-	mov		1, %o3
+	mov		-1, %o3
 	clr		%o4
 	andcc		%g1, 0x3, %g0
 	bne,pn		%icc, 95f
