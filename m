From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 03 Aug 2017 21:08:26 +0000
Subject: Re: [PATCH RFC 3/4] arch/sparc: Optimized memcpy, memset, copy_to_user, copy_from_user for M7
Message-Id: <97e07f34-a1d6-de42-7e8f-9c71b88c1653@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1501192650-1043374-1-git-send-email-babu.moger@oracle.com>
 <1501192650-1043374-3-git-send-email-babu.moger@oracle.com>
 <20170729.143619.1067390481813023112.davem@davemloft.net>
In-Reply-To: <20170729.143619.1067390481813023112.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David, Thanks for the comments. I am working on addressing your feedback.

Comments inline below.


On 7/29/2017 4:36 PM, David Miller wrote:
> From: Babu Moger <babu.moger@oracle.com>
> Date: Thu, 27 Jul 2017 15:57:29 -0600
>
>> @@ -600,7 +600,7 @@ niagara_tlb_fixup:
>>   	be,pt	%xcc, niagara4_patch
>>   	 nop
>>   	cmp	%g1, SUN4V_CHIP_SPARC_M7
>> -	be,pt	%xcc, niagara4_patch
>> +	be,pt	%xcc, sparc_m7_patch
>>   	 nop
>>   	cmp	%g1, SUN4V_CHIP_SPARC_SN
>>   	be,pt	%xcc, niagara4_patch
> This part will need to be respun now that the M8 patches are in
> as there will be a slight conflict in this hunk.
Actually, these patches have been tested both on M7 and M8.  I wanted to 
add M8 also. But M8 patches were
not in the kernel yet. Now that these M8 patches(from Allen) are in the 
kernel, I can add it now.
Will update it in the second version.
>> +        .register      %g2,#scratch
>> +
>> +       .section        ".text"
>> +       .global FUNC_NAME
>> +       .type   FUNC_NAME, #function
>> +       .align  16
>> +FUNC_NAME:
>> +	srlx            %o2, 31, %g2
>> +	cmp             %g2, 0
>> +	tne             %xcc, 5
>> +	PREAMBLE
>> +	mov		%o0, %g1	! save %o0
>> +	brz,pn          %o2, .Lsmallx
>> +
>> +	cmp            %o2, 3
>> +        ble,pn          %icc, .Ltiny_cp
>> +         cmp            %o2, 19
>> +        ble,pn          %icc, .Lsmall_cp
>> +         or             %o0, %o1, %g2
>> +        cmp             %o2, SMALL_MAX
>> +        bl,pn           %icc, .Lmedium_cp
>> +         nop
> What in world is going on with this indentation?
>
> I can't comprehend how, if anyone actually put their eyes on
> this code and the patch itself, wouldn't notice this.
>
> DO NOT mix all-spaced and TAB+space indentation.
>
> Always, consistently, use as many TABs as you can and
> then when needed add trailing spaces.

Sure. Will address these problems. In general will address all the 
format issues. thanks
>
>> +.Lsrc_dst_aligned_on_8:
>> +	! check if we are copying MED_MAX or more bytes
>> +        set MED_MAX, %o3
>> +        cmp %o2, %o3 			! limit to store buffer size
>> +	bgu,pn	%ncc, .Llarge_align8_copy
>> +	 nop
> Again, same problem here.
>
>> +/*
>> + * Handle all cases where src and dest are aligned on word
>> + * boundaries. Use unrolled loops for better performance.
>> + * This option wins over standard large data move when
>> + * source and destination is in cache for.Lmedium
>> + * to short data moves.
>> + */
>> +        set MED_WMAX, %o3
>> +        cmp %o2, %o3 			! limit to store buffer size
>> +	bge,pt	%ncc, .Lunalignrejoin	! otherwise rejoin main loop
>> +	 nop
> More weird indentation.
>
>> +.dbalign:
>> +        andcc   %o5, 7, %o3             ! is sp1 aligned on a 8 byte bound?
>> +        bz,pt   %ncc, .blkalign         ! already long word aligned
>> +         sub     %o3, 8, %o3             ! -(bytes till long word aligned)
>> +
>> +        add     %o2, %o3, %o2           ! update o2 with new count
>> +        ! Set -(%o3) bytes till sp1 long word aligned
>> +1:      stb     %o1, [%o5]              ! there is at least 1 byte to set
>> +	inccc   %o3                     ! byte clearing loop
>> +        bl,pt   %ncc, 1b
>> +	 inc     %o5
> More weird indentation.
>
>> +        ! Now sp1 is block aligned
>> +.blkwr:
>> +        andn    %o2, 63, %o4            ! calculate size of blocks in bytes
>> +        brz,pn  %o1, .wrzero            ! special case if c = 0
>> +         and     %o2, 63, %o3            ! %o3 = bytes left after blk stores.
>> +
>> +        set     MIN_LOOP, %g1
>> +        cmp     %o4, %g1                ! check there are enough bytes to set
>> +	blu,pn  %ncc, .short_set        ! to justify cost of membar
>> +                                        ! must be > pre-cleared lines
>> +         nop
> Likewise.
>
>> +
>> +        ! initial cache-clearing stores
>> +        ! get store pipeline moving
>> +	rd	%asi, %g3		! save %asi to be restored later
>> +        wr     %g0, ASI_STBIMRU_P, %asi
> Likewise.
>
>> +.wrzero_small:
>> +        stxa    %o1, [%o5]ASI_STBI_P
>> +        subcc   %o4, 64, %o4
>> +        bgu,pt  %ncc, .wrzero_small
>> +         add     %o5, 64, %o5
>> +	ba,a	.bsi_done
> Likewise.
>
>> +.asi_done:
>> +	wr	%g3, 0x0, %asi		! restored saved %asi
>> +.bsi_done:
>> +        membar  #StoreStore             ! required by use of Block Store Init
> Likewise.
>
>> +	.size		M7memset,.-M7memset
> It's usually a lot better to use ENTRY() and ENDPROC() instead of
> expanding these kinds of directives out.

Ok.  Sure. Will address it.
>> +	.globl	m7_patch_copyops
>> +	.type	m7_patch_copyops,#function
>> +m7_patch_copyops:
> ENTRY()
Sure.
>> +	.size	m7_patch_copyops,.-m7_patch_copyops
> ENDPROC()
Sure
>> +	.globl	m7_patch_bzero
>> +	.type	m7_patch_bzero,#function
>> +m7_patch_bzero:
> Likewise.
Ok
>> +	.size	m7_patch_bzero,.-m7_patch_bzero
> Likewise.
Ok
>> +	.globl	m7_patch_pageops
>> +	.type	m7_patch_pageops,#function
>> +m7_patch_pageops:
> Likewise.
Ok
>> +	.size	m7_patch_pageops,.-m7_patch_pageops
> Likewise.
ok
