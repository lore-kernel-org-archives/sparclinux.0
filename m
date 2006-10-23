From: David Miller <davem@davemloft.net>
Date: Mon, 23 Oct 2006 21:01:15 +0000
Subject: Re: Unaligned accesses in compat_sys_msgrcv and sys_msgrcv
Message-Id: <20061023.140115.45513727.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061021041107.GA4629@droopy.oc.cox.net>
In-Reply-To: <20061021041107.GA4629@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 23 Oct 2006 09:52:00 -0700

> It turned out that the source of these messages was fakeroot - a 
> Debian utility which wraps a few system calls to create an illusion 
> that the process is running with root privileges. It is commonly used 
> during package builds and uses IPC to communicate with the daemon 
> which tracks the (fake) information about file ownership and 
> permissions.

Thanks Jurij, I knew about fakeroot but not that it used
sysv IPC :-)
