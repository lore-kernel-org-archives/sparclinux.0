From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 03 Feb 2009 21:26:32 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090203212632.GA5514@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 02, 2009 at 12:50:38PM -0800, David Miller wrote:
> I'm pretty certain it's call_usermodehelper() that's hanging.
> 
> Perhaps something with forking kernel threads or invoking exec
> is failing on sparc64 on your machine for some reason.

Looks like you are right:

> tail console20090203.txt
Doing kobject_set_name()
kset_register()
kset_register: kset_init()
kset_register: kset_add_internal()
kset_register: kobject_uevent()
kobject_uevent_env: [of] fffff8a1fe00c6d8
kobject_uevent_env: Checking uevent_ops->filter
kobject_uevent_env: Allocating and filling env buffer.
kobject_uevent_env: Checking uevent_ops->uevent
kobject_uevent_env: Invoking uevent_helper[/sbin/hotplug]

Please look also at the full console output at
http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/console20090203.txt
as there are some "attempted to send uevent without kset!" and similar messages.

Maybe it's important that this is a two cpu machine (as a similar 6 cpu machine seems to work,
see other report on the list) ?
Thanks.

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
