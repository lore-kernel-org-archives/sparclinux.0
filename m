From: Joris van Rantwijk <jorisvr@sron.nl>
Date: Wed, 23 Jan 2013 22:01:28 +0000
Subject: Re: Kernel panic on FPU instruction without FPU present
Message-Id: <20130123230128.6d1cd1a9@bever>
List-Id: <sparclinux.vger.kernel.org>
References: <20130123203325.1e330a9a@bever>
In-Reply-To: <20130123203325.1e330a9a@bever>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2013-01-23, David Miller wrote:
> I don't think we're going to support chips that lack an FPU,
> sorry.

Ok, fair enough.
The kernel has explicit support for the LEON3 in several places, and I
automatically assumed that it would aim to support all possible
configurations. But I guess it makes sense to draw the line somewhere,
especially if all other SPARC variants have built-in FPUs.

> You can't even run the simplest things like the python interpreter
> without FPU support, the first thing it does during initialization
> is do a floating point square root.

You can of course still run such things as long as all of userland is
compiled with a toolchain that emulates floating point on compiler
level (i.e. GCC --with-float=soft). This is a fairly normal way to
build software for LEON3.

Thanks, Joris.
