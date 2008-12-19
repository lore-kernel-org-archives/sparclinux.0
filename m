From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2008 02:59:57 +0000
Subject: Re: replace incorrect memcpy_user_stub code
Message-Id: <20081218.185957.65032255.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812190208.mBJ28vn13713@elf.torek.net>
In-Reply-To: <200812190208.mBJ28vn13713@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 18 Dec 2008 19:08:57 -0700

> I'll send this formatted against the old kernel, not sparc-next
> (did get the latter all cloned up, but have not yet started working
> with it).
> 
> This came up in testing kgdb, using the built-in tests -- turn
> on CONFIG_KGDB_TESTS, then
> 
>     echo V1 > /sys/module/kgdbts/parameters/kgdbts
> 
> -- but it would affect using kgdb if you were debugging and looking
> at bad pointers.
> 
> You will probably want to tweak it anyway (especially the comment
> in the .S file: I thought use of KERNEL_DS was more rare than it
> is, though it probably *should* be more rare than it is...).

This is going to perform really bad, and it's common for
syscalls invoked by the kernel to trigger this case.

I'll have to think about this, thanks for pointing out the
issue.
