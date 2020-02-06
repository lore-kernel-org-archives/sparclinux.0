From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Thu, 06 Feb 2020 11:58:26 +0000
Subject: Re: [PATCH] kdb: Fix compiling on architectures w/out DBG_MAX_REG_NUM defined
Message-Id: <20200206115826.oeltu56pp6w5jwvs@holly.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <20200204141219.1.Ief3f3a7edbbd76165901b14813e90381c290786d@changeid>
 <20200205173042.chqij5i53mncfzar@holly.lan>
 <CAD=FV=V6ovmi-zCUYyFdiyf0pG4g=i5N4hUC8JjvrWDRUzPnqQ@mail.gmail.com>
In-Reply-To: <CAD=FV=V6ovmi-zCUYyFdiyf0pG4g=i5N4hUC8JjvrWDRUzPnqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Doug Anderson <dianders@chromium.org>
Cc: Anatoly Pugachev <matorola@gmail.com>, Sparc kernel list <sparclinux@vger.kernel.org>, Jason Wessel <jason.wessel@windriver.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Chuhong Yuan <hslester96@gmail.com>, kgdb-bugreport@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@oracle.com>

On Wed, Feb 05, 2020 at 10:01:17AM -0800, Doug Anderson wrote:
> Hi,
> 
> On Wed, Feb 5, 2020 at 9:30 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Tue, Feb 04, 2020 at 02:12:25PM -0800, Douglas Anderson wrote:
> > > In commit bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd"
> > > if current task has no regs") I tried to clean things up by using "if"
> > > instead of "#ifdef".  Turns out we really need "#ifdef" since not all
> > > architectures define some of the structures that the code is referring
> > > to.
> > >
> > > Let's switch to #ifdef again, but at least avoid using it inside of
> > > the function.
> > >
> > > Fixes: bbfceba15f8d ("kdb: Get rid of confusing diag msg from "rd" if current task has no regs")
> > > Reported-by: Anatoly Pugachev <matorola@gmail.com>
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Thanks for being so quick with this (especially when if I had been less
> > delinquent with linux-next it might have been spotted sooner).
> >
> >
> > > ---
> > > I don't have a sparc64 compiler but I'm pretty sure this should work.
> > > Testing appreciated.
> >
> > I've just add sparc64 into my pre-release testing (although I have had to
> > turn off a bunch of additional compiler warnings in order to do so).
> >
> >
> > >  kernel/debug/kdb/kdb_main.c | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> > > index b22292b649c4..c84e61747267 100644
> > > --- a/kernel/debug/kdb/kdb_main.c
> > > +++ b/kernel/debug/kdb/kdb_main.c
> > > @@ -1833,6 +1833,16 @@ static int kdb_go(int argc, const char **argv)
> > >  /*
> > >   * kdb_rd - This function implements the 'rd' command.
> > >   */
> > > +
> > > +/* Fallback to Linux showregs() if we don't have DBG_MAX_REG_NUM */
> > > +#if DBG_MAX_REG_NUM <= 0
> > > +static int kdb_rd(int argc, const char **argv)
> > > +{
> > > +     if (!kdb_check_regs())
> > > +             kdb_dumpregs(kdb_current_regs);
> > > +     return 0;
> > > +}
> > > +#else
> >
> > The original kdb_rd (and kdb_rm which still exists in this file) place
> > the #if inside the function and users > 0 so the common case was
> > covered at the top and the fallback at the bottom.
> >
> > Why change style when re-introducing this code?
> 
> My opinion is that #if / #ifdef leads to hard-to-follow code, so I
> have always taken the policy that #if / #ifdef don't belong anywhere
> inside a function if it can be avoided.  This seems to be the policy
> in Linux in general, though not as much in the existing kgdb code.
> IMO kgdb should be working to reduce #if / #ifdef inside functions.

I definitely agree that reducing #if and its shortcuts is a good thing.

However I would characterize the dominant pattern as using #if[def]
to replace disabled functionality with an inline nop version. Other
cases are, I think, less clear cut.


> In this case, the duplicated code is 1 line: the call to
> kdb_check_regs().  It seemed better to duplicate.  Another option that
> would avoid the #if / #ifdef in the function would be as follows.
> Happy to change my patch like this if you prefer:

I wasn't really the duplicated code that bothered me.

More that this test of DBG_MAX_REG_NUM is following a different pattern
to all other instances in the code case (for a start all others use a
DBG_MAX_REG_NUM > 0 test and put the fallback code at the bottom).


> ...or if you just want to get something quickly so we have time to
> debate the finer points, I wouldn't object to a simple Revert and I
> can put it on my plate to resubmit the patch later.

There's a degree of bikeshedding in the above (and as we both know this
are larger bits of tidying up that kdb, in particular, could benefit
from) but nevertheless I think a revert is better at this point.

I hope you don't mind but I shall interpret the above paragraph as an
Acked-by: since I'd like the record to show your diligence in jumping
on this!


Daniel.
