From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 04 Feb 2010 18:24:27 +0000
Subject: Re: [PATCH 0/8] niu parameters and RX flow separation
Message-Id: <cdf300971002041024r52cfd7eai8f70f20a93dedd96@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1265282762-13954-1-git-send-email-chris.torek@windriver.com>
In-Reply-To: <1265282762-13954-1-git-send-email-chris.torek@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

I'm happy to take advice -- I'm really rather new to the patch
process, and also this flow separation code.

As for the work from the google folks ... is there a good search
term or two I can use for this?  I've looked for "rxflow separation"
and mostly find your own patches....

Chris

On Thu, Feb 4, 2010 at 10:28 AM, David Miller <davem@davemloft.net> wrote:
>
> Please these patches CC:'d to netdev@vger.kernel.org
>
> There is nothing Sparc specific about the NIU driver and
> even if it were netdev@vger.kernel.org is where even platform
> specific network device patches are posted.
>
> Also, your patches which use module parameters to set
> things in the NIU chip will need to be deleted. =A0Instead
> you should create run-time configuration methods, such
> as new ethtool commands and/or flag bits, to modify these
> settings.
>
> Next, it's even more incredulious that you posted this only
> to the sparc list given that you make changes to the generic
> networking code.
>
> Finally, there are lots of other work, particularly from the google
> folks, to do software flow seperation, which frankly I see no need for
> on a chip like NIU which %100 already does this for you in hardware.
>
> This is a really bad patch submission, sorry.
>
> Thanks.
>
