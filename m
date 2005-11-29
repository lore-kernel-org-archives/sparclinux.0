From: Meelis Roos <mroos@linux.ee>
Date: Tue, 29 Nov 2005 14:05:03 +0000
Subject: Bad pte in exit_mmap, 2.6.15-rc3
Message-Id: <Pine.SOC.4.61.0511291602270.20932@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Testbooted 2.6.15-rc3 on my U5. All services started fine and then it 
started flooding this.

This is just FYI - I will be away from that machine for 3 next days and 
can't test any patches this time.

Bad pte = e00001fe02000f8a, process = ???, vm_flags = 844fb, vaddr = 70402000
Call Trace:
  [00000000004732c4] exit_mmap+0x64/0x160
  [000000000043ffac] mmput+0x2c/0xc0
  [0000000000443d48] do_exit+0x108/0xca0
  [0000000000444938] do_group_exit+0x58/0xa0
  [0000000000407194] linux_sparc_syscall32+0x34/0x40
  [00000000701ce2d0] 0x701ce2d0
Bad pte = e00001fe02000f8a, process = ???, vm_flags = 844fb, vaddr = 70404000
Call Trace:
  [00000000004732c4] exit_mmap+0x64/0x160
  [000000000043ffac] mmput+0x2c/0xc0
  [0000000000443d48] <7>eth0: no IPv6 routers present
do_exit+0x108/0xca0
  [0000000000444938] do_group_exit+0x58/0xa0
  [0000000000407194] linux_sparc_syscall32+0x34/0x40
  [00000000701ce2d0] 0x701ce2d0
Bad pte = e00001fe02000f8a, process = ???, vm_flags = 844fb, vaddr = 70406000
Call Trace:
  [00000000004732c4] exit_mmap+0x64/0x160
  [000000000043ffac] mmput+0x2c/0xc0
  [0000000000443d48] do_exit+0x108/0xca0
  [0000000000444938] do_group_exit+0x58/0xa0
  [0000000000407194] linux_sparc_syscall32+0x34/0x40
  [00000000701ce2d0] 0x701ce2d0
Bad pte = e00001fe02000f8a, process = ???, vm_flags = 844fb, vaddr = 70408000
Call Trace:
  [00000000004732c4] exit_mmap+0x64/0x160
  [000000000043ffac] mmput+0x2c/0xc0
  [0000000000443d48] do_exit+0x108/0xca0
  [0000000000444938] do_group_exit+0x58/0xa0
  [0000000000407194] linux_sparc_syscall32+0x34/0x40
  [00000000701ce2d0] 0x701ce2d0
Bad pte = e00001fe02000f8a, process = ???, vm_flags = 844fb, vaddr = 7040a000
Call Trace:
  [00000000004732c4] exit_mmap+0x64/0x160
  [000000000043ffac] mmput+0x2c/0xc0
  [0000000000443d48] do_exit+0x108/0xca0
  [0000000000444938] do_group_exit+0x58/0xa0
  [0000000000407194] linux_sparc_syscall32+0x34/0x40
  [00000000701ce2d0] 0x701ce2d0
Bad pte = e00001fe02000f8a, process = ???, vm_flags = 844fb, vaddr = 7040c000
Call Trace:
  [00000000004732c4] exit_mmap+0x64/0x160
  [000000000043ffac] mmput+0x2c/0xc0
  [0000000000443d48] do_exit+0x108/0xca0
  [0000000000444938] do_group_exit+0x58/0xa0
  [0000000000407194] linux_sparc_syscall32+0x34/0x40
  [00000000701ce2d0] 0x701ce2d0

-- 
Meelis Roos (mroos@linux.ee)
