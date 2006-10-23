From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 23 Oct 2006 16:52:00 +0000
Subject: Re: Unaligned accesses in compat_sys_msgrcv and sys_msgrcv
Message-Id: <20061023165200.GA3325@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061021041107.GA4629@droopy.oc.cox.net>
In-Reply-To: <20061021041107.GA4629@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Oct 22, 2006 at 09:54:19PM -0700, David Miller wrote:
> From: Jurij Smakov <jurij@wooyd.org>
> Date: Fri, 20 Oct 2006 21:11:08 -0700
> 
> > p = compat_alloc_user_space(second + sizeof(struct msgbuf));
> 
> Thanks again for this report Jurij, this patch should fix it up.
> 
> commit a94b1d1fd7ca3129e1d38d38167779fa6ee69780
> Author: David S. Miller <davem@sunset.davemloft.net>
> Date:   Sun Oct 22 21:53:30 2006 -0700

Thanks, that took care of the unaligned accesses nicely.

It turned out that the source of these messages was fakeroot - a 
Debian utility which wraps a few system calls to create an illusion 
that the process is running with root privileges. It is commonly used 
during package builds and uses IPC to communicate with the daemon 
which tracks the (fake) information about file ownership and 
permissions.

Best regards, 
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
