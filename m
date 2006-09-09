From: James Bottomley <James.Bottomley@SteelEye.com>
Date: Sat, 09 Sep 2006 16:04:15 +0000
Subject: Re: [Bugme-new] [Bug 7130] New: loading driver eat all CPU and
Message-Id: <1157817856.3462.7.camel@mulgrave.il.steeleye.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200609091032.k89AW7bM017561@fire-2.osdl.org>
	 <20060909083631.95a63528.akpm@osdl.org>
In-Reply-To: <20060909083631.95a63528.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-scsi@vger.kernel.org, wizard580@gmail.com, sparclinux@vger.kernel.org, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>

On Sat, 2006-09-09 at 08:36 -0700, Andrew Morton wrote:
> Does anyone else us the fcal driver?
> 
> I'd suggest the next step would be to run a kernel profile, or just sysrq-P
> to find out where the CPU is stuck.  Could a sparc person please talk the
> reporter through that process?

I'm not sure this is really worth it.  Apart from trying to keep it
compiling, fcal has had no maintainer since the 2.2 kernel days.  Since
no-one has the hardware or the inclination, it's not plugged into the
SCSI FC infrastructure and thus it's bitrotting.  Now might be a good
time to declare it officially dead and remove it from the tree.  Unless
someone actually wants to maintain it and bring it into the 21st
century?

James


