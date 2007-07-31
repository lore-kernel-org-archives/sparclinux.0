From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 09:21:52 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070731.022152.39156908.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: gavin duley <gduley@une.edu.au>
Date: Mon, 30 Jul 2007 09:45:12 +0000

> On Mon, Jul 30, 2007 at 02:22:35AM -0700, David Miller <davem@davemloft.net> wrote:
> > From: gavin duley <gduley@une.edu.au>
> > Date: Mon, 30 Jul 2007 09:16:53 +0000
> > 
> > > My Sun box is a Sun Ultra 5 with just one processor: a TI UltraSparc
> > > IIi (Sabre). From memory, it is 333MHz with 2MB cache.
> > 
> > What exactly is your test case that fails?
> 
> The application that hangs on my machine is iceweasel. The machine is 
> running Debian testing:

So I installed debian/testing on my ultra5, and ran iceweasel
both remotely over SSH and locally under gnome desktop,
I could get neither to hang.

Now, my ultra5 has a 270MHZ Ultra-IIi compared to your higher
speed chip, but I'm thinking that the cpu type is a red herring.

I think you guys have something enabled or in use in your
installations that I don't.

Do you happen to be using NIS, or NFS, or something unique like that?
If you have some firewalling enabled, can you retest with it disabled?

Thanks.
