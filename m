From: "Art Haas" <ahaas@airmail.net>
Date: Tue, 04 May 2004 16:42:04 +0000
Subject: Re: [PATCH] Small cleanup to kernel/setup.c
Message-Id: <20040504164204.GB14105@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040504132104.GA23807@artsapartment.org>
In-Reply-To: <20040504132104.GA23807@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 04, 2004 at 06:11:44PM +0200, Thomas Nemeth wrote:
> Le 04.05.04, Art Haas a tapot? :
> 
> [ ... snip ... ]
> | I don't like the original because it keeps doing strcmp() tests more
> | times than necessary. That was my motivation in doing changing this bit
> | of code.
> 
> 	Hi.
> 
> 	Why don't you just remove all strcmp's ?
> 	Something like
> if (strlen(&cputypval)=4)
> 	sparc_cpu_model=sun4;
> else if (&cputypval[4]='c')
> 	sparc_cpu_model=sun4c;
> else if (&cputypval[4]='d')
> 	sparc_cpu_model=sun4d;
> ...
> 
> 	Could be better :) But of course, if Sun changes its naming
> 	scheme, it won't work anymore...

The strlen() above won't work because of a trailing space in 'sun4 '
name. Regardless, the maintainers don't think the change is worthwhile,
so I'm not going to pester them about this anymore. This bit of code is
only used once, and for the few extra strcmp() calls it isn't worth
making a fuss. There are other places in the sparc code that developer
time and efforts can be spent, such as getting SMP stuff to work in 2.6,
and once that hurdle is crossed then little micro-optimizations like I'd
proposed in the patch might be worth re-examining.

It would be nice if there were as many people examining the Sparc code
as there are the i386 or PPC code, but that isn't the case.

Art Haas

-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
