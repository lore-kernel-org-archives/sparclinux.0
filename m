From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 05 Sep 2019 15:25:13 +0000
Subject: Re: [bisected] semctl/shmctl/msgctl broken on sparc64
Message-Id: <CAK8P3a1yEnDSPy1P1op2NVpebTkio660NrOQTky6p2fYZOMLuw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAEdQ38E695mQzoi=cJ2KbqzqHpXjkyBGGj=kLrovZLyM8FybbA@mail.gmail.com>
In-Reply-To: <CAEdQ38E695mQzoi=cJ2KbqzqHpXjkyBGGj=kLrovZLyM8FybbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Sep 3, 2019 at 7:02 AM Matt Turner <mattst88@gmail.com> wrote:
>
>
> arch/sparc/include/uapi/asm/unistd.h
>     Defines __32bit_syscall_numbers__ if __arch64__
>
> arch/sparc/include/asm/unistd.h
>     Includes arch/sparc/include/uapi/asm/unistd.h
>     Defines __ARCH_WANT_SYS_IPC if __32bit_syscall_numbers__
>
> ipc/syscall.c
>     Looks like it defines different paths for __ARCH_WANT_SYS_IPC vs not
>
> I get lost at this point, but I'm guessing that's where the difference
> between 32-bit and 64-bit comes from.
>
> Any ideas? I'm happy to test patches.

I found the issue and sent a patch now, see
https://lore.kernel.org/lkml/20190905152155.1392871-2-arnd@arndb.de/

     Arnd
