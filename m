From: Adrian Bunk <bunk@fs.tum.de>
Date: Sat, 13 Mar 2004 17:34:44 +0000
Subject: modular nfsd requires kernel changes on sh, sparc64, x86_64
Message-Id: <20040313173444.GX14833@fs.tum.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net, davem@redhat.com, sparclinux@vger.kernel.org, ak@suse.de, discuss@x86-64.org, gniibe@m17n.org, kkojima@rr.iij4u.or.jp, linux-sh@m17n.org

Compiling and inserting a module into the currently running kernel 
should work without needing a reboot.

For nfsd this seems to work everywhere except on the sh, sparc64 
and x86_64 architectures where adding the nfsd module changes 
non-modular kernel code (checked in 2.6.4-mm1):


arch/sh/kernel/entry.S:

<--  snip  -->

...
#if !defined(CONFIG_NFSD) && !defined(CONFIG_NFSD_MODULE)
#define sys_nfsservctl          sys_ni_syscall
#endif
...

<--  snip  -->


arch/x86_64/ia32/sys_ia32.c:

<--  snip  -->

...
#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
/* Stuff for NFS server syscalls... */
struct nfsctl_svc32 {
        u16                     svc32_port;
        s32                     svc32_nthreads;
};

struct nfsctl_client32 {
...

<--  snip  -->


arch/sparc64/kernel/sys_sparc32.c:

<--   snip  -->

...
#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
/* Stuff for NFS server syscalls... */
struct nfsctl_svc32 {
        u16                     svc32_port;
        s32                     svc32_nthreads;
};

struct nfsctl_client32 {
...

<--  snip  -->





cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

