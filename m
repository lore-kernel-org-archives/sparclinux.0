From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 04 Jun 2017 20:26:50 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <d58c5980-c973-a74f-292c-f246680ec246@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
 <20170602.132809.1754806777743128355.davem@davemloft.net>
 <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
 <20170604.162150.706660537991026056.davem@davemloft.net>
In-Reply-To: <20170604.162150.706660537991026056.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On 06/04/2017 10:21 PM, David Miller wrote:
> It's the compiler.  It's not compiling the kernel properly.  What part
> of that do you not understand?  The kernel, if miscompiled itself,
> cannot do anything about it.

How do you know it's the compiler? This has not happened with earlier
versions of the kernel using the same compiler. Again, we're not
using gcc-7.1

> The kernel expects that the compiler is able to compile the kernel
> properly.  Period.

I'm not arguing that.

> I know this might in fact be news to you, but that is a pretty
> fundamental expectation.  And when the compiler has bugs, it will not
> compile the kernel properly and therefore the kernel won't work.

Again, how do you know it's the compiler?

> Therefore the compiler in that situation needs to be fixed, not the
> kernel.  And furthermore, you are dealing wiht an unreleased version
> of gcc which is stil under development, having lots of changes made,
> bugs fixed, etc.  It's a moving target.

The kernel was not compiled with gcc-7.1. I *never* said that. We're
not using Gentoo here, this is Debian. The kernel was compiled with
the current stable gcc-6 version.

> In my point of view if I have to choose between working on bugs
> showing up in the kernel with released versions of gcc, vs unreleased
> versions of gcc, due to time constraints.  I will always put effort
> into released versions of gcc.

I don't understand why you keep bringing this up. I *never* said the
kernel was built with gcc-7.1. It wasn't.

> Why can't you understand this fundamental issue of my having
> constraints like time?  If you don't like this, find some other
> person to fix your bug or even better, do it yourself you have
> access to all of the code just like I or anyone else does.

I don't understand why you're attacking me personally here when
I'm pointing out an important issue with the kernel on SPARC.

You're the person who is most knowledgeable with the code and
the bug seems pretty darn serious. Hence I was reporting it.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
