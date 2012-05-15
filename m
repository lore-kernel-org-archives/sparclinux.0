From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 15:30:45 +0000
Subject: Re: [PATCH] sparc32: Remove cypress cpu support.
Message-Id: <20120515153045.GB5499@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.010944.1681839607025121917.davem@davemloft.net>
In-Reply-To: <20120515.010944.1681839607025121917.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 15, 2012 at 03:16:34PM +1000, Julian Calaby wrote:
> Hi David,
> 
> On Tue, May 15, 2012 at 3:09 PM, David Miller <davem@davemloft.net> wrote:
> >
> > It's the one aberration in v8, the only cpu that
> > didn't actually have hardware multiply and divide
> > instructions.
> >
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > ---
> >
> > I'm tempted to push this.
> 
> I would be too.
> 
> I was thinking of adding a Kconfig variable for Cypress CPU support
> since it's status first came up and linking this to the CFLAGS so that
> we would only generate v7 code if it's enabled, but I haven't had the
> time.

If we started doing this we would still have to maintain Cypress support.
The whole purpose is to trim down the sparc32 kernel to
the more relevant parts while making the kernel easier to maintain.

	Sam
