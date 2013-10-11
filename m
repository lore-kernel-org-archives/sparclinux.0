From: David Miller <davem@davemloft.net>
Date: Fri, 11 Oct 2013 21:54:53 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131011.175453.93949625847842706.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Gurudas Pai <gurudas.pai@oracle.com>
Date: Fri, 11 Oct 2013 14:26:52 -0700

> CPU CAPS: [flush,stbar,swap,muldiv,v9,blkinit,n2,mul32]
> CPU CAPS: [div32,v8plus,popc,vis,vis2,ASIBlkInit,fmaf,ima]

Hmmm, lots of capabilities missing I thought would be there.
For example, all the crypto opcodes.

Are they really not there in the T5 chips?  Indeed they don't
show up in the hwcap-list of the cpu MDESC node :-/

