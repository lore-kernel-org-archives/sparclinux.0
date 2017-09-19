From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 19 Sep 2017 06:53:50 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <9825dcb1-5016-fce2-f295-ac0eaba84bfb@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/18/2017 06:43 PM, David Miller wrote:
>> Also, since mdesc is basically a tree it maps well to a filesystem
>> structure like sysfs.
> 
> We don't export identical information two different ways in the kernel.

I agree.

> We have /dev/mdesc already.

Is there anything that prevents us from removing it?

> For the other cases, sysfs was done first.  It wasn't duplicating an
> existing mechanism.

I don't think Eric wants to duplicate the mechanism. He rather wants
to move mdesc to sysfs which sounds like a reasonable decision.

As a user, I'd always be looking for system information below /sys,
not in a special device available in /dev/. Not supporting sysfs
for providing hardware information sounds like a step backwards
to me.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
