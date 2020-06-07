From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 07 Jun 2020 09:11:33 +0000
Subject: Re: Suspected bug in wait syscall or similar
Message-Id: <741dc1ef-1e4c-f278-9cf7-db17fda31a9d@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1848982.8N1hjUtedq@eto.sf-tec.de>
In-Reply-To: <1848982.8N1hjUtedq@eto.sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Rolf!

On 6/7/20 9:34 AM, Rolf Eike Beer wrote:
> Thanks to the work of the fish maintainer this now looks like it is a bug in 
> either gcc or posix_spawn() or something like that:
> 
> https://github.com/fish-shell/fish-shell/issues/6878#issuecomment-640128661
> 
> A minimal testcase is here:
> 
> https://gist.github.com/ridiculousfish/1b28af43ae2a3a871a5f4aa43a3811f2
> 
> This is not limited to sparc32 userspace, but also affects sparc64.

Has this been reported upstream yet? I would guess this is a glibc problem.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
