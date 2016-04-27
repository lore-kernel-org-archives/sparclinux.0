From: Rob Gardner <rob.gardner@oracle.com>
Date: Wed, 27 Apr 2016 19:46:46 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <57211726.2070900@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 04/27/2016 01:36 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 27 Apr 2016 15:33:55 -0400 (EDT)
>
>> Therefore some other aspect of the change is causing problems and I
>> think that aspect is the size of the new code.
> Actually, there is a way to prove that this is indeed the bug, Meelis
> what does the entry for "swapper_tsb" say in your System.map file for
> a failing kernel?
>
> If it is not "0000000000408000", then that shows the bug.
>


I've run into this situation, and the assembler emits a warning that 
looks like this:

arch/sparc/kernel/head_64.S:869: Warning: .space or .fill with negative 
value, ignored

I've worked around it by moving some of the includes to after the ttable 
include. I think this is ok as long as code doesn't get situated too far 
away for the branch displacement to handle.

Rob Gardner

