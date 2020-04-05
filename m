From: Matt Turner <mattst88@gmail.com>
Date: Sun, 05 Apr 2020 20:18:56 +0000
Subject: Re: [PATCH 4/5] second: Fix typo'd operator
Message-Id: <CAEdQ38HQ+tb+ZQ2-7tGQSsuz=6fcKa5++-dMOdhcUs=ZzbBFwQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Apr 5, 2020 at 12:23 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>
> Hi,
>
> On Sun, Apr 05, 2020 at 11:54:50AM -0700, Matt Turner wrote:
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> >  second/disk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/second/disk.c b/second/disk.c
> > index 40234b3..b81a465 100644
> > --- a/second/disk.c
> > +++ b/second/disk.c
> > @@ -293,7 +293,7 @@ int silo_disk_read(char *buff, int size, unsigned long long offset)
> >       if (!net) {
> >           if (prom_vers != PROM_P1275) {
> >                   if (((romvec->pv_printrev >> 16) < 2 ||
> > -                      ((romvec->pv_printrev >> 16) = 2 && (romvec->pv_printrev && 0xffff) < 6))
> > +                      ((romvec->pv_printrev >> 16) = 2 && (romvec->pv_printrev & 0xffff) < 6))
> >                       && offset >= 0x40000000) {
> >                       printf ("Buggy old PROMs don't allow reading past 1GB from start of the disk. Send complaints to SMCC\n");
> >                       return -1;
>
> I think it's worth mentioning in the commit log that this is changing
> the behaviour... After the patch only < 2.6 PROMs will fail (which is
> probably correct), instead of every 2.* like now.

Sure, that's fair.

> BTW, I guess you found this error after a GCC warning, not in real use?

Correct.
