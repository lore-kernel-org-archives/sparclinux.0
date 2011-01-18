From: Jesper Nilsson <jesper.nilsson@axis.com>
Date: Tue, 18 Jan 2011 09:26:39 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110118092638.GJ9874@axis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110115.211722.39173519.davem@davemloft.net> <20110116.220755.179947617.davem@davemloft.net> <20110117143954.GA17813@pcpool00.mathematik.uni-freiburg.de> <20110117.212444.193701604.davem@davemloft.net>
In-Reply-To: <20110117.212444.193701604.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: "brl+ccmadness@pcpool00.mathematik.uni-freiburg.de" <brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>, "richm@oldelvet.org.uk" <richm@oldelvet.org.uk>, "609371@bugs.debian.org" <609371@bugs.debian.org>, "ben@decadent.org.uk" <ben@decadent.org.uk>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>, "fweisbec@gmail.com" <fweisbec@gmail.com>, "mingo@redhat.com" <mingo@redhat.com>, "jeffm@suse.com" <jeffm@suse.com>

On Tue, Jan 18, 2011 at 06:24:44AM +0100, David Miller wrote:
> From: "Bernhard R. Link" <brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
> Date: Mon, 17 Jan 2011 15:39:54 +0100
> 
> > * David Miller <davem@davemloft.net> [110117 07:07]:
> >> Ugh, and I just noticed that include/linux/klist.h does this fixed
> >> alignment of "4" too, where is this stuff coming from?  It's
> >> wrong on 64-bit, at best.  But I can't see the impetus behind doing
> >> this at all in the first place.
> > 
> > Is that actually misaligned? Unless I still mix things up, that is in the
> > struct thus should be fine (i.e. the "d" case in my example above).
> 
> On CRIS, structs naturally align on a byte-boundary only.
> 
> However, code using klists encodes a binary state in the lowest bit of
> klist pointers.  So this assumes that the structures will be at least
> 2 byte aligned, which will not be true on CRIS.
> 
> We have a lot of other code which uses this trick (encoding 1 or 2
> bits of binary state into the lowest bits of a pointer) so I'm
> surprised this workaround isn't needed elsewhere for CRIS too.

Surprisingly, we haven't found any other place where this is an issue
for CRIS, either the code isn't used on CRIS, or the aligment is
ensured by some other means (kmalloc for example).

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
