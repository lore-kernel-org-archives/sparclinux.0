From: David Miller <davem@davemloft.net>
Date: Tue, 22 Dec 2009 01:42:40 +0000
Subject: Re: Checking for v9v/64v capability
Message-Id: <20091221.174240.71106169.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912220054220.25079@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Tue, 22 Dec 2009 01:06:26 +0100 (CET)

> But how would the package manager (apt-get/yum/zypper) decide whether 
> they are on sun4v or not, without resorting to testing for 
> SPARC-specific hardware itself? That is to say, I think the kernel 
> should hand out this information in some way perhaps. Solaris's uname(2) 
> syscall would directly return sun4[cduv], while Linux just outputs 
> sparc/sparc64.

The kernel sets elf feature flags in the new processes's
stack frame upon execution.

This is how glibc decides which special directories to look
for shared libraries (/lib/v9v, /lib/ultra3, etc.)

RPM could query these flags as well.

Debian does the right thing already FWIW :-)

BTW, did you ever resolve the 64-bit stat() issue?  Was it
a bum build of Fedora's sparc64 glibc?   Also, why are you
building 64-bit binaries?  Just for testing?  For general
use doing 32-bit binaries is much more efficient even on
sparc64 systems.
