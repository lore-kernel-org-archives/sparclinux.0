From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 13 Nov 2019 21:56:22 +0000
Subject: Re: [PATCH 03/23] y2038: vdso: change timeval to __kernel_old_timeval
Message-Id: <alpine.DEB.2.21.1911132256110.2507@nanos.tec.linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108210824.1534248-3-arnd@arndb.de>
In-Reply-To: <20191108210824.1534248-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Vincent Chen <deanbo422@gmail.com>, y2038@lists.linaro.org, Richard Weinberger <richard@nod.at>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Borislav Petkov <bp@alien8.de>, Greentime Hu <green.hu@gmail.com>, Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

On Fri, 8 Nov 2019, Arnd Bergmann wrote:

> The gettimeofday() function in vdso uses the traditional 'timeval'
> structure layout, which will be incompatible with future versions of
> glibc on 32-bit architectures that use a 64-bit time_t.
> 
> This interface is problematic for y2038, when time_t overflows on 32-bit
> architectures, but the plan so far is that a libc with 64-bit time_t
> will not call into the gettimeofday() vdso helper at all, and only
> have a method for entering clock_gettime().  This means we don't have
> to fix it here, though we probably want to add a new clock_gettime()
> entry point using a 64-bit version of 'struct timespec' at some point.
> 
> Changing the vdso code to use __kernel_old_timeval helps isolate
> this usage from the other ones that still need to be fixed properly,
> and it gets us closer to removing the 'timeval' definition from the
> kernel sources.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
