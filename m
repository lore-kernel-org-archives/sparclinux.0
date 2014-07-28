From: David Miller <davem@davemloft.net>
Date: Mon, 28 Jul 2014 23:43:27 +0000
Subject: Re: Segmentation faults and RSS counter errors: Possible hints for cause?
Message-Id: <20140728.164327.1971601844111535625.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271731.00668.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271731.00668.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 27 Jul 2014 17:31:00 +0200

> Note that dumping a stack trace also involves flushing all register windows
> out to the stack, so the fact that we observed the segfault and RSS problem
> only in combination with the instrumentation patch (but not with the patch
> that just prevents invalid entries to be inserted into the TSB, with no further
> actions) could also point in this direction.

User register windows should be fully flushed to the stack before we try to
copy the address space, via the "flushw" done in the sys_vfork/sys_fork/sys_clone
assembler paths of arch/sparc/kernel/syscalls.S
