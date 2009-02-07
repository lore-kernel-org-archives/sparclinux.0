From: Meelis Roos <mroos@linux.ee>
Date: Sat, 07 Feb 2009 10:19:34 +0000
Subject: Re: SILO problems
Message-Id: <Pine.SOC.4.64.0902071216070.28855@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <498D413B.2060009@neb.rr.com>
In-Reply-To: <498D413B.2060009@neb.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Boot device: disk  File and args:
> 
> ...and at this point the machine freezes.  It still responds to Stop+A, 
> but any attempts to do "boot disk0", "boot disk:3", "boot disk:c", etc., 
> etc., yield the same result.

I assume you have tried to reinstall silo intio the boot block already?

I can not provide a good answer, but having struggled with similar 
problem once, I suggest backup your filesystem contents, wipe the 
beginning of the disk with dd if=/dez/zero, create an empty partition 
and reinstall. This has solved one silo problem and problems with 
partitioning and installer/parted.

-- 
Meelis Roos (mroos@linux.ee)
