From: Boqun Feng <boqun.feng@gmail.com>
Date: Sat, 29 Jul 2017 01:20:49 +0000
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one else seeing this?
Message-Id: <20170729012049.xyaeiqukhzcvj7mf@tardis>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="j5ye6wdmhn62lpcy"
List-Id: <sparclinux.vger.kernel.org>
References: <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
 <20170728184129.GA24364@linux.vnet.ibm.com>
In-Reply-To: <20170728184129.GA24364@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org


--j5ye6wdmhn62lpcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 11:41:29AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> > On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:
> > > Hi Jonathan,
> > >=20
> > > FWIW, there is wakeup-missing issue in swake_up() and swake_up_all():
> > >=20
> > > 	https://marc.info/?l=3Dlinux-kernel&m=3D149750022019663
> > >=20
> > > and RCU begins to use swait/wake last year, so I thought this could be
> > > relevant.
> > >=20
> > > Could you try the following patch and see if it works? Thanks.
> > >=20
> > > Regards,
> > > Boqun
> > >=20
> > > ------------------>8
> > > Subject: [PATCH] swait: Remove the lockless swait_active() check in
> > >  swake_up*()
> > >=20
> > > Steven Rostedt reported a potential race in RCU core because of
> > > swake_up():
> > >=20
> > >         CPU0                            CPU1
> > >         ----                            ----
> > >                                 __call_rcu_core() {
> > >=20
> > >                                  spin_lock(rnp_root)
> > >                                  need_wake =3D __rcu_start_gp() {
> > >                                   rcu_start_gp_advanced() {
> > >                                    gp_flags =3D FLAG_INIT
> > >                                   }
> > >                                  }
> > >=20
> > >  rcu_gp_kthread() {
> > >    swait_event_interruptible(wq,
> > >         gp_flags & FLAG_INIT) {
> >=20
> > So the idea is that we get the old value of ->gp_flags here, correct?
> >=20

Yes.

> > >    spin_lock(q->lock)
> > >=20
> > >                                 *fetch wq->task_list here! *
> >=20
> > And the above fetch is really part of the swait_active() called out
> > below, right?
> >=20

Right.

> > >    list_add(wq->task_list, q->task_list)
> > >    spin_unlock(q->lock);
> > >=20
> > >    *fetch old value of gp_flags here *
> >=20
> > And here we fetch the old value of ->gp_flags again, this time under
> > the lock, right?
> >=20

Hmm.. a bit different, this time is still lockless but *after* the wait
enqueued itself. We could rely on the spin_lock(q->lock) above to pair
with a spin_unlock() from another lock critical section of accessing
the wait queue(typically from some waker). But in the case Steven came
up, there is an lockless accessing to the wait queue from the waker, so
such a pair doesn't exist, which end up that the waker sees a empty wait
queue and do nothing, while the waiter still observes the old value
after its enqueue and goes to sleep.

> > >                                  spin_unlock(rnp_root)
> > >=20
> > >                                  rcu_gp_kthread_wake() {
> > >                                   swake_up(wq) {
> > >                                    swait_active(wq) {
> > >                                     list_empty(wq->task_list)
> > >=20
> > >                                    } * return false *
> > >=20
> > >   if (condition) * false *
> > >     schedule();
> > >=20
> > > In this case, a wakeup is missed, which could cause the rcu_gp_kthread
> > > waits for a long time.
> > >=20
> > > The reason of this is that we do a lockless swait_active() check in
> > > swake_up(). To fix this, we can either 1) add a smp_mb() in swake_up()
> > > before swait_active() to provide the proper order or 2) simply remove
> > > the swait_active() in swake_up().
> > >=20
> > > The solution 2 not only fixes this problem but also keeps the swait a=
nd
> > > wait API as close as possible, as wake_up() doesn't provide a full
> > > barrier and doesn't do a lockless check of the wait queue either.
> > > Moreover, there are users already using swait_active() to do their qu=
ick
> > > checks for the wait queues, so it make less sense that swake_up() and
> > > swake_up_all() do this on their own.
> > >=20
> > > This patch then removes the lockless swait_active() check in swake_up=
()
> > > and swake_up_all().
> > >=20
> > > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >=20
> > Even though Jonathan's testing indicates that it didn't fix this
> > particular problem:
> >=20
> > Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20
> And while we are at it:
>=20
> Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>=20

Thanks!

Regards,
Boqun

> > > ---
> > >  kernel/sched/swait.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >=20
> > > diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> > > index 3d5610dcce11..2227e183e202 100644
> > > --- a/kernel/sched/swait.c
> > > +++ b/kernel/sched/swait.c
> > > @@ -33,9 +33,6 @@ void swake_up(struct swait_queue_head *q)
> > >  {
> > >  	unsigned long flags;
> > >=20
> > > -	if (!swait_active(q))
> > > -		return;
> > > -
> > >  	raw_spin_lock_irqsave(&q->lock, flags);
> > >  	swake_up_locked(q);
> > >  	raw_spin_unlock_irqrestore(&q->lock, flags);
> > > @@ -51,9 +48,6 @@ void swake_up_all(struct swait_queue_head *q)
> > >  	struct swait_queue *curr;
> > >  	LIST_HEAD(tmp);
> > >=20
> > > -	if (!swait_active(q))
> > > -		return;
> > > -
> > >  	raw_spin_lock_irq(&q->lock);
> > >  	list_splice_init(&q->task_list, &tmp);
> > >  	while (!list_empty(&tmp)) {
> > > --=20
> > > 2.13.0
> > >=20
>=20

--j5ye6wdmhn62lpcy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEj5IosQTPz8XU1wRHSXnow7UH+rgFAll74ssACgkQSXnow7UH
+ri2bgf/dV8v1METg1EwYgTXUOWCc+j4qayywKzlMgK4ncdNL7/xLzcGp/m9HzRo
pRoEuu/B/1a5NcfTeOuO8a/FQ5GXQCjwQYYHYjcm8zkh91MGO9poH+/jvvQr3sEY
jWhoO0NoRNHVhthkAjOA6EGr1dU/KdkZJSPX1IqHVHlCMTrB9cwx6MdU3MwSACOD
XD3Xt5e+/0RNWgFqKjYvk1PWREv9OLjnzEiE3lUqflFXJMkJcu0lZOdl3Tvw366c
2ne6aV0EzCvVKCPPkdC+6fZWCwSDv8OPE5DwIL4ktCUrXqTHUQCDbDveTI6xXUR1
pMKvkzjyF0emUOJrL1kK6/GyWboDHA==
=xN3r
-----END PGP SIGNATURE-----

--j5ye6wdmhn62lpcy--
