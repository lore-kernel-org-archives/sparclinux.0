From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 03 Jan 2021 13:10:48 +0000
Subject: Re: [sparc64] running stress-ng and a sparc64 hardware / kernel woes
Message-Id: <ff57237d-1e5b-9171-d320-eef57bc8d7c5@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwARwrMeJZTWLeUtGyjStuz=ze2dwNqov0EyfHkRBM1fw@mail.gmail.com>
In-Reply-To: <CADxRZqwARwrMeJZTWLeUtGyjStuz=ze2dwNqov0EyfHkRBM1fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anatoly Pugachev <matorola@gmail.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>

Hi Anatoly!

On 1/3/21 1:56 PM, Anatoly Pugachev wrote:
> Running a simple stress-ng as a non-privileged (non root) user :
> 
> stress-ng --opcode 1 --timeout 60 --metrics-brief
> 
> will almost always bring the linux kernel to an unusable state,
> starting from "Unable to handle kernel NULL pointer dereference",
> "Bogus kernel PC [0000000000000000] in fault handler", "Kernel
> unaligned access at TPC", "Unable to handle kernel paging request at
> virtual address" and "rcu: INFO: rcu_sched detected stalls on
> CPUs/tasks"...

This looks very similar to the kernel crashes on SPARC that we saw on
the buildds for the GCC testsuite in the past (and other packages).

I wonder whether we can use stress-ng to provoke the kernel crash on
POWER when hosting big-endian VMs with high load on little-endian hosts [1].

Adrian

> [1] https://bugzilla.kernel.org/show_bug.cgi?id 6669

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
