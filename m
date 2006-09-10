From: David Miller <davem@davemloft.net>
Date: Sun, 10 Sep 2006 13:11:40 +0000
Subject: Re: [Bugme-new] [Bug 7130] New: loading driver eat all CPU and
Message-Id: <20060910.061140.74736819.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200609091032.k89AW7bM017561@fire-2.osdl.org>
	<20060909083631.95a63528.akpm@osdl.org>
	<1157817856.3462.7.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1157817856.3462.7.camel@mulgrave.il.steeleye.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James.Bottomley@SteelEye.com
Cc: akpm@osdl.org, linux-scsi@vger.kernel.org, wizard580@gmail.com, sparclinux@vger.kernel.org, bugme-daemon@bugzilla.kernel.org

From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sat, 09 Sep 2006 11:04:15 -0500

> On Sat, 2006-09-09 at 08:36 -0700, Andrew Morton wrote:
> > Does anyone else us the fcal driver?
> > 
> > I'd suggest the next step would be to run a kernel profile, or just sysrq-P
> > to find out where the CPU is stuck.  Could a sparc person please talk the
> > reporter through that process?
> 
> I'm not sure this is really worth it.  Apart from trying to keep it
> compiling, fcal has had no maintainer since the 2.2 kernel days.  Since
> no-one has the hardware or the inclination, it's not plugged into the
> SCSI FC infrastructure and thus it's bitrotting.

I think it's not feasible nor worth plugging the fcal driver into the
SCSI FC infrastructure right now simply because these drivers need a
full software FC stack, and the SCSI FC stuff just provides very high
level interfaces to all of this an expects on-board firmware to do all
the protocol packet building and other FC stuff just like the
Qlogic-FC and other cards do.

So it's not just a matter of "porting fcal to SCSI FC", someone would
need to implement the full FC software stack.

