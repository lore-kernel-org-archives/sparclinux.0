From: "C.Newport" <crn@netunix.com>
Date: Fri, 19 Mar 2004 10:52:14 +0000
Subject: Re: Ultrasparc 2 SMP 2.4.26-pre4 fails
Message-Id: <200403191052.14467.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200403180100.54517.crn@netunix.com>
In-Reply-To: <200403180100.54517.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 18 March 2004 10:51 am, C.Newport wrote:
> On Thursday 18 March 2004 2:30 am, David S. Miller wrote:
> > On Thu, 18 Mar 2004 01:00:54 +0000
> >
> > "C.Newport" <crn@netunix.com> wrote:
> > > Am I wasting my time trying to get 2.4.x SMP working ?, checking
> > > back in the list, others seem to have had similar problems but the
> > > fixes seem to refer to 2.6 only.
> >
> > Nope, it should work like a charm.  Boot with "-p" and see if
> > anymore diags get spit out.

Progress :-
I have stripped out all non-esentials from the default config and
SMP now works. Looks like I have a nice time-consuming job of
putting things back until it breaks again.

