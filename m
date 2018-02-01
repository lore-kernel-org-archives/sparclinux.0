From: Joe Perches <joe@perches.com>
Date: Thu, 01 Feb 2018 22:09:30 +0000
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields, ASIs and traps
Message-Id: <1517522970.7489.72.camel@perches.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
	 <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
	 <1517517122.7489.47.camel@perches.com>
	 <20180201.153903.1719756519690647679.davem@davemloft.net>
In-Reply-To: <20180201.153903.1719756519690647679.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>
Cc: khalid.aziz@oracle.com, dave.hansen@linux.intel.com, mhocko@suse.com, mingo@kernel.org, gregkh@linuxfoundation.org, kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com, tom.hromatka@oracle.com, allen.pais@oracle.com, rob.gardner@oracle.com, david.j.aldridge@oracle.com, babu.moger@oracle.com, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, vegard.nossum@oracle.com, pombredanne@nexb.com, jane.chu@oracle.com, anthony.yznaga@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, khalid@gonehiking.org

On Thu, 2018-02-01 at 15:39 -0500, David Miller wrote:
> From: Joe Perches <joe@perches.com>
> Date: Thu, 01 Feb 2018 12:32:02 -0800
> 
> >> diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
> > []
> >> @@ -219,6 +219,16 @@
> >>      nop;                                            \
> >>      nop;
> >>  
> >> +#define SUN4V_MCD_PRECISE                           \
> >> +    ldxa    [%g0] ASI_SCRATCHPAD, %g2;              \
> >> +    ldx     [%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;    \
> >> +    ldx     [%g2 + HV_FAULT_D_CTX_OFFSET], %g5;     \
> >> +    ba,pt   %xcc, etrap;                            \
> >> +     rd     %pc, %g7;                               \
> >> +    ba,pt   %xcc, sun4v_mcd_detect_precise;         \
> >> +     nop;                                           \
> >> +    nop;
> > 
> > and here and elsewhere.
> 
> Joe, this is intentional in Sparc assembler.
> 
> Branches on sparc have delay slots, and this is annotated by indenting
> the delay slot instruction one space more than the branch preceeding
> it.

OK, that is new to me and seems a sensible convention.

btw:

There seem to be only a few instances where that
convention is not followed in arch/sparc/...

(maybe some missing or false positives below)

$ git ls-files arch/sparc/ | \
  xargs grep-2.5.4 -P -n '^([ \t]+)b\w+,p.*\n\1[^ ]\S' | \
  perl -p -e 's/(:\d+:)/\1\n/'
arch/sparc/include/asm/tsb.h:168:
	brz,pn		REG1, FAIL_LABEL; \
	sethi		%uhi(_PAGE_PUD_HUGE), REG2; \
arch/sparc/include/asm/ttable.h:281:
	ba,pt	%xcc, etrap_save;			\
	wrpr	%g1, %cwp;				\
arch/sparc/kernel/head_64.S:472:
	bne,pn	%icc, 49f
	add	%g7, 1, %g7
arch/sparc/kernel/head_64.S:474:
	bne,pt	%xcc, 41b
	add	%g1, 1, %g1
arch/sparc/kernel/rtrap_64.S:72:
		ba,pt			%xcc, rtrap_no_irq_enable
		nop
arch/sparc/kernel/rtrap_64.S:161:
		brz,pt			%l3, 1f
		mov			%g6, %l2
arch/sparc/lib/GENmemcpy.S:100:
	bne,pt		%XCC, 1b
	add		%o0, 1, %o0
arch/sparc/lib/M7memcpy.S:896:
	bgu,pt	%xcc, .Lsmallnotalign4	! loop til 3 or fewer bytes remain
	EX_ST(STORE(stb, %o3, %o0-1), memcpy_retl_o2_plus_4)
arch/sparc/lib/M7memcpy.S:902:
	bz,pt	%xcc, .Lsmallx
	EX_ST(STORE(stb, %o3, %o0), memcpy_retl_o2_plus_1)	! store one byte
arch/sparc/lib/M7memcpy.S:905:
	bz,pt	%xcc, .Lsmallx
	EX_ST(STORE(stb, %o3, %o0+1), memcpy_retl_o2_plus_1)! store second byte
arch/sparc/lib/NG2memcpy.S:299:
	bne,pt		%XCC, 1b
	add		%o0, 1, %o0
arch/sparc/lib/NG4fls.S:23:
	brz,pn	%o0, 1f
	LZCNT_O0_G2	!lzcnt	%o0, %g2
arch/sparc/lib/NGmemcpy.S:216:
	bne,pt		%XCC, 1b
	add		%o0, 1, %o0
arch/sparc/lib/csum_copy.S:103:
	ba,pt		%xcc, 1f
	LOAD(prefetch, %o0 + 0x140, #n_reads)


