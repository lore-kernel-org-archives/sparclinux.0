From: Meelis Roos <mroos@linux.ee>
Date: Fri, 30 Jan 2004 18:20:22 +0000
Subject: Re: SILO 1.4.2 released
Message-Id: <Pine.GSO.4.44.0401302002460.2307-100000@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <20040129182954.GK532@phunnypharm.org>
In-Reply-To: <20040129182954.GK532@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Actually I uploaded 1.4.0, 1.4.1, 1.4.2 and 1.4.3 all yesterday. So
> there's no way possible you had 1.4.1...maybe it was 1.3.1 :)

Hmm, not sure. I only remember exactly that I did update yesterday or
the day before and it upgraded lilo.

> Ok, next time you can, when you get the problem, type ".registers" at
> the ok prompt, and send me the output please? Also do:

Hand copied because I have my serial gender changer is use - so free
format (hopefully no typos):

%g0	0
%g1	2a3c00
%g2	ffefa398
%g3	20
%g4	2a5000
%g5	0
%g6	0
%g7	ffffffff
PC	286748
nPC	28674c
Y	1c00000
PSR	4801fe6
WIM	80
TBR	ffeff090

> ok> cd /memory
> ok> .properties

.attributes actually - OBP 2.29 here.

reg		00000000	00000000	02000000
		00000000	02000000	02000000
		00000000	04000000	02000000
		00000000	06000000	02000000
		00000000	08000000	02000000
		00000000	0a000000	02000000
		00000000	0c000000	02000000
		00000000	0e000000	02000000

available	00000000	00000000	0ffa1000

name		memory

> ok> cd /virtual-memory
> ok> .properties

available	00000000	fff00000	00100000
		00000000	fef00000	00e00000
		00000000	00000000	fe400000
		00000000	ffed3000	00010000
		00000000	ffe15000	000b8000
		00000000	ffd00000	00008000
		00000000	fe400000	00a00000
reg		00000000	00000000	80000000
		00000000	80000000	80000000
name		virtual-memory

> And also send me the output of "dump-itlb".

dump-itlb ?
(what's the corresponding word in older obp?)

-- 
Meelis Roos (mroos@linux.ee)

