From: "David S. Miller" <davem@redhat.com>
Date: Thu, 18 Mar 2004 23:10:02 +0000
Subject: Re: fix ENOSYS from io_getevents()/NR_SYSCALLS
Message-Id: <20040318151002.4fee5c6b.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040318142225.GA2045@holomorphy.com>
In-Reply-To: <20040318142225.GA2045@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 18 Mar 2004 06:22:25 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> NR_SYSCALLS appears to be off by one, and so aio tests/etc. are failing
> with -ENOSYS. __NR_io_getevents is 272, so the bgeu,pn NR_SYSCALLS etc.
> checks mistakenly punt io_getevents() off to linux_sparc_ni_syscall().
> The following patch gets the aio tests running.

sparc32 needed the same fix too, thanks Will.
