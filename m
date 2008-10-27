From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Mon, 27 Oct 2008 15:16:45 +0000
Subject: build failure on sparc64 (Re: linux-next: Tree for October 27)
Message-Id: <a4423d670810270816x20ea60a7s4fdee99b046a15a4@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-next@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

init/built-in.o: In function `start_kernel':
/home/alexb/linux-2.6/init/main.c:648: undefined reference to `locking_selftest'
kernel/built-in.o: In function `init_kprobes':
/home/alexb/linux-2.6/kernel/kprobes.c:1106: undefined reference to
`init_test_probes'
