From: David Miller <davem@redhat.com>
Date: Thu, 16 Oct 2014 20:07:42 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141016.160742.1639247937393238792.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410150012001.11850@adalberg.ut.ee>
	<20141014.173246.921084057467310731.davem@davemloft.net>
	<alpine.LRH.2.11.1410160956090.13273@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410160956090.13273@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Thu, 16 Oct 2014 10:02:57 +0300 (EEST)

> scripts/Makefile.build:352: recipe for target 'sound/modules.order' failed
> make[1]: *** [sound/modules.order] Bus error
> make[1]: *** Deleting file 'sound/modules.order'
> Makefile:929: recipe for target 'sound' failed

I just reproduced this on my Sun Blade 2500, so it can trigger on UltraSPARC-IIIi
systems too.
