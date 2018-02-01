From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Feb 2018 21:49:32 +0000
Subject: Re: [PATCH v11 03/10] sparc64: Add support for ADI register fields, ASIs and traps
Message-Id: <20180201214932.GA25218@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1517497017.git.khalid.aziz@oracle.com>
 <e4ad304a57afeff9e3bd6f1fc57a927c943506b0.1517497017.git.khalid.aziz@oracle.com>
 <1517517122.7489.47.camel@perches.com>
In-Reply-To: <1517517122.7489.47.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Joe Perches <joe@perches.com>
Cc: Khalid Aziz <khalid.aziz@oracle.com>, davem@davemloft.net, dave.hansen@linux.intel.com, mhocko@suse.com, mingo@kernel.org, gregkh@linuxfoundation.org, glx@linutronix.de, kstewart@linuxfoundation.org, vijay.ac.kumar@oracle.com, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com, tom.hromatka@oracle.com, allen.pais@oracle.com, rob.gardner@oracle.com, david.j.aldridge@oracle.com, babu.moger@oracle.com, bob.picco@oracle.com, steven.sistare@oracle.com, pasha.tatashin@oracle.com, vegard.nossum@oracle.com, pombredanne@nexb.com, jane.chu@oracle.com, anthony.yznaga@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>

> >  #define _PAGE_E_4V	  _AC(0x0000000000000800,UL) /* side-Effect          */
> >  #define _PAGE_CP_4V	  _AC(0x0000000000000400,UL) /* Cacheable in P-Cache */
> >  #define _PAGE_CV_4V	  _AC(0x0000000000000200,UL) /* Cacheable in V-Cache */
> > +/* Bit 9 is used to enable MCD corruption detection instead on M7 */
> > +#define _PAGE_MCD_4V      _AC(0x0000000000000200,UL) /* Memory Corruption    */
> 
> trivia:
> 
> There are some whitespace alignment issues here
Looks like you are fouled by the use of tabs.
When you apply the patch it is fine.

> 
> > diff --git a/arch/sparc/include/asm/ttable.h b/arch/sparc/include/asm/ttable.h
> []
> > @@ -219,6 +219,16 @@
> >  	nop;						\
> >  	nop;
> >  
> > +#define SUN4V_MCD_PRECISE				\
> > +	ldxa	[%g0] ASI_SCRATCHPAD, %g2;		\
> > +	ldx	[%g2 + HV_FAULT_D_ADDR_OFFSET], %g4;	\
> > +	ldx	[%g2 + HV_FAULT_D_CTX_OFFSET], %g5;	\
> > +	ba,pt	%xcc, etrap;				\
> > +	 rd	%pc, %g7;				\
> > +	ba,pt	%xcc, sun4v_mcd_detect_precise;		\
> > +	 nop;						\
> > +	nop;
> 
> and here and elsewhere.
> 
> It would be nicer to make all these use
> similar indentation.

The patch uses the sparc idiom to indent instructions
in the delay slot after a branch with one space.
So the space before the nop is mandatory and not a bug.

	Sam
