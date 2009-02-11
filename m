From: David Miller <davem@davemloft.net>
Date: Wed, 11 Feb 2009 21:58:52 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090211.135852.122126133.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Wed, 11 Feb 2009 22:25:04 +0100

> On Mon, Feb 09, 2009 at 11:21:01PM +0100, Hermann Lauer wrote:
> > 
> > Unfortunately the patch applied to 2.6.27.13 didn't change anything, 
> > still hanging - see below. Full output is available at the web.
> > 
> > Adding memQ2k hung also with a 2.6.28 series kernel. Any further ideas ?
> > 
> > Doing kobject_set_name()
> > kset_register()
> > kset_register: kset_init()
> > kset_register: kset_add_internal()
> > kset_register: kobject_uevent()
> > kobject_uevent_env: [of] fffff8a1fe00c6d8
> > kobject_uevent_env: Checking uevent_ops->filter
> > kobject_uevent_env: Allocating and filling env buffer.
> > kobject_uevent_env: Checking uevent_ops->uevent
> > kobject_uevent_env: Invoking uevent_helper[/sbin/hotplug]
> 
> Tried today "# CONFIG_CGROUPS is not set" which mentioned David
> some time ago, but still the same hang.

Yes, I didn't expect that to help.

I'm real busy but will get back to you with some new debugging
patches hopefully in the next few days.
