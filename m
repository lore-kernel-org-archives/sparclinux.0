From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Wed, 20 Nov 2019 22:49:19 +0000
Subject: Re: [Y2038] [PATCH 08/23] y2038: ipc: remove __kernel_time_t reference from headers
Message-Id: <dd1a30609f05e800550097080c1d1b27065f91ff.camel@codethink.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20191108210236.1296047-1-arnd@arndb.de>
 <20191108210824.1534248-8-arnd@arndb.de>
In-Reply-To: <20191108210824.1534248-8-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "David S.
 Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Fri, 2019-11-08 at 22:07 +0100, Arnd Bergmann wrote:
[...]
> --- a/arch/x86/include/uapi/asm/sembuf.h
> +++ b/arch/x86/include/uapi/asm/sembuf.h
> @@ -21,9 +21,9 @@ struct semid64_ds {
>  	unsigned long	sem_ctime;	/* last change time */
>  	unsigned long	sem_ctime_high;
>  #else
> -	__kernel_time_t	sem_otime;	/* last semop time */
> +	long		sem_otime;	/* last semop time */
>  	__kernel_ulong_t __unused1;
> -	__kernel_time_t	sem_ctime;	/* last change time */
> +	long		sem_ctime;	/* last change time */
>  	__kernel_ulong_t __unused2;
>  #endif
>  	__kernel_ulong_t sem_nsems;	/* no. of semaphores in array */
[...]

We need to use __kernel_long_t here to do the right thing on x32.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
