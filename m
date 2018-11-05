From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 05 Nov 2018 10:48:43 +0000
Subject: Re: [PATCH v2 3/4] sparc: add system call table generation support
Message-Id: <CAK8P3a0XOzuMxv5wJpd=jhronFJQ=PwCZ58VgxSkL_sSPV+CZQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
 <1541080391-3890-4-git-send-email-firoz.khan@linaro.org> <20181101.133315.47887636039827313.davem@davemloft.net>
In-Reply-To: <20181101.133315.47887636039827313.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: firoz.khan@linaro.org, sparclinux@vger.kernel.org, gregkh@linuxfoundation.org, pombredanne@nexb.com, tglx@linutronix.de, kstewart@linuxfoundation.org, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, deepa.kernel@gmail.com, marcin.juszkiewicz@linaro.org

On 11/1/18, David Miller <davem@davemloft.net> wrote:
> From: Firoz Khan <firoz.khan@linaro.org>
> Date: Thu,  1 Nov 2018 19:23:10 +0530
>
>> +141	common	getpeername		sys_getpeername			sys_nis_syscall
>  ...
>> +150	common	getsockname		sys_getsockname			sys_nis_syscall
>
> The sys_nis_syscall in these two entries is incorrect, see the patch
> below.
>
> One of my worst fears about this change has been realized, that
> instead of helping us find problems, it is so automated to the point
> that it fails to question issues like this.
>
> If sys_nis_syscall for the compat syscall shows up in a situation where the
> native 32-bit syscall does have an entry, that's a BUG and the script
> should
> point this out so that the bug can be fixed.

I see this as a multi-step process. Unfortunately, some architectures have
multiple issues in their system call tables, most importantly the ones that
include system call numbers on some architectures but have had them
removed when the implementation got removed.

The sparc sys_nis_syscall is another such issue: we don't have anything
like that on other architectures, so I think we should either move it to
kernel/sys_ni.c for everyone, or use the normal sys_ni_syscall().

Then there is inconsistency between the set of system calls per architecture,
e.g. some have both socketcall()/ipc() and the individual socket syscalls
from those multiplexors, some only have one of the two sets.
Here, I think we may want to move to the separate system calls on all
architectures and only keep the multiplexors for backwards compatibility.
A future glibc may then remove the support for socketcall() and ipc()
once they require linux-5.x or higher and always have the separate calls.

However, for all of those, I want the /format/ of the tables to be consistent
so we can create the tooling around it to find and fix the issues. The work
that Firoz is doing for now just makes sure that the /contents/ of the tables
don't change at all, which is hard enough to do (the current version gets
it all right afaict, but the previous versions missed some details).

      Arnd
