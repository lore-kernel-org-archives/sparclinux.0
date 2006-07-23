From: Chris Newport <crn@netunix.com>
Date: Sun, 23 Jul 2006 13:24:20 +0000
Subject: Re: sparc32: git SCSI and fs
Message-Id: <44C37884.6010200@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20060719.134205.74563314.davem@davemloft.net>
In-Reply-To: <20060719.134205.74563314.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:

>From: Chris Newport <crn@netunix.com>
>Date: Fri, 21 Jul 2006 23:03:31 +0100
>
>  
>
>>A year or so ago I did a few patches for Sun4d and there was a note in 
>>the iommu code about sun4d not having a register that was used for 
>>scratch data in sun4m.
>>Could this bug be back ?
>>
>>Sorry to be vague, this is from memory.
>>    
>>
>
>It would be nice to have something specific, I see nothing
>explicit in the current tree:
>
>  
>
I have not been able to find the file with the relevant comment, but 
looking back in my mail archive, it seems to relate to this code in 
2.4.26 include/asm-sparc/winmacro.h, looks like jj has created a workaround.
Maybe need to look at earlier 2.4 versions before the comment got dropped.

#ifdef CONFIG_SMP
#define LOAD_CURRENT4M(dest_reg, idreg) \
        rd       %tbr, %idreg; \
        sethi    %hi(C_LABEL(current_set)), %dest_reg; \
        srl      %idreg, 10, %idreg; \
        or       %dest_reg, %lo(C_LABEL(current_set)), %dest_reg; \
        and      %idreg, 0xc, %idreg; \
        ld       [%idreg + %dest_reg], %dest_reg;

/* Sliiick. We have a Linux current register :) -jj */
#define LOAD_CURRENT4D(dest_reg) \
        lda      [%g0] ASI_M_VIKING_TMP2, %dest_reg;

/* Blackbox - take care with this... - check smp4m and smp4d before 
changing thi
s. */



