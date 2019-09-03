From: Matt Turner <mattst88@gmail.com>
Date: Tue, 03 Sep 2019 05:02:43 +0000
Subject: [bisected] semctl/shmctl/msgctl broken on sparc64
Message-Id: <CAEdQ38E695mQzoi=cJ2KbqzqHpXjkyBGGj=kLrovZLyM8FybbA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Arnd,

The following commit breaks the semctl/shmctl/msgctl syscalls on
64-bit sparc userland (but not on 32-bit sparc userland)

commit 275f22148e8720e84b180d9e0cdf8abfd69bac5b
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Mon Dec 31 22:22:40 2018 +0100

    ipc: rename old-style shmctl/semctl/msgctl syscalls

The LTP test case semctl01 can quickly reproduce the failure, but I
initially noticed this failure in the Perl test suite. Looks like the
syscalls always return EINVAL now. Funny, the commit doesn't even
touch arch/sparc :)

arch/sparc/include/uapi/asm/unistd.h
    Defines __32bit_syscall_numbers__ if __arch64__

arch/sparc/include/asm/unistd.h
    Includes arch/sparc/include/uapi/asm/unistd.h
    Defines __ARCH_WANT_SYS_IPC if __32bit_syscall_numbers__

ipc/syscall.c
    Looks like it defines different paths for __ARCH_WANT_SYS_IPC vs not

I get lost at this point, but I'm guessing that's where the difference
between 32-bit and 64-bit comes from.

Any ideas? I'm happy to test patches.

Thanks,
Matt
