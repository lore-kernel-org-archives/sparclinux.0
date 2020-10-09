From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 09 Oct 2020 14:30:35 +0000
Subject: Re: SMP is broken on sparc64 with kernel 4.x/5.x
Message-Id: <37f4b03a-c108-2c76-ea31-e8a31a0fad34@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201009161924.c8f031c079dd852941307870@gmx.de>
In-Reply-To: <20201009161924.c8f031c079dd852941307870@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Wolf!

On 10/9/20 4:19 PM, Wolf Ruediger Spielmann wrote:
> I freshly installed linux on my SUN Ultra 60 /w 2x 450MHz CPUs.
> 
> First I tested kernel 5.8.x and couldn't get SMP to work on both CPUs - just the first CPU will be activated.
> Same results with kernel 4.19.146 .
> Kernel 3.18.140 runs perfectly on both CPUs.
> 
> Might be the problem that the CPUs numbering scheme is not linear:
> CPU1 is #0 and CPU2 is #2 (NOT #1)

It mostly affects older machines, the newer machines such as T5220, T5240 and T5 that
we have in Debian have no issues with the latest kernel versions.

We do have an UltraSPARC IIIi machine that we need to keep at 4.19 as the machine otherwise
becomes unstable.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
