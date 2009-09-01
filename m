From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 01 Sep 2009 06:51:01 +0000
Subject: Re: [PATCH 1/1] sparc,leon: Sparc-Leon SMP support
Message-Id: <646765f40908312351v3574b542o9e483ec481f26b98@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
In-Reply-To: <1251726441-1032-1-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, Sep 1, 2009 at 16:54, Konrad Eisele<konrad@gaisler.com> wrote:
> Julian Calaby wrote:
>>
>>> =A0struct leon3_irqctrl_regs_map *leon3_irqctrl_regs; /* interrupt
>>> controller base address, initialized by amba_init() */
>>> =A0struct leon3_gptimer_regs_map *leon3_gptimer_regs; /* timer controll=
er
>>> base address, initialized by amba_init() */
>>> =A0struct amba_apb_device leon_percpu_timer_dev[16];
>>> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
>>> index 509b1ff..d55c255 100644
>>> --- a/arch/sparc/mm/srmmu.c
>>> +++ b/arch/sparc/mm/srmmu.c
>>> @@ -2301,7 +2301,8 @@ void __init ld_mmu_srmmu(void)
>>> =A0 =A0 =A0 BTFIXUPSET_CALL(flush_cache_mm, smp_flush_cache_mm,
>>> BTFIXUPCALL_NORM);
>>> =A0 =A0 =A0 BTFIXUPSET_CALL(flush_cache_range, smp_flush_cache_range,
>>> BTFIXUPCALL_NORM);
>>> =A0 =A0 =A0 BTFIXUPSET_CALL(flush_cache_page, smp_flush_cache_page,
>>> BTFIXUPCALL_NORM);
>>> - =A0 =A0 =A0 if (sparc_cpu_model !=3D sun4d) {
>>> + =A0 =A0 =A0 if (sparc_cpu_model !=3D sun4d &&
>>> + =A0 =A0 =A0 =A0 =A0 sparc_cpu_model !=3D sparc_leon) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTFIXUPSET_CALL(flush_tlb_all, smp_flush_tl=
b_all,
>>> BTFIXUPCALL_NORM);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTFIXUPSET_CALL(flush_tlb_mm, smp_flush_tlb=
_mm,
>>> BTFIXUPCALL_NORM);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 BTFIXUPSET_CALL(flush_tlb_range, smp_flush_=
tlb_range,
>>> BTFIXUPCALL_NORM);
>>
>> Again, doesn't seem SMP related.
>
> This is in srmmu.c inside a CONFIG_SMP section:
> #ifdef CONFIG_SMP
> =A0 =A0 =A0 =A0/* El switcheroo... */
> =A0...
>>> + =A0 =A0 =A0 if (sparc_cpu_model !=3D sun4d &&
>>> + =A0 =A0 =A0 =A0 =A0 sparc_cpu_model !=3D sparc_leon) {
> =A0...
> #endif

That's what I get from reading over the patch at work without access
to the actual codebase.

Thanks!

--=20

Julian Calaby

Email: julian.calaby@gmail.com
.Plan: http://sites.google.com/site/juliancalaby/
