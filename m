From: David Miller <davem@davemloft.net>
Date: Sat, 21 Oct 2006 06:35:58 +0000
Subject: Re: Unaligned accesses in compat_sys_msgrcv and sys_msgrcv
Message-Id: <20061020.233558.10299339.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061021041107.GA4629@droopy.oc.cox.net>
In-Reply-To: <20061021041107.GA4629@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 20 Oct 2006 21:11:08 -0700

> p = compat_alloc_user_space(second + sizeof(struct msgbuf));
> 
> at ipc/compat.c:352 does not guarantee alignment of p, so when we 
> later try to ldxa from the address &p->mtype (in get_user) or stxa 
> to &msgp->mtype (in put_user), we catch an exception.
> 
> As I'm not sure what would be the correct fix here, I'd appreciate any 
> advice on how to deal with that.

compat_alloc_user_space() should round down the pointer it returns
to be 8-byte aligned.

Thanks for catching this, I'll cook up a patch over the weekend.

What application is calling sys_msgrev() during a compile btw?
