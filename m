From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 15 Jun 2007 16:49:07 +0000
Subject: Re: [PATCH] Fix build errors with strict MM checking
Message-Id: <20070615164907.GA17305@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20070612231600.GA8953@palantir8>
In-Reply-To: <20070612231600.GA8953@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jun 15, 2007 at 02:11:49AM -0700, William Lee Irwin III wrote:
> On Thu, Jun 14, 2007 at 08:19:12PM +0100, Martin Habets wrote:
> > I understand it slows down things a lot. Do you mean it has no
> > run-time value when debugging suspected MM problems? I do get
> > different output: unhandled paging request with strict MM checking
> > versus a DMA error without.
> > Now for the new patch attempt:
> > Turning on STRICT_MM_TYPECHECKS in include/asm/page.h causes some
> > build errors for sparc32. This patch against 2.6.21 fixes these.
> 
> Unhandled paging request vs. DMA errors? This sounds ominous. What
> CPU type?

This is a supersparc UP machine. It only happens if I use an SMP kernel,
and only on one machine out of 6 SS10/SS20 UP/SMP boxes.
The special thing about this machine is that is has 320MB memory, versus
128MB or less on the others. And it has 2 disks, but one other box has
2 disks as well.

I got 2 ross CPUs yesterday. With those no problem so far. Guess I'll
ignore it for now, maybe stress testing will make it pop up again on
one of the supersparcs.
Still, I would like to learn a debugging aproach if/when that time
comes, the oops is below (sorry Dave).
In general I'm very content with the SMP performance on 2.6.21.

-- 
Martin

esp: esp0, regs[fd025000:fd00f000] irq[36]
esp: esp0, regs[fd025000:fd00f000] irq[36]
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
esp: esp0 is a FAS100A, 40 MHz (ccf=0), SCSI ID 7
scsi0 : esp
scsi0 : esp
do_sparc_fault: pgd:1
do_sparc_fault: pgd:1
do_sparc_fault: pmd:1 pmd_k:1
do_sparc_fault: pmd:1 pmd_k:1
Unable to handle kernel paging request at virtual address fff0d000
Unable to handle kernel paging request at virtual address fff0d000
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
tsk->{mm,active_mm}->pgd = fc000000
              \|/ ____ \|/
              \|/ ____ \|/
              "@'/ ,. \`@"
              "@'/ ,. \`@"
              /_| \__/ |_\
              /_| \__/ |_\
                 \__U_/
                 \__U_/
swapper(1): Oops [#1]
swapper(1): Oops [#1]
PSR: 40400fc6 PC: f0122710 NPC: f0122714 Y: 00000000    Not tainted
PSR: 40400fc6 PC: f0122710 NPC: f0122714 Y: 00000000    Not tainted
PC: <esp_maybe_execute_command+0x32c/0x63c>
PC: <esp_maybe_execute_command+0x32c/0x63c>
%G: 00000000 ffffff80  00000000 00000001  00000006 f000f000  f0afe000 07ffff00
%G: 00000000 ffffff80  00000000 00000001  00000006 f000f000  f0afe000 07ffff00
%O: fbc75af0 fbc5d7a0  00000001 00000002  f00f31f0 fbc75b08  f0aff540 f0122610
%O: fbc75af0 fbc5d7a0  00000001 00000002  f00f31f0 fbc75b08  f0aff540 f0122610
RPC: <esp_maybe_execute_command+0x22c/0x63c>
RPC: <esp_maybe_execute_command+0x22c/0x63c>
%L: f0b3da00 fff0d000  fbc76cc0 fbc75b38  00000000 00000000  fbc75000 fbc68690
%L: f0b3da00 fff0d000  fbc76cc0 fbc75b38  00000000 00000000  fbc75000 fbc68690
%I: fbc75af0 fbc5d7a0  00000010 fbc71ba0  12000000 00000000  f0aff5a8 f0122c10
%I: fbc75af0 fbc5d7a0  00000010 fbc71ba0  12000000 00000000  f0aff5a8 f0122c10
Caller[f0122c10]Caller[f0122c10]: esp_queuecommand+0x80/0xc8
: esp_queuecommand+0x80/0xc8
Caller[f01135fc]Caller[f01135fc]: scsi_dispatch_cmd+0x19c/0x2b0
: scsi_dispatch_cmd+0x19c/0x2b0
Caller[f0119374]Caller[f0119374]: scsi_request_fn+0x214/0x394
: scsi_request_fn+0x214/0x394
Caller[f00e1958]Caller[f00e1958]: __generic_unplug_device+0x34/0x40
: __generic_unplug_device+0x34/0x40
Caller[f00e2868]Caller[f00e2868]: blk_execute_rq_nowait+0x70/0x94
: blk_execute_rq_nowait+0x70/0x94
Caller[f00e28f0]Caller[f00e28f0]: blk_execute_rq+0x64/0x9c
: blk_execute_rq+0x64/0x9c
Caller[f0117ce0]Caller[f0117ce0]: scsi_execute+0xc4/0xd8
: scsi_execute+0xc4/0xd8
Caller[f0117d50]Caller[f0117d50]: scsi_execute_req+0x5c/0x90
: scsi_execute_req+0x5c/0x90
Caller[f011aaa0]Caller[f011aaa0]: scsi_probe_and_add_lun+0x18c/0x9c4
: scsi_probe_and_add_lun+0x18c/0x9c4
Caller[f011b5b8]Caller[f011b5b8]: __scsi_scan_target+0xb0/0x5e4
: __scsi_scan_target+0xb0/0x5e4
