From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Wed, 12 May 2004 23:22:54 +0000
Subject: Re: mystery backtrace
Message-Id: <20040512232254.GA24017@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040512220458.GA4624@amarooas.com.au>
In-Reply-To: <20040512220458.GA4624@amarooas.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, May 13, 2004 at 08:04:58AM +1000, Jim Watson wrote:

> this is from openoffice.org 680 on linux sparc
> 
> Any advice would be appreciated, is this valid output of the "list" command
> [1], and what can i do next?
> 
> 0x00000000 in ?? ()
> (gdb) where
> #0  0x00000000 in ?? ()
> (gdb) list
> 1       /build/buildd/glibc-2.3.2.ds1/build-tree/sparc-libc/csu/crti.S: No
> such file or directory.
>         in /build/buildd/glibc-2.3.2.ds1/build-tree/sparc-libc/csu/crti.S

No, the program has for some reason jumped to NULL.  You need a full
backtrace if you can get one.  If not, your registers are trashed as
well, and you'll have to use breakpoints or some other method to catch
it before it happens.  It shows you crti.S because the lowest address
in the binary (closest to the 0x0 shown) is in that standard C runtime.

-- 
Keith M Wesolowski
