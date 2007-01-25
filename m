From: David Miller <davem@davemloft.net>
Date: Thu, 25 Jan 2007 23:26:21 +0000
Subject: Re: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <20070125.152621.55836260.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Vince Weaver <vince@deater.net>
Date: Wed, 24 Jan 2007 22:00:12 -0500 (EST)

> I've reproduced it, here are the results (the bug is still at line 413,=20
> my debug code pushed it down a bit):
>=20
> [  263.773194] VMW: fault_code=3D4 address=FF0cc000 regs->tpcp131660
>=20

I have a theory about what is happening here, but not why.
But I'd like some more confirmation.  What I think is going
on is that (in do_sparc64_fault):

	fault_code =3D get_thread_fault_code();

	if (notify_page_fault(DIE_PAGE_FAULT, "page_fault", regs,
		       fault_code, 0, SIGSEGV) =3D NOTIFY_STOP)
		return;

	si_code =3D SEGV_MAPERR;
	address =3D current_thread_info()->fault_address;

The addr/code state is changed between the read of
get_thread_fault_code() and ->fault_address.

Besides the main fault path, there is only one other path which
could trigger here which writes to these thread state variables.
That's the window spill/fill code, BUT that code guards the writes
with a check if we came from privileged mode which should always
be true, for example:

	rdpr	%tstate, %g1
	andcc	%g1, TSTATE_PRIV, %g0
	saved
	be,pn	%xcc, 1f
	 and	%g1, TSTATE_CWP, %g1
	retry
1:	mov	FAULT_CODE_WRITE | FAULT_CODE_DTLB | FAULT_CODE_WINFIXUP, %g4
	stb	%g4, [%g6 + TI_FAULT_CODE]
	stx	%g5, [%g6 + TI_FAULT_ADDR]

If TSTATE_PRIV is set, it skips the write to TI_FAULT_{CODE,ADDR}.

I highly suspected this code path because the value of "address" is
in the user process stack address range, however the logic is clearly
correct here.

The other problematic case are other cpus accessing the
current_thread_info()->flags member in a non-atomic manner.
This is critical because get_thread_fault_code() is a byte
embedded in that area.  So if another thread does a read-modify-write
of current_thread_info->flags we can get:

	Cpu 1			Cpu 2
	...			read ->flags, see old fault_code
	store new fault_code
	store new fault_address
				write ->flags, puts old fault_code there

and that would look exactly like this.

I think the fault being taken is a stack fault via a save instruction
in userspace or similar.  The most recent fault before that was an
instruction fault into GLIBC which set the fault code to FAULT_CODE_ITLB.

That's why we see FAULT_CODE_ITLB combined with a stack address.

I did some auditing and I really can't see how it can happen :-)
But we can test this theory with a relatively simple patch,
can you give this a try?  What it does is it moves fault_code
out of the thread flags word.

If you can't trigger it, then my theory is right.  If you can't,
then the bug is somewhere else :-)

Note, this patch is pretty straight forward, but I've only compile
tested it.  I'm about to test boot it myself right now.

diff --git a/include/asm-sparc64/thread_info.h b/include/asm-sparc64/thread=
_info.h
index 2ebf7f2..75921fd 100644
--- a/include/asm-sparc64/thread_info.h
+++ b/include/asm-sparc64/thread_info.h
@@ -11,8 +11,6 @@
=20
 #define NSWINS		7
=20
-#define TI_FLAG_BYTE_FAULT_CODE		0
-#define TI_FLAG_FAULT_CODE_SHIFT	56
 #define TI_FLAG_BYTE_WSTATE		1
 #define TI_FLAG_WSTATE_SHIFT		48
 #define TI_FLAG_BYTE_CWP		2
@@ -49,7 +47,8 @@ struct thread_info {
 	int			preempt_count;	/* 0 =3D> preemptable, <0 =3D> BUG */
 	__u8			new_child;
 	__u8			syscall_noerror;
-	__u16			__pad;
+	__u8			fault_code;
+	__u8			__pad;
=20
 	unsigned long		*utraps;
=20
@@ -77,7 +76,6 @@ struct thread_info {
 /* offsets into the thread_info struct for assembly code access */
 #define TI_TASK		0x00000000
 #define TI_FLAGS	0x00000008
-#define TI_FAULT_CODE	(TI_FLAGS + TI_FLAG_BYTE_FAULT_CODE)
 #define TI_WSTATE	(TI_FLAGS + TI_FLAG_BYTE_WSTATE)
 #define TI_CWP		(TI_FLAGS + TI_FLAG_BYTE_CWP)
 #define TI_CURRENT_DS	(TI_FLAGS + TI_FLAG_BYTE_CURRENT_DS)
@@ -92,6 +90,7 @@ struct thread_info {
 #define TI_PRE_COUNT	0x00000038
 #define TI_NEW_CHILD	0x0000003c
 #define TI_SYS_NOERROR	0x0000003d
+#define TI_FAULT_CODE	0x0000003e
 #define TI_UTRAPS	0x00000040
 #define TI_REG_WINDOW	0x00000048
 #define TI_RWIN_SPTRS	0x000003c8=09
@@ -179,8 +178,8 @@ register struct thread_info *current_thread_info_reg as=
m("g6");
 	((unsigned char *)(&((ti)->flags)))
 #define __cur_thread_flag_byte_ptr	__thread_flag_byte_ptr(current_thread_i=
nfo())
=20
-#define get_thread_fault_code()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_=
FAULT_CODE])
-#define set_thread_fault_code(val)	(__cur_thread_flag_byte_ptr[TI_FLAG_BYT=
E_FAULT_CODE] =3D (val))
+#define get_thread_fault_code()		(current_thread_info()->fault_code)
+#define set_thread_fault_code(val)	(current_thread_info()->fault_code =3D =
(val))
 #define get_thread_wstate()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_WSTA=
TE])
 #define set_thread_wstate(val)		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_W=
STATE] =3D (val))
 #define get_thread_cwp()		(__cur_thread_flag_byte_ptr[TI_FLAG_BYTE_CWP])
