From: Konrad Eisele <konrad@gaisler.com>
Date: Wed, 10 Jun 2009 11:32:04 +0000
Subject: Re: [PATCH 1/7] CONFIG_SPARC_LEON option
Message-Id: <4A2F99B4.3020400@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> [snip]
> 
>> +#ifndef __ASSEMBLY__
>> +
>> +/* do a virtual address read without cache */
>> +static inline unsigned long leon_readnobuffer_reg(unsigned long paddr)
>> +{
>> +       unsigned long retval;
>> +       __asm__ __volatile__("lda [%1] %2, %0\n\t" :
>> +                            "=r"(retval) : "r"(paddr), "i"(ASI_LEON_NOCACHE));
>> +       return retval;
>> +}
>> +
>> +/* do a physical address bypass write, i.e. for 0x80000000 */
>> +static inline void leon_store_reg(unsigned long paddr, unsigned long value)
>> +{
>> +       __asm__ __volatile__("sta %0, [%1] %2\n\t" : : "r"(value), "r"(paddr),
>> +                            "i"(ASI_LEON_BYPASS) : "memory");
>> +}
>> +
>> +/* do a physical address bypass load, i.e. for 0x80000000 */
>> +static inline unsigned long leon_load_reg(unsigned long paddr)
>> +{
>> +       unsigned long retval;
>> +       __asm__ __volatile__("lda [%1] %2, %0\n\t" :
>> +                            "=r"(retval) : "r"(paddr), "i"(ASI_LEON_BYPASS));
>> +       return retval;
>> +}
>> +
>> +extern inline void leon_srmmu_disabletlb(void)
>> +{
>> +       unsigned int retval;
>> +       __asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
>> +                            "i"(ASI_LEON_MMUREGS));
>> +       retval |= LEON_CNR_CTRL_TLBDIS;
>> +       __asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
>> +                            "i"(ASI_LEON_MMUREGS) : "memory");
>> +}
>> +
>> +extern inline void leon_srmmu_enabletlb(void)
>> +{
>> +       unsigned int retval;
>> +       __asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
>> +                            "i"(ASI_LEON_MMUREGS));
>> +       retval = retval & ~LEON_CNR_CTRL_TLBDIS;
>> +       __asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retval), "r"(0),
>> +                            "i"(ASI_LEON_MMUREGS) : "memory");
>> +}

leon_readnobuffer_reg() read from virtual address but force a cache miss
leon_store_reg() leon_load_reg() read from physical address using MMU bypass
leon_srmmu_disabletlb() and leon_srmmu_enabletlb() are 2 leon specific helper
functions: the leon-srmmu's tlb can be enabled/disabled (like caches). Mostly
used for debugging but useful anyway.

> 
> [snip]
> 
>> +extern inline unsigned long sparc_leon3_get_dcachecfg(void)
>> +{
>> +       unsigned int retval;
>> +       __asm__ __volatile__("lda [%1] %2, %0\n\t" :
>> +                            "=r"(retval) :
>> +                            "r"(ASI_LEON3_SYSCTRL_DCFG),
>> +                            "i"(ASI_LEON3_SYSCTRL));
>> +       return retval;
>> +}
>> +
>> +/*enable snooping*/
>> +extern inline void sparc_leon3_enable_snooping(void)
>> +{
>> +       __asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
>> +                         "set 0x800000, %%l2\n\t"
>> +                         "or  %%l2, %%l1, %%l2\n\t"
>> +                         "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
>> +};
>> +
>> +extern inline void sparc_leon3_disable_cache(void)
>> +{
>> +       __asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
>> +                         "set 0x00000f, %%l2\n\t"
>> +                         "andn  %%l2, %%l1, %%l2\n\t"
>> +                         "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
>> +};
> 
> I don't understand what's going on with this code, but I don't think
> it should live in a header file.

Note that there is a
#ifdef CONFIG_SPARC_LEON
around the whole leon.h file.

sparc_leon3_get_dcachecfg() gets the cache configuration information.
That is cache size etc.
sparc_leon3_enable_snooping() enables snooping on the amba bus for the
caches.
sparc_leon3_disable_cache() disable the caches.

All of theses functions are useful to leon.h . How do you think one
should proceed? Do you really think it is cleaner when creating a
new .h file just for the inlines. Isnt it quite neat with just one leon.h
file that includes all sparc-leon specific things?

-- Greetings Konrad

> 
> Thanks,
> 
> --
> 
> Julian Calaby
> 
> Email: julian.calaby@gmail.com
> .Plan: http://sites.google.com/site/juliancalaby/
> 
> 

