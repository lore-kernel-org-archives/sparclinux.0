From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 21 Nov 2019 14:28:03 +0000
Subject: Re: [Y2038] [PATCH 08/23] y2038: ipc: remove __kernel_time_t reference from headers
Message-Id: <CAK8P3a0VORzqLLTFpt9VYn_SONsve+-q0fTrZrPbLMpX9T6SBQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108210824.1534248-8-arnd@arndb.de>
 <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
In-Reply-To: <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, linux-mips@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor>

On Wed, Nov 20, 2019 at 11:49 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
> [...]
> > --- a/arch/x86/include/uapi/asm/sembuf.h
> > +++ b/arch/x86/include/uapi/asm/sembuf.h
> > @@ -21,9 +21,9 @@ struct semid64_ds {
> >       unsigned long   sem_ctime;      /* last change time */
> >       unsigned long   sem_ctime_high;
> >  #else
> > -     __kernel_time_t sem_otime;      /* last semop time */
> > +     long            sem_otime;      /* last semop time */
> >       __kernel_ulong_t __unused1;
> > -     __kernel_time_t sem_ctime;      /* last change time */
> > +     long            sem_ctime;      /* last change time */
> >       __kernel_ulong_t __unused2;
> >  #endif
> >       __kernel_ulong_t sem_nsems;     /* no. of semaphores in array */
> [...]
>
> We need to use __kernel_long_t here to do the right thing on x32.

Good catch, thanks for the review!

I applied the patch below now on top.

       Arnd

commit c7ebd8a1c1825c3197732ea692cf3dde34a644f5 (HEAD)
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Nov 21 15:25:04 2019 +0100

    y2038: ipc: fix x32 ABI breakage

    The correct type on x32 is 64-bit wide, same as for the other struct
    members around it, so use  __kernel_long_t in place of the original
    __kernel_time_t here, corresponding to the rest of the structure.

    Fixes: caf5e32d4ea7 ("y2038: ipc: remove __kernel_time_t reference
from headers")
    Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/x86/include/uapi/asm/sembuf.h
b/arch/x86/include/uapi/asm/sembuf.h
index 7c1b156695ba..20cab43c4b15 100644
--- a/arch/x86/include/uapi/asm/sembuf.h
+++ b/arch/x86/include/uapi/asm/sembuf.h
@@ -21,9 +21,9 @@ struct semid64_ds {
        unsigned long   sem_ctime;      /* last change time */
        unsigned long   sem_ctime_high;
 #else
-       long            sem_otime;      /* last semop time */
+       __kernel_long_t sem_otime;      /* last semop time */
        __kernel_ulong_t __unused1;
-       long            sem_ctime;      /* last change time */
+       __kenrel_long_t sem_ctime;      /* last change time */
        __kernel_ulong_t __unused2;
 #endif
        __kernel_ulong_t sem_nsems;     /* no. of semaphores in array */
