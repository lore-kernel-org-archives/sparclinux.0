From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 29 Nov 2017 18:58:21 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <CADxRZqwVZ=ckY3EYvorrcs6gEeX+BNuE7qJNhgjZ+01iT-jwQg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Nov 29, 2017 at 9:48 PM, David Miller <davem@davemloft.net> wrote:
>
> We are initializing free memory, then we end up at a totally unrelated
> piece of code.
>
> Something is causing the cpu to call some random address and we need
> to figure out why.
>
> I've built the current kernel on a SunBlade-2500 with gcc-4.4.5 and I
> couldn't reproduce this crash.

David, using your git sparc kernel tree, bisect log:

mator@ttip:~/sparc$ git remote -v
origin  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git (fetch)
origin  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git (push)

mator@ttip:~/sparc$ git bisect good
46ad8d2d22c17e2b577adec55ae87161666a3267 is the first bad commit
commit 46ad8d2d22c17e2b577adec55ae87161666a3267
Author: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date:   Wed Oct 11 12:50:06 2017 -0600

    sparc64: Use sparc optimized fls and __fls for T4 and above

    For T4 and above, patch fls and __fls functions
    at the boot time to use lzcnt instruction.

    Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

:040000 040000 ce2dbe8d19a2aa2cd1fae96c53d1424c5a381da9
54eb6cc99041f28bbe77b573cd7b2d55b8b0f5eb M      arch

mator@ttip:~/sparc$ git bisect log
git bisect start
# bad: [0c86a6bd85ff0629cd2c5141027fc1c8bb6cde9c] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect bad 0c86a6bd85ff0629cd2c5141027fc1c8bb6cde9c
# good: [39dae59d66acd86d1de24294bd2f343fd5e7a625] Linux 4.14-rc8
git bisect good 39dae59d66acd86d1de24294bd2f343fd5e7a625
# good: [5bbcc0f595fadb4cac0eddc4401035ec0bd95b09] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
git bisect good 5bbcc0f595fadb4cac0eddc4401035ec0bd95b09
# good: [441692aafc1731087bbaf657a8b6059d95c2a6df] Merge branch
'for-linus' of git://git.armlinux.org.uk/~rmk/linux-arm
git bisect good 441692aafc1731087bbaf657a8b6059d95c2a6df
# good: [bec04432cb9036dedf89140c102b5ac03e4b3626] Merge branch 'next'
of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
git bisect good bec04432cb9036dedf89140c102b5ac03e4b3626
# good: [bfe0feb143151cce76411bb211c3eec0f6cff7ba] amdgpu/dc: convert
dc_stream_state to kref.
git bisect good bfe0feb143151cce76411bb211c3eec0f6cff7ba
# good: [2ce079f04d5914dae14fdc8618f804cc0d2a1b8f] Merge tag
'kbuild-misc-v4.15' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
git bisect good 2ce079f04d5914dae14fdc8618f804cc0d2a1b8f
# good: [817002475046737877915d87889a012d851650fa] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net
git bisect good 817002475046737877915d87889a012d851650fa
# bad: [020aae3ee58c1af0e7ffc4e2cc9fe4dc630338cb] ima: do not update
security.ima if appraisal status is not INTEGRITY_PASS
git bisect bad 020aae3ee58c1af0e7ffc4e2cc9fe4dc630338cb
# good: [f2645fa317b8905b8934f06a0601d5b7fa66aba0] platform/x86:
dell-smbios-wmi: introduce userspace interface
git bisect good f2645fa317b8905b8934f06a0601d5b7fa66aba0
# bad: [07c455ee222f3ad219c2835d05a175a326a138fb] Merge tag
'platform-drivers-x86-v4.15-1' of
git://git.infradead.org/linux-platform-drivers-x86
git bisect bad 07c455ee222f3ad219c2835d05a175a326a138fb
# bad: [1deab8ce2c91e3b16563b7a7ea150f82334262ec] Merge
git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc
git bisect bad 1deab8ce2c91e3b16563b7a7ea150f82334262ec
# good: [70cbec0c53739e170ea9c418e740f007ab5bca52] sparc64: SPARC
optimized fls function
git bisect good 70cbec0c53739e170ea9c418e740f007ab5bca52
# bad: [68fa10dce0bfe263000ea3fd147ed74f5a4342c2] sparc/led: Convert
timers to use timer_setup()
git bisect bad 68fa10dce0bfe263000ea3fd147ed74f5a4342c2
# bad: [46ad8d2d22c17e2b577adec55ae87161666a3267] sparc64: Use sparc
optimized fls and __fls for T4 and above
git bisect bad 46ad8d2d22c17e2b577adec55ae87161666a3267
# good: [2b41ce5df20b698436526fcd8478094140b91706] sparc64: SPARC
optimized __fls function
git bisect good 2b41ce5df20b698436526fcd8478094140b91706
# first bad commit: [46ad8d2d22c17e2b577adec55ae87161666a3267]
sparc64: Use sparc optimized fls and __fls for T4 and above

reverting just 46ad8d2d22c17e2b577adec55ae87161666a3267 on upstream
git kernel (git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git)
I was able to boot kernel v4.15-rc1-24-g43570f0383d6 successfully.

So, can we blame 46ad8d2d22c17e2b577adec55ae87161666a3267 and revert it ?

Thanks.
