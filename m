From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 19 Jan 2011 16:14:55 +0000
Subject: Re: Bug#609371: linux-image-2.6.37-trunk-sparc64: module scsi_mod:
Message-Id: <20110119161455.GA18503@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20110118201323.GA14930@Krystal> <1295382144.12215.123.camel@gandalf.stny.rr.com> <20110119050844.GA8776@Krystal> <20110118.211639.68142725.davem@davemloft.net> <20110119151004.GA11022@Krystal>
In-Reply-To: <20110119151004.GA11022@Krystal>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: David Miller <davem@davemloft.net>, rostedt@goodmis.org, richm@oldelvet.org.uk, 609371@bugs.debian.org, ben@decadent.org.uk, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, fweisbec@gmail.com, mingo@redhat.com

> 
> If my memory serves me correctly, I think "long long" is aligned on 4 bytes on
> ppc32, but on 8 bytes on x86_32 (yeah, that's weird). How about we create a
> #define __long_long_aligned __attribute__((__aligned__(__alignof__(long long))))

#define __u64_aligned __attribute__((__aligned__(__alignof__(long long))))

A bit shorter but maybe less obvious.

	Sam
