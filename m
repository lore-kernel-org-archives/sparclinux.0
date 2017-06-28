From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 28 Jun 2017 08:56:30 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <20170628085540.GB25072@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 27, 2017 at 04:21:16PM +0300, Meelis Roos wrote:
> I have most of my sparclinux testbed in DMZ-s and I can make them 
> available to any developers who want it, along with root access and 
> built in management (if any).

FWIW, we have more modern hardware available to external developers in
Debian. There is one SPARC-T5 running Debian unstable (sparc64) inside
an LDOM and a Sun Fire T2000 that are available.

I have already provided access to QEMU upstream, glibc upstream, Free
Pascal upstream and others that I forgot. The FPC people, for example,
already made great progress on adding sparc64 support to their
compiler ;).

So, if anyone needs faster sparc64 hardware running a current version
of Linux for testing, please let me know.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
