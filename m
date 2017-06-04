From: David Miller <davem@davemloft.net>
Date: Sun, 04 Jun 2017 20:21:50 +0000
Subject: Re: sparc gcc 7.1 compile issue
Message-Id: <20170604.162150.706660537991026056.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1f8e2488-d051-7688-2d40-089f4acab6ce@physik.fu-berlin.de>
        <20170602.132809.1754806777743128355.davem@davemloft.net>
        <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
In-Reply-To: <a2f74c42-5a3a-23ec-b8f9-7694f606b714@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: glaubitz@physik.fu-berlin.de
Cc: wbx@openadk.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sun, 4 Jun 2017 15:16:33 +0200

> On 06/02/2017 07:28 PM, David Miller wrote:
>>> Isn't a bug in the kernel if an application is able to crash to the point
>>> that the machine has to be hard-rebooted?
>> 
>> It can be a bug in the compiler too and not necessarily the kernel's
>> fault which is what I think is happening in your case.
> 
> So, in your point of view it's perfectly fine if an application is able
> to crash the whole kernel with just user privileges?

It isn't, this is about cause, not result.

Also, it's about developer time constraints.

> Shouldn't the kernel be able to cope with that?

It's the compiler.  It's not compiling the kernel properly.  What part
of that do you not understand?  The kernel, if miscompiled itself,
cannot do anything about it.

The kernel expects that the compiler is able to compile the kernel
properly.  Period.

I know this might in fact be news to you, but that is a pretty
fundamental expectation.  And when the compiler has bugs, it will not
compile the kernel properly and therefore the kernel won't work.

That kernel cannot "cope" with that, generally speaking.

Therefore the compiler in that situation needs to be fixed, not the
kernel.  And furthermore, you are dealing wiht an unreleased version
of gcc which is stil under development, having lots of changes made,
bugs fixed, etc.  It's a moving target.

But actually, that's not the main issue.

In my point of view if I have to choose between working on bugs
showing up in the kernel with released versions of gcc, vs unreleased
versions of gcc, due to time constraints.  I will always put effort
into released versions of gcc.

Why can't you understand this fundamental issue of my having
constraints like time?  If you don't like this, find some other
person to fix your bug or even better, do it yourself you have
access to all of the code just like I or anyone else does.
