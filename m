From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 07 Feb 2020 10:58:05 +0000
Subject: Re: [sparc64] unable to build kernel after bbfceba15f8 / "kdb: Get rid of confusing diag msg from "r
Message-Id: <ba1e277d-511c-9ed6-994c-d096e54c3ab3@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqyB_g3S0OHkNcyDiS8PX-vGwrtH+3Cp-YNJ7SGj3x6bDg@mail.gmail.com>
 <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
In-Reply-To: <CAD=FV=UYbMMr+obKqCvKpfpsJ-T5n6p9cZZsjFwF4kfTKM0Jqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Doug Anderson <dianders@chromium.org>, Anatoly Pugachev <matorola@gmail.com>
Cc: Sparc kernel list <sparclinux@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, Daniel Thompson <daniel.thompson@linaro.org>

Hi Doug!

On 2/4/20 11:13 PM, Doug Anderson wrote:
> Argh.  Sorry about this.  :(  I'm not setup with a sparc compiler, but
> I've simulated your results on arm64 by just commenting out the
> definition of "DBG_MAX_REG_NUM" in "arch/arm64/include/asm/kgdb.h".
At least on Debian and openSUSE, compilers for most kernel architectures
are available as cross-compilers ready for installation. So it might
be a good idea to have a machine running Debian or openSUSE around
for performing these tests.

On Debian, you can just install a SPARC compiler with:

$ apt install gcc-sparc64-linux-gnu

The only target that is currently missing is ia64 but that's on my
TODO list for Debian :).

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
