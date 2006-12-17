From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 17 Dec 2006 11:14:05 +0000
Subject: Re: sparc32 modpost warnings
Message-Id: <20061217111404.GA12314@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0612131133540.10721@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0612131133540.10721@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Meelis,

Some partial answers inline.

On Wed, Dec 13, 2006 at 11:35:47AM +0200, Meelis Roos wrote:
> Tried to compile todays git on sparc32 with custom config. It compiled 
> fine (will test in the evening if I get some time) but emitted this 
> bunch of warnings during modpost. Maybe somebody would like to have a 
> look, I will be busy this week myself.
> 
> WARNING: vmlinux - Section mismatch: reference to .init.text:no_sun4u_here from .text between 'current_pc' (at offset 0x9040) and 'already_mapped'
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .text between 'go_to_highmem' (at offset 0x9280) and 'init_thread_union'
> WARNING: vmlinux - Section mismatch: reference to .init.text: from .text between 'go_to_highmem' (at offset 0x9284) and 'init_thread_union'

I do not plan to fix these, it would require too much shuffling around in
head.S. The first could indicate a real problem AFAIK, but that would only
show if one would boot a sparc32 kernel on a sparc64 machine.

> WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_ksoftirqd from .text between 'init' (at offset 0xc040) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.text:spawn_softlockup_task from .text between 'init' (at offset 0xc048) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.text:sched_init_smp from .text between 'init' (at offset 0xc050) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.text:usermodehelper_init from .text between 'init' (at offset 0xc060) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.text:driver_init from .text between 'init' (at offset 0xc068) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.text:sysctl_init from .text between 'init' (at offset 0xc070) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc088) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc0e8) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:initcall_debug from .text between 'init' (at offset 0xc1a8) and 'rest_init'
> WARNING: vmlinux - Section mismatch: reference to .init.text:prepare_namespace from .text between 'init' (at offset 0xc1e8) and 'rest_init'

See http://article.gmane.org/gmane.linux.ports.sparc/6844
for these. Sadly I never heard back from Sam, and this fix has not been picked
up.

> WARNING: vmlinux - Section mismatch: reference to .init.text:init_idle from .text between 'fork_idle' (at offset 0x2a7bc) and 'mm_alloc'
> WARNING: vmlinux - Section mismatch: reference to .init.data:initkmem_list3 from .text between 'set_up_list3s' (at offset 0x6594c) and 's_stop'
> WARNING: vmlinux - Section mismatch: reference to .init.data:initkmem_list3 from .text between 'set_up_list3s' (at offset 0x65950) and 's_stop'
> WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unitable from .text between 'promcon_init_unimap' (at offset 0xdebcc) and 'promcon_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unitable from .text between 'promcon_init_unimap' (at offset 0xdebd4) and 'promcon_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unicount from .text between 'promcon_init_unimap' (at offset 0xdebdc) and 'promcon_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:promfont_unicount from .text between 'promcon_init_unimap' (at offset 0xdebe4) and 'promcon_init'
> WARNING: vmlinux - Section mismatch: reference to .init.data:logo_sun_clut224 from .text between 'fb_find_logo' (at offset 0xe6790) and 'cfb_fillrect'
> WARNING: vmlinux - Section mismatch: reference to .init.data:logo_sun_clut224 from .text between 'fb_find_logo' (at offset 0xe6798) and 'cfb_fillrect'
> WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_regvals from .text between 'cg3_probe' (at offset 0xe8d9c) and 'cg3_setcolreg'
> WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_regvals from .text between 'cg3_probe' (at offset 0xe8da0) and 'cg3_setcolreg'
> WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_dacvals from .text between 'cg3_probe' (at offset 0xe8dc8) and 'cg3_setcolreg'
> WARNING: vmlinux - Section mismatch: reference to .init.data:cg3_dacvals from .text between 'cg3_probe' (at offset 0xe8dd0) and 'cg3_setcolreg'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_analog from .text between 'bw2_probe' (at offset 0xe9170) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_analog from .text between 'bw2_probe' (at offset 0xe9190) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_ecl from .text between 'bw2_probe' (at offset 0xe9198) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_ecl from .text between 'bw2_probe' (at offset 0xe91a0) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_1600 from .text between 'bw2_probe' (at offset 0xe91c0) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_1600 from .text between 'bw2_probe' (at offset 0xe91c8) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_66hz from .text between 'bw2_probe' (at offset 0xe91dc) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_66hz from .text between 'bw2_probe' (at offset 0xe91e4) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_76hz from .text between 'bw2_probe' (at offset 0xe91e8) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:bw2regs_76hz from .text between 'bw2_probe' (at offset 0xe91f0) and 'cg14_unmap_regs'
> WARNING: vmlinux - Section mismatch: reference to .init.data:__cg14_mmap_map from .text between 'cg14_probe' (at offset 0xe9770) and 'cg14_pan_display'
> WARNING: vmlinux - Section mismatch: reference to .init.data:__cg14_mmap_map from .text between 'cg14_probe' (at offset 0xe9778) and 'cg14_pan_display'

Looks like these come from individual drivers. Will have a look if and when
I find time.

Cheers,
-- 
Martin
---------------------------------------------------------------------------
30 years from now GNU/Linux will be as redundant a term as MERT/UNIX is 
today. - Martin Habets
---------------------------------------------------------------------------
