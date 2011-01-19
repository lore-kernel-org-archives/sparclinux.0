From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 21:44:28 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119.134428.71569409.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119161534.GB15031@Krystal>
	<1295460822.12215.1389.camel@gandalf.stny.rr.com>
	<20110119182052.GB18970@Krystal>
In-Reply-To: <20110119182052.GB18970@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 13:20:53 -0500

> Now what I'm discussing with David Miller is if creating a
> 
>   __long_packed_aligned
> 
> and using it for *both* type and variable alignment would be more palatable (it
> also works, and is more compact).

As I mentioned in another reply, we should not be using packed.

Packed has other implications, which makes it use byte-at-a-time accesses
for all parts of a structure when you tag it with 'packed'.  GCC doesn't
try to be clever and see that actually such accesses are safe.

If plain "__long_aligned" works and, since you're tagging it to the structure
definition, it only specifies a minimum-alignment, then I'm fine with using
that to fix this.
