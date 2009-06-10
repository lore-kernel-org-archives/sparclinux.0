From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 10 Jun 2009 23:18:53 +0000
Subject: Re: [PATCH 1/7] CONFIG_SPARC_LEON option
Message-Id: <646765f40906101618x3823497q9af9618e27bce009@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1244628574-23789-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Wed, Jun 10, 2009 at 21:32, Konrad Eisele<konrad@gaisler.com> wrote:
>>
>> [snip]
>>
>>> +#ifndef __ASSEMBLY__
>>> +
>>> +/* do a virtual address read without cache */
>>> +static inline unsigned long leon_readnobuffer_reg(unsigned long paddr)
>>> +{
>>> + =A0 =A0 =A0 unsigned long retval;
>>> + =A0 =A0 =A0 __asm__ __volatile__("lda [%1] %2, %0\n\t" :
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"=3Dr"(retval)=
 : "r"(paddr),
>>> "i"(ASI_LEON_NOCACHE));
>>> + =A0 =A0 =A0 return retval;
>>> +}
>>> +
>>> +/* do a physical address bypass write, i.e. for 0x80000000 */
>>> +static inline void leon_store_reg(unsigned long paddr, unsigned long
>>> value)
>>> +{
>>> + =A0 =A0 =A0 __asm__ __volatile__("sta %0, [%1] %2\n\t" : : "r"(value),
>>> "r"(paddr),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i"(ASI_LEON_B=
YPASS) : "memory");
>>> +}
>>> +
>>> +/* do a physical address bypass load, i.e. for 0x80000000 */
>>> +static inline unsigned long leon_load_reg(unsigned long paddr)
>>> +{
>>> + =A0 =A0 =A0 unsigned long retval;
>>> + =A0 =A0 =A0 __asm__ __volatile__("lda [%1] %2, %0\n\t" :
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"=3Dr"(retval)=
 : "r"(paddr),
>>> "i"(ASI_LEON_BYPASS));
>>> + =A0 =A0 =A0 return retval;
>>> +}
>>> +
>>> +extern inline void leon_srmmu_disabletlb(void)
>>> +{
>>> + =A0 =A0 =A0 unsigned int retval;
>>> + =A0 =A0 =A0 __asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=3Dr"(ret=
val) :
>>> "r"(0),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i"(ASI_LEON_M=
MUREGS));
>>> + =A0 =A0 =A0 retval |=3D LEON_CNR_CTRL_TLBDIS;
>>> + =A0 =A0 =A0 __asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retv=
al),
>>> "r"(0),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i"(ASI_LEON_M=
MUREGS) : "memory");
>>> +}
>>> +
>>> +extern inline void leon_srmmu_enabletlb(void)
>>> +{
>>> + =A0 =A0 =A0 unsigned int retval;
>>> + =A0 =A0 =A0 __asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=3Dr"(ret=
val) :
>>> "r"(0),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i"(ASI_LEON_M=
MUREGS));
>>> + =A0 =A0 =A0 retval =3D retval & ~LEON_CNR_CTRL_TLBDIS;
>>> + =A0 =A0 =A0 __asm__ __volatile__("sta %0, [%%g0] %2\n\t" : : "r"(retv=
al),
>>> "r"(0),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i"(ASI_LEON_M=
MUREGS) : "memory");
>>> +}
>
> leon_readnobuffer_reg() read from virtual address but force a cache miss
> leon_store_reg() leon_load_reg() read from physical address using MMU byp=
ass
> leon_srmmu_disabletlb() and leon_srmmu_enabletlb() are 2 leon specific
> helper
> functions: the leon-srmmu's tlb can be enabled/disabled (like caches).
> Mostly
> used for debugging but useful anyway.
>
>>
>> [snip]
>>
>>> +extern inline unsigned long sparc_leon3_get_dcachecfg(void)
>>> +{
>>> + =A0 =A0 =A0 unsigned int retval;
>>> + =A0 =A0 =A0 __asm__ __volatile__("lda [%1] %2, %0\n\t" :
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"=3Dr"(retval)=
 :
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"r"(ASI_LEON3_=
SYSCTRL_DCFG),
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"i"(ASI_LEON3_=
SYSCTRL));
>>> + =A0 =A0 =A0 return retval;
>>> +}
>>> +
>>> +/*enable snooping*/
>>> +extern inline void sparc_leon3_enable_snooping(void)
>>> +{
>>> + =A0 =A0 =A0 __asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "set 0x800000, %%l2\n=
\t"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "or =A0%%l2, %%l1, %%=
l2\n\t"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sta %%l2, [%%g0] 2\n=
\t" : : : "l1", "l2");
>>> +};
>>> +
>>> +extern inline void sparc_leon3_disable_cache(void)
>>> +{
>>> + =A0 =A0 =A0 __asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "set 0x00000f, %%l2\n=
\t"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "andn =A0%%l2, %%l1, =
%%l2\n\t"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "sta %%l2, [%%g0] 2\n=
\t" : : : "l1", "l2");
>>> +};
>>
>> I don't understand what's going on with this code, but I don't think
>> it should live in a header file.
>
> Note that there is a
> #ifdef CONFIG_SPARC_LEON
> around the whole leon.h file.
>
> sparc_leon3_get_dcachecfg() gets the cache configuration information.
> That is cache size etc.
> sparc_leon3_enable_snooping() enables snooping on the amba bus for the
> caches.
> sparc_leon3_disable_cache() disable the caches.
>
> All of theses functions are useful to leon.h . How do you think one
> should proceed? Do you really think it is cleaner when creating a
> new .h file just for the inlines. Isnt it quite neat with just one leon.h
> file that includes all sparc-leon specific things?

My issue with these functions being in leon.h is that they are code in
a header file, despite being small inline functions.

If I were writing this code, I would have placed the functions in
files called leon_debug.c or leon_cache.c. However given that these
are very low-level functions, and are essentially being used as
macros, I can understand why you've put them in this file.

It's pretty much up to you. Now that I've had a better look at these,
I understand why you've done this the way you have.

Thanks,

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
