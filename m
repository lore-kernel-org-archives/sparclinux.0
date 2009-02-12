From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Thu, 12 Feb 2009 15:30:30 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090212153030.GF8613@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Feb 11, 2009 at 03:15:13PM -0800, David Miller wrote:
> From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
> Date: Mon, 9 Feb 2009 23:21:01 +0100
> 
> > kobject_uevent_env: Invoking uevent_helper[/sbin/hotplug]
> > 
> 
> Ok, let's see if it's the fork or the exec attempt which
> dies.  Please reboot the same with the following debugging
> patch added.

Added patches to 2.6.27.15, hang see below (full output
is on the web). Hope this gives you any clues.

Thanks. 

kobject_uevent_env: Checking uevent_ops->filter
kobject_uevent_env: Allocating and filling env buffer.
kobject_uevent_env: Checking uevent_ops->uevent
kobject_uevent_env: Invoking uevent_helper[/sbin/hotplug]
call_usermodehelper_setup: kzalloc()
call_usermodehelper_setup: INIT_WORK and done
call_usermodehelper_exec: helper_lock()
call_usermodehelper_exec: queue_work()
call_usermodehelper_exec: wait_for_completion
__call_usermodehelper: wait=0

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
