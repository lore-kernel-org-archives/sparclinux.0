From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 23 Jan 2013 22:02:41 +0000
Subject: Re: Kernel panic on FPU instruction without FPU present
Message-Id: <CAGRGNgXRimjiaZnh-sFGgddCEaa4=iZP5RjjCp+oV0nFv-ijBw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20130123203325.1e330a9a@bever>
In-Reply-To: <20130123203325.1e330a9a@bever>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

On Thu, Jan 24, 2013 at 7:50 AM, David Miller <davem@davemloft.net> wrote:
>
> I don't think we're going to support chips that lack an FPU,
> sorry.
>
> You can't even run the simplest things like the python interpreter
> without FPU support, the first thing it does during initialization
> is do a floating point square root.

As Joris said, you can compile software to do their floating point
calculations in software - I believe the option is --no-fpu in gcc -
however the entire toolchain needs to be compiled with support for
this.
 - http://gcc.gnu.org/wiki/Software_floating_point
 - http://gcc.gnu.org/onlinedocs/gcc/SPARC-Options.html
 - http://stackoverflow.com/questions/1018638/using-software-floating-point-on-x86-linux

Also, ignoring the massive amount of work this would take, would it be
possible to handle the trap by hooking into the kernel's soft float
implementation instead?

Personally, I don't see any issue with printing a scary message and
killing the task if it tries to do floating point on a system without
it.

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
