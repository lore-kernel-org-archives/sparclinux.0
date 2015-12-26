From: David Miller <davem@davemloft.net>
Date: Sat, 26 Dec 2015 04:25:40 +0000
Subject: Re: [PATCH 1/2] sparc64: Ensure perf can access user stacks
Message-Id: <20151225.232540.2173574320038921398.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1450844167-7327-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Thu, 24 Dec 2015 10:39:05 -0700

> Sorry I should have noted this in the log message, but we
> intentionally did not use get_fs() and set_fs() there because they are
> not safe to use in a "nested" interrupt context.  n.b. get_fs() is not
> guaranteed to report a value consistent with %asi while we're
> executing the perf interrupt handler, because it may have interrupted
> kernel code where %asi is inconsistent with the thread_info current_ds
> value. This is common, e.g. right in NGmemcpy.

Is that a real problem?

The return from trap will restore the %asi register properly from
the %tstate register.
