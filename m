From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 11 Dec 2017 21:50:40 +0000
Subject: Re: n2_crypto gets a BUG() triggered on T5240
Message-Id: <20171211215040.GA2190@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
In-Reply-To: <nycvar.YFH.7.76.1712110214220.28416@n3.vanv.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Jan.

On Mon, Dec 11, 2017 at 02:14:31AM +0100, Jan Engelhardt wrote:
> 
> 
> With the current Debian sid system (2-3 days old) running the 4.14.2,
> loading the n2_crypto module causes a BUG() to get triggered. The
> system is a T5240 and the problem is reliably repeatable in case I
> should try some suggestions, patches, or if I need to provide more
> information. On a T5120, loading n2_crypto does not lead to this
> issue.

One (not so educated) guess would be to try if:
79db795833bf5c3e798bcd7a5aeeee3fb0505927 "sparc64: Don't clibber fixed registers in __multi4."
will fix this.

4.14.2 have the commit that the above commit fixes.

But using a newer kernel should probarly be first as Davem already suggested.

	Sam
