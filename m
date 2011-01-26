From: daniel@gaisler.com
Date: Wed, 26 Jan 2011 21:28:27 +0000
Subject: Re: SPARC32 SMP IRQ15 question
Message-Id: <20110126162827.nhm5kl1pcksgwcoc@webmail.bluegenesis.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4D0A2102.8030100@gaisler.com>
In-Reply-To: <4D0A2102.8030100@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



On Wed, 26 Jan 2011 11:52:53 -0800 (PST), David Miller  wrote:
From: Daniel Hellstrom <daniel@gaisler.com>
  > Date: Wed, 26 Jan 2011 18:02:22  0100
  >
  > > I have made an first implementation on the LEON, the hangs that I
  > > could trigger quite easily are now gone and I can run my system for
  > > several days without rather heavy load, however I still have some
  > > problems on another board, but I don't think they are directly
  > > related... 
  > >
  > > Please look at my implementation suggestion (patches in separate email
  > > soon), I have tried to separate the patches so that it will be easier
  > > to implement it for other CPU models, however I don't really know the
  > > other architectures... it would be nice if someone else could have
  > > look at it and someone how has the hardware... 
  > >
  > > I have removed the use of smp_cross_call in smp_call_function* and
  > > instead used the generic implementation by defining
  > > USE_GENERIC_SMP_HELPERS, I think this is the cleanest approach. 
  >
  > Thanks so much for doing this work!
  > 
   
   
   
  I must thank you as well! I still haven't replied on you response 
about the per-cpu timers, it is quite much non-LEON work there.. but I 
will follow up on that later even though I might do exactly as you told 
me to :)
   
  The patch is rather small, but I have spent a lot time of testing it. 
   
  I'm looking forward to your reply,
   
  Daniel

