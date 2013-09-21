From: Bob Picco <bpicco@meloft.net>
Date: Sat, 21 Sep 2013 18:39:53 +0000
Subject: Re: [PATCH 0/6] Make PAGE_OFFSET variable.
Message-Id: <20130921183953.GC29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130921.011546.399976981566163964.davem@davemloft.net>
In-Reply-To: <20130921.011546.399976981566163964.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Sat Sep 21 2013, 01:58:35PM EDT]
> From: Kirill Tkhai <tkhai@yandex.ru>
> Date: Sat, 21 Sep 2013 19:34:49 +0400
> 
> > Boot tested on Sun Ultra 60 UPA/PCI (2 X UltraSPARC-II 296MHz)
> 
> Thanks a lot, can you tell me what it said early in bootup?
> 
> Specifically this part:
> 
> [    0.000000] PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)
> 
> Thanks again!
This is a T4-1 in CA. I'll push it hard.
[    0.000000] PAGE_OFFSET is 0xffff800000000000 (max_phys_bits = 47)

Locally I try not to wear noise suppressing head phones on Saturdays for
my T4-2 :) I will review the patches again by tomorrow. They look good so far!

thanx,

bob
