From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 23:48:35 +0000
Subject: Re: [PATCH 7/9] sparc: use piggyback_32 for sparc64
Message-Id: <20110101234835.GA19089@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
In-Reply-To: <1293915632-4596-7-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jan 02, 2011 at 12:29:17AM +0100, Josip Rodin wrote:
> On Sat, Jan 01, 2011 at 10:00:30PM +0100, Sam Ravnborg wrote:
> > +		for (i = 0; i < LOOKBACK; ++i) {
> > +			if (buffer[i + 0] = 'H' && buffer[i + 1] = 'd' &&
> > +			    buffer[i + 2] = 'r' && buffer[i + 3] = 'S') {
> > +				return offset + i;
> > +			}
> > +		}
> 
> > -	for (q = buffer, r = q + 512; q < r; q += 4) {
> > -		if (*q = 'H' && q[1] = 'd' && q[2] = 'r' && q[3] = 'S')
> > -			break;
> > -	}
> 
> BTW, while the new code is eminently more readable in general, is there
> a reason to slow down that search by using increments of 1 instead of 4?
> Did the old one ever miss?

I used increment by 1 because there was nothing in head_32/_64 comments
that guaranteed that "HdrS" would be on a 4-byte aligned address.
[The actual implmentation guarantees this today].

I had two options:
- use increment by one
- use increment by 4 and explain why it was safe to do so

And I just picked the simpler variant.

So I do not fix any know issue - just playing safe.
And speed does not matter here....

	Sam
