From: Meelis Roos <mroos@linux.ee>
Date: Thu, 16 Oct 2014 20:16:44 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <alpine.LRH.2.11.1410162313440.19924@adalberg.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410150012001.11850@adalberg.ut.ee> <20141014.173246.921084057467310731.davem@davemloft.net> <alpine.LRH.2.11.1410160956090.13273@adalberg.ut.ee> <20141016.160742.1639247937393238792.davem@redhat.com>
In-Reply-To: <20141016.160742.1639247937393238792.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@redhat.com>
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

> > scripts/Makefile.build:352: recipe for target 'sound/modules.order' failed
> > make[1]: *** [sound/modules.order] Bus error
> > make[1]: *** Deleting file 'sound/modules.order'
> > Makefile:929: recipe for target 'sound' failed
> 
> I just reproduced this on my Sun Blade 2500, so it can trigger on UltraSPARC-IIIi
> systems too.

My bisection led to the folloowing commit but it seems irrelevant (I 
have no sun4v on these machines):

4ccb9272892c33ef1c19a783cfa87103b30c2784 is the first bad commit
commit 4ccb9272892c33ef1c19a783cfa87103b30c2784
Author: bob picco <bpicco@meloft.net>
Date:   Tue Sep 16 09:26:47 2014 -0400

    sparc64: sun4v TLB error power off events


However, the following chunk sound slightly suspicious:

+       if (fault_code & FAULT_CODE_BAD_RA)
+               goto do_sigbus;
+

because SIGNUS is what I got. For some machines, it killed chekroot 
during startup, for some shells under some circumstances, for some sshd.

-- 
Meelis Roos (mroos@linux.ee)
