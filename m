From: Christopher Zimmermann <madroach@zakweb.de>
Date: Wed, 07 Dec 2005 13:56:27 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051207135627.GA767@sparc>
List-Id: <sparclinux.vger.kernel.org>
References: <20051205.181732.34234732.davem@davemloft.net>
In-Reply-To: <20051205.181732.34234732.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 06, 2005 at 03:39:58PM -0800, David S. Miller wrote:
> From: Christopher Zimmermann <madroach@zakweb.de>
> Date: Tue, 6 Dec 2005 16:08:10 +0100
> 
> > I'm not sure, if this is the same problem, but since 2.6.15rc3 my X11 broke
> > too. I'm working on an Ultra2 Creator. This is what my X11 says on 2.6.15rc5:
> > 
> > Call Trace:
> >  [0000000000439de4] copy_process+0x8e4/0xe40
> 
> This was fixed in 2.6.15rc4 and later.

As I said, I tested 2.6.15rc5, too. It performs as badly as rc3.
The symptoms are the same J.H. Aho described. But in contrast to J.H.
Aho I can switch back to a vt. By pressing CTRL+c on the vt I started X
on, I can kill the X server. This is the output I get after pressing
CTRL+c:

waiting for X server to shut down Bad pte = 800001fc00600e88, process = Xorg, vm_flags = 184473, vaddr = 7001e000
Call Trace:
 [000000000046c390] unmap_region+0x90/0x140
 [000000000046cad4] do_munmap+0x174/0x240
 [000000000046cbbc] sys_munmap+0x1c/0x40
 [0000000000406cd4] linux_sparc_syscall32+0x34/0x40
 [00000000003d3ee0] 0x3d3ee0


xinit:  unexpected signal 2.
