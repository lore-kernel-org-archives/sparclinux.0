From: Meelis Roos <mroos@linux.ee>
Date: Tue, 22 Mar 2005 08:40:12 +0000
Subject: sparc32 kernel panic on modprobe sg
Message-Id: <Pine.SOC.4.61.0503221036540.29185@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is 2.6.12-rc1 on a SparcStation 20, 1 SCSI disk installed. SCSI 
generic is compiled modular and when I do "modprobe sg" I get this 
panic. It seems similar to the sunbmac panic because it has to do with 
softirq's but it may be a coincidence.

Seems it happened while syslogd tried to write something to the tty?

Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 0
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 000003cc
tsk->{mm,active_mm}->pgd = fc01d400
               \|/ ____ \|/
               "@'/ ,. \`@"
               /_| \__/ |_\
                  \__U_/
syslogd(684): Oops [#1]
PSR: 400000c4 PC: f00df4d0 NPC: f00df4d4 Y: 00000000    Not tainted
PC: <tty_wakeup+0x4/0x64>
%G: 00000000 f0034afc  00000001 404000a6  f0034aa0 00000000  fbf90000 00000001
%O: ffffffff 00000000  00000000 fbf9df38  50019778 00000314  fbf91db0 f00116dc
RPC: <__udelay+0x1c/0x24>
%L: f01a13a4 404000e5  f01a1378 00000080  00000001 00000001  fbf9c000 50028660
%I: 00000000 00049000  00000000 00000000  00014070 0000000a  fbf91e18 f0034afc
Caller[f0034afc]: tasklet_action+0x6c/0xb8
Caller[f00347b0]: __do_softirq+0xa0/0xc4
Caller[f0034814]: do_softirq+0x40/0x54
Caller[f00108e8]: patch_handler_irq+0x0/0x24
Caller[00011aec]: 0x11aec
Instruction DUMP: 81c3e008  90023fe7  9de3bf98 <c20620b8> 80886020  12800006  b
Kernel panic - not syncing: Aiee, killing interrupt handler!

-- 
Meelis Roos (mroos@linux.ee)
