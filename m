From: chase rayfield <cusbrar1@gmail.com>
Date: Wed, 28 Jun 2017 16:32:25 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <CACwypyN-+UjAa8_pcCiep8ppTUVarh11Y64dq1vmT7injFUAHA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"and testing on old ultrasparcs seems to be one of the issues."

Testing on old hardware is important... because there are differences
and stuff breaks. I still haven't figured out how to get an X server
going on my Ultra45 for instance... perhaps fbdev but that is
decidedly bleh. It's happily running Gentoo and my Homepage etc in the
meantime...

I can provide access to just about any 32bit hardware except
TurboSparc (working on that ;-) ), an Ultra 1E, 10, U45 and T2000, for
anyone wanting to dork around with that as well.... on a 100/10 link.
I don't have a fancy setup to power cycle them at the moment though I
can easily wire up serial consoles. I could stick a Radeon RX560 in
the U45 if someone wants to try getting mesa + X11 acceleration
working on Sparc64 on that specific hardware at least.

Chase

On Wed, Jun 28, 2017 at 4:56 AM, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, Jun 27, 2017 at 04:21:16PM +0300, Meelis Roos wrote:
>> I have most of my sparclinux testbed in DMZ-s and I can make them
>> available to any developers who want it, along with root access and
>> built in management (if any).
>
> FWIW, we have more modern hardware available to external developers in
> Debian. There is one SPARC-T5 running Debian unstable (sparc64) inside
> an LDOM and a Sun Fire T2000 that are available.
>
> I have already provided access to QEMU upstream, glibc upstream, Free
> Pascal upstream and others that I forgot. The FPC people, for example,
> already made great progress on adding sparc64 support to their
> compiler ;).
>
> So, if anyone needs faster sparc64 hardware running a current version
> of Linux for testing, please let me know.
>
> Adrian
>
> --
>  .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer - glaubitz@debian.org
> `. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
>   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
