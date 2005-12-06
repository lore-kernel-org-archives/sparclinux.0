From: Christopher Zimmermann <madroach@zakweb.de>
Date: Tue, 06 Dec 2005 15:08:10 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051206150810.GA857@sparc>
List-Id: <sparclinux.vger.kernel.org>
References: <20051205.181732.34234732.davem@davemloft.net>
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm not sure, if this is the same problem, but since 2.6.15rc3 my X11 broke
too. I'm working on an Ultra2 Creator. This is what my X11 says on 2.6.15rc5:

Call Trace:
 [0000000000439de4] copy_process+0x8e4/0xe40
 [000000000043a380] do_fork+0x40/0x1e0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3bfc] 0x701d3bfc
Bad pte = 1fc00600a88, process = ???, vm_flags = 184473, vaddr = 7001e000
Call Trace:
 [000000000046bc20] exit_mmap+0x80/0x140
 [0000000000439454] mmput+0x34/0xe0
 [0000000000484e8c] flush_old_exec+0x1cc/0x940
 [0000000000427f2c] load_elf_binary+0x3cc/0x15c0
 [00000000004857d4] search_binary_handler+0x74/0x1a0
 [00000000004a3e78] compat_do_execve+0x118/0x1e0
 [000000000041f71c] sparc32_execve+0x3c/0xc0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3d68] 0x701d3d68
Bad pte = 1fc00600a88, process = Xorg, vm_flags = 184473, vaddr = 7001e000
Call Trace:
 [0000000000439de4] copy_process+0x8e4/0xe40
 [000000000043a380] do_fork+0x40/0x1e0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3bfc] 0x701d3bfc
Bad pte = 1fc00600a88, process = ???, vm_flags = 184473, vaddr = 7001e000
Call Trace:
 [000000000046bc20] exit_mmap+0x80/0x140
 [0000000000439454] mmput+0x34/0xe0
 [0000000000484e8c] flush_old_exec+0x1cc/0x940
 [0000000000427f2c] load_elf_binary+0x3cc/0x15c0
 [00000000004857d4] search_binary_handler+0x74/0x1a0
 [00000000004a3e78] compat_do_execve+0x118/0x1e0
 [000000000041f71c] sparc32_execve+0x3c/0xc0
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000701d3d68] 0x701d3d68

waiting for X server to shut down Bad pte = 800001fc00600e88, process = Xorg, vm_flags = 184473, vaddr = 7001e000
Call Trace:
 [000000000046c390] unmap_region+0x90/0x140
 [000000000046cad4] do_munmap+0x174/0x240
 [000000000046cbbc] sys_munmap+0x1c/0x40
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000003d3ee0] 0x3d3ee0
FreeFontPath: FPE "/usr/lib/X11/fonts/misc" refcount is 2, should be 1; fixing.


On Mon, Dec 05, 2005 at 06:17:32PM -0800, David S. Miller wrote:
> From: "J.O. Aho" <trizt@iname.com>
> Date: Tue, 6 Dec 2005 03:04:11 +0100 (CET)
> 
> > The dmesg entry comes from 2.6.15-rc2, but is kind of the same, expect not 
> > all versions has the ugly and annoying face.
> 
> 1) Lots of problems have been fixed that trigger that bug message,
>    please give 2.6.15-rc5 a spin.
> 
> 2) You didn't give what the failure mode is for kernels such
>    as 2.6.14.2, which should work, and certainly don't print out
>    that bug message
> 
> 3) Finally, this discussion belongs on sparclinux@vger.kernel.org (CC'd),
>    not linux-kernel.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
