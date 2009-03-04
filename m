From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 04 Mar 2009 00:28:02 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090303162802.abadba4a.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<fa686aa40903031615wa3e9c3bt226636f5b51d293c@mail.gmail.com>
In-Reply-To: <fa686aa40903031615wa3e9c3bt226636f5b51d293c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com, tpiepho@freescale.com, smaclennan@pikatech.com

On Tue, 3 Mar 2009 17:15:58 -0700
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Tue, Mar 3, 2009 at 5:09 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > linux-next's dc0f6e94d7f487c624254597a0b86ef41c525673 (which I don't
> > seem to be able to find on any mailing lists to which I subscribe)
> > breaks the sparc64 allmodconfig build:
> 
> Hmm, I don't see that one either.  Which tree did it go in via?
> 

leds            git     git://git.o-hand.com/linux-rpurdie-leds#for-mm
