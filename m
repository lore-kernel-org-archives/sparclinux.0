From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 05 Nov 2005 00:36:23 +0000
Subject: Re: possible cg6 fix for pixels repeating at display edge or fading
Message-Id: <20051104.163623.29339177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4363EE58.1090508@mc.net>
In-Reply-To: <4363EE58.1090508@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bob Breuer <breuerr@mc.net>
Date: Sat, 29 Oct 2005 16:49:12 -0500

> Has anyone else using a cg6 seen the color banding or fading and pixels
> on the right side being repeated off to the edges of the monitor?
> 
> I think I've found the cause of the problem.  Contrary to the comment,
> changing the bt->control register affects something other than the
> cursor.  Also, it looks like cg6_bt_init() already sets up the DAC and
> this chunk of the code may be redundant.
> 
> The following patch seems to work for me on a TGX+.  If you are seeing
> problems, can you give this a try and report if it works or not?

That register sets the overlay plane, we should just leave it
alone since as you correctly noted other code inits that register
already.

I'll delete those bogus lines, thanks Bob.
