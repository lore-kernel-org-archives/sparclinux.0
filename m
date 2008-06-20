From: David Miller <davem@davemloft.net>
Date: Fri, 20 Jun 2008 21:21:37 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <20080620.142137.242155859.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670806190902l48c542e0i6a7380a2d3e7f520@mail.gmail.com>
	<20080619.190048.193701955.davem@davemloft.net>
	<a4423d670806201419i2f0c0982j69eb423f9ecd239d@mail.gmail.com>
In-Reply-To: <a4423d670806201419i2f0c0982j69eb423f9ecd239d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Sat, 21 Jun 2008 01:19:29 +0400

> 2008/6/20 David Miller <davem@davemloft.net>:
> > When you revert that changeset, there is a loop in the backtrace of
> > all kernel threads, and therefore lockdep turns itself off when all of
> > the stack backtrace slots get consumed by that loop in the backtraces.
> >
> > After the revert you should see a set of kernel messages like:
> >
> > BUG: MAX_STACK_TRACE_ENTRIES too low!
> > turning off the locking correctness validator.
> >
> > and that would confirm my theory.
> 
> No, I do not have such messages.

When you revert that patch, this is exactly what you should
see.

Make sure to check "dmesg" because they get lost on the screeen
during the time between registering the VC console driver and
the ATY framebuffer registry.
