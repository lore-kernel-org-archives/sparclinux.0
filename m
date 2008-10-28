From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Date: Tue, 28 Oct 2008 04:47:23 +0000
Subject: Re: build failure on sparc64 (Re: linux-next: Tree for October 27)
Message-Id: <20081028043523.GA3113@in.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670810270816x20ea60a7s4fdee99b046a15a4@mail.gmail.com> <a4423d670810270843j55cf1bd9s223aaa447667903e@mail.gmail.com>
In-Reply-To: <a4423d670810270843j55cf1bd9s223aaa447667903e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexander Beregalov <a.beregalov@gmail.com>
Cc: linux-next@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>

On Mon, Oct 27, 2008 at 07:43:24PM +0400, Alexander Beregalov wrote:
> 2008/10/27 Alexander Beregalov <a.beregalov@gmail.com>:
> > init/built-in.o: In function `start_kernel':
> > /home/alexb/linux-2.6/init/main.c:648: undefined reference to `locking_selftest'
> > kernel/built-in.o: In function `init_kprobes':
> > /home/alexb/linux-2.6/kernel/kprobes.c:1106: undefined reference to
> > `init_test_probes'
> >
> 
> Hm, it was strange situation
> 
> `make image` runs oldconfig, after that config was the following:
> CONFIG_KERNEL_TESTS disabled
> CONFIG_DEBUG_LOCKING_API_SELFTESTS=y
> CONFIG_KPROBES_SANITY_TEST=y
> 
> But they both are under "if KERNEL_TESTS" condition in test/Kconfig.
> Strange, I can not reproduce it anymore

No wonder :-) Stephen dropped the tests/ tree pending a decision on its
future.

You should however be able to select and run the tests from under the
'Kernel hacking' menu.

Ananth
