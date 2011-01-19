From: David Miller <davem@davemloft.net>
Date: Wed, 19 Jan 2011 22:22:04 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119.142204.124077863.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110119182052.GB18970@Krystal>
	<20110119.134428.71569409.davem@davemloft.net>
	<20110119221538.GB23544@Krystal>
In-Reply-To: <20110119221538.GB23544@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mathieu.desnoyers@efficios.com
Cc: rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Date: Wed, 19 Jan 2011 17:15:38 -0500

> * David Miller (davem@davemloft.net) wrote:
>> If plain "__long_aligned" works and, since you're tagging it to the structure
>> definition, it only specifies a minimum-alignment, then I'm fine with using
>> that to fix this.
> 
> I'd prefer to add the "packed" to ensure that gcc never decides for some odd
> reason to use an alignment larger than the one we specify in the linker script.

Agreed.
