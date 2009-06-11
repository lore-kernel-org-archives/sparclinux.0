From: Julian Calaby <julian.calaby@gmail.com>
Date: Thu, 11 Jun 2009 07:36:52 +0000
Subject: Re: [PATCH 7/7] sparc-leon specific SRMMU initialization and
Message-Id: <646765f40906110036r4af36dbcg6bf8c29fb512a4b4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45EE.40007@gaisler.com>
In-Reply-To: <4A2E45EE.40007@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Thu, Jun 11, 2009 at 17:01, Konrad Eisele<konrad@gaisler.com> wrote:
>>> =A0enum mbus_module srmmu_modtype;
>>> @@ -568,6 +572,11 @@ static void srmmu_switch_mm(struct mm_st
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 srmmu_ctxd_set(&srmmu_context_table[mm->con=
text], mm->pgd);
>>> =A0 =A0 =A0 }
>>>
>>> +#ifdef CONFIG_SPARC_LEON
>>> + =A0 =A0 =A0 flush_tlb_mm(0);
>>> + =A0 =A0 =A0 if (leon_flush_during_switch)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 leon_flush_cache_all();
>>> +#endif
>>> =A0 =A0 =A0 if (is_hypersparc)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 hyper_flush_whole_icache();
>>>
>>
>> Hmm... it would be nice to match the style of the statement after
>> this, something like:
>>
>> if (is_leon) {
>> =A0 =A0flush_tlb_mm(0);
>> =A0 =A0if (leon_flush_during_switch)
>> =A0 =A0 =A0 =A0leon_flush_cache_all();
>> }
>>
>> But that would mean that the leon_flush_during_switch and
>> leon_flush_cache_all() would have to be defined for the non-SPARC_LEON
>> case, which isn't what you're trying to do here, however if
>> leon_flush_cache_all() is defined as a blank function, the compiler
>> *should* optimise all this away.
>>
>
> I'm not shure what to do here. I wonder weather
> if (is_leon) {
> is better than a
> #ifdef CONFIG_SPARC_LEON
> it seems to me that the later is better.
> It seems to me that in case of the former you have to have the
> implicit knowledge that =A0the compiler will optimize away the
> function calls (and you have =A0to search your way through the source
> code to come to a conclusion =A0that it will), and this is quite more
> complex and disturbing than a #ifdef. I'd think #ifdef CONFIG_SPARC_LEON
> is much cleaner.
> Moreover it is not in line with the general strategy: to make leon-specif=
ic
> parts be only compiled in when CONFIG_SPARC_LEON is defined. Then =A0all
> leon_mm.c
> and leon_kernel.c should also be compiled in always and protected with
> is_leon()
> instead of only compiling it in the CONFIG_SPARC_LEON case...
>
> But, hey, he, who checkes in, decides. Maybe Dave Miller can say how it
> should be.

I should possibly explain myself here a little.

My agenda with hacking on SparcLinux is to get 32-bit Sparc fully
tested and working with current kernel releases. (At the moment, I've
completed phase 1, getting the hardware and am slowly working on phase
2, getting it to boot.)

My methodology is to decrease the 32-bit specific parts of the code to
the absolute minimum, whilst removing ifdef guards where possible to
allow other methods, e.g. Kconfig, to choose which bits are compiled
or not, with the end goal being that there is little difference
between a 32-bit kernel and a 64-bit kernel.

As I cast my eye over all these changes for SPARC LEON, I'm looking at
the code in exactly the same way, asking myself the question "How can
we merge this code into the existing code leaving little special-case
code?"

I understand your goals with this - get LEON support upstream, don't
break existing systems - and I understand your methodology - making
your changes disappear when SPARC_LEON is unset - but I *know* that
I'll be submitting patches to do exactly what I'm talking about once
I'm hacking at this again.

Back to the code.

As for leon_kernel.c and leon_mm.c, they shouldn't be compiled unless
CONFIG_LEON is set, exactly as you have it now.

As for this code, the cleanest option I see is to make leon_init() and
leon_flush_cache_all() no-ops (or empty macros) when CONFIG_LEON isn't
set. My rationale for this is simple: support for HyperSPARC CPUs adds
some "dead" code on my MicroSPARC / SuperSPARC machines, and yet it
cannot be compiled out, so why should LEON CPUs be treated any
differently?

As for things like new hardware or new bus types, they add little
bulk, so I see no reason to cut them out when CONFIG_LEON isn't set. -
and for all we know, AMBA bus may become the emerging standard for
open source SPARC systems, not just LEON.

Thanks for understanding =3D)

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
