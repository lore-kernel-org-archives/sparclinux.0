From: David Miller <davem@davemloft.net>
Date: Wed, 16 Aug 2017 00:51:49 +0000
Subject: Re: [sparc64] kernel OOPS with gcc 7.1 / 7.2
Message-Id: <20170815.175149.980394449365280138.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
In-Reply-To: <CADxRZqw4Qomu0n2k0hC4to-wp9GW8FR_k290sD6HmTXbgmBa0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anthony Yznaga <anthony.yznaga@oracle.com>
Date: Tue, 15 Aug 2017 17:45:12 -0700

> I compiled a kernel with gcc 7 and found that the compiler inserted a
> call to __multi3() in mq_attr_ok().  The sparc64 implementation of
> __multi3() was added by 1b4af13ff2cc specifically for gcc 7 and later,
> but it clobbers %g4 and %g5.  Not sure if that was intended but it
> looks like __multi3() is not safe to call from kernel code.

Good catch, we have to redo the register allocation in that routine
to fix this.
