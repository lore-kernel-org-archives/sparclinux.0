From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 05 Nov 2005 23:56:54 +0000
Subject: Re: sparc64 errors
Message-Id: <20051105.155654.77195500.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Sun, 30 Oct 2005 09:12:01 -0600

> For the purpose of documentation, I'm posting the errors that I'm seeing
> with buildcheck under 2.6 sparc64. I have no idea if these are false
> positives or not.

They nearly all are, but I've quieted a few of them nonetheless in my
tree.

For example, in the arch/sparc64/kernel/time.c case we set the
timer_ops to a "dummy" version that just returns zero in case a super
early call to sched_clock() or similar occurs.  But we always reset
that pointer to the correct ops vector long before the init stuff gets
freed up.

The buildcheck scripts are very simple and have no way to know that it
truly isn't referenced improperly.  They just grep for .data section
references to .init et al. areas.
