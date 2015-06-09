From: David Miller <davem@davemloft.net>
Date: Tue, 09 Jun 2015 19:02:07 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <20150609.120207.248599655687564710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Y Knight <jyknight@google.com>
Date: Tue, 9 Jun 2015 08:13:58 -0400

> Um, but my test isn't testing what is being stored to memory at
> all. It is storing to memory and **never loading from the memory
> after**. Why would writing FROM fp registers TO memory corrupt the
> *registers* due to a missing memory barrier?

The memory barrier is necessary for two reasons, only one of them is
to handle the asynchronousness of the memory operations.

The other reason is that there are strict rules for accessing the FPU
register file around block loads and stores.

Therefore if you don't do the proper memory barriers you can get
corrupted FPU register as well as memory contents.

And complicating things even more, what you can get away with is
different on every single cpu variant.  That's why I really wish
debian didn't disable multiarch as that makes the code use the
UltraSPARC-I/II/III memcpy, which might not be %100 kosher on
Niagara-T1 and later.

Anyways, please put proper memory barriers into your testcase and
let's see if the problem still triggers.

Thanks.
