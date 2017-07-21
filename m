From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 21 Jul 2017 23:24:51 +0000
Subject: Re: Reproducer for sparc64 kernel lock-up bug
Message-Id: <e8fd014f-b001-e4c2-506d-17549b8d2d93@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
In-Reply-To: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 07/21/2017 11:37 PM, Pierre Muller wrote:
> But I suspect that the line:
> setup_rt_frame: not implemented
> is more a general limitation of qemu-sparc64...
> muller@gcc21:~/pas/test$ qemu-sparc64 -version
> qemu-sparc64 version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.34), Copyright (c) 2003-2008 Fabrice Bellard
> Is there a newer version out?

There absolutely is. QEMU is one of the few packages where I would always recommend
to use the latest git snapshot. There are constant improvements to the codebase and
especially when comparing against such old versions. QEMU 2.0.0 is *ancient*. We're
heading towards 2.9.0 now.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
