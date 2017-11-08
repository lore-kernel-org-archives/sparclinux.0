From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Wed, 08 Nov 2017 20:44:45 +0000
Subject: Re: [PATCH v9 00/10] Application Data Integrity feature introduced by SPARC M7
Message-Id: <CF004B9F-A3B6-4A44-AD9E-EC01D6B740BB@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1508364660.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1508364660.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>
Cc: David Miller <davem@davemloft.net>, dave.hansen@linux.intel.com, akpm@linux-foundation.org, 0x7f454c46@gmail.com, aarcange@redhat.com, ak@linux.intel.com, Allen Pais <allen.pais@oracle.com>, aneesh.kumar@linux.vnet.ibm.com, arnd@arndb.de, Atish Patra <atish.patra@oracle.com>, benh@kernel.crashing.org, Bob Picco <bob.picco@oracle.com>, bsingharora@gmail.com, chris.hyser@oracle.com, cmetcalf@mellanox.com, corbet@lwn.net, dan.carpenter@oracle.com, dave.jiang@intel.com, dja@axtens.net, Eric Saint Etienne <eric.saint.etienne@oracle.com>, geert@linux-m68k.org, hannes@cmpxchg.org, heiko.carstens@de.ibm.com, hpa@zytor.com, hughd@google.com, imbrenda@linux.vnet.ibm.com, jack@suse.cz, jmarchan@redhat.com, jroedel@suse.de, Khalid Aziz <khalid@gonehiking.org>, kirill.shutemov@linux.intel.com


> On Oct 20, 2017, at 9:57 AM, Khalid Aziz <khalid.aziz@oracle.com> wrote:
> 
> Patch 9/10
>  When a processor supports additional metadata on memory pages, that
>  additional metadata needs to be copied to new memory pages when those
>  pages are moved. This patch allows architecture specific code to
>  replace the default copy_highpage() routine with arch specific
>  version that copies the metadata as well besides the data on the page.
> 
> Patch 10/10
>  This patch adds support for a user space task to enable ADI and enable
>  tag checking for subsets of its address space. As part of enabling
>  this feature, this patch adds to support manipulation of precise
>  exception for memory corruption detection, adds code to save and
>  restore tags on page swap and migration, and adds code to handle ADI
>  tagged addresses for DMA.
> 
> Changelog v9:
> 
> 	- Patch 1/10: No changes
> 	- Patch 2/10: No changes
> 	- Patch 3/10: No changes
> 	- Patch 4/10: No changes
> 	- Patch 5/10: No changes
> 	- Patch 6/10: No changes
> 	- Patch 7/10: No changes
> 	- Patch 8/10: No changes
> 	- Patch 9/10: New patch
> 	- Patch 10/10: Patch 9 from v8. Added code to copy ADI tags when
> 	  pages are migrated. Updated code to detect overflow and underflow
> 	  of addresses when allocating tag storage.

Patch 09/10 wasn't delivered to me, but I reviewed the copy on lkml.org.

The changes looks good, but there is one remaining functional issue
which I've pointed out twice now in previous comments that still has not
been addressed:

The code paths through rtrap that overwrite PSTATE need to also set
PSTATE.mcde=1 since additional kernel work done after PSTATE is
overwritten could access ADI-enabled user memory and depend on version
checking being enabled.  For example, rtrap may call SCHEDULE_USER and
resume execution in another thread.  Without a fix, the resumed thread
will run with PSTATE.mcde=0 until it completes a return to user mode or
is rescheduled on a CPU where PSTATE.mcde is set.  If the thread
accesses ADI-enabled user memory with a versioned address (e.g. to
complete some I/O) in that timeframe then the access will fail.

Here is what you need to fix it:

diff --git a/arch/sparc/kernel/rtrap_64.S b/arch/sparc/kernel/rtrap_64.S
index dff86fa..07c82a7 100644
--- a/arch/sparc/kernel/rtrap_64.S
+++ b/arch/sparc/kernel/rtrap_64.S
@@ -24,13 +24,21 @@
 		.align			32
 __handle_preemption:
 		call			SCHEDULE_USER
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
+661:		 wrpr			%g0, RTRAP_PSTATE, %pstate
+		.section		.sun_m7_1insn_patch, "ax"
+		.word			661b
+		wrpr			%g0, RTRAP_PSTATE | PSTATE_MCDE, %pstate
+		.previous
 		ba,pt			%xcc, __handle_preemption_continue
 		 wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 
 __handle_user_windows:
 		call			fault_in_user_windows
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
+661:		 wrpr			%g0, RTRAP_PSTATE, %pstate
+		.section		.sun_m7_1insn_patch, "ax"
+		.word			661b
+		wrpr			%g0, RTRAP_PSTATE | PSTATE_MCDE, %pstate
+		.previous
 		ba,pt			%xcc, __handle_preemption_continue
 		 wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 
@@ -47,7 +55,11 @@ __handle_signal:
 		add			%sp, PTREGS_OFF, %o0
 		mov			%l0, %o2
 		call			do_notify_resume
-		 wrpr			%g0, RTRAP_PSTATE, %pstate
+661:		 wrpr			%g0, RTRAP_PSTATE, %pstate
+		.section		.sun_m7_1insn_patch, "ax"
+		.word			661b
+		wrpr			%g0, RTRAP_PSTATE | PSTATE_MCDE, %pstate
+		.previous
 		wrpr			%g0, RTRAP_PSTATE_IRQOFF, %pstate
 
 		/* Signal delivery can modify pt_regs tstate, so we must
diff --git a/arch/sparc/kernel/urtt_fill.S b/arch/sparc/kernel/urtt_fill.S
index 364af32..3a7f2d8 100644
--- a/arch/sparc/kernel/urtt_fill.S
+++ b/arch/sparc/kernel/urtt_fill.S
@@ -49,7 +49,11 @@ user_rtt_fill_fixup_common:
 		SET_GL(0)
 		.previous
 
-		wrpr	%g0, RTRAP_PSTATE, %pstate
+661:		wrpr	%g0, RTRAP_PSTATE, %pstate
+		.section		.sun_m7_1insn_patch, "ax"
+		.word			661b
+		wrpr	%g0, RTRAP_PSTATE | PSTATE_MCDE, %pstate
+		.previous
 
 		mov	%l1, %g6
 		ldx	[%g6 + TI_TASK], %g4

