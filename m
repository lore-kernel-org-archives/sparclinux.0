From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 20 Jun 2008 21:19:29 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <a4423d670806201419i2f0c0982j69eb423f9ecd239d@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670806190707k7ae6da8cud80a826a1603d941@mail.gmail.com>
	 <a4423d670806190902l48c542e0i6a7380a2d3e7f520@mail.gmail.com>
	 <20080619.190048.193701955.davem@davemloft.net>
In-Reply-To: <20080619.190048.193701955.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

2008/6/20 David Miller <davem@davemloft.net>:
> When you revert that changeset, there is a loop in the backtrace of
> all kernel threads, and therefore lockdep turns itself off when all of
> the stack backtrace slots get consumed by that loop in the backtraces.
>
> After the revert you should see a set of kernel messages like:
>
> BUG: MAX_STACK_TRACE_ENTRIES too low!
> turning off the locking correctness validator.
>
> and that would confirm my theory.

No, I do not have such messages.
Does it mean that we need different explanation?
