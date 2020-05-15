From: "Karstens, Nate" <Nate.Karstens@garmin.com>
Date: Fri, 15 May 2020 16:26:28 +0000
Subject: RE: [PATCH v2] Implement close-on-fork
Message-Id: <954ef5ce2e47472f8b41300bf59209c5@garmin.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200515152321.9280-1-nate.karstens@garmin.com>
 <20200515160342.GE23230@ZenIV.linux.org.uk>
In-Reply-To: <20200515160342.GE23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, David Laight <David.Laight@aculab.com>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kerne>

Al,

The reference to the POSIX change was included more for a reference to that discussion, not to say "POSIX did this and so Linux must do it to". In any case, the documentation presented to the Austin Group was focused more around the issue we ran into and some alternative solutions. In reviewing the notes from the meeting I didn't get the impression that they added this to POSIX simply because Solaris and *BSD already had it (reference https://austingroupbugs.net/view.php?id=1317, the first solution we suggested).

> It penalizes every call of fork() in the system

Is the performance hit really that drastic? fork() does a lot of stuff and this really seems like a drop in the bucket...

> adds an extra dirtied cacheline on each socket()/open()/etc.

It sounds like we can work to improve that, though.

> already has a portable solution

What is the solution?

Thanks,

Nate

-----Original Message-----
From: Al Viro <viro@ftp.linux.org.uk> On Behalf Of Al Viro
Sent: Friday, May 15, 2020 11:04
To: Karstens, Nate <Nate.Karstens@garmin.com>
Cc: Jeff Layton <jlayton@kernel.org>; J. Bruce Fields <bfields@fieldses.org>; Arnd Bergmann <arnd@arndb.de>; Richard Henderson <rth@twiddle.net>; Ivan Kokshaysky <ink@jurassic.park.msu.ru>; Matt Turner <mattst88@gmail.com>; James E.J. Bottomley <James.Bottomley@hansenpartnership.com>; Helge Deller <deller@gmx.de>; David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Eric Dumazet <edumazet@google.com>; David Laight <David.Laight@aculab.com>; linux-fsdevel@vger.kernel.org; linux-arch@vger.kernel.org; linux-alpha@vger.kernel.org; linux-parisc@vger.kernel.org; sparclinux@vger.kernel.org; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH v2] Implement close-on-fork

CAUTION - EXTERNAL EMAIL: Do not click any links or open any attachments unless you trust the sender and know the content is safe.


On Fri, May 15, 2020 at 10:23:17AM -0500, Nate Karstens wrote:

> This functionality was approved by the Austin Common Standards
> Revision Group for inclusion in the next revision of the POSIX
> standard (see issue 1318 in the Austin Group Defect Tracker).

It penalizes every call of fork() in the system (as well as adds an extra dirtied cacheline on each socket()/open()/etc.), adds memory footprint and complicates the API.  All of that - to deal with rather uncommon problem that already has a portable solution.

As for the Austin Group, the only authority it has ever had derives from consensus between existing Unices.  "Solaris does it, Linux and *BSD do not" translates into "Austin Group is welcome to take a hike".
BTW, contrary to the lovely bit of misrepresentation in that thread of theirs ("<LWN URL> suggests that" != "someone's comment under LWN article says it _appears_ that"), none of *BSD do it.

IMO it's a bad idea.

NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

________________________________

CONFIDENTIALITY NOTICE: This email and any attachments are for the sole use of the intended recipient(s) and contain information that may be Garmin confidential and/or Garmin legally privileged. If you have received this email in error, please notify the sender by reply email and delete the message. Any disclosure, copying, distribution or use of this communication (including attachments) by someone other than the intended recipient is prohibited. Thank you.
