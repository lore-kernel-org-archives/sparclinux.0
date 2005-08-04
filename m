From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 04 Aug 2005 14:12:26 +0000
Subject: Re: [PATCH] Remove errno declaration in drivers/sbus/char/envctrl.c
Message-Id: <20050804.071226.85381631.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050804134803.GA32109@localhost>
In-Reply-To: <20050804134803.GA32109@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mathieu Chouquet-Stringer <mchouque@free.fr>
Subject: [PATCH] Remove errno declaration in drivers/sbus/char/envctrl.c
Date: Thu, 04 Aug 2005 09:48:03 -0400

> errno is already declarded in linux/errno.h:

Where?  It _is_ defined in linux/unistd.h and the fact that
we're indirectly getting that header file somehow is the
source of the problem.

> Moreover errno isn't used in this file at all so the following patch
> (against latest git tree) just removes it (kernel compiles fine).

It is used implicitly by the system call macros inside
of asm-*/unistd.h, for example in the _syscall?() macros.

And we do call execve() in envctrl.c which expands to one
of those macros (specifically, _syscall3()).

So you patch is not correct.

Probably the best version of the fix would be to include
linux/unistd.h instead of asm/unistd.h, so you might want
to code that up and test it out.
