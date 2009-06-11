From: Konrad Eisele <konrad@gaisler.com>
Date: Thu, 11 Jun 2009 06:58:47 +0000
Subject: Re: [PATCH 7/7] sparc-leon specific SRMMU initialization and
Message-Id: <4A30ABD5.90801@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45EE.40007@gaisler.com>
In-Reply-To: <4A2E45EE.40007@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>>  enum mbus_module srmmu_modtype;
>> @@ -568,6 +572,11 @@ static void srmmu_switch_mm(struct mm_st
>>                srmmu_ctxd_set(&srmmu_context_table[mm->context], mm->pgd);
>>        }
>>
>> +#ifdef CONFIG_SPARC_LEON
>> +       flush_tlb_mm(0);
>> +       if (leon_flush_during_switch)
>> +               leon_flush_cache_all();
>> +#endif
>>        if (is_hypersparc)
>>                hyper_flush_whole_icache();
>>
> 
> Hmm... it would be nice to match the style of the statement after
> this, something like:
> 
> if (is_leon) {
>     flush_tlb_mm(0);
>     if (leon_flush_during_switch)
>         leon_flush_cache_all();
> }
> 
> But that would mean that the leon_flush_during_switch and
> leon_flush_cache_all() would have to be defined for the non-SPARC_LEON
> case, which isn't what you're trying to do here, however if
> leon_flush_cache_all() is defined as a blank function, the compiler
> *should* optimise all this away.
> 

I'm not shure what to do here. I wonder weather
if (is_leon) {
is better than a
#ifdef CONFIG_SPARC_LEON
it seems to me that the later is better.
It seems to me that in case of the former you have to have the
implicit knowledge that  the compiler will optimize away the
function calls (and you have  to search your way through the source
code to come to a conclusion  that it will), and this is quite more
complex and disturbing than a #ifdef. I'd think #ifdef CONFIG_SPARC_LEON
is much cleaner.
Moreover it is not in line with the general strategy: to make leon-specific
parts be only compiled in when CONFIG_SPARC_LEON is defined. Then  all leon_mm.c
and leon_kernel.c should also be compiled in always and protected with is_leon()
instead of only compiling it in the CONFIG_SPARC_LEON case...

But, hey, he, who checkes in, decides. Maybe Dave Miller can say how it should be.
-- Konrad
