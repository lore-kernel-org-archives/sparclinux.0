From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Feb 2005 16:02:21 +0000
Subject: Re: framebuffer blanking
Message-Id: <20050215080221.7af4db45.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502151230350.2239@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 15 Feb 2005 12:33:15 +0200 (EET)
Meelis Roos <mroos@linux.ee> wrote:

> I have cg3 and cg6 framebuffers in my SS5. Current snapshot kernel makes 
> both work well for fb console (haven't tried X). There is only one 
> strange thing left - console blanking.
> 
> Both cg3 and cg6 behave the same: when it's blanking time, cursor is 
> turned off but all the text stays. When I press a key to unblank, the 
> cursor appears again and start flashing like usual.

Put some debugging printk()'s into drivers/video/cg3.c:cg3_blank() to
see if it's actually getting called and programming the registers.
