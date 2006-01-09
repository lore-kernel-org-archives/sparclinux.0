From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 09 Jan 2006 06:50:02 +0000
Subject: Re: strace broken on SPARC64
Message-Id: <20060108.225002.113326957.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 09 Jan 2006 00:50:43 +0000

> Whilst debugging some USB printing problems with strace I noticed that
> the output from strace in recent kernels is broken. A bit of detective
> work shows that it last worked properly in 2.6.12 and broke during
> 2.6.13 development. It seems that it broke due to git commit
> db7d9a4eb700be766cc9f29241483dbb1e748832
>=20
> http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dcommitdiff_plain;h=DB7d9a4eb700be766cc9f29241483dbb1e748832;hp=CDd5186f7=
53b23ab51f86679bdc4cc698ab0b893
>=20
> After a bit of searching I found that removing the above patch makes
> strace happy (note I didn't get time to try this with 2.6.15 saw it with
> a tree based between 2.6.12 and 2.6.13 - with git head set to
> d06e4c4001cf26147a6af0718703368944f0df32)
>=20
> I cannot obviously see what is wrong with the patch but looking at the
> symptoms of the breakage I would guess that either syscall entry or exit
> is not being captured. I only seem to see every other syscall and the
> return values are bogus in many cases. (It is probably exit that is
> wrong)

Thanks for the report.

Luis F. Ortiz also narrowed it down to the:

[SPARC64]: Move syscall success and newchild state out of thread flags.

changeset as well.

Looking at the entry.S part of the diff, the problem is obvious.

We're spamming the existing flags value in register %l0, thus
corrupting the subsequent tracing flag et al. checks.

This should fix it:

diff --git a/arch/sparc64/kernel/entry.S b/arch/sparc64/kernel/entry.S
index 11a8484..86ff6a9 100644
--- a/arch/sparc64/kernel/entry.S
+++ b/arch/sparc64/kernel/entry.S
@@ -1657,8 +1657,8 @@ ret_sys_call:
 	/* Check if force_successful_syscall_return()
 	 * was invoked.
 	 */
-	ldub		[%curptr + TI_SYS_NOERROR], %l0
-	brz,pt		%l0, 1f
+	ldub		[%curptr + TI_SYS_NOERROR], %l1
+	brz,pt		%l1, 1f
 	 nop
 	ba,pt		%xcc, 80f
 	 stb		%g0, [%curptr + TI_SYS_NOERROR]
